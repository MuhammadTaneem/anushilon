from rest_framework import viewsets
from rest_framework.authentication import BasicAuthentication, TokenAuthentication
from rest_framework.permissions import AllowAny

from .models import ExamSubmission
from .serializers import ExamSubmissionSerializer


class ExamSubmissionViewSet(viewsets.ModelViewSet):
    queryset = ExamSubmission.objects.all()
    serializer_class = ExamSubmissionSerializer
    authentication_classes = [BasicAuthentication, TokenAuthentication]
    permission_classes = [AllowAny]

    def create(self, request, *args, **kwargs):
        # Access the request data from the request.data attribute
        print("Request Body:", request.data)

        # Proceed with the default create implementation
        return super().create(request, *args, **kwargs)


