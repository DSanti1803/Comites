# Generated by Django 5.1.1 on 2024-11-15 15:36

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('comites_api', '0002_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='citacion',
            name='actarealizada',
            field=models.BooleanField(default=False),
        ),
    ]
