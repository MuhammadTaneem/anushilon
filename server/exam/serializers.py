from rest_framework import serializers

from exam.models import Exam
from mcq.models import MCQ


class ExamSerializer(serializers.ModelSerializer):
    mcq_list = serializers.ListField(child=serializers.IntegerField())

    class Meta:
        model = Exam
        fields = (
            'id',
            'syllabus',
            'exam_number',
            'number_of_question',
            'duration',
            'point',
            'exam_date',
            'package',
            'creator',
            'mcq_list',
            'creator_name',
            'published',
            'create_date',
            'last_edit'
        )

    def create(self, validated_data):
        mcq_list_data = validated_data.pop('mcq_list', [])
        exam = Exam.objects.create(**validated_data)
        for question_id in mcq_list_data:
            mcq_question = MCQ.objects.get(id=question_id)
            exam.mcq_list.add(mcq_question)

        return exam

    def validate(self, attrs):
        if not attrs.get('creator'):
            attrs['creator'] = self.context['request'].user
        return attrs
