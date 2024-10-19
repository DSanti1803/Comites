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
with open('aprendices.json', 'r') as file:
    aprendices = json.load(file)

# Insertar los datos en la base de datos
for aprendiz in aprendices:
    cursor.execute('''
        INSERT INTO comites_api_usuarioaprendiz (id, nombres, apellidos, "tipoDocumento", "numeroDocumento", ficha, programa, "correoElectronico", rol1, estado, coordinacion)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (id) DO UPDATE SET
            nombres = EXCLUDED.nombres,
            apellidos = EXCLUDED.apellidos,
            "tipoDocumento" = EXCLUDED."tipoDocumento",
            "numeroDocumento" = EXCLUDED."numeroDocumento",
            ficha = EXCLUDED.ficha,
            programa = EXCLUDED.programa,
            "correoElectronico" = EXCLUDED."correoElectronico",
            rol1 = EXCLUDED.rol1,
            estado = EXCLUDED.estado,
            coordinacion = EXCLUDED.coordinacion;
    ''', (
        aprendiz['id'], aprendiz['nombres'], aprendiz['apellidos'], aprendiz['tipoDocumento'],
        aprendiz['numeroDocumento'], aprendiz['ficha'], aprendiz['programa'], aprendiz['correoElectronico'],
        aprendiz['rol1'], aprendiz['estado'], aprendiz['coordinacion']
    ))
    
    

conn.commit()
cursor.close()
conn.close()

print("Datos importados correctamente.")
