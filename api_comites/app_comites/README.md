# Backend del Aplicativo de Comités

## Requisitos previos

Antes de instalar y ejecutar el backend, asegúrate de tener los siguientes requisitos instalados:

- **Python 3.12.5**
- **Django 5.1.1**
- **PostgreSQL 16**

## Instalación

### 1. Clonar el repositorio

```sh
  git clone https://github.com/tu-repositorio/Comites-Sena.git
  cd Comites-Sena/backend
```

### 2. Crear y activar un entorno virtual

```sh
  python -m venv venv
  source venv/bin/activate  # En Linux/macOS
  venv\Scripts\activate  # En Windows
```

### 3. Instalar dependencias

```sh
  pip install -r requirements.txt
```

### 4. Instalación de PostgreSQL

- **Descargar e instalar PostgreSQL desde: https://www.enterprisedb.com/downloads/postgres-postgresql-downloads.**

- **Seleccionar la versión 16 compatible con tu sistema operativo.**

- **Ejecutar el instalador y dar clic en continuar hasta llegar al apartado de la contraseña.**

- **Ingresar una contraseña segura y continuar hasta que la instalación termine.**

- **Abrir la carpeta “PostgreSQL 16” y ejecutar “SQL Shell”.**

- **Presionar Enter cuatro veces hasta que solicite la contraseña ingresada previamente.**

- **Introducir la contraseña y luego ejecutar el siguiente comando:**

```sql
CREATE DATABASE comites;
```

Para verificar la base de datos, abrir pgAdmin 4, ingresar la contraseña y explorar la lista de bases de datos para confirmar que `comites` ha sido creada correctamente.

### 5. Configurar la base de datos en Django

Crea una base de datos en PostgreSQL con el nombre `comites_db` y configura las credenciales en `settings.py`:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'comites_db',
        'USER': 'tu_usuario',
        'PASSWORD': 'tu_contraseña',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

### 6. Ejecutar migraciones

```sh
  python manage.py makemigrations
  python manage.py migrate
```

### 7. Ejecutar el servidor

```sh
  python manage.py runserver
```

El backend estará disponible en `http://127.0.0.1:8000/`.

## Endpoints principales

- **/api/Solicitud/** → Gestión de solicitudes
- **/api/Reglamento/** → Gestión de reglamento Sena.
- **/api/llamadoAtencion/** → Gestión de llamados de atención.
- **/api/UsuarioAprendiz/** → Generación de aprendices

## Tecnologías utilizadas

- **Django 5.1.1**
- **Django Rest Framework**
- **PostgreSQL 16**
- **Correo con SMTP** (para notificaciones)

## Mantenimiento y actualización

Para actualizar dependencias, ejecuta:

```sh
  pip install -r requirements.txt --upgrade
```

Para aplicar nuevos cambios en la base de datos:

```sh
  python manage.py makemigrations
  python manage.py migrate
```

## Estructura del proyecto


| **Descripción**                                                                                                                                                          | **Carpeta**                                                                                                                |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| migrations: Contiene los archivos de migraciones que Django utiliza para mantener sincronizada la base de datos con los modelos definidos en tu proyecto. Al crear un nuevo modelo o realizar cambios, Django generará un archivo de migración aquí. 
 El archivo __init__.py dentro de esta carpeta la convierte en un módulo de Python.| <p align="center">[Image](https://github.com/user-attachments/assets/6cfe3dc7-cf4e-470a-a63b-38d1f3b35167)</p>           |
| pycache: Carpeta generada automáticamente por Python. Almacena versiones compiladas de los archivos .py (archivos .pyc) para acelerar la ejecución del código. No necesitas modificar nada aquí.| <p align="center">![Image](https://github.com/user-attachments/assets/f1c7a35f-1bdc-432a-8b2c-25a4f4793aad)</p>           |
| staticfiles: Si configuras Django para manejar archivos estáticos (CSS, JavaScript, imágenes, etc.), esta carpeta puede generarse al ejecutar comandos como collectstatic. Es una ubicación centralizada para servir estos archivos en producción.Además, el comando django-admin startproject también genera otros archivos clave en el directorio principal del proyecto:| <p align="center">![Image](https://github.com/user-attachments/assets/e942ba25-7eb2-4bb9-a1ac-497251960f3a) </p>           |
| ·manage.py (archivo): Script de utilidad principal que te permite ejecutar comandos deDjango, cómo iniciar el servidor, hacer migraciones (makemigrations), y más.| <p align="center">![Image](https://github.com/user-attachments/assets/e39e3979-71b2-44f6-ae5f-e59b9a4af238) </p>           |
| · settings.py: Contiene todas las configuraciones del proyecto, como la base de datos,aplicaciones instaladas, configuraciones de seguridad, etc.| <p align="center">![Image](https://github.com/user-attachments/assets/b3da0096-b885-434b-ab5a-2febb23316ec)</p>           |
| ·urls.py: Archivo donde defines las rutas y puntos de entrada de tu aplicación web.| <p align="center">![Image](https://github.com/user-attachments/assets/6f1eab65-a363-4916-be72-006826190820)</p>           |
| Estos Scripts de Python permiten enviar datos a la base de datos mediante Json, envia los datos a sus tablas correspondientes en el orden correcto para poder ser utilizados | <p align="center">![Image](https://github.com/user-attachments/assets/32f662f8-e7bb-4f84-a850-06325b40696f) </p>           |
| Estos Scripts de Python generan usuarios falsos para realizar las pruebas en el aplicativo, todos los datos son falsos, esto gracias a la librería “faker” y “random” que permiten generar datos falsos y en caso de que en alguna casilla sea un dato de selección “random” nos ayuda a que se escoja de manera aleatoria, asegurándonos que todos los datos son diferentes y podamos hacer pruebas como si fueran usuarios reales.| <p align="center">![Image](https://github.com/user-attachments/assets/e3159d70-776e-4e9c-a029-ff4c1addcd5d)</p>           |
| Esta carpeta se crea en el momento de activar el entorno virtual, este contiene todas las dependencias instaladas, todas sus librerías y scripts necesarios y el archivo de configuración de Python para que detecte la carpeta donde se encuentra instalado Python y pueda funcionar correctamente | <p align="center">![Image](https://github.com/user-attachments/assets/0a9282e2-466d-44dd-88b6-ce7c6be5d1bc) </p>           |




## Desarrolladores del Backend

- **Manuel Enrique Lucero Suarez - Desarrollador Principal**
- **David Santiago Quiroga Vargas**
