from datetime import date, datetime, time
from django.utils import timezone
from django.http import JsonResponse
from django.views.decorators.http import require_GET
from rest_framework import generics, mixins
from rest_framework.authentication import BasicAuthentication, TokenAuthentication
from rest_framework.pagination import LimitOffsetPagination
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from exam.models import Exam
from utility.enum import group_enum_dict, package_category_enum_dict
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
    data = {
        'groups': group_enum_dict(),
        'category': package_category_enum_dict(),
    }
    try:
        return JsonResponse({'status': 200, 'message': 'context loaded', 'data': data})

    except Exception as e:
        return JsonResponse(
            {"status_code": 500, "status": 'Failed', "message": 'Internal server error', "error": str(e)}, status=500) \

@require_GET
def get_exam_package(request):
    try:
        category = request.GET.get('category', None)
        packages = Package.objects.filter(category=category, published=True)

        data = []

        for package in packages:

            exam = Exam.objects.filter(package=package, published=True, exam_date=date.today()).first()

            # exam = Exam.objects.filter(package=package, published=True, exam_date__date=date.today()).first()
            print(f'exam {exam}')
            exam_data = {'id': package.id, 'name': package.name, 'exam_id': exam.id if exam else None}
            data.append(exam_data)

        return JsonResponse({'status': 200, 'message': 'context loaded', 'data': data})

    except Exception as e:
        return JsonResponse(
            {"status_code": 500, "status": 'Failed', "message": 'Internal server error', "error": str(e)}, status=500)

# class GetPackageAndTodayExamView(RetrieveAPIView):
#     serializer_class = PackageSerializer
#     queryset = Package.objects.all()
#
#     def get_queryset(self):
#         category = self.request.query_params.get('category', None)
#         if category:
#             try:
#                 Package.objects.filter(category=category, published=True).all()
#                 # exam = Exam.objects.filter(package=package, date=date.today()).first()
#                 # if exam:
#                 #     return Exam.objects.filter(pk=exam.pk)  # Return the exam queryset
#                 # else:
#                 #     return Package.objects.filter(pk=package.pk)  # Return the package queryset
#                 return
#             except Package.DoesNotExist:
#                 pass
#
#         return Package.objects.none()
#
#     def get_object(self):
#         category = self.request.query_params.get('category', None)
#         if category:
#             try:
#                 packages = Package.objects.filter(category=category, published=True).all()
#                 # exam = Exam.objects.filter(package=package, date=date.today(), published=True).first()
#                 # if exam:
#                 #     return exam
#                 # else:
#                 #     # If there is no exam today, return the package information
#                 #     return package
#                 return packages
#             except Package.DoesNotExist:
#                 pass
#
#         return None
#
#
#
#
