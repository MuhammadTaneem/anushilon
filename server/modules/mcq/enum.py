from enum import Enum


def hardness_enum_dict():
    return {e.value: e.name for e in Hardness}


def category_enum_dict():
    return {e.value: e.name for e in Category}


class Hardness(Enum):
    easy = "Easy"
    medium = "Medium"
    hard = "Hard"
    super_hard = "Super Hard"


class Category(Enum):
    theoretical = "Theoretical"
    mathematical = "Mathematical"
    critical = "Critical"


# Get a specific enum value by its name
def get_hardness_role(key):
    try:
        return Hardness[key].value
    except KeyError:
        return None


def get_category_role(key):
    try:
        return Category[key].value
    except KeyError:
        return None
