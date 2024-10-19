import json
from faker import Faker
import random

fake = Faker()

def generar_coordinadores(num_coordinadores=300):
    coordinadores = []
 

    for i in range(num_coordinadores):
        coordinador = {
            "id": i + 1,
            "nombres": fake.first_name(),
            "apellidos": fake.last_name(),
            "tipoDocumento": random.choice(["TI", "CC", "CE", "PAS", "NIT"]),
            "numeroDocumento": fake.unique.random_number(digits=4),
            "correoElectronico": "manuelsuarez292005@gmail.com",
            "rol1": "COORDINADOR",
            "coordinacion": random.choice(["1", "2", "3", "4"]),
            "estado": random.choice([True, False])
        }
        coordinadores.append(coordinador)

    return coordinadores

# Generar los 200 aprendices
coordinadores = generar_coordinadores()

# Guardar los datos en un archivo JSON
with open('coordinadores.json', 'w') as json_file:
    json.dump(coordinadores, json_file, indent=4)

print("Archivo JSON creado con éxito.")