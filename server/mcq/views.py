from django.views.decorators.http import require_GET
from rest_framework import generics, mixins, status
from rest_framework.authentication import BasicAuthentication, TokenAuthentication
from rest_framework.pagination import LimitOffsetPagination
from rest_framework.parsers import MultiPartParser
from rest_framework.permissions import AllowAny, IsAuthenticatedOrReadOnly
from django.db.models import Q
from .enum import hardness_enum_dict, category_enum_dict, subjects_enum_dict
from .models import MCQ
from .serializers import MCQSerializer
from custom_user.models import CustomUser
from django.http import JsonResponse


class MCQView(mixins.ListModelMixin, mixins.CreateModelMixin, generics.GenericAPIView):
    queryset = MCQ.objects.all()
    pagination_class = LimitOffsetPagination
    serializer_class = MCQSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]
    # parser_classes = [MultiPartParser]
    lookup_field = ['id']

    def get_queryset(self):
        queryset = super().get_queryset()
        subject = self.request.query_params.get('subject')
        if subject:
            queryset = queryset.filter(subject=subject)

        chapter = self.request.query_params.get('chapter')
        if chapter:
            queryset = queryset.filter(chapter=chapter)

        problem_setter = self.request.query_params.get('problem_setter')
        if problem_setter:
            queryset = queryset.filter(problem_setter=problem_setter)

        hardness = self.request.query_params.get('hardness')
        if hardness:
            queryset = queryset.filter(hardness=hardness)

        category = self.request.query_params.get('category')
        if category:
            queryset = queryset.filter(categories=category)

        q = self.request.query_params.get('q')
        if q:
            q = q.strip().lower()
            queryset = queryset.filter(Q(question__icontains=q))

        return queryset

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        problem_setter = request.data.get('problem_setter')
        if not problem_setter:
            mutable_data = request.data.copy()  # Create a mutable copy of request.data
            mutable_data['problem_setter'] = request.user.id
            request._data = mutable_data  # Update request._data with the modified copy
        return self.create(request, *args, **kwargs)


class MCQUpdateView(mixins.RetrieveModelMixin, mixins.UpdateModelMixin, generics.GenericAPIView):
    queryset = MCQ.objects.all()
    serializer_class = MCQSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]
    # parser_classes = [MultiPartParser]

    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)

    def put(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)




@require_GET
def get_mcq_add_context(request):
    try:
        admins = CustomUser.objects.filter(role="problem_setter")
        admin_data = {admin.id: admin.full_name for admin in admins}

        data = {
            'hardness': hardness_enum_dict(),
            'category': category_enum_dict(),
            'subject': subjects_enum_dict(),
            'problem_setter': admin_data
        }
        return JsonResponse({'status': 200, 'message': 'context loaded', 'data': data})

    except Exception as e:
        return JsonResponse({"status_code": 500, "status": 'Failed', "message": 'Internal server error', "error": str(e)}, status=500)

