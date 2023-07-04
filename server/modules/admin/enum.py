from enum import Enum


def enum_dict():
    return {e.value: e.name for e in AdminRole}


class AdminRole(Enum):
    admin = "Admin"
    super_admin = "Super Admin"
    problem_setter = "Problem Setter"


# Get a specific enum value by its name
def get_admin_role(key):
    try:
        return AdminRole[key].value
    except KeyError:
        return None


# Example usage
print(get_admin_role("admin"))  # Output: "Admin"
print(get_admin_role("Super Admin"))  # Output: "Super Admin"
print(get_admin_role("nonexistent_role"))  # Output: None
