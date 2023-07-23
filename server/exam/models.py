from django.db import models

from custom_user.models import CustomUser
from mcq.models import MCQ
from package.models import Package


class Exam(models.Model):
    syllabus = models.CharField(max_length=1023, null=False, blank=False)
    exam_number = models.IntegerField(null=False, blank=False)
    number_of_question = models.IntegerField(null=False, blank=False)
    duration = models.IntegerField(null=False, blank=False)
    point = models.IntegerField(null=False, blank=False)
    exam_date = models.DateTimeField(null=False, blank=False)
    package = models.ForeignKey(Package, on_delete=models.DO_NOTHING, null=False, blank=False)
    creator = models.ForeignKey(CustomUser, on_delete=models.DO_NOTHING, null=False, blank=False)
    mcq_list = models.ManyToManyField(MCQ)
    published = models.BooleanField(default=False)
    create_date = models.DateTimeField(auto_now_add=True)
    last_edit = models.DateTimeField(auto_now=True)

    @property
    def creator_name(self):
        if self.creator:
            return self.creator.full_name
        return None
    def package_name(self):
        if self.package:
            return self.package.name
        return None

    def mcq_list_value(self):
        related_objects = self.mcq_list.all()
        related_ids = related_objects.values()
        return related_ids
