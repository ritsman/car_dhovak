import pandas as pd
import models  # Make sure models.py is in the same directory

def import_clients_from_excel(file_path: str, db):
    df = pd.read_excel(file_path)
    for _, row in df.iterrows():
        flatno = str(row['flatno']).strip()
        mobile = str(row['mobile']).strip()
        name = str(row['name']).strip()

        # Check if client with same flatno and name exists
        existing = db.query(models.Client).filter_by(flatno=flatno, name=name).first()
        if existing:
            existing.mobile = mobile
        else:
            client = models.Client(flatno=flatno, mobile=mobile, name=name)
            db.add(client)
    db.commit()
