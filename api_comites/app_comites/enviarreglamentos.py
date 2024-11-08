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
with open('reglamentos.json', 'r', encoding='utf-8') as file:
    reglamentos = json.load(file)

# Insertar los datos en la base de datos
for reglamento in reglamentos:
    # Validar longitud de los campos (ajustar tamaños según tu esquema de base de datos)
   

    cursor.execute('''
        INSERT INTO comites_api_reglamento (id, capitulo, numeral, descripcion, academico, disciplinario, gravedad)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        ON CONFLICT (id) DO UPDATE SET
            capitulo = EXCLUDED.capitulo,
            numeral = EXCLUDED.numeral,
            descripcion = EXCLUDED.descripcion,
            academico = EXCLUDED.academico,
            disciplinario = EXCLUDED.disciplinario,
            gravedad = EXCLUDED.gravedad;
    ''', (
        reglamento['id'], reglamento['capitulo'], reglamento['numeral'], reglamento['descripcion'],
        reglamento['academico'], reglamento['disciplinario'], reglamento['gravedad']
    ))

conn.commit()
cursor.close()
conn.close()

print("Datos importados correctamente.")
