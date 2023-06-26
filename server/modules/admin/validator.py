from formencode import Schema, validators, All


class AdminLoginValidator(Schema):
    password = validators.ByteString(not_empty=True, strip=True)
    email = All(validators.Email(not_empty=True, strip=True))
