# Generated by Django 4.2.3 on 2023-08-01 06:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('exam', '0002_alter_exam_exam_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='exam',
            name='negative_marking',
            field=models.BooleanField(default=True),
        ),
        migrations.AddField(
            model_name='exam',
            name='penalty',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='exam',
            name='point',
            field=models.IntegerField(default=1),
        ),
    ]