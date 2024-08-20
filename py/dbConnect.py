from flask import Blueprint, request
# Blueprint flask 내에 있는 모듈
# flask 서버 내 파일 관리를 도와주는 모듈
import pymysql
import json

member = Blueprint("member", __name__, template_folder="templates")

@member.route('/')
def test():
    return "member Page"

# jdbc py - db 연결
# mysql 사용시에 pymysql

@member.route('/test')
def dbtest():
    # db 연결
    db = pymysql.connect(
            host='project-db-cgi.smhrd.com',  # URL
            user='plant',                     # 사용자 이름
            password='1234',                  # 비밀번호
            db='plant',                       # 데이터베이스 이름
            charset='utf8',                   # 인코딩
            port=3307                         # 포트
        )
    # pymysql.connect(host = ip주소(로컬호스트), user id 값, user pw 값, db 스키마 값, 인코딩)

    if db :
        return 'success'
    else :
        return 'fail'


