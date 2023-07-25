from django.db import models

from utility.enum import GroupEnum


class Student(models.Model):
    name = models.CharField(null=False, blank=False)
    email = models.CharField(null=False, blank=False)
    photo_url = models.CharField(null=False, blank=False)
    google_id = models.CharField(null=False, blank=False)
    balance = models.IntegerField(default=0, null=False, blank=False)
    group = models.CharField(max_length=20, choices=[(group.name, group.value) for group in GroupEnum], null=True,
                             blank=True)
    create_date = models.DateTimeField(auto_now_add=True)
    last_edit = models.DateTimeField(auto_now=True)
