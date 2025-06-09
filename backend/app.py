from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Erlaubt Anfragen von Flutter-App

@app.route('/ask', methods=['POST'])
def ask():
    data = request.get_json()
    question = data.get('question', '')

    # Einfache Dummy-Antwort zur Demonstration
    answer = f"Du hast gefragt: '{question}' – das ist eine gute Frage!"
    return jsonify({'answer': answer})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)