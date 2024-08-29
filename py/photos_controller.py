from flask import Blueprint, request, jsonify
import pymysql

photos = Blueprint("photos", __name__, template_folder="templates")

def format_datetime(dt):
    return dt.strftime("%Y-%m-%dT%H:%M:%S.%fZ")

@photos.route("/insert", methods=['POST'])
def insert_photo():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    post_id = data.get('post_id')
    category = data.get('category')
    is_primary = data.get('is_primary', 0)  # 기본값은 0
    file_name = data.get('file_name')
    server_path = data.get('server_path')
    file_type = data.get('file_type')
    created_at = data.get('created_at')

    print("/insert")
    print(post_id)
    print(category)
    print(is_primary)
    print(file_name)
    print(server_path)
    print(file_type)
    print(created_at)

    # 입력 데이터 검증
    if not all([post_id, category, file_name, server_path, file_type, created_at]):
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
    INSERT INTO photos (post_id, category, is_primary, file_name, server_path, file_type, created_at)
    VALUES (%s, %s, %s, %s, %s, %s, %s)
    '''

    # 3. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (post_id, category, is_primary, file_name, server_path, file_type, created_at))
        db.commit()
        
        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Photo inserted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Insert failed"}), 500
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": "An error occurred"}), 500
    finally:
        cursor.close()
        db.close()


@photos.route("/select", methods=['POST'])
def select_photos():
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
    SELECT * FROM photos WHERE post_id = %s
    '''

    # 3. select 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (post_id,))
        photos_data = cursor.fetchall()

        if photos_data:
            # 모든 사진 정보를 JSON 형식으로 변환
            photos_list = []
            for photo in photos_data:
                photos_list.append({
                    "photo_id": photo[0],
                    "post_id": photo[1],
                    "category": photo[2],
                    "is_primary": photo[3],
                    "file_name": photo[4],
                    "server_path": photo[5],
                    "file_type": photo[6],
                    "created_at": format_datetime(photo[7]),
                })
            return jsonify({"status": "success", "data": photos_list})
        else:
            return jsonify({"status": "fail", "message": "No photos found for this post"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@photos.route("/update", methods=['POST'])
def update_photo():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    photo_id = data.get('photo_id')
    post_id = data.get('post_id')
    category = data.get('category')
    is_primary = data.get('is_primary')
    file_name = data.get('file_name')
    server_path = data.get('server_path')
    file_type = data.get('file_type')

    print("/update")
    print(photo_id)
    print(post_id)
    print(category)
    print(is_primary)
    print(file_name)
    print(server_path)
    print(file_type)

    if not photo_id or not post_id or not file_name or not server_path or not file_type:
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
    UPDATE photos
    SET post_id = %s, category = %s, is_primary = %s, file_name = %s, server_path = %s, file_type = %s
    WHERE photo_id = %s
    '''

    # 3. update 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (post_id, category, is_primary, file_name, server_path, file_type, photo_id))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Photo updated successfully"})
        else:
            return jsonify({"status": "fail", "message": "Photo not found or no changes made"}), 404
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@photos.route("/delete", methods=['POST'])
def delete_photo():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    photo_id = data.get('photo_id')

    if not photo_id:
        return jsonify({"status": "fail", "message": "Missing photo_id"}), 400

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
    print(photo_id)

    # 2. SQL문 작성
    sql = '''
    DELETE FROM photos WHERE photo_id = %s
    '''

    # 3. delete 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (photo_id,))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Photo deleted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Photo not found"}), 404
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()
