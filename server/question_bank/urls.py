from django.urls import path
from .views import QuestionBankListCreateView, QuestionBankDetailView, get_question_bank_add_context

urlpatterns = [
    path('', QuestionBankListCreateView.as_view(), name='question-bank-list-create'),
    path('<int:pk>/', QuestionBankDetailView.as_view(), name='question-bank-detail'),
    path('context/', get_question_bank_add_context, name='get_question_bank_add_context'),
]
