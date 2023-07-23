from django.urls import path
from .views import create_or_return_student, update_student, get_student

urlpatterns = [
    path('', create_or_return_student, name='create_or_return_student'),
    path('<int:pk>/', update_student, name='update_student'),
    # path('student/', get_student, name='get_student_by_email'),
]
