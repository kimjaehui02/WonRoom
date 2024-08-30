from flask import Blueprint, request, jsonify
import pymysql
from datetime import datetime

chat_messages = Blueprint("chat_messages", __name__, template_folder="templates")

def format_datetime(dt):
    return dt.strftime("%Y-%m-%dT%H:%M:%S.%fZ")

@chat_messages.route("/insert", methods=['POST'])
def insert_chat_message():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    chat_text = data.get('chat_text')
    speaker = data.get('speaker')
    chat_time = data.get('chat_time', datetime.now().strftime('%Y-%m-%d %H:%M:%S'))  # 기본값은 현재 시간

    print("/insert")
    print(chat_text)
    print(speaker)
    print(chat_time)

    # 입력 데이터 검증
    if not chat_text or speaker is None:
        return jsonify({"status": "fail", "message": "Missing required fields"}), 400

    # 1. DB 연결
    db = pymysql.connect(
        host='project-db-cgi.smhrd.com',  # URL
        user='plant',                     # 사용자 이름
        password='1234',                  # 비밀번호
        db='plant',                       # 데이터베이스 이름
        charset='utf8',                   # 인코딩
        port=3307                         # 포트
    )
    cursor = db.cursor()

    # 2. SQL문 작성
    sql = '''
    INSERT INTO chat_messages (chat_text, speaker, chat_time)
    VALUES (%s, %s, %s)
    '''

    # 3. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (chat_text, speaker, chat_time))
        db.commit()
        
        # 성공 여부를 체크하여 응답
        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Chat message inserted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Insert failed"}), 500
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": "An error occurred"}), 500
    finally:
        cursor.close()
        db.close()


@chat_messages.route("/select", methods=['POST'])
def select_chat_messages():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    chat_time_start = data.get('chat_time_start')
    chat_time_end = data.get('chat_time_end')

    # 1. DB 연결
    db = pymysql.connect(
        host='project-db-cgi.smhrd.com',  # URL
        user='plant',                     # 사용자 이름
        password='1234',                  # 비밀번호
        db='plant',                       # 데이터베이스 이름
        charset='utf8',                   # 인코딩
        port=3307                         # 포트
    )
    cursor = db.cursor()

    print("/select")
    print(chat_time_start)
    print(chat_time_end)

    # 2. SQL문 작성
    sql = '''
    SELECT * FROM chat_messages
    WHERE chat_time BETWEEN %s AND %s
    '''

    # 3. select 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (chat_time_start, chat_time_end))
        messages = cursor.fetchall()

        if messages:
            # 모든 채팅 메시지를 JSON 형식으로 변환
            messages_list = []
            for message in messages:
                messages_list.append({
                    "chat_id": message[0],
                    "chat_text": message[1],
                    "speaker": message[2],
                    "chat_time": format_datetime(message[3]),
                })
            return jsonify({"status": "success", "data": messages_list})
        else:
            return jsonify({"status": "fail", "message": "No messages found"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@chat_messages.route("/update", methods=['POST'])
def update_chat_message():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    chat_id = data.get('chat_id')
    chat_text = data.get('chat_text')
    speaker = data.get('speaker')
    chat_time = data.get('chat_time', None)  # 선택적 필드

    print("/update")
    print(chat_id)
    print(chat_text)
    print(speaker)
    print(chat_time)

    if not chat_id or not chat_text or speaker is None:
        return jsonify({"status": "fail", "message": "Missing required fields"}), 400

    # 1. DB 연결
    db = pymysql.connect(
        host='project-db-cgi.smhrd.com',  # URL
        user='plant',                     # 사용자 이름
        password='1234',                  # 비밀번호
        db='plant',                       # 데이터베이스 이름
        charset='utf8',                   # 인코딩
        port=3307                         # 포트
    )
    cursor = db.cursor()

    # 2. SQL문 작성
    sql = '''
    UPDATE chat_messages
    SET chat_text = %s, speaker = %s, chat_time = %s
    WHERE chat_id = %s
    '''

    # 3. update 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (chat_text, speaker, chat_time, chat_id))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Chat message updated successfully"})
        else:
            return jsonify({"status": "fail", "message": "Chat message not found or no changes made"}), 404
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@chat_messages.route("/delete", methods=['POST'])
def delete_chat_message():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    chat_id = data.get('chat_id')

    if not chat_id:
        return jsonify({"status": "fail", "message": "Missing chat_id"}), 400

    # 1. DB 연결
    db = pymysql.connect(
        host='project-db-cgi.smhrd.com',  # URL
        user='plant',                     # 사용자 이름
        password='1234',                  # 비밀번호
        db='plant',                       # 데이터베이스 이름
        charset='utf8',                   # 인코딩
        port=3307                         # 포트
    )
    cursor = db.cursor()

    print("/delete")
    print(chat_id)

    # 2. SQL문 작성
    sql = '''
    DELETE FROM chat_messages WHERE chat_id = %s
    '''

    # 3. delete 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (chat_id,))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Chat message deleted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Chat message not found"}), 404
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()
