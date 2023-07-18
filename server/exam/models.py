from django.db import models
from mcq.models import MCQ


class Exam(models.Model):
    syllabus = models.CharField(max_length=1023, null=False, blank=False)
    exam_number = models.IntegerField(null=False, blank=False)
    number_of_question = models.IntegerField(null=False, blank=False)
    duration = models.IntegerField(null=False, blank=False)
    point = models.IntegerField(null=False, blank=False)
    exam_date = models.DateField(null=False, blank=False)
    package = models.ForeignKey('package.Package', on_delete=models.DO_NOTHING, null=False, blank=False)
    creator = models.ForeignKey('custom_user.CustomUser', on_delete=models.DO_NOTHING, null=False, blank=False)
    mcq_list = models.ManyToManyField(MCQ)
    published = models.BooleanField(default=False)
    create_date = models.DateTimeField(auto_now_add=True)
    last_edit = models.DateTimeField(auto_now=True)

    @property
    def creator_name(self):
        if self.creator:
            return self.creator.full_name
        return None
