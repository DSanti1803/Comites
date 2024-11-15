from rest_framework import serializers
from .models import *

from rest_framework import serializers

class UsuarioAprendizSerializer(serializers.ModelSerializer):
    class Meta:
        model = UsuarioAprendiz
        fields = '__all__'
    
class InstructorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Instructor
        fields = '__all__'
        
class AbogadoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Abogado
        fields = '__all__'

class CoordinadorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Coordinador
        fields ='__all__'

class BienestarSerializer(serializers.ModelSerializer):
    class Meta:
        model = Bienestar
        fields = '__all__'


    
class ReglamentoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reglamento
        fields = '__all__'

class SolicitudSerializer(serializers.ModelSerializer):
    aprendiz = serializers.PrimaryKeyRelatedField(
        queryset=UsuarioAprendiz.objects.all(), many=True, required=False
    )
    responsable = serializers.PrimaryKeyRelatedField(
        queryset=Instructor.objects.filter(rol1__in=['INSTRUCTOR']),
        many=True,
        required=False
    )
    reglamento = serializers.PrimaryKeyRelatedField(
        queryset=Reglamento.objects.all(), many=True, required=False
    )

    class Meta:
        model = Solicitud
        fields = [
            'id', 'aprendiz', 'fechasolicitud', 'descripcion',
            'observaciones', 'responsable', 'reglamento', 'solicitudenviada', 'citacionenviada', 'comiteenviado', 'planmejoramiento',
            'desicoordinador', 'desiabogada', 'finalizado'
        ]

    # Sobreescribir el método to_representation para asegurarse de que los IDs se devuelvan como enteros
    def to_representation(self, instance):
        representation = super().to_representation(instance)
        
        # Asegurarse de que los IDs son devueltos como enteros
        representation['id'] = int(representation['id'])
        
        # Convertir los IDs de las relaciones ManyToMany a enteros
        representation['aprendiz'] = [int(a.id) for a in instance.aprendiz.all()]
        representation['responsable'] = [int(r.id) for r in instance.responsable.all()]
        representation['reglamento'] = [int(reg.id) for reg in instance.reglamento.all()]
        
        return representation

   

        
class AprendizSolicitudSerializer(serializers.ModelSerializer):
    class Meta:
        model = AprendizSolicitud
        fields = '__all__'
        
    def to_representation(self, instance):
        # Asegúrate de acceder al campo correcto del objeto `instance`
        representation = super().to_representation(instance)
        # Si quieres acceder a los campos del modelo relacionado `Reglamento`
        representation['aprendiz'] = {
            'id': instance.aprendiz.id,
            'nombres': instance.aprendiz.nombres,
            'apellidos': instance.aprendiz.apellidos,
            'tipoDocumento': instance.aprendiz.tipoDocumento,
            'numeroDocumento': instance.aprendiz.numeroDocumento,
            'ficha': instance.aprendiz.ficha,
            'programa': instance.aprendiz.programa,
            'correoElectronico': instance.aprendiz.correoElectronico,
            'rol1': instance.aprendiz.rol1,
            'estado': instance.aprendiz.estado,
            'coordinacion': instance.aprendiz.coordinacion,
            
            # Agrega más campos según sea necesario
        }
        representation['solicitud'] = {
            'id': instance.solicitud.id,
            'aprendiz': UsuarioAprendizSerializer(instance.solicitud.aprendiz.all(), many=True).data,  # Usar .all() y serializar
            'fechasolicitud': instance.solicitud.fechasolicitud,
            'descripcion': instance.solicitud.descripcion,
            'observaciones': instance.solicitud.observaciones,
            'responsable': InstructorSerializer(instance.solicitud.responsable.all(), many=True).data,  # Usar .all() y serializar
            'reglamento': ReglamentoSerializer(instance.solicitud.reglamento.all(), many=True).data,
            'solicitudenviada':instance.solicitud.solicitudenviada,
            'citacionenviada': instance.solicitud.citacionenviada,
            'comiteenviado': instance.solicitud.comiteenviado,
            'planmejoramiento': instance.solicitud.planmejoramiento,
            'desicoordinador':instance.solicitud.desicoordinador,
            'desiabogada': instance.solicitud.desiabogada,
            'finalizado': instance.solicitud.finalizado,
        }
        
        return representation
    
class InstructorSolicitudSerializer(serializers.ModelSerializer):
    class Meta:
        model = InstructorSolicitud
        fields = '__all__'
    def to_representation(self, instance):
        # Asegúrate de acceder al campo correcto del objeto `instance`
        representation = super().to_representation(instance)
        # Si quieres acceder a los campos del modelo relacionado `Reglamento`
        representation['instructor'] = {
            'id': instance.instructor.id,
            'nombres': instance.instructor.nombres,
            'apellidos': instance.instructor.apellidos,
            'tipoDocumento': instance.instructor.tipoDocumento,
            'numeroDocumento': instance.instructor.numeroDocumento,
            'correoElectronico': instance.instructor.correoElectronico,
            'rol1': instance.instructor.rol1,
            'estado': instance.instructor.estado,
            'coordinacion': instance.instructor.coordinacion,
            # Agrega más campos según sea necesario
           
        }
        representation['solicitud'] = {
            'id': instance.solicitud.id,
            'aprendiz': UsuarioAprendizSerializer(instance.solicitud.aprendiz.all(), many=True).data,  # Usar .all() y serializar
            'fechasolicitud': instance.solicitud.fechasolicitud,
            'descripcion': instance.solicitud.descripcion,
            'observaciones': instance.solicitud.observaciones,
            'responsable': InstructorSerializer(instance.solicitud.responsable.all(), many=True).data,  # Usar .all() y serializar
            'reglamento': ReglamentoSerializer(instance.solicitud.reglamento.all(), many=True).data,
            'solicitudenviada':instance.solicitud.solicitudenviada,
            'citacionenviada': instance.solicitud.citacionenviada,
            'comiteenviado': instance.solicitud.comiteenviado,
            'planmejoramiento': instance.solicitud.planmejoramiento,
            'desicoordinador':instance.solicitud.desicoordinador,
            'desiabogada': instance.solicitud.desiabogada,
            'finalizado': instance.solicitud.finalizado,
        }
        
        return representation
        
class ReglamentoSolicitudSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReglamentoSolicitud
        fields = '__all__'
    def to_representation(self, instance):
        # Asegúrate de acceder al campo correcto del objeto `instance`
        representation = super().to_representation(instance)
        # Si quieres acceder a los campos del modelo relacionado `Reglamento`
        representation['reglamento'] = {
            'id': instance.reglamento.id,
            'capitulo': instance.reglamento.capitulo,
            'numeral': instance.reglamento.numeral,
            'descripcion': instance.reglamento.descripcion,
            # Agrega más campos según sea necesario
        }
        representation['solicitud'] = {
            'id': instance.solicitud.id,
            'aprendiz': UsuarioAprendizSerializer(instance.solicitud.aprendiz.all(), many=True).data,  # Usar .all() y serializar
            'fechasolicitud': instance.solicitud.fechasolicitud,
            'descripcion': instance.solicitud.descripcion,
            'observaciones': instance.solicitud.observaciones,
            'responsable': InstructorSerializer(instance.solicitud.responsable.all(), many=True).data,  # Usar .all() y serializar
            'reglamento': ReglamentoSerializer(instance.solicitud.reglamento.all(), many=True).data,
           'solicitudenviada':instance.solicitud.solicitudenviada,
            'citacionenviada': instance.solicitud.citacionenviada,
            'comiteenviado': instance.solicitud.comiteenviado,
            'planmejoramiento': instance.solicitud.planmejoramiento,
            'desicoordinador':instance.solicitud.desicoordinador,
            'desiabogada': instance.solicitud.desiabogada,
            'finalizado': instance.solicitud.finalizado,
        }
        
        return representation
    
class CitacionSerializer(serializers.ModelSerializer):


    solicitud = serializers.PrimaryKeyRelatedField(queryset=Solicitud.objects.all(), write_only=True)
    solicitud_data = serializers.SerializerMethodField(read_only=True)  # Campo solo para leer

    class Meta:
        model = Citacion
        fields = ['id', 'solicitud', 'solicitud_data', 'diacitacion', 'horainicio', 'horafin', 'lugarcitacion', 'enlacecitacion', 'actarealizada']

    # Método para mostrar todos los datos de la solicitud al visualizar
    def get_solicitud_data(self, obj):
        # Serializar la solicitud completa si está presente
        return SolicitudSerializer(obj.solicitud).data if obj.solicitud else None
    
class ActaSerializer(serializers.ModelSerializer):
    citacion_data = serializers.SerializerMethodField(read_only=True)  # Método para obtener datos de la citación
    clasificacioninformacion = serializers.ChoiceField(choices=Acta.clasificacion.choices, read_only=True)  # Agregar ChoiceField para el campo clasificacioninformacion

    class Meta:
        model = Acta
        fields = ['id', 'citacion', 'citacion_data', 'verificacionquorom', 'verificacionasistenciaaprendiz',
                  'verificacionbeneficio', 'reporte', 'descargos', 'pruebas', 
                  'deliberacion', 'votos', 'conclusiones', 'clasificacioninformacion']  # Incluir citacion_data

    def get_citacion_data(self, obj):
        # Aquí puedes serializar los detalles de la citación si lo deseas
        return CitacionSerializer(obj.citacion).data if obj.citacion else None