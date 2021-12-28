"""
Routes and views for the flask application.
"""

from datetime import datetime
from flask import render_template, flash, redirect, request, session, url_for
from werkzeug.urls import url_parse
from config import Config
from FlaskWebProject import app, db
from FlaskWebProject.forms import LoginForm#, PostForm
from flask_login import current_user, login_user, logout_user, login_required
from FlaskWebProject.models import User#, Post
import msal
import uuid

imageSourceUrl = 'https://'+ app.config['BLOB_ACCOUNT']  + '.blob.core.windows.net/' + app.config['BLOB_CONTAINER']  + '/'

@app.route('/')
@app.route('/home')
@login_required
def home():
    print('HELLO FROM home!')
    user = User.query.filter_by(username=current_user.username).first_or_404()
    # posts = Post.query.all()
    return render_template(
        'index.html',
        title='Home Page',
        # posts=posts
    )


@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('home'))
    form = LoginForm()
    if form.validate_on_submit():
        print('TODO TODO TODO')
        user = User.query.filter_by(username=form.username.data).first()
        print(user)
        print(form.password.data)
        if user is None or not user.check_password(form.password.data):
            flash('Invalid username or password.')
            return redirect(url_for('login'))
        login_user(user, remember=form.remember_me.data)
        next_page = request.args.get('next')
        if not next_page or url_parse(next_page).netloc != '':
            next_page = url_for('home')
        return redirect(next_page)
    session["state"] = str(uuid.uuid4())
    auth_url = _build_auth_url(scopes=Config.SCOPE, state=session["state"])
    return render_template('login.html', title='Sign In', form=form, auth_url=auth_url)


@app.route('/logout')
def logout():
    logout_user()
    # TODO: Add the rest of the code to use MS Login!



    return redirect(url_for('login'))




def _build_auth_url(authority=None, scopes=None, state=None):
    # TODO: Return the full Auth Request URL with appropriate Redirect URI
    return None