import json
import psycopg2

# Configurar la conexión a la base de datos
conn = psycopg2.connect(
    dbname="comites",
    user="postgres",
    password="ladoblem",
    host="localhost",  # o la dirección de tu servidor PostgreSQL
    port="5432"
    
)

cursor = conn.cursor()

# Leer el archivo JSON
with open('instructores.json', 'r') as file:
    instructores = json.load(file)

# Insertar los datos en la base de datos
for instructor in instructores:
    cursor.execute('''
        INSERT INTO comites_api_instructor (id, nombres, apellidos, "tipoDocumento", "numeroDocumento", "correoElectronico", rol1,  coordinacion, estado)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (id) DO UPDATE SET
            nombres = EXCLUDED.nombres,
            apellidos = EXCLUDED.apellidos,
            "tipoDocumento" = EXCLUDED."tipoDocumento",
            "numeroDocumento" = EXCLUDED."numeroDocumento",
            "correoElectronico" = EXCLUDED."correoElectronico",
            rol1 = EXCLUDED.rol1,
            coordinacion = EXCLUDED.rol1,
            estado = EXCLUDED.estado;
    ''', (
        instructor['id'], instructor['nombres'], instructor['apellidos'], instructor['tipoDocumento'],
        instructor['numeroDocumento'],  instructor['correoElectronico'],
        instructor['rol1'],  instructor['coordinacion'], instructor['estado']
    ))
    
with open('coordinadores.json', 'r') as file:
    coordinadores = json.load(file)

# Insertar los datos en la base de datos
for coordinador in coordinadores:
    cursor.execute('''
        INSERT INTO comites_api_coordinador (id, nombres, apellidos, "tipoDocumento", "numeroDocumento", "correoElectronico", rol1,  coordinacion, estado)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (id) DO UPDATE SET
            nombres = EXCLUDED.nombres,
            apellidos = EXCLUDED.apellidos,
            "tipoDocumento" = EXCLUDED."tipoDocumento",
            "numeroDocumento" = EXCLUDED."numeroDocumento",
            "correoElectronico" = EXCLUDED."correoElectronico",
            rol1 = EXCLUDED.rol1,
            coordinacion = EXCLUDED.rol1,
            estado = EXCLUDED.estado;
    ''', (
        coordinador['id'], coordinador['nombres'], coordinador['apellidos'], coordinador['tipoDocumento'],
        coordinador['numeroDocumento'],  coordinador['correoElectronico'],
        coordinador['rol1'],  coordinador['coordinacion'], coordinador['estado']
    ))
    
with open('abogados.json', 'r') as file:
    abogados = json.load(file)

# Insertar los datos en la base de datos
for abogado in abogados:
    cursor.execute('''
        INSERT INTO comites_api_abogado (id, nombres, apellidos, "tipoDocumento", "numeroDocumento", "correoElectronico", rol1,  estado)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (id) DO UPDATE SET
            nombres = EXCLUDED.nombres,
            apellidos = EXCLUDED.apellidos,
            "tipoDocumento" = EXCLUDED."tipoDocumento",
            "numeroDocumento" = EXCLUDED."numeroDocumento",
            "correoElectronico" = EXCLUDED."correoElectronico",
            rol1 = EXCLUDED.rol1,
            estado = EXCLUDED.estado;
    ''', (
        abogado['id'], abogado['nombres'], abogado['apellidos'], abogado['tipoDocumento'],
        abogado['numeroDocumento'],  abogado['correoElectronico'],
        abogado['rol1'], abogado['estado']
    ))

with open('bienestar1.json', 'r') as file:
    bienestar1 = json.load(file)

# Insertar los datos en la base de datos
for bienestar in bienestar1:
    cursor.execute('''
        INSERT INTO comites_api_bienestar (id, nombres, apellidos, "tipoDocumento", "numeroDocumento", "correoElectronico", rol1,  estado)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (id) DO UPDATE SET
            nombres = EXCLUDED.nombres,
            apellidos = EXCLUDED.apellidos,
            "tipoDocumento" = EXCLUDED."tipoDocumento",
            "numeroDocumento" = EXCLUDED."numeroDocumento",
            "correoElectronico" = EXCLUDED."correoElectronico",
            rol1 = EXCLUDED.rol1,
            estado = EXCLUDED.estado;
    ''', (
        bienestar['id'], bienestar['nombres'], bienestar['apellidos'], bienestar['tipoDocumento'],
        bienestar['numeroDocumento'],  bienestar['correoElectronico'],
        bienestar['rol1'], bienestar['estado']
    ))
conn.commit()
cursor.close()
conn.close()

print("Datos importados correctamente.")
