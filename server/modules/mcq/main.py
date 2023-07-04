
import formencode
from fastapi import APIRouter, status, Request, Depends, Query
from fastapi.responses import JSONResponse
from core.exception import CustomException
from modules.admin.models import Admin
from core.db import SessionManager
from .models import MCQ
from .validator import McqValidator
from core.dependencis import verify_password, generate_token, ACCESS_TOKEN_EXPIRE_MINUTES, get_hash_password, \
    send_email, get_current_user
from .schema import McqSchema
from .enum import category_enum_dict, get_category_role, get_hardness_role, hardness_enum_dict
from ..admin.enum import AdminRole
from sqlalchemy.orm import attributes

router = APIRouter()


@router.get("/")
def get_mcq(
        subject: int = Query(None),
        chapter: int = Query(None),
        problem_setter: int = Query(None),
        hardness: str = Query(None),
        category: str = Query(None),
        q: str = Query(None)
):
    session = SessionManager.create_session()
    query = session.query(MCQ)

    if subject is not None:
        query = query.filter(MCQ.subject == subject)

    if chapter is not None:
        query = query.filter(MCQ.chapter == chapter)

    if problem_setter is not None:
        query = query.filter(MCQ.problem_setter == problem_setter)

    if hardness is not None:
        query = query.filter(MCQ.hardness == hardness)

    if category is not None:
        query = query.filter(MCQ.categories == category)

    if q is not None:
        q = q.strip().lower()
        search_pattern = f"%{q}%"
        query = query.filter(MCQ.question.ilike(search_pattern))

    mcq_list = query.all()
    return {'status': status.HTTP_200_OK, 'message': 'mcq List loaded', 'mcq_list': mcq_list}


@router.post("/")
async def write_mcq(request: Request, current_user: Admin = Depends(get_current_user)):
    try:
        mcq_dict = await request.json()
        if current_user.role == AdminRole.problem_setter:
            mcq_dict["problem_setter"] = current_user.id
        clean_data = McqValidator.to_python(mcq_dict)
        data = MCQ(**clean_data)
        session = SessionManager.create_session()
        session.add(data)
        session.commit()
        session.refresh(data)
        session.close()
        return JSONResponse(status_code=status.HTTP_201_CREATED,
                            content={'status': 'Success', 'message': 'MCQ Uploaded successfully',
                                     'mcq': {"id": data.id, "question": data.question}})
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


@router.put("/{mcq_id}")
async def update_mcq(mcq_id: int, request: Request, current_user: Admin = Depends(get_current_user)):
    try:
        mcq_dict = await request.json()
        if current_user.role == AdminRole.problem_setter:
            mcq_dict["problem_setter"] = current_user.id

        session = SessionManager.create_session()
        existing_mcq = session.query(MCQ).filter(MCQ.id == mcq_id).first()

        if not existing_mcq:
            session.close()
            raise CustomException(status_code=status.HTTP_404_NOT_FOUND, status='Failed',
                                  message='MCQ not found')

        # Update the existing MCQ record with the new data
        clean_data = McqValidator.to_python(mcq_dict)
        for key, value in clean_data.items():
            setattr(existing_mcq, key, value)
        session.commit()
        session.refresh(existing_mcq)
        data = McqSchema(**existing_mcq.__dict__)
        session.close()

        return JSONResponse(status_code=status.HTTP_200_OK,
                            content={'status': 'Success', 'message': 'MCQ updated successfully',
                                     'mcq': data.__dict__})
    except formencode.Invalid as e:
        return JSONResponse(status_code=status.HTTP_406_NOT_ACCEPTABLE,
                            content={'status': 'Failed', 'message': 'Fix the following error',
                                     'errors': e.unpack_errors()})
    except CustomException as e:
        raise e
    except Exception as e:
        raise CustomException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, status='Failed',
                              message='Internal server error', error=e)
