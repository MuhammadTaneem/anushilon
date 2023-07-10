from enum import Enum


# class UserRoleEnum(Enum):
#     admin = 'Admin'
#     super_admin = 'Super Admin'
#     problem_setter = 'Problem Setter'
#     student = 'Student'


import importlib
# from enum import Enum


def hardness_enum_dict():
    return {e.name: e.value for e in Hardness}


def category_enum_dict():
    return {e.name: e.value for e in Category}
module_name = __name__  # Use the current module name

module = importlib.import_module(module_name)
def subjects_enum_dict():
    return {
        subject_enum.value: {
            'name': subject_enum.name,
            'value': subject_enum.value,
            'chapters': {chapter_enum.name: chapter_enum.value for chapter_enum in getattr(module,subject_enum.value)}
        } for subject_enum in Subject
    }


class Hardness(Enum):
    easy = "Easy"
    medium = "Medium"
    hard = "Hard"
    super_hard = "Super Hard"


class Category(Enum):
    theoretical = "Theoretical"
    mathematical = "Mathematical"
    critical = "Critical"


class Subject(str, Enum):
    math = 'Math'
    science = 'Science'
    history = 'History'


class Math(str, Enum):
    algebra = 'Algebra'
    geometry = 'Geometry'
    calculus = 'Calculus'
    # Add more chapters for Math


class Science(str, Enum):
    physics = 'Physics'
    chemistry = 'Chemistry'
    biology = 'Biology'
    # Add more chapters for Science


class History(str, Enum):
    ancient_history = 'Ancient History'
    modern_history = 'Modern History'
    world_wars = 'World Wars'
