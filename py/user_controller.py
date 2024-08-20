from flask import Blueprint, request
# Blueprint flask 내에 있는 모듈
# flask 서버 내 파일 관리를 도와주는 모듈
import pymysql
import json

users = Blueprint("member", __name__, template_folder="templates")

@users.route('/')
def test():
    return "member Page"

# jdbc py - db 연결
# mysql 사용시에 pymysql

@users.route('/test')
def dbtest():
    # db 연결
    db = pymysql.connect(
            host='project-db-cgi.smhrd.com',  # URL
            user='plant',                     # 사용자 이름
            password='1234',                  # 비밀번호
            db='plant',                       # 데이터베이스 이름
            charset='utf8',                   # 인코딩
            port=3307                         # 포트
        )
    # pymysql.connect(host = ip주소(로컬호스트), user id 값, user pw 값, db 스키마 값, 인코딩)

    if db :
        return 'success'
    else :
        return 'fail'



@users.route("/insert", methods=['POST'])
def insert():
    # 0. 데이터 받아주기
    user_id = request.form.get('user_id')
    user_pw = request.form.get('user_pw')
    user_nick = request.form.get('user_nick')
    user_email = request.form.get('user_email')
    reg_date = request.form.get('reg_date')

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
    INSERT INTO users (user_id, user_pw, user_nick, user_email, reg_date)
    VALUES (%s, %s, %s, %s, %s)
    '''

    # 4. insert 실행, 파라미터 채워주기
    try:
        cursor.execute(sql, (user_id, user_pw, user_nick, user_email, reg_date))
        row = cursor.rowcount
        db.commit()
    except Exception as e:
        db.rollback()  # 오류 발생 시 롤백
        return f"Error: {str(e)}"
    finally:
        cursor.close()
        db.close()

    if row > 0:
        return "success"
    else:
        return "fail"


@users.route('/login')
def login() :
    json_data = []
    # 0. 데이터 가지고 오기
    id = request.args.get("id")
    pw = request.args.get("pw")

    # 1. DB 연결
    db = pymysql.connect(host='localhost',user='root', password='1234', db='flutter_db',charset='utf8')

    # 2. 데이터 접근을 위한 객체 - cursor
    cursor = db.cursor()

    # 3. sql문
    sql = "select * from member where id = %(id)s and pw = %(pw)s"

    # 4. sql문 실행
    dict1 = {"id" : id, "pw" : pw}
    cursor.execute(sql, dict1)

    # 5. select문 값 받아주기
    result = cursor.fetchall() 
    # select 문의 결과값 모든 행을 가져오기
    # result = cursor.fetchone() 
    # select 문의 결과값 중 상단 1개만 가지고오기
    # cursor.fetchmany(3)
    # select 문의 결과값 중 n개의 데이터를 출력 
    print(result)
    row_header = [i[0] for i in cursor.description]
    print(row_header)    
    for i in result:
        # zip() 서로 다른 리스트 하나로 묶는 내장 함수 
        # -> 묶인 결과는 튜플 형식
        # print(dict(zip(row_header, i)))
        json_data.append(dict(zip(row_header, i)))
    print(json_data)

    # json.dumps(데이터)
    data = json.dumps(json_data)

    # cursor 객체는 데이터의 컬럼명..
    # for i in cursor.description:
    #     print(i[0])


        
    print(cursor.description[0])

    # 튜플은 리턴이 안된다.
    # 튜플 -> json 형식으로 바꾸어 준다
    # 리스트 형식
    return data


@users.route("/update")
def update():
    # 0. 데이터 가지고 오기
    id = request.args.get("id")
    pw = request.args.get("pw")
    age = int(request.args.get("age"))
    name = request.args.get("name")

    # 1. DB 연결
    db = pymysql.connect(host='localhost', user='root', password='1234', db='flutter_db', charset='utf8')

    # 2. 데이터 접근을 위한 객체 - cursor
    cursor = db.cursor()

    # 3. sql문
    sql = "UPDATE member SET pw = %(pw)s, age = %(age)s, name = %(name)s WHERE id = %(id)s"

    # 4. sql문 실행
    dict1 = {"id": id, "pw": pw, "age": age, "name": name}
    cursor.execute(sql, dict1)

    # 5. 커밋 및 커서 닫기
    db.commit()
    row = cursor.rowcount


    cursor.close()

    # Database 닫기
    db.close()

    # 결과 반환
    if row > 0:
        return "success"
    else:
        return "fail"

# @member.route("/update")
# def update():
#     #업데이트 기능 만들기
#     id = request.args.get('id')
#     pw = request.args.get('pw')
#     name = request.args.get('name')
#     age = int(request.args.get('age'))
#     # MySQL 데이터베이스 연결
#     db = pymysql.connect(host='localhost', user='root', password='123456', db='flutter_db', charset='utf8')
#     # 데이터에 접근
#     cursor = db.cursor()
#     # SQL query 작성
#     sql = 'update member set pw = %(pw)s, age = %(age)s, name = %(name)s where id = %(id)s'
    
#     cursor.execute(sql,{'id': id, 'pw':pw,'age':age,'name':name })
#     row = cursor.rowcount

#     # 수정 사항 db에 저장
#     db.commit()
 
# # Database 닫기
#     db.close()


#     if row>0:
#         sendMsg = "success"
#     else:
#         sendMsg = 'fail'
#     return sendMsg


@users.route('/delete')
def delete():
    #회원 탈퇴기능 만들기
    id = request.args.get('id')

    # MySQL 데이터베이스 연결
    # 1. DB 연결
    db = pymysql.connect(host='localhost', user='root', password='1234', db='flutter_db', charset='utf8')
    # 데이터에 접근
    cursor = db.cursor()
    # SQL query 작성
    sql = 'delete from member where id = %(id)s'
    cursor.execute(sql,{'id': id })
    row = cursor.rowcount

    # 수정 사항 db에 저장
    db.commit()
 
    # Database 닫기
    db.close()

    if row>0:
        sendMsg = "success"
    else:
        sendMsg = 'fail'
    return sendMsg


