import importlib
from enum import Enum


def hardness_enum_dict():
    return {e.name: e.value for e in Hardness}


def category_enum_dict():
    return {e.name: e.value for e in Category}


# def subjects_enum_dict():
#     return {{subject_enum.value: subject_enum.name, 'chapters ': {e.value: e.name for e in subject_enum.name}} for
#             subject_enum in Subject}


# def subjects_enum_dict():
#     return {
#         subject_enum.value: {
#             'name': subject_enum.name,
#             'value': subject_enum.value,
#             'chapters': {e.value: e.name for e in subject_enum}
#         } for subject_enum in Subject
#     }
module_name = __name__  # Use the current module name

# Import the module dynamically
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
    # Add more chapters for History

# # Get a specific enum value by its name
# def get_hardness_role(key):
#     try:
#         return Hardness[key].value
#     except KeyError:
#         return None


# def get_category_role(key):
#     try:
#         return Category[key].value
#     except KeyError:
#         return None
