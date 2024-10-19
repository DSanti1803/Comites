import json
from faker import Faker
import random

fake = Faker()

def generar_instructores(num_instructores=300):
    instructores = []
 

    for i in range(num_instructores):
        instructor = {
            "id": i + 1,
            "nombres": fake.first_name(),
            "apellidos": fake.last_name(),
            "tipoDocumento": random.choice(["TI", "CC", "CE", "PAS", "NIT"]),
            "numeroDocumento": fake.unique.random_number(digits=4),
            "correoElectronico": "manuelsuarez292005@gmail.com",
            "rol1": "INSTRUCTOR",
            "coordinacion": random.choice(["1", "2", "3", "4"]),
            "estado": random.choice([True, False])
        }
        instructores.append(instructor)

    return instructores

# Generar los 200 aprendices
instructores = generar_instructores()

# Guardar los datos en un archivo JSON
with open('instructores.json', 'w') as json_file:
    json.dump(instructores, json_file, indent=4)

print("Archivo JSON creado con éxito.")