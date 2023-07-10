from django.urls import path
# from .views import MCQListView, MCQDetailView, MCQCreateView, MCQUpdateView, MCQDeleteView
from .views import MCQView, MCQUpdateView, get_mcq_add_context

app_name = 'mcq_app'

urlpatterns = [
    path('', MCQView.as_view(), name='mcq-list'),
    path('<int:pk>/', MCQUpdateView.as_view(), name='mcq-update'),
    path('context/', get_mcq_add_context, name='get_mcq_add_context'),
    # path('mcqs/<int:pk>/', MCQDetailView.as_view(), name='mcq-detail'),
    # path('mcqs/create/', MCQCreateView.as_view(), name='mcq-create'),
    # path('mcqs/<int:pk>/update/', MCQUpdateView.as_view(), name='mcq-update'),
    # path('mcqs/<int:pk>/delete/', MCQDeleteView.as_view(), name='mcq-delete'),
]