# Generated by Django 4.2.3 on 2023-08-01 07:18

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0005_alter_exam_penalty'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='exam',
            name='negative_marking',
        ),
    ]
