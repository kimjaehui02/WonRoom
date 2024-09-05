from flask import Blueprint, request, jsonify
import pymysql
import json

users = Blueprint("users", __name__, template_folder="templates")

# DB 연결 함수
def get_db_connection():
    return pymysql.connect(
        host='project-db-cgi.smhrd.com',
        user='plant',
        password='1234',
        db='plant',
        charset='utf8',
        port=3307
    )

@users.route('/')
def test():
    return "users Page"

@users.route('/test')
def dbtest():
    try:
        db = get_db_connection()
        return 'success'
    except Exception as e:
        return f'fail: {str(e)}', 500

@users.route("/insert", methods=['POST'])
def insert():
    data = request.get_json()
    if not all(key in data for key in ('user_id', 'user_pw', 'user_nick', 'user_email', 'reg_date')):
        return jsonify({"status": "fail", "message": "Missing required fields"}), 400

    user_id = data.get('user_id')
    user_pw = data.get('user_pw')
    user_nick = data.get('user_nick')
    user_email = data.get('user_email')
    reg_date = data.get('reg_date')
    favorite_plant_id = data.get('favorite_plant_id', None)  # Optional field

    db = get_db_connection()
    cursor = db.cursor()

    sql = '''
    INSERT INTO users (user_id, user_pw, user_nick, user_email, reg_date, favorite_plant_id)
    VALUES (%s, %s, %s, %s, %s, %s)
    '''
    
    try:
        cursor.execute(sql, (user_id, user_pw, user_nick, user_email, reg_date, favorite_plant_id))
        db.commit()
        row = cursor.rowcount
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

    return jsonify({"status": "success"}) if row > 0 else jsonify({"status": "fail", "message": "Insert failed"}), 500


@users.route("/login", methods=['POST'])
def login():
    data = request.get_json()
    if not all(key in data for key in ('user_id', 'user_pw')):
        return jsonify({"status": "fail", "message": "Missing required fields"}), 400

    user_id = data.get('user_id')
    user_pw = data.get('user_pw')

    db = get_db_connection()
    cursor = db.cursor()

    sql = '''
    SELECT user_id, user_nick, user_email, reg_date FROM users WHERE user_id = %s AND user_pw = %s
    '''

    try:
        cursor.execute(sql, (user_id, user_pw))
        user = cursor.fetchone()
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

    if user:
        return jsonify({
            "status": "success",
            "user_id": user[0],
            "user_nick": user[1],
            "user_email": user[2],
            "reg_date": user[3]
        })
    else:
        return jsonify({"status": "fail", "message": "Invalid credentials"}), 401

@users.route("/check_id", methods=['POST'])
def check_id():
    data = request.get_json()
    if 'user_id' not in data:
        return jsonify({"status": "fail", "message": "Missing user_id"}), 400

    user_id = data.get('user_id')

    db = get_db_connection()
    cursor = db.cursor()

    sql = 'SELECT COUNT(*) FROM users WHERE user_id = %s'

    try:
        cursor.execute(sql, (user_id,))
        count = cursor.fetchone()[0]
        return jsonify({"status": "success" if count == 0 else "fail", "message": "Available" if count == 0 else "ID already taken"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@users.route("/check_nickname", methods=['POST'])
def check_nickname():
    data = request.get_json()
    if 'user_nick' not in data:
        return jsonify({"status": "fail", "message": "Missing user_nick"}), 400

    user_nick = data.get('user_nick')

    db = get_db_connection()
    cursor = db.cursor()

    sql = 'SELECT COUNT(*) FROM users WHERE user_nick = %s'

    try:
        cursor.execute(sql, (user_nick,))
        count = cursor.fetchone()[0]
        return jsonify({"status": "success" if count == 0 else "fail", "message": "Available" if count == 0 else "Nickname already taken"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@users.route("/check_email", methods=['POST'])
def check_email():
    data = request.get_json()
    if 'user_email' not in data:
        return jsonify({"status": "fail", "message": "Missing user_email"}), 400

    user_email = data.get('user_email')

    db = get_db_connection()
    cursor = db.cursor()

    sql = 'SELECT COUNT(*) FROM users WHERE user_email = %s'

    try:
        cursor.execute(sql, (user_email,))
        count = cursor.fetchone()[0]
        return jsonify({"status": "success" if count == 0 else "fail", "message": "Available" if count == 0 else "Email already taken"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@users.route("/update", methods=['POST'])
def update():
    data = request.get_json()
    
    # 필수 필드 확인
    if 'user_id' not in data:
        return jsonify({"status": "fail", "message": "Missing required field: user_id"}), 400

    user_id = data.get('user_id')
    user_pw = data.get('user_pw', None)
    user_nick = data.get('user_nick', None)  # 수신하되 업데이트에는 사용하지 않음
    user_email = data.get('user_email', None)
    favorite_plant_id = data.get('favorite_plant_id', None)

    # 업데이트할 필드와 값을 저장할 딕셔너리 생성
    update_fields = {}
    if user_pw is not None and user_pw != "":
        update_fields['user_pw'] = user_pw
    if user_email is not None and user_email != "":
        update_fields['user_email'] = user_email
    if favorite_plant_id is not None:  # Check if favorite_plant_id is provided
        update_fields['favorite_plant_id'] = favorite_plant_id

    # 필드가 없으면 반환
    if not update_fields:
        return jsonify({"status": "fail", "message": "No fields to update"}), 400

    # 동적으로 SQL 쿼리 생성
    set_clause = ", ".join(f"{field} = %s" for field in update_fields.keys())
    sql = f"UPDATE users SET {set_clause} WHERE user_id = %s"
    values = list(update_fields.values()) + [user_id]

    db = get_db_connection()
    cursor = db.cursor()

    print("/update")
    print(user_id)
    print(user_pw)
    print(user_nick)  # 닉네임을 수신하되 업데이트에 사용하지 않음
    print(user_email)
    print(favorite_plant_id)
    print(sql)
    print(set_clause)
    print(values)

    try:
        cursor.execute(sql, values)
        db.commit()
        row = cursor.rowcount
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

    # 업데이트가 없더라도 성공 처리
    if row == 0:
        # user_id가 실제로 존재하는지 확인 (업데이트된 내용이 없을 경우 체크)
        cursor = db.cursor()
        cursor.execute("SELECT COUNT(1) FROM users WHERE user_id = %s", (user_id,))
        user_exists = cursor.fetchone()[0]
        cursor.close()
        if user_exists == 0:
            return jsonify({"status": "fail", "message": "User not found"}), 404

    return jsonify({"status": "success"}), 200


@users.route('/delete', methods=['POST'])
def delete():
    data = request.get_json()
    if 'user_id' not in data:
        return jsonify({"status": "fail", "message": "Missing user_id"}), 400

    user_id = data.get('user_id')

    db = get_db_connection()
    cursor = db.cursor()

    sql = '''
    DELETE FROM users
    WHERE user_id = %s
    '''

    try:
        cursor.execute(sql, (user_id,))
        db.commit()
        row = cursor.rowcount
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

    return jsonify({"status": "success"}) if row > 0 else jsonify({"status": "fail", "message": "User not found"}), 404

@users.route('/find_id_by_nick_email', methods=['POST'])
def find_id_by_nick_email():
    data = request.get_json()
    if not all(key in data for key in ('user_nick', 'user_email')):
        return jsonify({"status": "fail", "message": "Missing required fields"}), 400

    user_nick = data.get('user_nick')
    user_email = data.get('user_email')

    db = get_db_connection()
    cursor = db.cursor()

    sql = '''
    SELECT user_id FROM users WHERE user_nick = %s AND user_email = %s
    '''

    try:
        cursor.execute(sql, (user_nick, user_email))
        user_id = cursor.fetchone()
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

    if user_id:
        original_user_id = user_id[0]
        if len(original_user_id) >= 4:
            masked_user_id = original_user_id[:-4] + '***' + original_user_id[-1]
        else:
            masked_user_id = '*' * len(original_user_id)

        return jsonify({
            "status": "success",
            "user_id": masked_user_id
        })
    else:
        return jsonify({"status": "fail", "message": "User not found"}), 404

@users.route('/reset_password', methods=['POST'])
def reset_password():
    data = request.get_json()
    if not all(key in data for key in ('user_id', 'user_email')):
        return jsonify({"status": "fail", "message": "Missing required fields"}), 400

    user_id = data.get('user_id')
    user_email = data.get('user_email')

    db = get_db_connection()
    cursor = db.cursor()

    sql = '''
    SELECT user_email FROM users WHERE user_id = %s
    '''
    try:
        cursor.execute(sql, (user_id,))
        stored_email = cursor.fetchone()
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db.close()

    if stored_email and stored_email[0] == user_email:
        db = get_db_connection()
        cursor = db.cursor()
        sql_update = '''
        UPDATE users SET user_pw = %s WHERE user_id = %s
        '''
        try:
            cursor.execute(sql_update, ('11111111', user_id))
            db.commit()
            row = cursor.rowcount
        except Exception as e:
            db.rollback()
            return jsonify({"status": "fail", "message": str(e)}), 500
        finally:
            cursor.close()
            db.close()

        return jsonify({"status": "success", "message": "Password reset to '1111'"}) if row > 0 else jsonify({"status": "fail", "message": "User not found"}), 404
    else:
        return jsonify({"status": "fail", "message": "Invalid user ID or email"}), 400


@users.route('/update_favorite_plant_id', methods=['POST'])
def update_favorite_plant_id():
    # 데이터 받아오기
    data = request.get_json()
    user_id = data.get('user_id')
    favorite_plant_id = data.get('favorite_plant_id')

    if not user_id or favorite_plant_id is None:
        return jsonify({"status": "fail", "message": "Missing user_id or favorite_plant_id"}), 400

    # DB 연결
    db = get_db_connection()
    cursor = db.cursor()

    # SQL문 작성 (업데이트 쿼리)
    sql = '''
    UPDATE users
    SET favorite_plant_id = %s
    WHERE user_id = %s
    '''

    # update 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (favorite_plant_id, user_id))
        db.commit()
        row = cursor.rowcount
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

    if row > 0:
        return jsonify({"status": "success"})
    else:
        return jsonify({"status": "fail", "message": "User not found"}), 404  # 상태 코드 404 (사용자 없음)
