# Generated by Django 4.2.1 on 2024-11-14 19:50

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('comites_api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Abogado',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('nombres', models.CharField(max_length=255)),
                ('apellidos', models.CharField(max_length=255)),
                ('tipoDocumento', models.CharField(choices=[('TI', 'Tarjeta de Identidad'), ('CC', 'Cedula de Ciudadanía'), ('CE', 'Cedula de Extranjería'), ('PAS', 'Pasaporte'), ('NIT', 'Número de identificación tributaria')], default='CC', max_length=3)),
                ('numeroDocumento', models.CharField(max_length=50)),
                ('correoElectronico', models.CharField(max_length=100)),
                ('rol1', models.CharField(blank=True, choices=[('ABOGADO', 'ABOGADO')], default='ABOGADO', max_length=15, null=True)),
                ('estado', models.BooleanField(default=True)),
            ],
        ),
        migrations.CreateModel(
            name='AprendizSolicitud',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
            ],
        ),
        migrations.CreateModel(
            name='Bienestar',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('nombres', models.CharField(max_length=255)),
                ('apellidos', models.CharField(max_length=255)),
                ('tipoDocumento', models.CharField(choices=[('TI', 'Tarjeta de Identidad'), ('CC', 'Cedula de Ciudadanía'), ('CE', 'Cedula de Extranjería'), ('PAS', 'Pasaporte'), ('NIT', 'Número de identificación tributaria')], default='CC', max_length=3)),
                ('numeroDocumento', models.CharField(max_length=50)),
                ('correoElectronico', models.CharField(max_length=100)),
                ('rol1', models.CharField(blank=True, choices=[('BIENESTAR', 'BIENESTAR')], default='BIENESTAR', max_length=15, null=True)),
                ('estado', models.BooleanField(default=True)),
            ],
        ),
        migrations.CreateModel(
            name='Coordinador',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('nombres', models.CharField(max_length=255)),
                ('apellidos', models.CharField(max_length=255)),
                ('tipoDocumento', models.CharField(choices=[('TI', 'Tarjeta de Identidad'), ('CC', 'Cedula de Ciudadanía'), ('CE', 'Cedula de Extranjería'), ('PAS', 'Pasaporte'), ('NIT', 'Número de identificación tributaria')], default='CC', max_length=3)),
                ('numeroDocumento', models.CharField(max_length=50)),
                ('correoElectronico', models.CharField(max_length=100)),
                ('rol1', models.CharField(blank=True, choices=[('COORDINADOR', 'COORDINADOR')], default='COORDINADOR', max_length=15, null=True)),
                ('coordinacion', models.CharField(choices=[('1', '1'), ('2', '2'), ('3', '3'), ('4', '4')], max_length=15)),
                ('estado', models.BooleanField(default=True)),
            ],
        ),
        migrations.CreateModel(
            name='Instructor',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('nombres', models.CharField(max_length=255)),
                ('apellidos', models.CharField(max_length=255)),
                ('tipoDocumento', models.CharField(choices=[('TI', 'Tarjeta de Identidad'), ('CC', 'Cedula de Ciudadanía'), ('CE', 'Cedula de Extranjería'), ('PAS', 'Pasaporte'), ('NIT', 'Número de identificación tributaria')], default='CC', max_length=3)),
                ('numeroDocumento', models.CharField(max_length=50)),
                ('correoElectronico', models.CharField(max_length=100)),
                ('rol1', models.CharField(blank=True, choices=[('INSTRUCTOR', 'INSTRUCTOR')], default='INSTRUCTOR', max_length=15, null=True)),
                ('coordinacion', models.CharField(choices=[('1', '1'), ('2', '2'), ('3', '3'), ('4', '4')], max_length=15)),
                ('estado', models.BooleanField(default=True)),
            ],
        ),
        migrations.CreateModel(
            name='InstructorSolicitud',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
            ],
        ),
        migrations.CreateModel(
            name='Reglamento',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('capitulo', models.CharField()),
                ('numeral', models.CharField()),
                ('descripcion', models.CharField(max_length=1000)),
                ('academico', models.BooleanField(default=True)),
                ('disciplinario', models.BooleanField(default=True)),
                ('gravedad', models.CharField(max_length=250)),
            ],
        ),
        migrations.CreateModel(
            name='ReglamentoSolicitud',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('reglamento', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='comites_api.reglamento')),
            ],
        ),
        migrations.CreateModel(
            name='UsuarioAprendiz',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('nombres', models.CharField(max_length=255)),
                ('apellidos', models.CharField(max_length=255)),
                ('tipoDocumento', models.CharField(choices=[('TI', 'Tarjeta de Identidad'), ('CC', 'Cedula de Ciudadanía'), ('CE', 'Cedula de Extranjería'), ('PAS', 'Pasaporte'), ('NIT', 'Número de identificación tributaria')], default='CC', max_length=255)),
                ('numeroDocumento', models.CharField(max_length=255)),
                ('ficha', models.CharField(max_length=255)),
                ('programa', models.CharField(max_length=225)),
                ('correoElectronico', models.EmailField(max_length=225)),
                ('rol1', models.CharField(blank=True, choices=[('APRENDIZ', 'APRENDIZ')], default='APRENDIZ', max_length=15, null=True)),
                ('estado', models.BooleanField(default=True)),
                ('coordinacion', models.CharField(choices=[('1', '1'), ('2', '2'), ('3', '3'), ('4', '4')], max_length=15)),
            ],
        ),
        migrations.CreateModel(
            name='Solicitud',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('fechasolicitud', models.DateTimeField(auto_now_add=True)),
                ('descripcion', models.CharField(max_length=600)),
                ('observaciones', models.CharField(max_length=300)),
                ('solicitudenviada', models.BooleanField(default=True)),
                ('citacionenviada', models.BooleanField(default=False)),
                ('comiteenviado', models.BooleanField(default=False)),
                ('planmejoramiento', models.BooleanField(default=False)),
                ('desicoordinador', models.BooleanField(default=False)),
                ('desiabogada', models.BooleanField(default=False)),
                ('finalizado', models.BooleanField(default=False)),
                ('aprendiz', models.ManyToManyField(through='comites_api.AprendizSolicitud', to='comites_api.usuarioaprendiz')),
                ('reglamento', models.ManyToManyField(through='comites_api.ReglamentoSolicitud', to='comites_api.reglamento')),
                ('responsable', models.ManyToManyField(through='comites_api.InstructorSolicitud', to='comites_api.instructor')),
            ],
        ),
        migrations.AddField(
            model_name='reglamentosolicitud',
            name='solicitud',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='comites_api.solicitud'),
        ),
        migrations.AddField(
            model_name='instructorsolicitud',
            name='solicitud',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='comites_api.solicitud'),
        ),
        migrations.AddField(
            model_name='instructorsolicitud',
            name='usuario',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='comites_api.instructor'),
        ),
        migrations.CreateModel(
            name='Citacion',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('diacitacion', models.DateTimeField()),
                ('horainicio', models.TimeField()),
                ('horafin', models.TimeField()),
                ('lugarcitacion', models.CharField(max_length=600)),
                ('enlacecitacion', models.CharField(max_length=600)),
                ('solicitud', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='comites_api.solicitud')),
            ],
        ),
        migrations.AddField(
            model_name='aprendizsolicitud',
            name='aprendiz',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='comites_api.usuarioaprendiz'),
        ),
        migrations.AddField(
            model_name='aprendizsolicitud',
            name='solicitud',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='comites_api.solicitud'),
        ),
        migrations.CreateModel(
            name='Acta',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('verificacionquorom', models.CharField(max_length=600)),
                ('verificacionasistenciaaprendiz', models.CharField(max_length=600)),
                ('verificacionbeneficio', models.CharField(max_length=600)),
                ('reporte', models.CharField(max_length=600)),
                ('descargos', models.CharField(max_length=600)),
                ('pruebas', models.CharField(max_length=600)),
                ('deliberacion', models.CharField(max_length=600)),
                ('votos', models.CharField(max_length=600)),
                ('conclusiones', models.CharField(max_length=600)),
                ('clasificacioninformacion', models.CharField(blank=True, choices=[('PUBLICA', 'PUBLICA'), ('PRIVADO', 'PRIVADO'), ('SEMIPRIVADO', 'SEMIPRIVADO'), ('SENSISBLE', 'SENSISBLE')], default='PUBLICA', max_length=15, null=True)),
                ('citacion', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='comites_api.citacion')),
            ],
        ),
        migrations.AlterUniqueTogether(
            name='reglamentosolicitud',
            unique_together={('reglamento', 'solicitud')},
        ),
        migrations.AlterUniqueTogether(
            name='instructorsolicitud',
            unique_together={('usuario', 'solicitud')},
        ),
        migrations.AlterUniqueTogether(
            name='aprendizsolicitud',
            unique_together={('aprendiz', 'solicitud')},
        ),
    ]
