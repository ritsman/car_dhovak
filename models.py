from sqlalchemy import Column, Integer, String, Date, Float
from database import Base

class Client(Base):
    __tablename__ = "clients"
    id = Column(Integer, primary_key=True, index=True)
    flatno = Column(String, nullable=False)
    mobile = Column(String, nullable=False)
    name = Column(String, nullable=False)

class Payment(Base):
    __tablename__ = "payments"
    id = Column(Integer, primary_key=True, index=True)
    flatno = Column(String, nullable=False)
    received_date = Column(Date, nullable=False)
    amount = Column(Float, nullable=False)
    narration = Column(String)
