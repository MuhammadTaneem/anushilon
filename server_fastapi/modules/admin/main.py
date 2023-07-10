from datetime import datetime, timedelta

import formencode
from fastapi import APIRouter, status, Request
from fastapi.responses import JSONResponse
from core.exception import CustomException
from modules.admin.models import Admin
from core.db import SessionManager
from .validator import AdminLoginValidator, AdminValidator
from core.dependencis import verify_password, generate_token, ACCESS_TOKEN_EXPIRE_MINUTES, get_hash_password, \
    send_email
from .schema import ReadAdmin
from .enum import get_admin_role

router = APIRouter()


@router.get("/")
def get_user(request: Request):
    return {'status': status.HTTP_200_OK, 'message': 'admin Page loaded'}


@router.post("/login")
async def login_user(request: Request):
    try:
        admin_dict = await request.json()
        AdminLoginValidator.to_python(admin_dict)
        session = SessionManager.create_session()
        admin_exists = session.query(Admin).filter(Admin.email == admin_dict['email']).first()
        print(admin_exists)
        session.close()

        if not admin_exists:
            return JSONResponse(status_code=status.HTTP_404_NOT_FOUND,
                                content={'status': 'Failed', 'message': 'User not found, Please create an account.',
                                         'errors': None})

        password_verification = verify_password(admin_dict['password'], admin_exists.password)
        if not password_verification:
            return JSONResponse(status_code=status.HTTP_401_UNAUTHORIZED,
                                content={'status': 'Failed', 'message': 'Incorrect password.',
                                         'errors': None})

        expire_time = (datetime.now() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)).isoformat()

        data = {
            'id': admin_exists.id,
            'email': admin_exists.email,
            'role': admin_exists.role,
            'expire': expire_time,
            'token': generate_token(email=admin_exists.email),
        }
        return JSONResponse(status_code=status.HTTP_200_OK,
                            content={'status': 'Success', 'message': 'Login successfully',
                                     'user': data})
    except formencode.Invalid as e:
        return JSONResponse(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                            content={'status': 'Failed', 'message': 'Fix the following error.',
                                     'errors': e.unpack_errors()})

    except CustomException as e:
        raise e

    except Exception as e:
        raise CustomException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, status='Failed',
                              message='Internal  server error', error=e)


@router.post("/")
async def create_user(request: Request):
    try:
        # user_dict = user.__dict__
        user_dict = await request.json()
        # import pdb;pdb.set_trace()
        clean_data = AdminValidator.to_python(user_dict)
        clean_data.update({'password': get_hash_password(clean_data["password"])})
        del clean_data["password_confirm"]
        data = Admin(**clean_data)
        # session = create_session()
        session = SessionManager.create_session()

        session.add(data)
        session.commit()
        session.refresh(data)
        session.close()

        msg = f"Dear {data.full_name}, \n your account is successfully created . As a {get_admin_role(data.role)}"
        send_email(data.email, "Account Activation", msg)
        data = ReadAdmin.from_orm(data).__dict__

        # data = schema.ReadUser(**data.__dict__)
        return JSONResponse(status_code=status.HTTP_201_CREATED,
                            content={'status': 'Success', 'message': 'User Created successfully. Please Check your '
                                                                     'email to active your account', 'user': data})
    except formencode.Invalid as e:
        return JSONResponse(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                            content={'status': 'Failed', 'message': 'Fix the following error',
                                     'errors': e.unpack_errors()})

    except CustomException as e:
        raise e

    except Exception as e:
        # import pdb;pdb.set_trace()
        raise CustomException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, status='Failed',
                              message='Internal server error', error=e)
