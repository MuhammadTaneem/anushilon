from django.db import models
from exam.models import Exam
from mcq.models import MCQ
from student.models import Student


class ExamSubmission(models.Model):
    student = models.ForeignKey(Student, on_delete=models.DO_NOTHING, null=False, blank=False)
    exam = models.ForeignKey(Exam, on_delete=models.DO_NOTHING, null=False, blank=False)
    mcq_list = models.ManyToManyField(MCQ, through='MCQSubmission')
    point = models.IntegerField(null=True,blank=False,default=0)
    penalty = models.FloatField(null=True,blank=False,default=0)
    create_date = models.DateTimeField(auto_now_add=True)
    last_edit = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.student} - {self.exam}"


class MCQSubmission(models.Model):
    exam_submission = models.ForeignKey(ExamSubmission, on_delete=models.CASCADE)
    mcq = models.ForeignKey(MCQ, on_delete=models.CASCADE)
    submitted_option = models.IntegerField()

    def __str__(self):
        return f"{self.exam_submission} - {self.mcq}"
