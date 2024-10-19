import json
from faker import Faker
import random

fake = Faker()

def generar_abogados(num_abogados=300):
    abogados = []
 

    for i in range(num_abogados):
        abogado = {
            "id": i + 1,
            "nombres": fake.first_name(),
            "apellidos": fake.last_name(),
            "tipoDocumento": random.choice(["TI", "CC", "CE", "PAS", "NIT"]),
            "numeroDocumento": fake.unique.random_number(digits=4),
            "correoElectronico": "manuelsuarez292005@gmail.com",
            "rol1": "ABOGADO",
            "estado": random.choice([True, False])
        }
        abogados.append(abogado)

    return abogados

# Generar los 200 aprendices
abogados = generar_abogados()

# Guardar los datos en un archivo JSON
with open('abogados.json', 'w') as json_file:
    json.dump(abogados, json_file, indent=4)

print("Archivo JSON creado con éxito.")