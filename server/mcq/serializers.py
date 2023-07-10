from rest_framework import serializers

from mcq.models import MCQ


# class MCQSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = MCQ
#         fields = '__all__'
#
#     def validate(self, attrs):
#         if not attrs.get('option_text_1') and not attrs.get('option_img_url_1'):
#             raise serializers.ValidationError("Either option_text_1 or option_img_url_1 is required.")
#         elif not attrs.get('option_text_2') and not attrs.get('option_img_url_2'):
#             raise serializers.ValidationError("Either option_text_2 or option_img_url_2 is required.")
#         elif not attrs.get('option_text_3') and not attrs.get('option_img_url_3'):
#             raise serializers.ValidationError("Either option_text_3 or option_img_url_3 is required.")
#         elif not attrs.get('option_text_4') and not attrs.get('option_img_url_4'):
#             raise serializers.ValidationError("Either option_text_4 or option_img_url_4 is required.")
#
#         return attrs


class MCQSerializer(serializers.ModelSerializer):
    class Meta:
        model = MCQ
        fields = '__all__'

    def validate(self, attrs):
        errors = {}

        if not attrs.get('option_text_1') and not attrs.get('option_img_1'):
            errors['option_text_1'] = "Text or Image is required."

        if not attrs.get('option_text_2') and not attrs.get('option_img_2'):
            errors['option_text_2'] = "Text or Image is required."

        if not attrs.get('option_text_3') and not attrs.get('option_img_3'):
            errors['option_text_3'] = "Text or Image is required."

        if not attrs.get('option_text_4') and not attrs.get('option_img_4'):
            errors['option_text_4'] = "Text or Image is required."

        if errors:
            raise serializers.ValidationError(errors)

        return attrs
