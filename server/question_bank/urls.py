from django.urls import path
from .views import QuestionBankListCreateView, QuestionBankDetailView, get_question_bank_add_context, QuestionBankListView

urlpatterns = [
    path('', QuestionBankListCreateView.as_view(), name='question-bank-list-create'),
    path('list/', QuestionBankListView.as_view(), name='question-bank-list-view'),
    path('<int:pk>/', QuestionBankDetailView.as_view(), name='question-bank-detail'),
    path('context/', get_question_bank_add_context, name='get_question_bank_add_context'),
]
