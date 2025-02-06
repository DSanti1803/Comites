# Backend del Aplicativo de Comités

## Requisitos previos

Antes de instalar y ejecutar el backend, asegúrate de tener los siguientes requisitos instalados:

- **Python 3.12.5**
- **Django 5.1.1**
- **PostgreSQL 16**
- **Virtualenv** (Opcional, pero recomendado)

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

## Desarrolladores del Backend

- **Manuel Enrique Lucero Suarez - Desarrollador Principal**
- **David Santiago Quiroga Vargas**
