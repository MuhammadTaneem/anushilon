# Generated by Django 4.2.3 on 2023-07-25 16:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('student', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='student',
            name='balance',
            field=models.IntegerField(default=0),
        ),
    ]
