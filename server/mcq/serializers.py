from rest_framework import serializers

from mcq.models import MCQ


class MCQSerializer(serializers.ModelSerializer):
    class Meta:
        model = MCQ
        fields = '__all__'
