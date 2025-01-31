# Aplicativo de Comités del Centro de Biotecnología Agropecuaria de Mosquera




## Indice


* [Descripción del proyecto](#Descripción-del-proyecto)

* [Características del proyecto](#Características-del-proyecto)

* [Requisitos previos](#Requisitos-previos)

* [Instalación](#Instalacion)

* [Configuracion de la API](#Configuracion-de-la-API)

* [Tecnologías utilizadas](#tecnologías-utilizadas)

* [Versiones y Herramientas Implementadas](#Versiones-y-Herramientas-Implementadas)
  
* [Estructura del proyecto](#Estructura-del-proyecto)

* [Desarrolladores del Proyecto](#desarrolladores)






## Descripción del proyecto

Este proyecto es una aplicación para el seguimiento de los comités de acuerdo con el reglamento del aprendiz, permitiendo gestionar el proceso desde el llamado de atención a los aprendices hasta el comité general o decisión tomada por este. La aplicación tiene funcionalidades clave como la emisión de llamados de atención, solicitudes a los grupos ejecutores y al comité general, y el seguimiento de las etapas correspondientes para que no se salte el conducto regular o la escalabilidad de cada caso de los aprendices.
El sistema permite que los interesados de cada caso en específico puedan tener un conocimiento del progreso en tiempo real y así poder tomar las medidas correspondientes ya que no va a existir ningún procedimiento que se realice fuera del aplicativo.
Todos los usuarios del aplicativo sin importar el rol que cumplan tienen un histórico que pueden consultar como lo es, procesos activos, procesos cancelados o procesos terminados.





## Características del proyecto

- **Agilización de Solicitudes y llamados de atención** 
 Facilita y acelera los procesos de llamados de atención y de solicitudes tanto de comité de equipo ejecutor como los de comité general, permitiendo tener más orden a la hora de gestionar un proceso.
- **Estadísticas de Procesos**
  Ofrece estadísticas detalladas de los procesos, los reglamentos entre otros, para tener una retroalimentación mas detallada de los procesos y de por qué suceden.
- **Gestión de Procesos**
	Incluye cards las cuales permiten ver el estado de cada proceso, además de poder descargar los documentos relacionados al proceso permitiendo un fácil acceso a la información necesaria 
- **Citaciones Rápidas**
 Tanto los instructores como los coordinadores tienen la facilidad de realizar una citación rápidamente, tienen la opción de citar manualmente y automáticamente, donde no tendrán que rellenar datos extensos y será mucho más rápido el proceso de citar.
- **Radicaciones Automáticas**
Proporciona una función que automatiza el proceso de radicación, donde se radicarán todas las citaciones con el numero consecuente administrado por dicha área.
- **Funciones de Autenticación de Usuario**
  Incluye verificaciones de usuarios usando el numero de documento de la persona como usuario y enviando un correo electrónico al email relacionado con ese documento, lo cual asegura que el que está iniciando sesión sea la persona adecuada y no existan intentos de falsificación de contraseñas.
- **Creación de documentos**
  En los formularios de los procesos el usuario que lo rellene al finalizar con un formulario se creará automáticamente el documento relacionado al tipo de proceso que se esté diligenciando con la información que el usuario colocó. Este documento contará con su estructura oficial establecida por el Sena.
- **Envió de correos**
  Existen procesos a los cuales se debe notificar de manera formal al aprendiz, instructor, entre otros, dependiendo del proceso se enviará un correo electrónico a los usuarios correspondientes. Por ejemplo, al citar un comité, se podrá enviar un correo electrónico a todas las personas implicadas dando la información detallada junto a su documento de citación.


## Requisitos previos

Antes de instalar el proyecto, asegúrate de tener instalados los siguientes programas y herramientas:

- **Visual Studio Code (Última versión disponible)** 
Potente y ligero editor de código fuente de Microsoft, ideal para múltiples lenguajes y herramientas de desarrollo.
- **Flutter versión 3.22.3**
Framework de Google que permite crear aplicaciones móviles nativas de alta calidad con una única base de código.
- **Python 3.12.5**
Lenguaje de programación interpretado y orientado a objetos, reconocido por su simplicidad, legibilidad y versatilidad.
- **Django 5.1.1**
Framework web de Python que permite desarrollar aplicaciones web de forma rápida y eficiente. Se trata de un software gratuito y de código abierto.
- **PostgreSQL 16**
  Sistema de gestión de bases de datos relacional de código abierto, conocido por su robustez, flexibilidad y capacidad para manejar grandes volúmenes de datos.


## Instalación

Sigue estos pasos para configurar el proyecto localmente:
La instalación para entornos locales se hace después de importar 

1. **Crear la Base de Datos PostgreSQL**
En SQL Shell (Software incluido en la instalación de PostgreSQL) ejecutar la siguiente line de código: Create Database comités;

2. **Clonar el Repositorio del Backend**

Abre CMD y ejecuta las siguientes líneas de código
 
-Git clone https://github.com/DSanti1803/Comites/tree/main/api_comites/app_comites
3. **Crear y Activar el Entorno Virtual**

-python -m venv venv 
-source venv/bin/activate


4. **Instalar las Dependencias** 

-pip install -r requirements.txt
 
5. **Realizar Migraciones**

-python manage.py makemigrations 
-python manage.py migrate

6. **Enviar Datos de Prueba**
   
Los datos tanto de los aprendices como los de instructores son datos ficticios para realizar pruebas de funcionalidades. Los datos de los reglamentos son reales y están sacados del reglamento del aprendiz oficial establecido por el Sena
-python enviaraprendices.py 
-python enviarreglamentos.py 
-python enviarinstructores.py 


7. **Iniciar Servidor**
   
-python manage.py runserver



## Configuracion de la API

Asegúrate de que la configuración de la API en app_comites/settings.py coincide con la información que configuraste al instalar PostgreSQL, esta configuración se encuentra en las líneas 99-108, donde se deberá verificar lo siguiente: Nombre BD, usuario, contraseña, host y puerto.



- **Clonar el Repositorio del Frontend:**

Por último, clona el frontend con uso de CMD, y abrelo en Visual Studio Code

-Git clone https://github.com/DSanti1803/Comites/tree/main/comites

 ### Ejecutar el Proyecto en Visual Studio Code
1.	Abre el proyecto clonado en Visual Studio Code.
2.	Ve a la pestaña de "Run".
3.	Ejecuta el proyecto con "Start Debugging".
4.	Para evitar problemas de depuración, cierra el aplicativo y vuelve a ejecutarlo con la opción "Start without Debugging".

## Tecnologias utilizadas

- **Frontend:** 
  - Flutter V3.22.3

- **Backend:** 
  - Python 3.12.5
  - Django
    
- **Base de Datos:** 
  - PostgreSQL 16



 
  
## Versiones y Herramientas Implementas 
Este proyecto está desarrollado utilizando una combinación de tecnologías modernas y robustas para garantizar una experiencia de usuario eficiente y satisfactoria. Entre las principales herramientas y versiones implementadas en este proyecto se encuentran:

- **Flutter versión 3.22.3:**
Framework de Google que permite crear aplicaciones móviles nativas de alta calidad con una única base de código.
- **Python 3.12.5:** 
Lenguaje de programación interpretado y orientado a objetos, conocido por su simplicidad, legibilidad y versatilidad.
- **Django:** 
Framework web de Python para el desarrollo rápido de aplicaciones web seguras y escalables. 
  - Django ORM:
   Sistema de mapeo objeto-relacional que facilita la interacción con la base de datos.
  - Django Rest Framework:
Utilizado para construir APIs robustas y fácilmente mantenibles.
- **PostgreSQL 16:** 
Sistema de gestión de bases de datos relacional de código abierto, conocido por su robustez, flexibilidad y capacidad para manejar grandes volúmenes de datos.


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




## Desarrolladores del proyecto
- David Santiago Quiroga Vargas
- Manuel Enrique Lucero Suarez
