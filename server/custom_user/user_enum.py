from enum import Enum


class UserRoleEnum(Enum):
    admin = 'Admin'
    super_admin = 'Super Admin'
    problem_setter = 'Problem Setter'
    student = 'Student'


