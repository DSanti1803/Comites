---

# Proyecto de Seguimiento de Comités

Este proyecto es una aplicación para el seguimiento de los comités de acuerdo al reglamento del aprendiz, permitiendo gestionar el proceso desde el llamado de atención hasta el comité general. La aplicación tiene funcionalidades clave como la emisión de llamados de atención, solicitudes a los grupos ejecutores y al comité general, y el seguimiento de las etapas correspondientes.

## Tecnologías Utilizadas

- **Frontend**: Flutter
- **Backend**: Django
- **Base de Datos**: PostgreSQL (o cualquier base de datos configurada en Django)
- **Autenticación**: JWT (JSON Web Tokens)

## Funcionalidades

- **Llamados de atención**: Permite a los administradores realizar llamados de atención a los aprendices según el reglamento del aprendiz.
- **Solicitudes a grupos ejecutores**: Facilita la comunicación y seguimiento de las solicitudes enviadas a los grupos ejecutores.
- **Solicitudes al comité general**: Permite a los administradores y otros usuarios autorizados realizar solicitudes al comité general.
- **Seguimiento de comités**: El sistema permite monitorear el progreso de cada comité desde el inicio del llamado de atención hasta la resolución en el comité general.
- **Autenticación y roles de usuario**: Gestión de usuarios con diferentes niveles de acceso (administrador, grupo ejecutor, comité general).

## Instalación

### Backend (Django)

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/DSanti1803/Comites
   cd proyecto/backend
   ```

2. **Crea un entorno virtual**:
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # En Windows usa venv\Scripts\activate
   ```

3. **Instala las dependencias**:
   ```bash
   pip install -r requirements.txt
   ```

4. **Configura la base de datos**: Asegúrate de tener PostgreSQL o la base de datos configurada adecuadamente en `settings.py` del proyecto Django.

5. **Realiza las migraciones**:
   ```bash
   python manage.py migrate
   ```

6. **Ejecuta el servidor de desarrollo**:
   ```bash
   python manage.py runserver
   ```

El backend debería estar disponible en `http://127.0.0.1:8000`.

### Frontend (Flutter)

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/usuario/proyecto.git
   cd proyecto/frontend
   ```

2. **Instala las dependencias de Flutter**:
   ```bash
   flutter pub get
   ```

3. **Ejecuta la aplicación**:
   ```bash
   flutter run
   ```

La aplicación debería iniciarse en el emulador o dispositivo conectado.

## Endpoints del Backend

A continuación, algunos de los endpoints más relevantes de la API:

- `POST /api/l llamados/`: Realizar un llamado de atención a un aprendiz.
- `POST /api/solicitudes/ejecutor/`: Enviar una solicitud al grupo ejecutor.
- `POST /api/solicitudes/comite-general/`: Enviar una solicitud al comité general.
- `GET /api/seguimiento/{id}/`: Obtener el estado de seguimiento de un comité específico.

## Estructura del Proyecto

### Backend (Django)
- `backend/`: Código del backend en Django.
  - `api/`: Lógica de la API (modelos, vistas, serializadores).
  - `settings.py`: Configuración del proyecto.
  - `urls.py`: Rutas de la API.

### Frontend (Flutter)
- `frontend/`: Código del frontend en Flutter.
  - `lib/`: Archivos Dart de la aplicación Flutter.
  - `assets/`: Archivos estáticos (imagenes, fuentes, etc.).

## Contribución

Si deseas contribuir al proyecto, por favor sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama para tu funcionalidad (`git checkout -b nueva-funcionalidad`).
3. Realiza tus cambios y haz commit de ellos (`git commit -am 'Añadir nueva funcionalidad'`).
4. Envía un pull request.

## Versiones
1. Flutter: 3.22.3
2. Dart: 3.4.4
3. Python: 3.12.5
4. Django: 5.1.1
5. Postgres: 16.4


## Documentación 
En el siguiente link podrán descargar los documentos de PDF oficiales del sena para su respectiva clonación mediante codigo, además de que podrán encontrar la documentación técnica del aplicativo.
https://drive.google.com/drive/folders/1vYQIQg7ssPZ37pcq0ludBxgvhse7-zc_?usp=drive_link
