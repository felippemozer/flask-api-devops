import os


MONGO_DB = "users"


class DevConfig():
    MONGODB_SETTINGS = {
        "db": MONGO_DB,
        "host": os.getenv("MONGO_HOST"),
        "username": os.getenv("MONGO_USERNAME"),
        "password": os.getenv("MONGO_PASSWORD")
    }


class ProdConfig():
    MONGODB_SETTINGS = {
        "host": os.getenv("MONGO_HOST"),
    }


class MockConfig():
    MONGODB_SETTINGS = {
        "db": MONGO_DB,
        "host": "mongomock://localhost",
    }
