# Generated by Django 4.2.3 on 2023-07-23 10:49

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('mcq', '0001_initial'),
        ('package', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Exam',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('syllabus', models.CharField(max_length=1023)),
                ('exam_number', models.IntegerField()),
                ('number_of_question', models.IntegerField()),
                ('duration', models.IntegerField()),
                ('point', models.IntegerField()),
                ('exam_date', models.DateTimeField()),
                ('published', models.BooleanField(default=False)),
                ('create_date', models.DateTimeField(auto_now_add=True)),
                ('last_edit', models.DateTimeField(auto_now=True)),
                ('creator', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to=settings.AUTH_USER_MODEL)),
                ('mcq_list', models.ManyToManyField(to='mcq.mcq')),
                ('package', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, to='package.package')),
            ],
        ),
    ]
