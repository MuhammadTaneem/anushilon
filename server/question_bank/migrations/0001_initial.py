# Generated by Django 4.2.3 on 2023-08-08 05:05

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('mcq', '0002_alter_mcq_correct_ans'),
    ]

    operations = [
        migrations.CreateModel(
            name='QuestionBank',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('university', models.CharField(max_length=100)),
                ('unit', models.CharField(max_length=100)),
                ('year', models.PositiveIntegerField()),
                ('published', models.BooleanField(default=False)),
                ('create_date', models.DateTimeField(auto_now_add=True)),
                ('last_edit', models.DateTimeField(auto_now=True)),
                ('create_by', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to=settings.AUTH_USER_MODEL)),
                ('mcq_list', models.ManyToManyField(to='mcq.mcq')),
            ],
        ),
    ]