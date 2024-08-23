from flask import Blueprint, request, jsonify
import pymysql

comments = Blueprint("comments", __name__, template_folder="templates")

@comments.route("/insert", methods=['POST'])
def insert():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    post_id = data.get('post_id')
    user_id = data.get('user_id')
    comment_content = data.get('comment_content')
    created_at = data.get('created_at')  # 클라이언트에서 작성일을 받음
    parent_comment_id = data.get('parent_comment_id', None)  # 기본값은 None
    is_reply = data.get('is_reply', 0)  # 기본값은 0 (false)

    print(post_id)
    print(user_id)
    print(comment_content)
    print(created_at)
    print(parent_comment_id)
    print(is_reply)

    # # 필수 데이터 체크
    # if not all([post_id, user_id, comment_content, created_at]):
    #     return jsonify({"status": "fail", "message": "post_id, user_id, comment_content, and created_at are required"}), 400

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
    INSERT INTO comments (post_id, user_id, comment_content, created_at, parent_comment_id, is_reply)
    VALUES (%s, %s, %s, %s, %s, %s)
    '''

    # 3. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (post_id, user_id, comment_content, created_at, parent_comment_id, is_reply))
        db.commit()
        return jsonify({"status": "success", "message": "Comment added successfully"})
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500  # 상태 코드 500 (서버 오류)
    finally:
        cursor.close()
        db.close()
