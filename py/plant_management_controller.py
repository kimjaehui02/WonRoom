from flask import Blueprint, request, jsonify
import pymysql

plant_management = Blueprint("plant_management", __name__, template_folder="templates")

def format_date(date):
    return date.strftime("%Y-%m-%d")

@plant_management.route("/insert", methods=['POST'])
def insert_record():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    catalog_number = data.get('catalog_number')
    management_date = data.get('management_date')
    management_type = data.get('management_type')
    details = data.get('details')
    plant_id = data.get('plant_id')

    print("/insert")
    print(catalog_number)
    print(management_date)
    print(management_type)
    print(details)
    print(plant_id)

    # # 입력 데이터 검증
    # if not all([catalog_number, management_date, management_type, details, plant_id]):
    #     print("asdasdas")
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
    cursor = db.cursor()

    # 2. SQL문 작성
    sql = '''
    INSERT INTO plant_management_records (catalog_number, management_date, management_type, details, plant_id)
    VALUES (%s, %s, %s, %s, %s)
    '''

    # 3. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (catalog_number, management_date, management_type, details, plant_id))
        db.commit()
        
        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Record inserted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Insert failed"}), 500
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": "An error occurred"}), 500
    finally:
        cursor.close()
        db.close()
@plant_management.route("/select", methods=['POST'])
def select_records():
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

    print("/select")
    print(plant_id)

    # 2. SQL문 작성 (날짜가 빠른 순서로 정렬)
    sql = '''
    SELECT * FROM plant_management_records
    WHERE plant_id = %s
    ORDER BY management_date ASC
    '''

    # 3. select 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (plant_id,))
        records = cursor.fetchall()

        if records:
            # 모든 관리 기록 정보를 JSON 형식으로 변환
            records_list = []
            for record in records:
                records_list.append({
                    "record_id": record[0],
                    "catalog_number": record[1],
                    "management_date": format_date(record[2]),
                    "management_type": record[3],
                    "details": record[4],
                    "plant_id": record[5],
                })
            return jsonify({"status": "success", "data": records_list})
        else:
            return jsonify({"status": "fail", "message": "No records found for this plant"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()


@plant_management.route("/update", methods=['POST'])
def update_record():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    record_id = data.get('record_id')
    catalog_number = data.get('catalog_number')
    management_date = data.get('management_date')
    management_type = data.get('management_type')
    details = data.get('details')
    plant_id = data.get('plant_id')

    print("/update")
    print(record_id)
    print(catalog_number)
    print(management_date)
    print(management_type)
    print(details)
    print(plant_id)

    if not all([record_id, catalog_number, management_date, management_type, details, plant_id]):
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
    UPDATE plant_management_records 
    SET catalog_number = %s, management_date = %s, management_type = %s, details = %s, plant_id = %s
    WHERE record_id = %s
    '''

    # 3. update 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (catalog_number, management_date, management_type, details, plant_id, record_id))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Record updated successfully"})
        else:
            return jsonify({"status": "fail", "message": "Record not found or no changes made"}), 404
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@plant_management.route("/delete", methods=['POST'])
def delete_record():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    record_id = data.get('record_id')

    if not record_id:
        return jsonify({"status": "fail", "message": "Missing record_id"}), 400

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
    print(record_id)

    # 2. SQL문 작성
    sql = '''
    DELETE FROM plant_management_records WHERE record_id = %s
    '''

    # 3. delete 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (record_id,))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Record deleted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Record not found"}), 404
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()
