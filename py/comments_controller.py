from flask import Blueprint, request, jsonify
import pymysql

comments = Blueprint("comments", __name__, template_folder="templates")

def format_datetime(dt):
    return dt.strftime("%Y-%m-%dT%H:%M:%S.%fZ")

@comments.route("/insert", methods=['POST'])
def insert_comment():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    post_id = data.get('post_id')
    user_id = data.get('user_id')
    comment_content = data.get('comment_content')
    created_at = data.get('created_at')
    parent_comment_id = data.get('parent_comment_id', None)
    is_reply = data.get('is_reply', 0)  # 기본값 0으로 설정

    print("/insert")
    print(post_id)
    print(user_id)
    print(comment_content)
    print(created_at)
    print(parent_comment_id)
    print(is_reply)

    # 입력 데이터 검증
    if not all([post_id, user_id, comment_content, created_at]):
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

    # 2. 데이터 접근 객체 - cursor
    cursor = db.cursor()

    # 3. SQL문 작성
    sql = '''
    INSERT INTO comments (post_id, user_id, comment_content, created_at, parent_comment_id, is_reply)
    VALUES (%s, %s, %s, %s, %s, %s)
    '''

    # 4. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (post_id, user_id, comment_content, created_at, parent_comment_id, is_reply))
        db.commit()
        
        # 성공 여부를 체크하여 응답
        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Comment inserted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Insert failed"}), 500
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": "An error occurred"}), 500
    finally:
        cursor.close()
        db.close()

@comments.route("/select", methods=['POST'])
def select_comments():
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
    SELECT * FROM comments WHERE post_id = %s
    '''

    # 3. select 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (post_id,))
        comments_data = cursor.fetchall()

        if comments_data:
            # 모든 댓글 정보를 JSON 형식으로 변환
            comments_list = []
            for comment in comments_data:
                comments_list.append({
                    "comment_id": comment[0],
                    "post_id": comment[1],
                    "user_id": comment[2],
                    "comment_content": comment[3],
                    "created_at": format_datetime(comment[4]),
                    "parent_comment_id": comment[5],
                    "is_reply": comment[6],
                })
            return jsonify({"status": "success", "data": comments_list})
        else:
            return jsonify({"status": "fail", "message": "No comments found for this post"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@comments.route("/update", methods=['POST'])
def update_comment():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    comment_id = data.get('comment_id')
    # user_id = data.get('user_id')
    comment_content = data.get('comment_content')
    # is_reply = data.get('is_reply', None)  # is_reply은 선택적

    print("/update")
    print(comment_id)
    # print(user_id)
    print(comment_content)
    # print(is_reply)

    if not comment_id or not comment_content:
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
    UPDATE comments 
    SET comment_content = %s, is_reply = %s
    WHERE comment_id = %s
    '''

    # 3. update 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (comment_content,comment_id))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Comment updated successfully"})
        else:
            return jsonify({"status": "fail", "message": "Comment not found or no changes made"}), 404
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()  # 커서 닫기
        db.close()      # DB 연결 종료

@comments.route("/delete", methods=['POST'])
def delete_comment():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    comment_id = data.get('comment_id')

    if not comment_id:
        return jsonify({"status": "fail", "message": "Missing comment_id"}), 400

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
    print(comment_id)

    # 2. SQL문 작성
    sql = '''
    DELETE FROM comments WHERE comment_id = %s
    '''

    # 3. delete 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (comment_id,))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Comment deleted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Comment not found"}), 404
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()  # 커서 닫기
        db.close()      # DB 연결 종료
