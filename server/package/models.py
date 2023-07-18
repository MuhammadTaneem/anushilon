from django.db import models
from .enum import GroupEnum


class Package(models.Model):
    name = models.TextField(null=False, blank=False)
    description = models.TextField(null=False, blank=False)
    price = models.IntegerField(null=False, blank=False)
    discount_amount = models.IntegerField(null=True, blank=True)
    number_of_exam = models.IntegerField(null=False, blank=False)
    discount_start_date = models.DateTimeField(null=True, blank=True)
    discount_end_date = models.DateTimeField(null=True, blank=True)
    package_start_date = models.DateTimeField(null=False, blank=False)
    package_end_date = models.DateTimeField(null=False, blank=False)
    creator = models.ForeignKey('custom_user.CustomUser', on_delete=models.DO_NOTHING, null=True, blank=True)
    published = models.BooleanField(default=False)
    group = models.CharField(max_length=20, choices=[(group.name, group.value) for group in GroupEnum], null=False,
                             blank=False)
    create_date = models.DateTimeField(auto_now_add=True)
    last_edit = models.DateTimeField(auto_now=True)

    @property
    def creator_name(self):
        if self.creator:
            return self.creator.full_name
        return None
