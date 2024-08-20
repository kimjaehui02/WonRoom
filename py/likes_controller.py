from flask import Blueprint, request, jsonify
import pymysql

likes = Blueprint("likes", __name__, template_folder="templates")

@likes.route("/insert", methods=['POST'])
def insert():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')
    post_id = data.get('post_id')
    created_at = data.get('created_at')

    print(user_id)
    print(post_id)
    print(created_at)

    # # 필수 데이터 체크
    # if not all([user_id, post_id, created_at]):
    #     return jsonify({"status": "fail", "message": "user_id, post_id, and created_at are required"}), 400

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
        return jsonify({"status": "success", "message": "Like added successfully"})
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500  # 상태 코드 500 (서버 오류)
    finally:
        cursor.close()
        db.close()
