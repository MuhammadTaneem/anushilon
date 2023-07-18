from django.urls import path
from .views import PackageView, PackageUpdateView, get_package_add_context

app_name = 'package_app'

urlpatterns = [
    path('', PackageView.as_view(), name='package-list'),
    path('<int:pk>/', PackageUpdateView.as_view(), name='package-update'),
    path('context/', get_package_add_context, name='get_package_add_context'),
]