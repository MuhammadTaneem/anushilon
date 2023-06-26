from datetime import datetime, timedelta

import formencode
from fastapi import APIRouter, status, Request
from fastapi.responses import JSONResponse
from core.exception import CustomException
from modules.admin.models import Admin
from core.db import SessionManager
from .validator import AdminLoginValidator
from core.dependencis import verify_password, generate_token, ACCESS_TOKEN_EXPIRE_MINUTES

router = APIRouter()


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

        expire_time = (datetime.now()+timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)).isoformat()

        data = {
            'id': admin_exists.id,
            'email': admin_exists.email,
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
