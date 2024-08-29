from flask import Blueprint, request, jsonify
import pymysql

posts = Blueprint("posts", __name__, template_folder="templates")

def format_datetime(dt):
    return dt.strftime("%Y-%m-%dT%H:%M:%S.%fZ")

@posts.route("/insert", methods=['POST'])
def insert_post():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    post_title = data.get('post_title')
    post_content = data.get('post_content')
    user_id = data.get('user_id')
    created_at = data.get('created_at')
    image_url = data.get('image_url', '')  # image_url 필드는 선택적

    print("/insert")
    print(post_title)
    print(post_content)
    print(user_id)
    print(created_at)
    print(image_url)

    # 입력 데이터 검증
    # if not all([post_title, post_content, user_id, created_at]):
    #     print(400400)
    #     return jsonify({"status": "fail", "message": "Missing required fields"}), 400

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
    INSERT INTO posts (post_title, post_content, user_id, created_at, image_url)
    VALUES (%s, %s, %s, %s, %s)
    '''

    # 4. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (post_title, post_content, user_id, created_at, image_url))
        db.commit()
        
        # 성공 여부를 체크하여 응답
        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Post inserted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Insert failed"}), 500
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": "An error occurred"}), 500  # 일반적인 오류 메시지로 변경
    finally:
        cursor.close()
        db.close()


@posts.route("/select", methods=['POST'])
def select_post():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')




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
    print(user_id)

    # 2. SQL문 작성
    sql = '''
    SELECT * FROM posts WHERE user_id = %s
    '''

    # 3. select 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id,))
        posts = cursor.fetchall()

        if posts:
            # 모든 식물 정보를 JSON 형식으로 변환
            posts_list = []
            for posts in posts:
                posts_list.append({
                    "post_id": posts[0],
                    "post_title": posts[1],
                    "post_content": posts[2],
                    "user_id": posts[3],
                    "created_at": format_datetime(posts[4]),
                    "image_url": posts[5],
                })
            return jsonify({"status": "success", "data": posts_list})
        else:
            return jsonify({"status": "fail", "message": "No plants found for this user"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()
