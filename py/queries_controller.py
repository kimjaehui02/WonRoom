from flask import Blueprint, request, jsonify
import pymysql

queries = Blueprint("queries", __name__, template_folder="templates")

@queries.route("/insert", methods=['POST'])
def insert_query():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')
    created_at = data.get('created_at')
    query_type = data.get('query_type')
    title = data.get('title')
    content = data.get('content')
    parent_query_id = data.get('parent_query_id')

    # 입력 데이터 검증
    if not all([user_id, created_at, query_type, title, content]):
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
    INSERT INTO queries (user_id, created_at, query_type, title, content, parent_query_id)
    VALUES (%s, %s, %s, %s, %s, %s)
    '''

    # 4. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id, created_at, query_type, title, content, parent_query_id))
        row = cursor.rowcount
        db.commit()
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return jsonify({"status": "fail", "message": str(e)}), 500  # 상태 코드 500 (서버 오류)
    finally:
        cursor.close()
        db.close()

    if row > 0:
        return jsonify({"status": "success", "message": "Query inserted successfully"})
    else:
        return jsonify({"status": "fail", "message": "Insert failed"}), 500
