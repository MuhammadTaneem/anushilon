# Generated by Django 4.2.3 on 2023-07-30 10:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('package', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='package',
            name='category',
            field=models.CharField(choices=[('varsity', 'Varsity'), ('medical', 'Medical'), ('engineering', 'Engineering'), ('free_exam', 'Free Exam'), ('guccho', 'Guccho')], max_length=20),
        ),
    ]
