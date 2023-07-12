from django.db import models
from .enum import Subject,Category

class MCQ(models.Model):
    question = models.TextField()
    question_img = models.ImageField(upload_to='mcq', null=True, blank=True)
    option_text_1 = models.CharField(max_length=100, null=True, blank=True)
    option_img_1 = models.ImageField(upload_to='mcq', null=True, blank=True)
    option_text_2 =  models.CharField(max_length=100, null=True, blank=True)
    option_img_2 = models.ImageField(upload_to='mcq', null=True, blank=True)
    option_text_3 =  models.CharField(max_length=100, null=True, blank=True)
    option_img_3 = models.ImageField(upload_to='mcq', null=True, blank=True)
    option_text_4 = models.CharField(max_length=100, null=True, blank=True)
    option_img_4 = models.ImageField(upload_to='mcq', null=True, blank=True)
    correct_ans = models.CharField(max_length=100)
    explanation = models.TextField()
    explanation_img = models.ImageField(upload_to='mcq', null=True, blank=True)
    hardness = models.CharField(max_length=100)
    categories = models.CharField(max_length=100)
    subject = models.CharField(max_length=100)
    chapter = models.CharField(max_length=100)
    problem_setter = models.ForeignKey('custom_user.CustomUser', on_delete=models.SET_NULL, null=True)
    verified = models.BooleanField(default=False)
    published = models.BooleanField(default=False)
    create_date = models.DateTimeField(auto_now_add=True)
    last_edit = models.DateTimeField(auto_now=True)

    @property
    def problem_setter_name(self):
        if self.problem_setter:
            return self.problem_setter.full_name
        return None
