from flask import Blueprint, request, jsonify
import pymysql

likes = Blueprint("likes", __name__, template_folder="templates")

def format_datetime(dt):
    return dt.strftime("%Y-%m-%dT%H:%M:%S.%fZ")

@likes.route("/insert", methods=['POST'])
def insert_like():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')
    post_id = data.get('post_id')
    created_at = data.get('created_at')

    print("/insert")
    print(user_id)
    print(post_id)
    print(created_at)

    # 입력 데이터 검증
    if not all([user_id, post_id, created_at]):
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
    INSERT INTO likes (user_id, post_id, created_at)
    VALUES (%s, %s, %s)
    '''

    # 3. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id, post_id, created_at))
        db.commit()
        
        # 성공 여부를 체크하여 응답
        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Like inserted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Insert failed"}), 500
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": "An error occurred"}), 500  # 일반적인 오류 메시지로 변경
    finally:
        cursor.close()
        db.close()

@likes.route("/select", methods=['POST'])
def select_likes():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    post_id = data.get('post_id')

    if not post_id:
        return jsonify({"status": "fail", "message": "Missing post_id"}), 400

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
    print(post_id)

    # 2. SQL문 작성
    sql = '''
    SELECT * FROM likes WHERE post_id = %s
    '''

    # 3. select 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (post_id,))
        likes_data = cursor.fetchall()

        if likes_data:
            # 모든 좋아요 정보를 JSON 형식으로 변환
            likes_list = []
            for like in likes_data:
                likes_list.append({
                    "like_id": like[0],
                    "user_id": like[1],
                    "post_id": like[2],
                    "created_at": format_datetime(like[3]),
                })
            return jsonify({"status": "success", "data": likes_list})
        else:
            return jsonify({"status": "fail", "message": "No likes found for this post"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@likes.route("/delete", methods=['POST'])
def delete_like():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')
    post_id = data.get('post_id')

    if not all([user_id, post_id]):
        return jsonify({"status": "fail", "message": "Missing user_id or post_id"}), 400

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
    print(user_id)
    print(post_id)

    # 2. SQL문 작성
    sql = '''
    DELETE FROM likes WHERE user_id = %s AND post_id = %s
    '''

    # 3. delete 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id, post_id))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Like deleted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Like not found"}), 404
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()  # 커서 닫기
        db.close()      # DB 연결 종료
