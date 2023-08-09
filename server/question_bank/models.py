from django.db import models
from mcq.models import MCQ


class QuestionBank(models.Model):
    varsity = models.CharField(max_length=100)
    unit = models.CharField(max_length=100)
    year = models.PositiveIntegerField()
    mcq_list = models.ManyToManyField(MCQ)
    published = models.BooleanField(default=False)
    create_by = models.ForeignKey('custom_user.CustomUser', on_delete=models.DO_NOTHING, null=True, blank=True)
    create_date = models.DateTimeField(auto_now_add=True)
    last_edit = models.DateTimeField(auto_now=True)

    @property
    def creator_name(self):
        if self.create_by:
            return self.create_by.full_name
        return None

    def __str__(self):
        return f"{self.varsity} - {self.unit} ({self.year})"
