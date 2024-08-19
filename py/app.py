from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///test.db'
db = SQLAlchemy(app)

@app.route('/')
def hello():
    return "Hello, Flask!"

if __name__ == '__main__':
    app.debug = True
    app.run('192.168.219.81', port=8087)
