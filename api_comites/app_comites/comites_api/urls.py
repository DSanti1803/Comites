from django.urls import path, include
from rest_framework import routers
from .views import *

router = routers.DefaultRouter()
router.register(r'UsuarioAprendiz', UsuarioAprendizViewSet, basename='UsuarioAprendiz')
router.register(r'Instructor', InstructorViewSet, basename='Instructor')
router.register(r'Abogado', AbogadoViewSet, basename='Abogado')
router.register(r'Coordinador', CoordinadorViewSet, basename='Coordinador')
router.register(r'Bienestar', BienestarViewSet, basename='Bienestar')
router.register(r'Reglamento', ReglamentoViewSet, basename='Reglamento')
router.register(r'Solicitud', SolicitudViewSet, basename='Solicitud')
router.register(r'AprendizSolicitud', AprendizSolicitudViewSet, basename='AprendizSolicitud')
router.register(r'InstructorSolicitud', InstructorSolicitudViewSet, basename='InstructorSolicitud')
router.register(r'ReglamentoSolicitud', ReglamentoSolicitudViewSet, basename='ReglamentoSolicitud')
router.register(r'Citacion', CitacionViewSet, basename='Citacion')
router.register(r'Acta', ActaViewSet, basename='Acta')


urlpatterns = [
    path('', include(router.urls)),
    path('send-email/', send_email, name='send-email'),
]