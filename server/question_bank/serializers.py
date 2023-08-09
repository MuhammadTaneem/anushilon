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
        if not attrs.get('create_by'):
            attrs['create_by'] = self.context['request'].user
        return attrs

    def create(self, validated_data):
        mcq_data_list = validated_data.pop('mcq_list')
        question_bank = QuestionBank.objects.create(**validated_data)
        for mcq_data in mcq_data_list:
            mcq = MCQ.objects.create(**mcq_data)
            question_bank.mcq_list.add(mcq.id)
        return question_bank

    def update(self, instance, validated_data):
        mcq_data_list = self.initial_data.get('mcq_list', [])
        instance.varsity = validated_data.get('varsity', instance.varsity)
        instance.unit = validated_data.get('unit', instance.unit)
        instance.year = validated_data.get('year', instance.year)
        instance.published = validated_data.get('published', instance.published)
        instance.create_by = validated_data.get('create_by', instance.create_by)
        # instance.creator_name = validated_data.get('creator_name', instance.creator_name)

        # Update MCQ instances or create new ones
        updated_mcq_ids = []
        for mcq_data in mcq_data_list:
            # import pdb;pdb.set_trace()
            mcq_id = mcq_data.get('id')
            if mcq_id:
                updated_mcq_ids.append(mcq_id)
                instance.mcq_list.add(mcq_id)
                # mcq_instance = instance.mcq_list.filter(id=mcq_id).first()
                # if mcq_instance:
                #     mcq_serializer = MCQSerializer(mcq_instance, data=mcq_data)
                #     if mcq_serializer.is_valid():
                #         mcq_serializer.save()
                #         updated_mcq_ids.append(mcq_instance.id)
            else:
                mcq = MCQ.objects.create(**mcq_data)
                updated_mcq_ids.append(mcq.id)
                instance.mcq_list.add(mcq.id)

        # Remove MCQ instances that were not in the updated data
        for mcq_instance in instance.mcq_list.all():
            if mcq_instance.id not in updated_mcq_ids:
                mcq_instance.delete()

        instance.save()
        return instance


    # def update(self, instance, validated_data):
    #     import pdb;pdb.set_trace()
    #
    #     mcq_data_list = validated_data.pop('mcq_list')
    #
    #     question_bank = QuestionBank.objects.create(**validated_data)
    #     for mcq_data in mcq_data_list:
    #         # mcq = MCQ.objects.create(**mcq_data)
    #         question_bank.mcq_list.add(mcq_data)
    #     return question_bank

class QuestionBankUpdateSerializer(serializers.ModelSerializer):
    mcq_list = MCQSerializer(many=True, required=False)
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
        if not attrs.get('create_by'):
            attrs['create_by'] = self.context['request'].user
        return attrs

    def update(self, instance, validated_data):
        import pdb;pdb.set_trace()

        mcq_data_list = validated_data.pop('mcq_list')

        question_bank = QuestionBank.objects.create(**validated_data)
        for mcq_data in mcq_data_list:
            # mcq = MCQ.objects.create(**mcq_data)
            question_bank.mcq_list.add(mcq_data)
        return question_bank
class QuestionBankListSerializer(serializers.ModelSerializer):
    class Meta:
        model = QuestionBank
        fields = (
            'id',
            'varsity',
            'unit',
            'year',
        )
