from flask import Flask
from flask_mail import Mail

# from py파일명 import 변수명
# 다른 파일을 가져오기
from dbConnect import member
from comments_controller import comments
from likes_controller import likes
from photos_controller import photos
from plant_management_controller import plant_management
from posts_controller import posts
from queries_controller import queries
from user_controller import users
from user_plants_controller import user_plants
from chat_messages_controller import chat_messages
from email_controller import email_controller, init_mail  # 이메일 컨트롤러 추가

app = Flask(__name__)

# 이메일 설정 초기화
# init_mail(app)

# 다른 파일을 가져오고 나서 해당 url에 멤버를 기본으로 붙여두기
app.register_blueprint(member, url_prefix="/member")
app.register_blueprint(comments, url_prefix="/comments")
app.register_blueprint(likes, url_prefix="/likes")
app.register_blueprint(photos, url_prefix="/photos")
app.register_blueprint(plant_management, url_prefix="/plant_management")

app.register_blueprint(posts, url_prefix="/posts")
app.register_blueprint(queries, url_prefix="/queries")
app.register_blueprint(users, url_prefix="/users")
app.register_blueprint(user_plants, url_prefix="/user_plants")

app.register_blueprint(chat_messages, url_prefix="/chat_messages")

# 이메일 관련 Blueprint 등록
app.register_blueprint(email_controller, url_prefix="/email")

# 기본 주소로 이동 시 리턴하는 곳
@app.route('/')
def home():
    return "Welcome to the Flask App2!"

if __name__ == '__main__':
    app.debug = True
    app.run('192.168.219.243', port=8087)
