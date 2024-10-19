import json
from faker import Faker
import random

fake = Faker()

def generar_bienestar(num_bienestar=300):
    bienestar1 = []
 

    for i in range(num_bienestar):
        bienestar = {
            "id": i + 1,
            "nombres": fake.first_name(),
            "apellidos": fake.last_name(),
            "tipoDocumento": random.choice(["TI", "CC", "CE", "PAS", "NIT"]),
            "numeroDocumento": fake.unique.random_number(digits=4),
            "correoElectronico": "manuelsuarez292005@gmail.com",
            "rol1": "BIENESTAR",
            "estado": random.choice([True, False])
        }
        bienestar1.append(bienestar)

    return bienestar1

# Generar los 200 aprendices
bienestar1 = generar_bienestar()

# Guardar los datos en un archivo JSON
with open('bienestar1.json', 'w') as json_file:
    json.dump(bienestar1, json_file, indent=4)

print("Archivo JSON creado con éxito.")