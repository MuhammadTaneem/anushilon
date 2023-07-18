from rest_framework import serializers

from mcq.models import MCQ


class MCQSerializer(serializers.ModelSerializer):
    class Meta:
        model = MCQ
        fields = (
            'id',
            'question',
            'question_img',
            'option_text_1',
            'option_img_1',
            'option_text_2',
            'option_img_2',
            'option_text_3',
            'option_img_3',
            'option_text_4',
            'option_img_4',
            'correct_ans',
            'explanation',
            'explanation_img',
            'hardness',
            'source',
            'categories',
            'subject',
            'chapter',
            'problem_setter',
            'verified',
            'published',
            'create_date',
            'last_edit',
            'problem_setter_name',  # Include the problem_setter_name field in the serializer
        )

    def validate(self, attrs):
        if not attrs.get('problem_setter'):
            attrs['problem_setter'] = self.context['request'].user

        # errors = {}
        #
        # if not attrs.get('option_text_1') and not attrs.get('option_img_1'):
        #     errors['option_text_1'] = "Text or Image is required."
        #
        # if not attrs.get('option_text_2') and not attrs.get('option_img_2'):
        #     errors['option_text_2'] = "Text or Image is required."
        #
        # if not attrs.get('option_text_3') and not attrs.get('option_img_3'):
        #     errors['option_text_3'] = "Text or Image is required."
        #
        # if not attrs.get('option_text_4') and not attrs.get('option_img_4'):
        #     errors['option_text_4'] = "Text or Image is required."
        #
        # if errors:
        #     raise serializers.ValidationError(errors)

        return attrs
