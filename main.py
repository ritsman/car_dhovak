from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
import models
import schemas
from database import SessionLocal, engine
from init_db import create_tables
from excel_importer import import_clients_from_excel
import os
from typing import List
from fastapi.middleware.cors import CORSMiddleware


create_tables()

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Or specify your frontend's URL
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/import_clients/")
def import_clients(db: Session = Depends(get_db)):
    file_path = "clients.xlsx"
    if not os.path.exists(file_path):
        return {"error": "clients.xlsx not found"}
    import_clients_from_excel(file_path, db)
    return {"status": "Import completed"}

@app.get("/show_clients/", response_model=List[schemas.Client])
def get_clients(db: Session = Depends(get_db)):
    return db.query(models.Client).all()

@app.post("/clients/", response_model=schemas.Client)
def create_client(client: schemas.ClientCreate, db: Session = Depends(get_db)):
    db_client = models.Client(**client.dict())
    db.add(db_client)
    db.commit()
    db.refresh(db_client)
    return db_client

@app.get("/clients_records", response_model=List[schemas.Client])
async def get_clients(db: Session = Depends(get_db)):
    clients = db.query(models.Client).all()
    return clients


@app.post("/payments/", response_model=schemas.Payment)
def create_payment(payment: schemas.PaymentCreate, db: Session = Depends(get_db)):
    db_payment = models.Payment(**payment.dict())
    db.add(db_payment)
    db.commit()
    db.refresh(db_payment)
    return db_payment
