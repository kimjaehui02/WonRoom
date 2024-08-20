from flask import Flask, request

# from py파일명 import 변수명
# 다른 파일을 가져오기
from dbConnect import member

from user_controller import users


app = Flask(__name__)

# 다른 파일을 가져오고나서 해당 url에 멤버를 기본으로 붙여두기
app.register_blueprint(member, url_prefix = "/member")
app.register_blueprint(users, url_prefix = "/users")

# 기본 주소로 이동시 리턴하는곳
@app.route('/')
def home():
    return "Welcome to the Flask App2!"



if __name__ == '__main__':
    app.debug = True
    app.run('192.168.219.81',port=8087)
