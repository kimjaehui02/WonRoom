from flask import Blueprint, request, jsonify, current_app
from flask_mail import Mail, Message
import sqlite3

# Blueprint 생성
email_controller = Blueprint('email_controller', __name__)

# Flask 앱에 대한 참조가 필요하므로, 이 코드는 앱 초기화 부분에서 설정해야 합니다.
mail = Mail()

def init_mail(app):
    app.config['MAIL_SERVER'] = 'smtp.naver.com'  # 네이버 메일 서버 주소
    app.config['MAIL_PORT'] = 587  # TLS를 사용한 연결을 위한 포트
    app.config['MAIL_USERNAME'] = 'your_email@naver.com'  # 네이버 이메일 주소
    app.config['MAIL_PASSWORD'] = 'your_password'  # 네이버 이메일 비밀번호
    app.config['MAIL_USE_TLS'] = True  # TLS 사용 설정
    app.config['MAIL_USE_SSL'] = False  # SSL은 사용하지 않음
    mail.init_app(app)

@email_controller.route('/find_id', methods=['POST'])
def find_id():
    email = request.json.get('email')
    conn = sqlite3.connect('database.db')
    cursor = conn.cursor()
    cursor.execute("SELECT user_id FROM users WHERE email = ?", (email,))
    user = cursor.fetchone()
    conn.close()
    
    if user:
        msg = Message('Your User ID', sender=current_app.config['MAIL_USERNAME'], recipients=[email])
        msg.body = f'Your user ID is: {user[0]}'
        mail.send(msg)
        return jsonify({'message': 'User ID sent to your email'})
    else:
        return jsonify({'message': 'Email not found'}), 404

@email_controller.route('/reset_password', methods=['POST'])
def reset_password():
    email = request.json.get('email')
    msg = Message('Password Reset Link', sender=current_app.config['MAIL_USERNAME'], recipients=[email])
    msg.body = 'Click the link to reset your password: http://your-flask-api-url/reset_password'
    mail.send(msg)
    return jsonify({'message': 'Password reset link sent to your email'})
