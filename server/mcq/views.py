from rest_framework import generics, mixins
from rest_framework.authentication import BasicAuthentication
from rest_framework.permissions import AllowAny

from .models import MCQ
from .serializers import MCQSerializer


class MCQView(mixins.ListModelMixin, mixins.CreateModelMixin, generics.RetrieveUpdateAPIView):
    queryset = MCQ.objects.all()
    serializer_class = MCQSerializer
    authentication_classes = [BasicAuthentication]
    permission_classes = [AllowAny]
    lookup_field = ['id']

    def get(self, request, *args, **kwargs):
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)
