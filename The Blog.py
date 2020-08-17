from flask import Flask,render_template,request
from datetime import datetime
from flask_sqlalchemy import SQLAlchemy
import  pymysql
import json

with open("config.json") as file:
	params = json.load(file)["params"]

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]

db = SQLAlchemy(app)

class Contacts(db.Model):
	sno = db.Column(db.Integer, primary_key=True)
	name = db.Column(db.String(30), nullable=False)
	email = db.Column(db.String(30), nullable=False)
	subject = db.Column(db.String(50), nullable=False)
	message = db.Column(db.String(500), nullable=False)
	time = db.Column(db.String(20), nullable=False)
@app.route("/")
def main():
	return render_template('index.html', params = params)

@app.route("/index")
def Home():
	return render_template('index.html')

@app.route("/blog")
def articles():
	return render_template('blog.html')

@app.route("/about")
def about():
	return render_template('about.html')

@app.route("/contact", methods = ['GET', 'POST'])
def contact():
	if request.method == 'POST':
		''' User will enter data and it will put it in database'''
		name = request.form.get('name')
		email = request.form.get('email')
		subject = request.form.get('subject')
		message = request.form.get('message')

		query = Contacts(name = name, email = email, subject = subject, message = message, time = datetime.now())
		db.session.add(query)
		db.session.commit()

	return render_template('contact.html')

app.run(debug=True)

