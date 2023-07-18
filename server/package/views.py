from django.http import JsonResponse
from django.views.decorators.http import require_GET
from rest_framework import generics, mixins
from rest_framework.authentication import BasicAuthentication, TokenAuthentication
from rest_framework.pagination import LimitOffsetPagination
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from .enum import group_enum_dict
from .models import Package
from .serializers import PackageSerializer


class PackageView(mixins.ListModelMixin, mixins.CreateModelMixin, generics.GenericAPIView):
    queryset = Package.objects.all()
    pagination_class = LimitOffsetPagination
    serializer_class = PackageSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        queryset = super().get_queryset()
        published = self.request.query_params.get('published')
        if published:
            queryset = queryset.filter(published=published)

        group = self.request.query_params.get('group')
        if group:
            queryset = queryset.filter(group=group)

        start_date = self.request.query_params.get('package_start_date')
        if start_date:
            queryset = queryset.filter(package_start_date__gte=start_date)

        end_date = self.request.query_params.get('package_end_date')
        if end_date:
            queryset = queryset.filter(package_end_date__lte=end_date)

        queryset = queryset.order_by('-id')

        return queryset

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)


class PackageUpdateView(mixins.RetrieveModelMixin, mixins.UpdateModelMixin, generics.GenericAPIView):
    queryset = Package.objects.all()
    serializer_class = PackageSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)

    def put(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)


@require_GET
def get_package_add_context(request):
    try:
        return JsonResponse({'status': 200, 'message': 'context loaded', 'groups': group_enum_dict()})

    except Exception as e:
        return JsonResponse(
            {"status_code": 500, "status": 'Failed', "message": 'Internal server error', "error": str(e)}, status=500)
