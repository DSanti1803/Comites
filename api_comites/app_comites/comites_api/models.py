from django.db import models


# Create your models here.
class UsuarioAprendiz(models.Model):
    class TipoDocumentoA(models.TextChoices):
        TARJETAI = "TI", ('Tarjeta de Identidad')
        CEDULA = "CC", ('Cedula de Ciudadanía')
        EXTRANGERA = "CE", ('Cedula de Extranjería')
        PASAPORTE = "PAS", ('Pasaporte')
        NIT = "NIT", ('Número de identificación tributaria')
    class Coordinacion(models.TextChoices):
        COR1 = "1", ('1')
        COR2 = "2", ('2')
        COR3 = "3", ('3')
        COR4 = "4", ('4')

    class Roles(models.TextChoices):
        APRENDIZ ="APRENDIZ", ("APRENDIZ")
        

    id = models.AutoField(primary_key=True)
    nombres = models.CharField(max_length=255, blank=False, null=False)
    apellidos = models.CharField(max_length=255, blank=False, null=False)
    tipoDocumento = models.CharField(max_length=255, choices=TipoDocumentoA.choices, default=TipoDocumentoA.CEDULA)
    numeroDocumento = models.CharField(max_length=255, blank=False, null=False)
    ficha = models.CharField(max_length=255, blank=False, null=False)
    programa = models.CharField(max_length=225, blank=False, null=False)
    correoElectronico = models.EmailField(max_length=225, blank=False, null=False)  # Usar EmailField en lugar de CharField para correos
    rol1 = models.CharField( max_length=15, choices=Roles.choices, default=Roles.APRENDIZ, blank=True, null=True)  # Se debe agregar max_length al campo CharField
    estado = models.BooleanField(default=True, blank=False, null=False)
    coordinacion= models.CharField( max_length=15, choices=Coordinacion.choices, null=False)

class Instructor(models.Model):
    class TipoDocumento(models.TextChoices):
        TARJETAI = "TI", ('Tarjeta de Identidad')
        CEDULA = "CC", ('Cedula de Ciudadanía')
        EXTRANGERA = "CE", ('Cedula de Extranjería')
        PASAPORTE = "PAS", ('Pasaporte')
        NIT = "NIT", ('Número de identificación tributaria')
    
    class Coordinacion(models.TextChoices):
        COR1 = "1", ('1')
        COR2 = "2", ('2')
        COR3 = "3", ('3')
        COR4 = "4", ('4')
    class Roles(models.TextChoices):
        INSTRUCTOR = "INSTRUCTOR", ("INSTRUCTOR")
        
        
    id = models.AutoField(primary_key=True)
    nombres = models.CharField(max_length=255, blank=False, null=False)
    apellidos = models.CharField(max_length=255, blank=False, null=False)
    tipoDocumento = models.CharField(max_length=3, choices=TipoDocumento.choices, default=TipoDocumento.CEDULA)
    numeroDocumento = models.CharField(max_length=50, blank=False, null=False)
    correoElectronico = models.CharField(max_length=100, blank=False, null=False)
    rol1 = models.CharField(
        max_length=15, choices=Roles.choices, default=Roles.INSTRUCTOR, blank=True, null=True)
    coordinacion= models.CharField( max_length=15, choices=Coordinacion.choices, null=False)
    estado = models.BooleanField(default=True, blank=False, null=False)
    
class Abogado(models.Model):
    class TipoDocumento(models.TextChoices):
        TARJETAI = "TI", ('Tarjeta de Identidad')
        CEDULA = "CC", ('Cedula de Ciudadanía')
        EXTRANGERA = "CE", ('Cedula de Extranjería')
        PASAPORTE = "PAS", ('Pasaporte')
        NIT = "NIT", ('Número de identificación tributaria')
        
    class Roles(models.TextChoices):
        
        ABOGADO = "ABOGADO", ('ABOGADO')
        
    
    
    id = models.AutoField(primary_key=True)
    nombres = models.CharField(max_length=255, blank=False, null=False)
    apellidos = models.CharField(max_length=255, blank=False, null=False)
    tipoDocumento = models.CharField(max_length=3, choices=TipoDocumento.choices, default=TipoDocumento.CEDULA)
    numeroDocumento = models.CharField(max_length=50, blank=False, null=False)
    correoElectronico = models.CharField(max_length=100, blank=False, null=False)
    rol1 = models.CharField(
        max_length=15, choices=Roles.choices, default=Roles.ABOGADO, blank=True, null=True)
    estado = models.BooleanField(default=True, blank=False, null=False)
    
class Coordinador(models.Model):
    class TipoDocumento(models.TextChoices):
        TARJETAI = "TI", ('Tarjeta de Identidad')
        CEDULA = "CC", ('Cedula de Ciudadanía')
        EXTRANGERA = "CE", ('Cedula de Extranjería')
        PASAPORTE = "PAS", ('Pasaporte')
        NIT = "NIT", ('Número de identificación tributaria')
    
    class Coordinacion(models.TextChoices):
        COR1 = "1", ('1')
        COR2 = "2", ('2')
        COR3 = "3", ('3')
        COR4 = "4", ('4')
        
    class Roles(models.TextChoices):
        COORDINADOR = "COORDINADOR", ('COORDINADOR')
        
        
    id = models.AutoField(primary_key=True)
    nombres = models.CharField(max_length=255, blank=False, null=False)
    apellidos = models.CharField(max_length=255, blank=False, null=False)
    tipoDocumento = models.CharField(max_length=3, choices=TipoDocumento.choices, default=TipoDocumento.CEDULA)
    numeroDocumento = models.CharField(max_length=50, blank=False, null=False)
    correoElectronico = models.CharField(max_length=100, blank=False, null=False)
    rol1 = models.CharField(
        max_length=15, choices=Roles.choices, default=Roles.COORDINADOR, blank=True, null=True)
    coordinacion= models.CharField( max_length=15, choices=Coordinacion.choices, null=False)
    estado = models.BooleanField(default=True, blank=False, null=False)

class Bienestar(models.Model):
    class TipoDocumento(models.TextChoices):
        TARJETAI = "TI", ('Tarjeta de Identidad')
        CEDULA = "CC", ('Cedula de Ciudadanía')
        EXTRANGERA = "CE", ('Cedula de Extranjería')
        PASAPORTE = "PAS", ('Pasaporte')
        NIT = "NIT", ('Número de identificación tributaria')
        
    class Roles(models.TextChoices):
        BIENESTAR = "BIENESTAR", ('BIENESTAR')
    id = models.AutoField(primary_key=True)
    nombres = models.CharField(max_length=255, blank=False, null=False)
    apellidos = models.CharField(max_length=255, blank=False, null=False)
    tipoDocumento = models.CharField(max_length=3, choices=TipoDocumento.choices, default=TipoDocumento.CEDULA)
    numeroDocumento = models.CharField(max_length=50, blank=False, null=False)
    correoElectronico = models.CharField(max_length=100, blank=False, null=False)
    rol1 = models.CharField(
        max_length=15, choices=Roles.choices, default=Roles.BIENESTAR, blank=True, null=True)
    estado = models.BooleanField(default=True, blank=False, null=False)


    



class Reglamento(models.Model):
    id = models.AutoField(primary_key=True)
    capitulo = models.CharField(blank=False, null=False)# Eliminar max_length, ya que no aplica a IntegerField
    numeral = models.CharField(blank=False, null=False)  # Eliminar max_length, ya que no aplica a IntegerField
    descripcion = models.CharField(max_length=1000, blank=False, null=False)
    academico = models.BooleanField(default=True, blank=False, null=False)
    disciplinario = models.BooleanField(default=True, blank=False, null=False)
    gravedad= models.CharField(max_length=250, blank=False, null=False)

    
    
class Solicitud(models.Model):
    id = models.AutoField(primary_key=True)
    aprendiz = models.ManyToManyField('UsuarioAprendiz', through='AprendizSolicitud')
    fechasolicitud = models.DateTimeField(auto_now_add=True)
    descripcion = models.CharField(max_length=600, blank=False, null=False)
    observaciones = models.CharField(max_length=300, blank=False, null=False)
    responsable = models.ManyToManyField('Instructor', through='InstructorSolicitud')  # Asegúrate de que 'Usuario' esté definido en tu proyecto
    reglamento = models.ManyToManyField('Reglamento', through='ReglamentoSolicitud')
    solicitudenviada= models.BooleanField(default=True)#  Cambiado 'Reglamento' para seguir la convención de minúsculas
    citacionenviada = models.BooleanField(default=False)
    comiteenviado = models.BooleanField(default=False)
    planmejoramiento = models.BooleanField(default=False)
    desicoordinador= models.BooleanField(default=False)
    desiabogada= models.BooleanField(default=False)
    finalizado = models.BooleanField(default=False)
    
class AprendizSolicitud(models.Model):
    id = models.AutoField(primary_key=True)
    aprendiz = models.ForeignKey(UsuarioAprendiz, on_delete=models.CASCADE)
    solicitud = models.ForeignKey(Solicitud, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('aprendiz', 'solicitud')

        
class InstructorSolicitud(models.Model):
    id = models.AutoField(primary_key=True)
    usuario = models.ForeignKey(Instructor, on_delete=models.CASCADE)  # Verifica que el modelo 'Usuario' esté correctamente definido
    solicitud = models.ForeignKey(Solicitud, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('usuario', 'solicitud')

    
    
class ReglamentoSolicitud(models.Model):
    id = models.AutoField(primary_key=True)
    reglamento = models.ForeignKey(Reglamento, on_delete=models.CASCADE)
    solicitud = models.ForeignKey(Solicitud, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('reglamento', 'solicitud')

class Citacion(models.Model):
    id = models.AutoField(primary_key=True)
    solicitud = models.ForeignKey(Solicitud, on_delete=models.CASCADE)
    diacitacion = models.DateTimeField()  # Cambiado a DateTimeField
    horainicio = models.TimeField()
    horafin = models.TimeField()
    lugarcitacion = models.CharField(max_length=600, blank=False, null=False)
    enlacecitacion = models.CharField(max_length=600, blank=False, null=False)
    
class Acta(models.Model):
    
    class clasificacion(models.TextChoices):
        PUBLICA = "PUBLICA", ('PUBLICA')
        PRIVADO = "PRIVADO", ('PRIVADO')
        SEMIPRIVADO = "SEMIPRIVADO", ('SEMIPRIVADO')
        SENSISBLE = "SENSISBLE", ('SENSISBLE')

    id = models.AutoField(primary_key=True)
    citacion = models.ForeignKey(Citacion, on_delete=models.CASCADE)
    verificacionquorom = models.CharField(max_length=600, blank=False, null=False)
    verificacionasistenciaaprendiz = models.CharField(max_length=600, blank=False, null=False)
    verificacionbeneficio = models.CharField(max_length=600, blank=False, null=False)
    reporte = models.CharField(max_length=600, blank=False, null=False)
    descargos = models.CharField(max_length=600, blank=False, null=False)
    pruebas = models.CharField(max_length=600, blank=False, null=False)
    deliberacion = models.CharField(max_length=600, blank=False, null=False)
    votos = models.CharField(max_length=600, blank=False, null=False)
    conclusiones = models.CharField(max_length=600, blank=False, null=False)
    clasificacioninformacion= models.CharField( max_length=15, choices=clasificacion.choices, default=clasificacion.PUBLICA, blank=True, null=True)