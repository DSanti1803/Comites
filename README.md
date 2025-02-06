# Aplicativo de Comités del Centro de Biotecnología Agropecuaria de Mosquera

## Índice

- [Descripción del proyecto](#descripción-del-proyecto)
- [Características del proyecto](#características-del-proyecto)
- [Requisitos previos](#requisitos-previos)
- [Instalación](#instalación)
- [Tecnologías utilizadas](#tecnologías-utilizadas)
- [Estructura del proyecto](#estructura-del-proyecto)
- [Desarrolladores del Proyecto](#desarrolladores-del-proyecto)

## Descripción del proyecto

Este proyecto es una aplicación para el seguimiento de los comités de acuerdo con el reglamento del aprendiz, permitiendo gestionar el proceso desde el llamado de atención hasta la decisión final del comité. Incluye funcionalidades como la emisión de llamados de atención, solicitudes a los grupos ejecutores y seguimiento del proceso.

Todos los usuarios tienen acceso a un histórico de procesos activos, cancelados o finalizados.

## Características del proyecto

- **Agilización de solicitudes y llamados de atención**
- **Estadísticas detalladas** sobre procesos y reglamentos.
- **Gestión de procesos** con cards interactivas y documentos descargables.
- **Citaciones rápidas** tanto manuales como automáticas.
- **Radicaciones automáticas** con números consecutivos.
- **Autenticación segura** con verificación vía correo electrónico.
- **Generación automática de documentos** con estructura oficial.
- **Notificaciones por correo** a los involucrados en cada proceso.

## Requisitos previos

Antes de instalar el proyecto, asegúrate de tener:

- **Visual Studio Code** (Versión más reciente).
- **Flutter 3.22.3**.
- **Python 3.12.5**.
- **Django 5.1.1**.
- **PostgreSQL 16**.

## Instalación

Para instalar el backend y frontend, sigue los pasos detallados en sus respectivos README:

- [Instrucciones de instalación del backend](backend/README.md)
- [Instrucciones de instalación del frontend](frontend/README.md)

## Tecnologías utilizadas

### Frontend

- **Flutter V3.22.3**

### Backend

- **Python 3.12.5**
- **Django 5.1.1**
- **Django ORM y Django Rest Framework**

### Base de Datos

- **PostgreSQL 16**

## Estructura del proyecto

```
/Comites-Sena
│── /frontend  --> Contiene el código del frontend
│    ├── README.md  👈 Instrucciones del frontend
│
│── /backend  --> Contiene el código del backend
│    ├── README.md  👈 Instrucciones del backend
│
│── README.md  👈 Este archivo (General)
```

## Desarrolladores del proyecto

- **David Santiago Quiroga Vargas**
- **Manuel Enrique Lucero Suarez**

