from django.urls import path
from .views import CouponView,CouponUpdateView,get_coupon_add_context

app_name = 'coupon_app'

urlpatterns = [
    path('', CouponView.as_view(), name='CouponView'),
    path('<int:pk>/', CouponUpdateView.as_view(), name='CouponUpdateView'),
    path('context/', get_coupon_add_context, name='get_coupon_add_context'),
]