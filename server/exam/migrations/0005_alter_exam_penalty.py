# Generated by Django 4.2.3 on 2023-08-01 07:06

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0004_alter_exam_penalty'),
    ]

    operations = [
        migrations.AlterField(
            model_name='exam',
            name='penalty',
            field=models.FloatField(blank=True, default=0.25, null=True),
        ),
    ]
