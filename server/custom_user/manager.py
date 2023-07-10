from django.contrib.auth.base_user import BaseUserManager

from custom_user.user_enum import UserRoleEnum


class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError("Email is required.")
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):

        extra_fields.setdefault('role',UserRoleEnum.super_admin.value)
        extra_fields.setdefault('is_staff', True)
        return self.create_user(email, password, **extra_fields)
