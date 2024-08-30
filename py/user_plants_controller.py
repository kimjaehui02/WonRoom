from flask import Blueprint, request, jsonify
from datetime import datetime
# Blueprint flask 내에 있는 모듈
# flask 서버 내 파일 관리를 도와주는 모듈
import pymysql

user_plants = Blueprint("user_plants", __name__, template_folder="templates")

def format_datetime(dt):
    return dt.strftime("%Y-%m-%dT%H:%M:%S.%fZ")

@user_plants.route("/insert", methods=['POST'])
def insert_plant():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')
    catalog_number = data.get('catalog_number')
    diary_title = data.get('diary_title')
    next_watering_date = data.get('next_watering_date')
    created_at = data.get('created_at')  # 클라이언트에서 받은 시간

    print("/insert")
    print(user_id)
    print(catalog_number)
    print(diary_title)
    print(next_watering_date)
    print(created_at)

    # # 필수 데이터 체크
    # if not all([user_id, catalog_number, diary_title, next_watering_date, created_at]):
    #     return jsonify({"status": "fail", "message": "All fields are required"}), 400

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
    INSERT INTO user_plants (user_id, catalog_number, diary_title, next_watering_date, created_at)
    VALUES (%s, %s, %s, %s, %s)
    '''

    # 3. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id, catalog_number, diary_title, next_watering_date, created_at))
        db.commit()
        return jsonify({"status": "success", "message": "Plant added successfully"})
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@user_plants.route("/select", methods=['POST'])
def select_plants_by_user():
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
    SELECT * FROM user_plants WHERE user_id = %s
    '''

    # 3. select 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id,))
        plants = cursor.fetchall()

        if plants:
            # 모든 식물 정보를 JSON 형식으로 변환
            plants_list = []
            for plant in plants:
                plants_list.append({
                    "plant_id": plant[0],
                    "user_id": plant[1],
                    "catalog_number": plant[2],
                    "diary_title": plant[3],
                    "next_watering_date": format_datetime(plant[4]),
                    "created_at": format_datetime(plant[5])
                })
            return jsonify({"status": "success", "data": plants_list})
        else:
            return jsonify({"status": "fail", "message": "No plants found for this user"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()



@user_plants.route("/update_diary_title", methods=['POST'])
def update_plant_diary_title():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    plant_id = data.get('plant_id')
    diary_title = data.get('diary_title')
    # next_watering_date = data.get('next_watering_date')

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

    print("/update")
    print(f"Plant ID: {plant_id}, Diary Title: {diary_title}")

    # 2. SQL문 작성
    sql = '''
    UPDATE user_plants
    SET diary_title = %s
    WHERE plant_id = %s
    '''

    # 3. 업데이트 실행, 파라미터 채워주기
    try:
        # Prepare next_watering_date for SQL


        cursor.execute(sql, (diary_title, plant_id))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Plant information updated successfully"})
        else:
            return jsonify({"status": "fail", "message": "Plant not found"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@user_plants.route("/update_watering_date", methods=['POST'])
def update_plant_next_watering_date():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    plant_id = data.get('plant_id')
    next_watering_date = data.get('next_watering_date')

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

    print("/update")
    print(f"Plant ID: {plant_id}, Next Watering Date: {next_watering_date}")

    # 2. 날짜 문자열을 datetime 객체로 변환
    try:
        if next_watering_date:
            # 문자열을 datetime 객체로 변환하고 다시 문자열로 포맷
            next_watering_date = datetime.fromisoformat(next_watering_date.replace('Z', '+00:00')).strftime('%Y-%m-%d')

        # 3. SQL문 작성
        sql = '''
        UPDATE user_plants
        SET next_watering_date = %s
        WHERE plant_id = %s
        '''

        # 4. 업데이트 실행, 파라미터 채워주기
        cursor.execute(sql, (next_watering_date, plant_id))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Plant information updated successfully"})
        else:
            return jsonify({"status": "fail", "message": "Plant not found"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@user_plants.route("/delete", methods=['POST'])
def delete_plant():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    plant_id = data.get('plant_id')

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
    print(f"Plant ID: {plant_id}")

    # 2. SQL문 작성
    sql = '''
    DELETE FROM user_plants
    WHERE plant_id = %s
    '''

    # 3. 삭제 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (plant_id,))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Plant deleted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Plant not found"}), 404
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()


