from flask import Blueprint, request, jsonify
import pymysql

queries = Blueprint("queries", __name__, template_folder="templates")

def format_datetime(dt):
    return dt.strftime("%Y-%m-%dT%H:%M:%S.%fZ")

@queries.route("/insert", methods=['POST'])
def insert_query():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    user_id = data.get('user_id')
    created_at = data.get('created_at')
    query_type = data.get('query_type')
    title = data.get('title')
    content = data.get('content')
    parent_query_id = data.get('parent_query_id', None)  # 선택적 필드

    print("/insert")
    print(user_id)
    print(created_at)
    print(query_type)
    print(title)
    print(content)
    print(parent_query_id)

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
    cursor = db.cursor()

    # 2. SQL문 작성
    sql = '''
    INSERT INTO queries (user_id, created_at, query_type, title, content, parent_query_id)
    VALUES (%s, %s, %s, %s, %s, %s)
    '''

    # 3. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id, created_at, query_type, title, content, parent_query_id))
        db.commit()
        
        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Query inserted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Insert failed"}), 500
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": "An error occurred"}), 500
    finally:
        cursor.close()
        db.close()

@queries.route("/select", methods=['POST'])
def select_query():
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
    SELECT * FROM queries WHERE user_id = %s
    '''

    # 3. select 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id,))
        queries = cursor.fetchall()

        if queries:
            # 모든 질의 정보를 JSON 형식으로 변환
            queries_list = []
            for query in queries:
                queries_list.append({
                    "query_id": query[0],
                    "user_id": query[1],
                    "created_at": format_datetime(query[2]),
                    "query_type": query[3],
                    "title": query[4],
                    "content": query[5],
                    "parent_query_id": query[6],
                })
            return jsonify({"status": "success", "data": queries_list})
        else:
            return jsonify({"status": "fail", "message": "No queries found for this user"}), 404
    except Exception as e:
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@queries.route("/update", methods=['POST'])
def update_query():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    query_id = data.get('query_id')
    user_id = data.get('user_id')
    title = data.get('title')
    content = data.get('content')
    query_type = data.get('query_type')
    parent_query_id = data.get('parent_query_id', None)  # 선택적 필드

    print("/update")
    print(query_id)
    print(user_id)
    print(title)
    print(content)
    print(query_type)
    print(parent_query_id)

    if not query_id or not user_id or not title or not content or not query_type:
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
    UPDATE queries 
    SET title = %s, content = %s, query_type = %s, parent_query_id = %s
    WHERE query_id = %s AND user_id = %s
    '''

    # 3. update 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (title, content, query_type, parent_query_id, query_id, user_id))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Query updated successfully"})
        else:
            return jsonify({"status": "fail", "message": "Query not found or no changes made"}), 404
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()

@queries.route("/delete", methods=['POST'])
def delete_query():
    # 0. 데이터 받아주기 (JSON 형식으로 받아오기)
    data = request.get_json()
    query_id = data.get('query_id')

    if not query_id:
        return jsonify({"status": "fail", "message": "Missing query_id"}), 400

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
    print(query_id)

    # 2. SQL문 작성
    sql = '''
    DELETE FROM queries WHERE query_id = %s
    '''

    # 3. delete 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (query_id,))
        db.commit()

        if cursor.rowcount > 0:
            return jsonify({"status": "success", "message": "Query deleted successfully"})
        else:
            return jsonify({"status": "fail", "message": "Query not found"}), 404
    except Exception as e:
        db.rollback()
        return jsonify({"status": "fail", "message": str(e)}), 500
    finally:
        cursor.close()
        db.close()
