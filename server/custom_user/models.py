from django.contrib.auth.models import AbstractBaseUser
from django.db import models
from enum import Enum

from custom_user.manager import CustomUserManager
from custom_user.user_enum import UserRoleEnum


class CustomUser(AbstractBaseUser):
    username = None
    email = models.EmailField(unique=True)
    full_name = models.CharField(max_length=50)
    is_staff = models.BooleanField(default=False)
    role = models.CharField(max_length=20, choices=[(role.name, role.value) for role in UserRoleEnum],
                            default=UserRoleEnum.student.value)

    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        return True

    def has_module_perms(self, app_label):
        return True
