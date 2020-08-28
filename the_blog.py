from flask import Flask,render_template,request,session,redirect
from datetime import datetime
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
import  pymysql
import json
import math

with open("config.json") as file:
	params = json.load(file)["params"]

app = Flask(__name__)
app.secret_key = 'the random string'
app.config.update(
	MAIL_SERVER = 'smtp.gmail.com',
	MAIL_PORT = '465',
	MAIL_USE_SSL = True,
	MAIL_USERNAME = params['username'],
	MAIL_PASSWORD = params['password']
	)
mail = Mail(app)

app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]

db = SQLAlchemy(app)

class Contacts(db.Model):
	sno = db.Column(db.Integer, primary_key=True)
	name = db.Column(db.String(30), nullable=False)
	email = db.Column(db.String(30), nullable=False)
	subject = db.Column(db.String(50), nullable=False)
	message = db.Column(db.String(500), nullable=False)
	time = db.Column(db.String(20), nullable=False)

class Posts(db.Model):
	sno = db.Column(db.Integer, primary_key=True)
	place = db.Column(db.String(30), nullable=False)
	title = db.Column(db.String(50), nullable=False)
	img_file = db.Column(db.String(30), nullable=True)
	content = db.Column(db.String(800), nullable=False)
	date = db.Column(db.String(20), nullable=False)
	slug = db.Column(db.String(50), nullable=False)


@app.route("/")
def main():
	posts = Posts.query.filter_by().all()
	posts.reverse()
	last = math.ceil(len(posts) / params["no_of_post"])
	page = request.args.get("page")
	if not str(page).isnumeric():
		page = 1
	page = int(page)
	posts = posts[((page-1) * params["no_of_post"]): ((page-1) * params["no_of_post"]) + params["no_of_post"]]
	if page == 1:
		pre = '#'
		nex = "/?page=" + str(page + 1)
	elif page == last:
		pre = "/?page=" + str(page - 1)
		nex = '#'
	else:
		pre = "/?page=" + str(page - 1)
		nex = "/?page=" + str(page + 1)
	return render_template('index.html', params = params, posts = posts, pre = pre, nex = nex)

@app.route("/admin", methods = ['GET', 'POST'])
def admin():
	if 'user' in session and session['user'] == params['username']:
		posts = Posts.query.filter_by().all()
		return render_template('dashboard.html', params = params, posts = posts)
	if request.method == 'POST':
		username = request.form.get('username')
		password = request.form.get('pass')
		if (username == params['username']) and (password == params['password']):
			session['user'] = username
			posts = Posts.query.filter_by().all()
			return render_template('dashboard.html', params = params, posts = posts)
		else:
			return render_template('login.html', params = params)
	else:
		return render_template('login.html', params = params)

@app.route("/logout", methods =['GET'])
def logout():
	session.pop('user')
	return redirect('/admin')


@app.route("/blog/<string:post_slug>",methods = ['GET'])
def post_from_database(post_slug):
	post = Posts.query.filter_by(slug = post_slug).first()
	return render_template('blogpost.html', params = params, post = post)


@app.route("/management/<string:sno>",methods = ['GET','POST'])
def manage(sno):
	# if ('user' in session and session['user'] == params['username']):
		if request.method == 'POST':
			place = request.form.get('place')
			title = request.form.get('title')
			slug = request.form.get('slug')
			date = datetime.now()
			img = request.form.get('img')
			content = request.form.get('content')

			if sno == '0':
				post = Posts(place = place, title = title, slug = slug, img_file = img, date = date, content = content)
				db.session.add(post)
				db.session.commit()
				# mail.send_message('New post added', sender = 'Admin', recipients = [params['username']], body = content)
			else:
				post = Posts.query.filter_by(sno = sno).first()
				post.place = place
				post.title = title
				post.slug = slug
				post.img_file = img
				post.date = date
				post.content = content
				db.session.commit()
				return redirect(f"/management/{sno}")
		post = Posts.query.filter_by(sno = sno).first()
		return render_template('management.html', params = params, post = post)

@app.route("/delete/<string:sno>", methods =['GET'])
def delete(sno):
	if 'user' in session and session['user'] == params['username']:
		post = Posts.query.filter_by(sno = sno).first()
		db.session.delete(post)
		db.session.commit()
	return redirect('/admin')


@app.route("/index")
def Home():
	return redirect('/')

@app.route("/blog")
def articles():
	posts = Posts.query.filter_by().all()
	posts.reverse()
	last = math.ceil(len(posts) / 9)
	page = request.args.get("page")
	if not str(page).isnumeric():
		page = 1
	page = int(page)
	posts = posts[((page-1) * 9): ((page-1) * 9) + 9]
	if page == 1:
		pre = '#'
		nex = "/blog?page=" + str(page + 1)
	elif page == last:
		pre = "/blog?page=" + str(page - 1)
		nex = '#'
	else:
		pre = "/blog?page=" + str(page - 1)
		nex = "/blog?page=" + str(page + 1)
	return render_template('blog.html', params = params, xposts = posts, pre = pre, nex = nex)

@app.route("/about")
def about():
	return render_template('about.html', params = params)

@app.route("/contact", methods = ['GET', 'POST'])
def contact():
	posts = Posts.query.filter_by().all()
	posts.reverse()
	posts = posts[0 : params["no_of_post"]]
	if request.method == 'POST':
		''' User will enter data and it will put it in database'''
		name = request.form.get('name')
		email = request.form.get('email')
		subject = request.form.get('subject')
		message = request.form.get('message')

		query = Contacts(name = name, email = email, subject = subject, message = message, time = datetime.now())
		db.session.add(query)
		db.session.commit()
		mail.send_message('New message from ' + name, sender = email, recipients = [params['username']], body = message)
		

	return render_template('contact.html', params = params, posts = posts)

app.run(debug=True)

