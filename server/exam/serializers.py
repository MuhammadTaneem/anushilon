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

    # def to_internal_value(self, data):
    #
    #     import pdb;pdb.set_trace()
    #     if 'mcq_list' in data:
    #         mcq_list = data['mcq_list']
    #         if isinstance(mcq_list, str):
    #             # Convert a comma-separated string to a list of integers
    #             mcq_list = [int(mcq_id) for mcq_id in mcq_list.split(',')]
    #
    #         data['mcq_list'] = mcq_list
    #
    #     return super().to_internal_value(data)
