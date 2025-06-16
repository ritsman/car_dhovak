# init_db.py
from models import Base
from database import engine

def create_tables():
    Base.metadata.create_all(bind=engine)
