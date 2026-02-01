from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host="127.0.0.1"
        user=                  #username here in your mysql
        password=,             #password here in your mysql
        database="hospital_dashboard_M"
    )


@app.route("/health")
def health():
    return {"status": "API is running"}

@app.route("/patients")
def patients():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM patients")
    data = cursor.fetchall()
    conn.close()
    return jsonify(data)

if __name__ == "__main__":
    app.run(debug=True, port=5001)

