from rest_framework import serializers

from mcq.models import MCQ
from mcq.serializers import MCQSerializer
from question_bank.models import QuestionBank


class QuestionBankSerializer(serializers.ModelSerializer):
    mcq_list = MCQSerializer(many=True)

    class Meta:
        model = QuestionBank
        fields = (
            'id',
            'varsity',
            'unit',
            'year',
            'mcq_list',
            'published',
            'create_date',
            'last_edit',
            'creator_name',
            'create_by',
        )

    def validate(self, attrs):
        # import pdb;
        # pdb.set_trace()
        if not attrs.get('create_by'):
            attrs['create_by'] = self.context['request'].user
        return attrs

    # def create(self, validated_data):
    #     import pdb;pdb.set_trace()
    #     mcq_data_list = validated_data.pop('mcq_list')
    #     question_bank = QuestionBank.objects.create(**validated_data)
    #     for mcq_data in mcq_data_list:
    #         mcq = MCQ.objects.create(**mcq_data)
    #         question_bank.mcq_list.add(mcq.id)
    #     return question_bank
    def create(self, validated_data):
        mcq_data_list = validated_data.pop('mcq_list')

        question_bank = QuestionBank.objects.create(**validated_data)
        for mcq_data in mcq_data_list:
            mcq = MCQ.objects.create(**mcq_data)
            question_bank.mcq_list.add(mcq.id)
        # import pdb;
        # pdb.set_trace()
        return question_bank
