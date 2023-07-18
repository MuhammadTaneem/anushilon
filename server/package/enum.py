from enum import Enum


class GroupEnum(Enum):
    arts = 'Arts'
    science = 'Science'
    commerce = 'Commerce'
def group_enum_dict():
    return {e.name: e.value for e in GroupEnum}

