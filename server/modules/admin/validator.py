from formencode import Schema, validators, FancyValidator, Invalid, All
from core.db import SessionManager
from modules.admin.models import Admin


class AdminLoginValidator(Schema):
    password = validators.ByteString(not_empty=True, strip=True)
    email = All(validators.Email(not_empty=True, strip=True))


class UniqueUserValidator(FancyValidator):

    def _convert_to_python(self, value, state):
        session = SessionManager.create_session()

        user_exists = session.query(Admin).filter(Admin.email == value).first()
        session.close()
        email_msg = 'That email already exists'
        if user_exists:
            raise Invalid(email_msg, value, state)

        return value


class AdminValidator(Schema):
    full_name = validators.String(not_empty=True, strip=True)
    role = validators.String(not_empty=True, strip=True)
    email = All(validators.Email(not_empty=True, strip=True), UniqueUserValidator())
    password = validators.String(not_empty=True, strip=True)
    password_confirm = validators.String(not_empty=True, strip=True)
    chained_validators = [validators.FieldsMatch('password', 'password_confirm')]
