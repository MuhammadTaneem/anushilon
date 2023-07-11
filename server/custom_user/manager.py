from django.contrib.auth.base_user import BaseUserManager
from django.contrib.auth.hashers import make_password

from custom_user.enum import UserRole


class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        import pdb;pdb.set_trace()
        if not email:
            raise ValueError("Email is required.")
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):

        extra_fields.setdefault('role',UserRole.super_admin.value)
        extra_fields.setdefault('is_staff', True)
        return self.create_user(email, password, **extra_fields)
