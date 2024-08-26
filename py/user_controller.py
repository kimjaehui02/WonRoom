from flask import Blueprint, request, jsonify
# Blueprint flask 내에 있는 모듈
# flask 서버 내 파일 관리를 도와주는 모듈
import pymysql
import json

users = Blueprint("users", __name__, template_folder="templates")

@users.route('/')
def test():
    return "users Page"

# jdbc py - db 연결
# mysql 사용시에 pymysql

@users.route('/test')
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


@users.route("/insert", methods=['POST'])
def insert():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')
    user_pw = data.get('user_pw')
    user_nick = data.get('user_nick')
    user_email = data.get('user_email')
    reg_date = data.get('reg_date')

    # 1. DB 연결
    db = pymysql.connect(
        host='project-db-cgi.smhrd.com',  # URL
        user='plant',                     # 사용자 이름
        password='1234',                  # 비밀번호
        db='plant',                       # 데이터베이스 이름
        charset='utf8',                   # 인코딩
        port=3307                         # 포트
    )

    # 2. 데이터 접근 객체 - cursor
    cursor = db.cursor()

    print("/insert")
    print(user_id)
    print(user_pw)
    print(user_nick)
    print(user_email)
    print(reg_date)

    # 3. SQL문 작성
    sql = '''
    INSERT INTO users (user_id, user_pw, user_nick, user_email, reg_date)
    VALUES (%s, %s, %s, %s, %s)
    '''

    # 4. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id, user_pw, user_nick, user_email, reg_date))
        row = cursor.rowcount
        db.commit()
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return f"Error: {str(e)}", 500  # 상태 코드 500 (서버 오류)
    finally:
        cursor.close()
        db.close()

    if row > 0:
        return "success"
    else:
        return "fail"


@users.route("/login", methods=['POST'])
def login():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')
    user_pw = data.get('user_pw')

    # 1. DB 연결
    db = pymysql.connect(
        host='project-db-cgi.smhrd.com',  # URL
        user='plant',                     # 사용자 이름
        password='1234',                  # 비밀번호
        db='plant',                       # 데이터베이스 이름
        charset='utf8',                   # 인코딩
        port=3307                         # 포트
    )

    # 2. 데이터 접근 객체 - cursor
    cursor = db.cursor()

    print("/login")
    print(user_id)
    print(user_pw)

    # 3. SQL문 작성
    sql = '''
    SELECT user_id, user_nick, user_email, reg_date FROM users WHERE user_id = %s AND user_pw = %s
    '''

    # 4. select 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id, user_pw))
        user = cursor.fetchone()
    except Exception as e:
        return jsonify({"error": str(e)}), 500  # 상태 코드 500 (서버 오류)
    finally:
        cursor.close()
        db.close()

    if user:
       # 사용자 정보를 JSON 형식으로 변환 (user_pw 제외)
        return jsonify({
            "status": "success",
            "user_id": user[0],
            "user_nick": user[1],
            "user_email": user[2],
            "reg_date": user[3]
        })
    else:
        return jsonify({"status": "fail"}), 401  # 상태 코드 401 (인증 실패)


# DB 연결 함수
def get_db_connection():
    return pymysql.connect(
        host='project-db-cgi.smhrd.com',  # URL
        user='plant',                     # 사용자 이름
        password='1234',                  # 비밀번호
        db='plant',                       # 데이터베이스 이름
        charset='utf8',                   # 인코딩
        port=3307                         # 포트
    )

# 아이디 중복 검사
@users.route("/check_id", methods=['POST'])
def check_id():
    data = request.get_json()
    user_id = data.get('user_id')

    db = get_db_connection()
    cursor = db.cursor()

    sql = 'SELECT COUNT(*) FROM users WHERE user_id = %s'
    
    try:
        cursor.execute(sql, (user_id,))
        count = cursor.fetchone()[0]
        if count > 0:
            return jsonify({"status": "fail", "message": "이미 사용 중인 아이디입니다."}), 400
        else:
            return jsonify({"status": "success", "message": "사용 가능한 아이디입니다."})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

# 닉네임 중복 검사
@users.route("/check_nickname", methods=['POST'])
def check_nickname():
    data = request.get_json()
    user_nick = data.get('user_nick')

    db = get_db_connection()
    cursor = db.cursor()

    sql = 'SELECT COUNT(*) FROM users WHERE user_nick = %s'
    
    try:
        cursor.execute(sql, (user_nick,))
        count = cursor.fetchone()[0]
        if count > 0:
            return jsonify({"status": "fail", "message": "이미 사용 중인 닉네임입니다."}), 400
        else:
            return jsonify({"status": "success", "message": "사용 가능한 닉네임입니다."})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

# 이메일 중복 검사
@users.route("/check_email", methods=['POST'])
def check_email():
    data = request.get_json()
    user_email = data.get('user_email')

    db = get_db_connection()
    cursor = db.cursor()

    sql = 'SELECT COUNT(*) FROM users WHERE user_email = %s'
    
    try:
        cursor.execute(sql, (user_email,))
        count = cursor.fetchone()[0]
        if count > 0:
            return jsonify({"status": "fail", "message": "이미 사용 중인 이메일입니다."}), 400
        else:
            return jsonify({"status": "success", "message": "사용 가능한 이메일입니다."})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@users.route("/update", methods=['POST'])
def update():
   # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')
    user_pw = data.get('user_pw')
    user_nick = data.get('user_nick')
    user_email = data.get('user_email')

    # 1. DB 연결
    db = pymysql.connect(
        host='project-db-cgi.smhrd.com',
        user='plant',
        password='1234',
        db='plant',
        charset='utf8',
        port=3307
    )

    # 2. 데이터 접근 객체 - cursor
    cursor = db.cursor()

    # 3. SQL문 작성 (업데이트 쿼리)
    sql = '''
    UPDATE users
    SET user_pw = %s, user_nick = %s, user_email = %s
    WHERE user_id = %s
    '''

    # 4. update 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_pw, user_nick, user_email, user_id))
        db.commit()
        row = cursor.rowcount
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500  # 상태 코드 500 (서버 오류)
    finally:
        cursor.close()
        db.close()

    if row > 0:
        return jsonify({"status": "success"})
    else:
        return jsonify({"status": "fail", "message": "User not found"}), 404  # 상태 코드 404 (사용자 없음)



@users.route('/delete', methods=['POST'])
def delete():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')

    # MySQL 데이터베이스 연결
    # 1. DB 연결
    db = pymysql.connect(
        host='project-db-cgi.smhrd.com',
        user='plant',
        password='1234',
        db='plant',
        charset='utf8',
        port=3307
    )
    # 2. 데이터 접근 객체 - cursor
    cursor = db.cursor()
    # 3. SQL문 작성 (삭제 쿼리)
    sql = '''
    DELETE FROM users
    WHERE user_id = %s
    '''

    # 4. delete 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id,))
        db.commit()
        row = cursor.rowcount
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500  # 상태 코드 500 (서버 오류)
    finally:
        cursor.close()
        db.close()

    if row > 0:
        return jsonify({"status": "success"})
    else:
        return jsonify({"status": "fail", "message": "User not found"}), 404  # 상태 코드 404 (사용자 없음)
       

