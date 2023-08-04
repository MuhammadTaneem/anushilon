from datetime import date

from django.http import JsonResponse
from django.views.decorators.http import require_GET
from rest_framework import generics, mixins
from rest_framework.authentication import BasicAuthentication, TokenAuthentication
from rest_framework.pagination import LimitOffsetPagination
from rest_framework.permissions import IsAuthenticatedOrReadOnly, AllowAny

from custom_user.models import CustomUser
from utility.enum import subjects_enum_dict, hardness_enum_dict, category_enum_dict
from package.models import Package
from .models import Exam
from .serializers import ExamSerializer, ExamRoutineSerializer


class ExamView(mixins.ListModelMixin, mixins.CreateModelMixin, generics.GenericAPIView):
    queryset = Exam.objects.all()
    pagination_class = LimitOffsetPagination
    serializer_class = ExamSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        queryset = super().get_queryset()
        published = self.request.query_params.get('published')
        if published:
            queryset = queryset.filter(published=published)

        package = self.request.query_params.get('package')
        if package:
            queryset = queryset.filter(package=package)

        # subjects = self.request.query_params.get('subjects')
        # if subjects:
        #     queryset = queryset.filter(subjects__icontains=subjects)
        #
        # chapters = self.request.query_params.get('chapters')
        # if chapters:
        #     queryset = queryset.filter(chapters__icontains=chapters)

        from_date = self.request.query_params.get('exam_from_date')
        if from_date:
            queryset = queryset.filter(exam_date__gte=from_date)

        to_date = self.request.query_params.get('exam_to_date')
        if to_date:
            queryset = queryset.filter(exam_date__lte=to_date)

        queryset = queryset.order_by('-id')

        return queryset

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)


class ExamRoutineView(mixins.ListModelMixin, generics.GenericAPIView):
    queryset = Exam.objects.all()
    pagination_class = LimitOffsetPagination
    serializer_class = ExamRoutineSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        queryset = super().get_queryset()
        queryset = queryset.filter(published=True)

        package = self.request.query_params.get('package')
        if package:
            queryset = queryset.filter(package=package)

        from_date = self.request.query_params.get('exam_from_date')
        if from_date:
            queryset = queryset.filter(exam_date__gte=from_date)

        to_date = self.request.query_params.get('exam_to_date')
        if to_date:
            queryset = queryset.filter(exam_date__lte=to_date)

        queryset = queryset.order_by('-id')

        return queryset

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)


class ExamUpdateView(mixins.RetrieveModelMixin, mixins.UpdateModelMixin, generics.GenericAPIView):
    queryset = Exam.objects.all()
    pagination_class = LimitOffsetPagination
    serializer_class = ExamSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)

    def put(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)


@require_GET
def get_exam_add_context(request):
    try:
        packages = Package.objects.filter(published=True)
        packages_list = {package.id: package.name for package in packages}
        admins = CustomUser.objects.all()
        admin_data = {admin.id: admin.full_name for admin in admins}

        data = {
            'subjects': subjects_enum_dict(),
            'packages': packages_list,
            'hardness': hardness_enum_dict(),
            'category': category_enum_dict(),
            'problem_setter': admin_data
        }
        return JsonResponse({'status': 200, 'message': 'context loaded', 'data': data})

    except Exception as e:
        return JsonResponse(
            {"status_code": 500, "status": 'Failed', "message": 'Internal server error', "error": str(e)}, status=500)
