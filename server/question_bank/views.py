from django.db.models import Q
from django.http import JsonResponse
from django.views.decorators.http import require_GET
from rest_framework import generics, mixins
from rest_framework.authentication import BasicAuthentication, TokenAuthentication
from rest_framework.pagination import LimitOffsetPagination
from rest_framework.permissions import IsAuthenticatedOrReadOnly

from custom_user.models import CustomUser
from utility.enum import varsity_enum_dict, varsity_unit_enum_dict
from .models import QuestionBank
from .serializers import QuestionBankSerializer


class QuestionBankListCreateView(mixins.ListModelMixin, mixins.CreateModelMixin, generics.GenericAPIView):
    queryset = QuestionBank.objects.all()
    serializer_class = QuestionBankSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]
    pagination_class = LimitOffsetPagination

    def get_queryset(self):
        queryset = super().get_queryset()

        varsity = self.request.query_params.get('varsity')
        if varsity:
            queryset = queryset.filter(varsity=varsity)

        unit = self.request.query_params.get('unit')
        if unit:
            queryset = queryset.filter(unit=unit)

        year = self.request.query_params.get('year')
        if year:
            queryset = queryset.filter(year=year)

        published = self.request.query_params.get('published')
        if published:
            queryset = queryset.filter(published=published)
        queryset = queryset.order_by('-id')

        return queryset

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        print(request.data)
        return self.create(request, *args, **kwargs)


class QuestionBankDetailView(mixins.RetrieveModelMixin, mixins.UpdateModelMixin,
                             generics.GenericAPIView):
    queryset = QuestionBank.objects.all()
    serializer_class = QuestionBankSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [IsAuthenticatedOrReadOnly]

    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)

    def put(self, request, *args, **kwargs):
        return self.partial_update(request, *args, **kwargs)


@require_GET
def get_question_bank_add_context(request):
    try:
        data = {
            'varsity_enum_dict': varsity_enum_dict(),
            'varsity_unit_enum_dict': varsity_unit_enum_dict(),
        }
        return JsonResponse({'status': 200, 'message': 'context loaded', 'data': data})

    except Exception as e:
        return JsonResponse(
            {"status_code": 500, "status": 'Failed', "message": 'Internal server error', "error": str(e)}, status=500)
