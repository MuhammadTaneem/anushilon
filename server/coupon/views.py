from django.http import JsonResponse
from django.views.decorators.http import require_GET
from rest_framework import generics, mixins
from rest_framework.authentication import BasicAuthentication, TokenAuthentication
from rest_framework.pagination import LimitOffsetPagination
from rest_framework.permissions import IsAuthenticatedOrReadOnly

from custom_user.models import CustomUser
from package.serializers import PackageSerializer
from utility.enum import subjects_enum_dict, hardness_enum_dict, category_enum_dict, group_enum_dict
from package.models import Package
from .models import Coupon
from .serializers import CouponSerializer


class CouponView(mixins.ListModelMixin, mixins.CreateModelMixin, generics.GenericAPIView):
    queryset = Coupon.objects.all()
    pagination_class = LimitOffsetPagination
    serializer_class = CouponSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]



    def get_queryset(self):
        queryset = super().get_queryset()
        queryset = queryset.order_by('-id')

        return queryset



    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)


class CouponUpdateView(mixins.RetrieveModelMixin, mixins.UpdateModelMixin, generics.GenericAPIView):
    queryset = Coupon.objects.all()
    pagination_class = LimitOffsetPagination
    serializer_class = CouponSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)

    def put(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)


@require_GET
def get_coupon_add_context(request):
    try:
        packages = Package.objects.filter(published=True)
        serializer = PackageSerializer(packages, many=True)

        data = {

            'packages': serializer.data,
            'groups': group_enum_dict()

        }
        return JsonResponse({'status': 200, 'message': 'context loaded', 'data': data})

    except Exception as e:
        return JsonResponse(
            {"status_code": 500, "status": 'Failed', "message": 'Internal server error', "error": str(e)}, status=500)
