from flask import Flask,render_template
 
app = Flask(__name__)

@app.route("/")
def main():
	return render_template('index.html')

@app.route("/index")
def Home():
	return render_template('index.html')

@app.route("/blog")
def articles():
	return render_template('blog.html')

@app.route("/about")
def about():
	return render_template('about.html')

@app.route("/contact")
def contact():
	return render_template('contact.html')

app.run(debug=True)

