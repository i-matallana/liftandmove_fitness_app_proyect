from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware  # ← línea nueva
from pydantic import BaseModel, EmailStr
import pymysql
import bcrypt
from typing import Any

app = FastAPI()

# ← Agrega este bloque completo después de crear app
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# Herramienta para encriptar y verificar contraseñas

def verify_password(plain_password: str, hashed_password: str) -> bool:
    return bcrypt.checkpw(
        plain_password.encode("utf-8"),
        hashed_password.encode("utf-8")
    )

def get_password_hash(password: str) -> str:
    salt = bcrypt.gensalt()
    return bcrypt.hashpw(password.encode("utf-8"), salt).decode("utf-8")
# Conexión a MySQL
def get_db_connection():
    return pymysql.connect(
        host='localhost',
        user='root',
        password='',
        database='rutinas_ejercicios',
        cursorclass=pymysql.cursors.DictCursor
    )

class UserDataRegister(BaseModel):
    idUsu: str
    nombreUsu: str
    correoUsu: EmailStr
    contrasenha: str
    sexo: str
    altura_cm: int
    peso: int
    objetivo_entreno: str

class UserDataLogin(BaseModel):
    nombreUsu: str
    contrasenha: str

@app.get("/")
def root():
    return {"message": "API funcionando correctamente"}

# --- RUTA 1: REGISTRAR UN USUARIO ---
@app.post("/register")
def register(data: UserDataRegister) -> Any:
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            # Evitamos id duplicado
            cursor.execute("SELECT * FROM usuarios WHERE idUsu = %s", (data.idUsu,))
            if cursor.fetchone():
                raise HTTPException(status_code=400, detail="El id del usuario ya existe")

            # Evitamos nombre de usuario duplicado
            cursor.execute("SELECT * FROM usuarios WHERE nombreUsu = %s", (data.nombreUsu,))
            if cursor.fetchone():
                raise HTTPException(status_code=400, detail="El nombre de usuario ya existe")

            # Evitamos correo duplicado
            cursor.execute("SELECT * FROM usuarios WHERE correoUsu = %s", (data.correoUsu,))
            if cursor.fetchone():
                raise HTTPException(status_code=400, detail="El correo ya está registrado")

            # Validación simple del sexo
            if data.sexo not in ["M", "F"]:
                raise HTTPException(status_code=400, detail="El sexo debe ser 'M' o 'F'")

            # ENCRIPTAMOS LA CONTRASEÑA ANTES DE GUARDARLA
            hashed_password = get_password_hash(data.contrasenha)

            sql = """
                INSERT INTO usuarios
                (idUsu, nombreUsu, correoUsu, contrasenha, sexo, altura_cm, peso, objetivo_entreno)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql, (
                data.idUsu,
                data.nombreUsu,
                data.correoUsu,
                hashed_password,
                data.sexo,
                data.altura_cm,
                data.peso,
                data.objetivo_entreno
            ))
            connection.commit()

            return {"success": True, "message": "Usuario creado exitosamente"}
    finally:
        connection.close()

# --- RUTA 2: INICIO DE SESIÓN ---
@app.post("/login")
def login(data: UserDataLogin) -> Any:
    connection = get_db_connection()
    try:
        with connection.cursor() as cursor:
            sql = "SELECT * FROM usuarios WHERE nombreUsu = %s"
            cursor.execute(sql, (data.nombreUsu,))
            user = cursor.fetchone()

            # Validamos que el usuario exista y la contraseña plana coincida con el hash oculto
            if not user or not verify_password(data.contrasenha, user['contrasenha']):
                raise HTTPException(status_code=401, detail="Credenciales incorrectas")

            return {
                "success": True,
                "message": "Autenticación exitosa",
                "token": "token-temporal"
            }
    finally:
        connection.close()