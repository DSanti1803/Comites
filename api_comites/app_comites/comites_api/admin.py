from django.contrib import admin
from .models import *
# Register your models here.
admin.site.register(UsuarioAprendiz)
admin.site.register(Instructor)
admin.site.register(Abogado)
admin.site.register(Coordinador)
admin.site.register(Bienestar)
admin.site.register(Reglamento)
admin.site.register(Solicitud)
admin.site.register(AprendizSolicitud)
admin.site.register(InstructorSolicitud)
admin.site.register(ReglamentoSolicitud)
admin.site.register(Citacion)
admin.site.register(Acta)
