from django.urls import path
from .views import ExamView,ExamUpdateView,get_exam_add_context,ExamRoutineView

app_name = 'exam_app'

urlpatterns = [
    path('', ExamView.as_view(), name='ExamView'),
    path('routine/', ExamRoutineView.as_view(), name='ExamRoutineView'),
    path('<int:pk>/', ExamUpdateView.as_view(), name='exam-update'),
    path('context/', get_exam_add_context, name='get_exam_add_context'),
]