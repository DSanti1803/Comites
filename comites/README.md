# Frontend del Aplicativo de Comités

## Requisitos previos

Antes de instalar y ejecutar el frontend, asegúrate de tener los siguientes requisitos instalados:

- **Flutter 3.13.0 o superior**
- **Dart 3.1.0 o superior**
- **Android Studio o Visual Studio Code** (recomendado)
- **Dispositivo físico o emulador configurado**

## Instalación

### 1. Clonar el repositorio

```sh
git clone https://github.com/tu-repositorio/Comites-Sena.git
cd Comites-Sena/frontend
```

### 2. Instalar dependencias

```sh
flutter pub get
```

### 3. Ejecutar la aplicación

Para correr la aplicación en un dispositivo físico o emulador, usa:

```sh
flutter run
```

&#x20;Al momento de correr la app VScode preguntará en que dispositivo desea ejecutarlo, hay 3 opciones: Google, Windows o un dispositivo movil. Para correrlo en un movil solo se debe conectar el dispositivo al computador mediante un cable USB, cuando la maquina detecte el dispositivo aparecerá la opción de ejecutarlo en el dispositivo conectado.

## Características principales

- **Autenticación de usuarios** (Inicio de sesión y cierre de sesión)
- **Gestión de procesos** (Crear, actualizar y visualizar procesos)
- **Visualización de estadísticas** con gráficos de barras y circulares
- **Generación y descarga de documentos PDF**
- **Notificaciones en tiempo real**

## Tecnologías utilizadas

- **Flutter** (Framework principal)
- **Provider** (Manejo de estado)
- **fl\_chart** (Gráficos estadísticos)
- **dio** (Consumo de API REST)
- **flutter\_dotenv** (Manejo de variables de entorno)

## Mantenimiento y actualización

Para actualizar las dependencias del proyecto, usa:

```sh
flutter pub upgrade
```

Si hay cambios en el backend que afectan las estructuras de datos, asegúrate de actualizar los modelos en el frontend.

## Desarrolladores del Frontend

- **David Santiago Quiroga Vargas - Desarrollador Principal**
- **Manuel Enrique Lucero Suarez**

