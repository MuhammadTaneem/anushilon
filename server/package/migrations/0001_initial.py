# Generated by Django 4.2.3 on 2023-07-30 04:50

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Package',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.TextField()),
                ('description', models.TextField()),
                ('price', models.IntegerField()),
                ('discount_amount', models.IntegerField(blank=True, null=True)),
                ('number_of_exam', models.IntegerField()),
                ('discount_start_date', models.DateTimeField(blank=True, null=True)),
                ('discount_end_date', models.DateTimeField(blank=True, null=True)),
                ('package_start_date', models.DateTimeField()),
                ('package_end_date', models.DateTimeField()),
                ('published', models.BooleanField(default=False)),
                ('group', models.CharField(choices=[('arts', 'Arts'), ('science', 'Science'), ('commerce', 'Commerce')], max_length=20)),
                ('category', models.CharField(choices=[('varsity', 'Varsity'), ('medical', 'Medical'), ('engineering', 'Engineering'), ('guccho', 'Guccho')], max_length=20)),
                ('create_date', models.DateTimeField(auto_now_add=True)),
                ('last_edit', models.DateTimeField(auto_now=True)),
                ('creator', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
