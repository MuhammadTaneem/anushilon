# Generated by Django 4.2.3 on 2023-08-01 07:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0003_exam_negative_marking_exam_penalty_alter_exam_point'),
    ]

    operations = [
        migrations.AlterField(
            model_name='exam',
            name='penalty',
            field=models.FloatField(default=0.25),
        ),
    ]
