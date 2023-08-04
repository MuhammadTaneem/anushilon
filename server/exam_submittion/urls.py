from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ExamSubmissionViewSet

router = DefaultRouter()
router.register(r'', ExamSubmissionViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
