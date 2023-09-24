from flask import Flask
import pymysql

app = Flask(__name__)

# 配置 MySQL 连接信息
db_config = {
    'host': '192.168.98.131',
    'user': 'read',
    'password': '123456',
    'db': 'tennis',
    'charset': 'utf8mb4',
}

def connect_db():
    return pymysql.connect(**db_config)

@app.route('/')
def index():
    # 在这里执行与数据库的交互操作
    connection = connect_db()
    cursor = connection.cursor()
    
    try:
        cursor.execute("SHOW TABLES")
        data = cursor.fetchall()
        return str(data)
    finally:
        cursor.close()
        connection.close()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)

