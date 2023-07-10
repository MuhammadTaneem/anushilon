from enum import Enum


class UserRole(Enum):
    admin = 'Admin'
    super_admin = 'Super Admin'
    problem_setter = 'Problem Setter'
    student = 'Student'


