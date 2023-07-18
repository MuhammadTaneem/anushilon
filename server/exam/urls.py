from django.urls import path
from .views import ExamView,ExamUpdateView,get_exam_add_context

app_name = 'exam_app'

urlpatterns = [
    path('', ExamView.as_view(), name='ExamView'),
    path('<int:pk>/', ExamUpdateView.as_view(), name='exam-update'),
    path('context/', get_exam_add_context, name='get_exam_add_context'),
]