from rest_framework import serializers

from coupon.models import Coupon
from package.models import Package


class CouponSerializer(serializers.ModelSerializer):
    creator = serializers.HiddenField(default=serializers.CurrentUserDefault())

    class Meta:
        model = Coupon
        fields = (
            'id',
            'coupon_text',
            'coupon_start_date',
            'coupon_end_date',
            'creator',
            'packages',
            'published',
            'creator_name',
            'create_date',
            'last_edit',
            'packages_list'
        )

    packages = serializers.PrimaryKeyRelatedField(
        queryset=Package.objects.all(),
        many=True,
        required=False,
    )

