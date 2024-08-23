from application import create_app

import os
import socket


if os.getenv("FLASK_ENV") == "development":
    app = create_app("config.DevConfig")
else:
    app = create_app("config.ProdConfig")


if __name__ == "__main__":
    ip_address = socket.gethostbyname(socket.gethostname())
    app.run(debug=True, host=ip_address)
