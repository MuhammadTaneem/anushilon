from rest_framework import serializers

from .models import Package


class PackageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Package
        fields = (
            'id',
            'name',
            'description',
            'price',
            'discount_amount',
            'number_of_exam',
            'discount_start_date',
            'discount_end_date',
            'package_start_date',
            'package_end_date',
            'creator',
            'published',
            'group',
            'category',
            'last_edit',
            'published',
            'create_date',
            'last_edit',
            'creator_name',
        )

    def validate(self, attrs):
        if not attrs.get('creator'):
            attrs['creator'] = self.context['request'].user
        return attrs