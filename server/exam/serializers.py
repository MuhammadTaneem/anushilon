from rest_framework import serializers

from exam.models import Exam
from mcq.models import MCQ


class ExamSerializer(serializers.ModelSerializer):
    creator = serializers.HiddenField(default=serializers.CurrentUserDefault())

    class Meta:
        model = Exam
        fields = (
            'id',
            'syllabus',
            'exam_number',
            'number_of_question',
            'duration',
            'point',
            'penalty',
            'exam_date',
            'package',
            'creator',
            'mcq_list',
            'creator_name',
            'published',
            'create_date',
            'package_name',
            'last_edit',
            'mcq_list_value'
        )

    mcq_list = serializers.PrimaryKeyRelatedField(
        queryset=MCQ.objects.all(),
        many=True,
        required=False,
    )


class ExamRoutineSerializer(serializers.ModelSerializer):
    class Meta:
        model = Exam
        fields = (
            'id',
            'syllabus',
            'exam_number',
            'number_of_question',
            'duration',
            'point',
            'penalty',
            'exam_date',
            'package',
            'package_name',
        )

