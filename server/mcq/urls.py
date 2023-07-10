from django.urls import path
# from .views import MCQListView, MCQDetailView, MCQCreateView, MCQUpdateView, MCQDeleteView
from .views import MCQView
app_name = 'mcq_app'

urlpatterns = [
    path('', MCQView.as_view(), name='mcq-list'),
    # path('mcqs/<int:pk>/', MCQDetailView.as_view(), name='mcq-detail'),
    # path('mcqs/create/', MCQCreateView.as_view(), name='mcq-create'),
    # path('mcqs/<int:pk>/update/', MCQUpdateView.as_view(), name='mcq-update'),
    # path('mcqs/<int:pk>/delete/', MCQDeleteView.as_view(), name='mcq-delete'),
]