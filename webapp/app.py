import os
from flask import Flask
from flaskext.mysql import MySQL      # For newer versions of flask-mysql 
# from flask.ext.mysql import MySQL   # For older versions of flask-mysql
app = Flask(__name__)

mysql = MySQL()

database_host = 'DATABASE_HOST' in os.environ and os.environ['DATABASE_HOST'] or  'localhost'
db_user       = 'DATABASE_USER' in os.environ and os.environ['DATABASE_USER'] 
password      = 'DATABASE_PASSWORD' in os.environ and os.environ['DATABASE_PASSWORD'] 
db_name       = 'DATABASE_DB' in os.environ and os.environ['DATABASE_DB'] or  'test'

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = db_user
app.config['MYSQL_DATABASE_PASSWORD'] = password
app.config['MYSQL_DATABASE_DB'] = db_name
app.config['MYSQL_DATABASE_HOST'] = database_host
app.config['MYSQL_DATABASE_PORT'] = 3306
mysql.init_app(app)

conn = mysql.connect()

cursor = conn.cursor()

@app.route("/")
def main():
    return "Welcome!"

@app.route('/how are you')
def hello():
    return 'I am good, how about you?'

@app.route('/read from database')
def read():
    cursor.execute("SELECT * FROM employees")
    row = cursor.fetchone()
    result = []
    while row is not None:
      result.append(row[0])
      row = cursor.fetchone()

    return ",".join(result)

if __name__ == "__main__":
    app.run()
