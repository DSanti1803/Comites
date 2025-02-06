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


## Estructura del proyecto


| **Descripción**                                                                                                                                                          | **Carpeta**                                                                                                                |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| Contiene las funciones de inicio de sesión, de verificación y del envío del correo con el codigo de verificación para ingresar al Dasboard dependiendo del rol del usuario | <p align="center">![Image](https://github.com/user-attachments/assets/a63f5841-b447-449a-a33b-798cacdf7665))</p>           |
| Contiene todo lo relacionado con el Dashboard, contiene el controlador para el SideMenu, las funcionalidades de cada rol y sus pantallas principales integrando las funcionalidades| <p align="center">![Image](https://github.com/user-attachments/assets/c9712ede-2f6b-4aaf-a38b-fdfc50348211)</p>           |
| Carpeta con 3 documentos y 1 subcarpeta, api_service contiene funciones para obtener datos de la API para ser llamados en otros documentos rápidamente, el documento de construcción es un documento básico para colocar en caso de que alguna pantalla aún no se encuentre disponible, sena contiene la información general del Sena para ser mostrada a los usuarios, finalmente la subcarpeta de funciones contiene todas las funciones usadas en el aplicativo| <p align="center">![Image](https://github.com/user-attachments/assets/f631c758-6756-40e7-b8ea-4b802662207a)</p>           |
| Contiene 3 subcarpetas, components tiene documentos muy importantes para el funcionamiento del aplicativo: appbar arma la estructura del appbar el cual siempre será mostrado, header nos da la estructura de la card del usuario que se ve en la parte superior derecha, bienvenida y construcción contiene textos de bienvenida y construcción, finalmente side_menu es el encargado de identificar el rol del usuario logueado para filtrar las opciones que este tendrá en el aplicativo. Las dos subcarpetas contienen los main de cada función, es decir, las funciones integradas a la estructura con el appbar, side_menu y header| <p align="center">![Image](https://github.com/user-attachments/assets/a6d4deac-5ba3-46b0-942e-6955d4e351e6)</p>           |
| Son todos los modelos de cada tabla en la base de datos, son importantes para integrar datos en ella ya que hacen una conexión directa con el backend para la verificación y envío de datos| <p align="center">![Image](https://github.com/user-attachments/assets/4a9819c5-2edf-48e7-b881-42db28f8fef5)</p>           |
| En esta carpeta se encuentran las funcionalidades para crear documentos pdf con la estructura indicada por el Sena en sus documentos oficiales de cada procedimiento, cada uno requiere ciertos datos dependiendo del proceso para así ser mostrados | <p align="center">![Image](https://github.com/user-attachments/assets/9c61c4ed-bbb5-4a2e-a897-e147ff69aca1)</p>           |
| Contiene el Splash el cual es el primero en mostrarse al ejecutar la aplicación, mostrando información e imágenes del Sena que cambian cada cierto tiempo o que el usuario puede saltar, al terminar será enviado al dashboard de estadísticas generales | <p align="center">![Image](https://github.com/user-attachments/assets/2aa07b70-c94a-4145-9eae-876d27683e53)</p>           |
| Contiene algunos widgets útiles, contiene: una animación sobresaliente que al pasar el ratón por encima realiza dicha animación, cards con estilos, estas pueden ser modificadas tanto en tamaño como en colores según se requiera, drawerstyle es el estilo que se le da al menú lateral que se despliega en el lado izquierdo mostrando solo los iconos y al pasar el ratón encima de uno muestra su nombre, expandible_card ayuda a hacer cards más compactas con la opción de desplegar información y finalmente tooltip se encarga de mostrar descripciones al pasar el ratón por algún dato.| <p align="center">![Image](https://github.com/user-attachments/assets/2234ca38-6cab-4d89-97ec-1689afaba6b6)</p>           |
| Carpeta que contiene todas las imágenes, iconos, gifs o videos del proyecto, siendo organizados por categorías para un uso más eficiente | <p align="center">![Image](https://github.com/user-attachments/assets/ac348dd0-4b03-4df9-bb4a-3b7db52194ac) </p>           |
| Estos archivos contienen cosas principales del aplicativo, en constantsDesign tenemos todos los colores primarios y secundarios de fondos, letras, sombras, tema claro, tema oscuro, tamaño de padding, diseños de botones y demás, Main es el archivo principal del aplicativo, es el archivo que se ejecuta al correr el aplicativo. Provider contiene las verificaciones de usuarios para sacar su información, además de funciones para el inicio de sesión y para cerrar sesión. Responsive contiene los tamaños para diferentes dispositivos. Source contiene la conexión a la URL del API para realizar llamados y obtener información rápidamente| <p align="center">![Image](https://github.com/user-attachments/assets/d84ecbe9-06c9-4c3e-b8d0-1811a3f3fc32)</p>           |



## Desarrolladores del Frontend

- **David Santiago Quiroga Vargas - Desarrollador Principal**
- **Manuel Enrique Lucero Suarez**

