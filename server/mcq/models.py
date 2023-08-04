from django.db import models
from rest_framework.exceptions import ValidationError



class MCQ(models.Model):
    question = models.TextField()
    question_img = models.ImageField(upload_to='mcq', null=True, blank=True)
    option_text_1 = models.CharField(max_length=100, null=True, blank=True)
    option_img_1 = models.ImageField(upload_to='mcq', null=True, blank=True)
    option_text_2 = models.CharField(max_length=100, null=True, blank=True)
    option_img_2 = models.ImageField(upload_to='mcq', null=True, blank=True)
    option_text_3 = models.CharField(max_length=100, null=True, blank=True)
    option_img_3 = models.ImageField(upload_to='mcq', null=True, blank=True)
    option_text_4 = models.CharField(max_length=100, null=True, blank=True)
    option_img_4 = models.ImageField(upload_to='mcq', null=True, blank=True)
    correct_ans = models.IntegerField()
    explanation = models.TextField()
    explanation_img = models.ImageField(upload_to='mcq', null=True, blank=True)
    hardness = models.CharField(max_length=100)
    source = models.CharField(max_length=100, null=True, blank=True)
    categories = models.CharField(max_length=100)
    subject = models.CharField(max_length=100)
    chapter = models.CharField(max_length=100)
    problem_setter = models.ForeignKey('custom_user.CustomUser', on_delete=models.DO_NOTHING, null=True, blank=True)
    verified = models.BooleanField(default=False)
    published = models.BooleanField(default=False)
    create_date = models.DateTimeField(auto_now_add=True)
    last_edit = models.DateTimeField(auto_now=True)

    def clean(self):
        errors = {}
        if not self.option_text_1 and not self.option_img_1:
            errors['option_text_1'] = "Text or Image is required."
        if not self.option_text_2 and not self.option_img_2:
            errors['option_text_2'] = "Text or Image is required."
        if not self.option_text_3 and not self.option_img_3:
            errors['option_text_3'] = "Text or Image is required."
        if not self.option_text_4 and not self.option_img_4:
            errors['option_text_4'] = "Text or Image is required."
        if errors:
            raise ValidationError(errors)

        super().clean()

    def save(self, *args, **kwargs):
        self.full_clean()
        super().save(*args, **kwargs)

    # def has_valid_options(self):
    #     option_fields = [
    #         (self.option_text_1, self.option_img_1),
    #         (self.option_text_2, self.option_img_2),
    #         (self.option_text_3, self.option_img_3),
    #         (self.option_text_4, self.option_img_4),
    #     ]
    #
    #     for option_text, option_img in option_fields:
    #         if not option_text and not option_img:
    #             return False
    #     return True

    @property
    def problem_setter_name(self):
        if self.problem_setter:
            return self.problem_setter.full_name
        return None
    def __str__(self):
        return self.question
