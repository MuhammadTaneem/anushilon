from rest_framework import serializers

from .models import Student


class StudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Student
        fields = (
            'id',
            'name',
            'email',
            'photo_url',
            'balance',
            'google_id',
            'group',
            'create_date',
            'last_edit',
        )