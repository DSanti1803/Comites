
import json
from django.http import BadHeaderError, JsonResponse
from rest_framework import viewsets

from app_comites.settings import EMAIL_HOST_USER
from .models import *
from .serializer import *
from django.core.mail import EmailMessage, BadHeaderError, get_connection
from django.views.decorators.csrf import csrf_exempt
# Create your views here.
class UsuarioAprendizViewSet(viewsets.ModelViewSet):
    queryset = UsuarioAprendiz.objects.all()
    serializer_class = UsuarioAprendizSerializer
    
class InstructorViewSet(viewsets.ModelViewSet):
    queryset = Instructor.objects.all()
    serializer_class = InstructorSerializer
    
class AbogadoViewSet(viewsets.ModelViewSet):
    queryset = Abogado.objects.all()
    serializer_class = AbogadoSerializer
    
class CoordinadorViewSet(viewsets.ModelViewSet):
    queryset = Coordinador.objects.all()
    serializer_class = CoordinadorSerializer

class BienestarViewSet(viewsets.ModelViewSet):
    queryset = Bienestar.objects.all()
    serializer_class = BienestarSerializer
   

    
class ReglamentoViewSet(viewsets.ModelViewSet):
    queryset = Reglamento.objects.all()
    serializer_class = ReglamentoSerializer
    
class SolicitudViewSet(viewsets.ModelViewSet):
    queryset = Solicitud.objects.all()
    serializer_class = SolicitudSerializer
    
class AprendizSolicitudViewSet(viewsets.ModelViewSet):
    queryset = AprendizSolicitud.objects.all()
    serializer_class = AprendizSolicitudSerializer
    
class InstructorSolicitudViewSet(viewsets.ModelViewSet):
    queryset = InstructorSolicitud.objects.all()
    serializer_class = InstructorSolicitudSerializer
    
class ReglamentoSolicitudViewSet(viewsets.ModelViewSet):
    queryset = ReglamentoSolicitud.objects.all()
    serializer_class = ReglamentoSolicitudSerializer

class CitacionViewSet(viewsets.ModelViewSet):
    queryset = Citacion.objects.all()
    serializer_class = CitacionSerializer
    
class ActaViewSet(viewsets.ModelViewSet):
    queryset = Acta.objects.all()
    serializer_class = ActaSerializer
    
    


    
@csrf_exempt
def send_email(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            subject = data.get("subject", "")
            message = data.get("message", "")
            from_email = EMAIL_HOST_USER
            recipient_list = data.get("recipient_list", "")

            if subject and message and from_email and recipient_list:
                try:
                    email = EmailMessage(
                        subject,
                        message,
                        from_email,
                        recipient_list.split(),  # Convertir la lista de destinatarios a una lista de Python
                        connection=get_connection()
                    )
                    email.send()
                    return JsonResponse({"message": "Correo electrónico enviado exitosamente"}, status=200)
                except BadHeaderError:
                    return JsonResponse({"error": "Error al enviar correo electrónico"}, status=400)
            else:
                return JsonResponse({"error": "Por favor, complete todos los campos"}, status=400)
        except json.JSONDecodeError:
            return JsonResponse({"error": "Error al procesar la solicitud JSON"}, status=400)
    else:
        return JsonResponse({"error": "Método no permitido"}, status=405)
