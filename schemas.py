from pydantic import BaseModel
from datetime import date

class ClientBase(BaseModel):
    flatno: str
    mobile: str
    name: str

class ClientCreate(ClientBase):
    pass

class Client(ClientBase):
    id: int
    class Config:
        orm_mode = True

class PaymentBase(BaseModel):
    flatno: str
    received_date: date
    amount: float
    narration: str

class PaymentCreate(PaymentBase):
    pass

class Payment(PaymentBase):
    id: int
    class Config:
        orm_mode = True
