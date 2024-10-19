import json
from faker import Faker
import random

fake = Faker()

def generar_aprendices(num_aprendices=400):
    aprendices = []
    fichas = [f"{str(i).zfill(4)}" for i in range(1, num_aprendices // 20 + 1)]  # Fichas para cada 20 aprendices

    for i in range(num_aprendices):
        ficha_actual = fichas[i // 20]  # Cada 20 aprendices tendrán la misma ficha
        # Asignar la coordinación según el índice de la ficha
        coordinacion = str((i // 20) % 4 + 1)  # Coordinaciones 1, 2, 3, 4, en secuencia
        aprendiz = {
            "id": i + 1,
            "nombres": fake.first_name(),
            "apellidos": fake.last_name(),
            "tipoDocumento": random.choice(["TI", "CC", "CE", "PAS", "NIT"]),
            "numeroDocumento": fake.unique.random_number(digits=10),
            "ficha": ficha_actual,
            "programa": fake.job(),
            "correoElectronico": fake.email(),
            "rol1": "APRENDIZ",
            "estado": random.choice([True, False]),
            "coordinacion": coordinacion  # Todos los de la misma ficha tendrán la misma coordinación
        }
        aprendices.append(aprendiz)

    return aprendices

# Generar los 400 aprendices
aprendices = generar_aprendices()

# Guardar los datos en un archivo JSON
with open('aprendices.json', 'w') as json_file:
    json.dump(aprendices, json_file, indent=4)

print("Archivo JSON creado con éxito.")