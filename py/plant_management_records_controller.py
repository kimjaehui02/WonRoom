from flask import Blueprint, request, jsonify
import pymysql

plant_management_records = Blueprint("plant_management_records", __name__, template_folder="templates")

@plant_management_records.route("/insert", methods=['POST'])
def insert_record():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    catalog_number = data.get('catalog_number')
    management_date = data.get('management_date')
    management_type = data.get('management_type')
    details = data.get('details')
    plant_id = data.get('plant_id')  # 추가된 필드

    print(catalog_number)
    print(management_date)
    print(management_type)
    print(details)
    print(plant_id)

    # # 입력 데이터 검증
    # if not all([catalog_number, management_date, management_type, plant_id]):
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
    INSERT INTO plant_management_records (catalog_number, management_date, management_type, details, plant_id)
    VALUES (%s, %s, %s, %s, %s)
    '''

    # 4. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (catalog_number, management_date, management_type, details, plant_id))
        row = cursor.rowcount
        db.commit()
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500  # 상태 코드 500 (서버 오류)
    finally:
        cursor.close()
        db.close()

    if row > 0:
        return jsonify({"status": "success", "message": "Record inserted successfully"})
    else:
        return jsonify({"status": "fail", "message": "Insert failed"}), 500
