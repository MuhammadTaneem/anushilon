# Generated by Django 4.2.3 on 2023-07-10 16:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mcq', '0002_alter_mcq_chapter_alter_mcq_subject'),
    ]

    operations = [
        migrations.RenameField(
            model_name='mcq',
            old_name='option_img_url_1',
            new_name='option_img_1',
        ),
        migrations.RenameField(
            model_name='mcq',
            old_name='option_img_url_2',
            new_name='option_img_2',
        ),
        migrations.RenameField(
            model_name='mcq',
            old_name='option_img_url_3',
            new_name='option_img_3',
        ),
        migrations.RenameField(
            model_name='mcq',
            old_name='option_img_url_4',
            new_name='option_img_4',
        ),
        migrations.RenameField(
            model_name='mcq',
            old_name='question_img_url',
            new_name='question_img',
        ),
        migrations.AlterField(
            model_name='mcq',
            name='option_text_1',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='mcq',
            name='option_text_2',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='mcq',
            name='option_text_3',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
        migrations.AlterField(
            model_name='mcq',
            name='option_text_4',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]
