import os
import uuid
import formencode
import starlette
from fastapi import APIRouter, status, Request, Depends, Query, File
from fastapi.responses import JSONResponse
from starlette.datastructures import MultiDict, UploadFile
from core.exception import CustomException
from modules.admin.models import Admin
from core.db import SessionManager
from .models import MCQ
from .validator import McqValidator
from core.dependencis import get_current_user
from .schema import McqSchema
from .enum import category_enum_dict, hardness_enum_dict, subjects_enum_dict
from ..admin.enum import AdminRole

router = APIRouter()


def save_image(image_data, file_name):
    print("file save--------------------------------------------------------")
    save_dir = "media/mcq"
    if not os.path.isdir(save_dir):
        os.makedirs(save_dir)

    full_file_path = os.path.join(save_dir, file_name)

    if os.path.exists(full_file_path):
        unique_filename = f"{uuid.uuid4().hex}_{file_name}"
        full_file_path = os.path.join(save_dir, unique_filename)

    with open(full_file_path, "wb") as f:
        f.write(image_data)

    return f"/{full_file_path}"


async def file_to_url(form_data):
    print("come to json filer -------------------------")
    image_url_keys = [
        "question_img_url",
        "option_img_url_1",
        "option_img_url_2",
        "option_img_url_3",
        "option_img_url_4",
        "explanation_img",
    ]
    for item in image_url_keys:

        if isinstance(form_data[item], starlette.datastructures.UploadFile):
            print("-----------------------------")

            image_data = await form_data[item].read()
            if form_data[item].content_type in ["image/jpeg", "image/png", "image/gif"]:
                form_data[item] = save_image(image_data, (form_data[item]).filename)
            else:
                return JSONResponse(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    content={
                        'status': 'Failed',
                        'message': f'{item} is not a valid image.'
                    }
                )

    return form_data


@router.get("/context")
def get_mcq_add_context():

    try:
        session = SessionManager.create_session()
        admins = session.query(Admin).filter(Admin.role == "problem_setter").all()
        admin_data = {admin.id: admin.full_name for admin in admins}
        # admin_data = [{"id": admin.id, "name": admin.full_name} for admin in admins]
        data= {
            'hardness': hardness_enum_dict(),
            'category': category_enum_dict(),
            'subject': subjects_enum_dict(),
            'problem_setter': admin_data
        }
        return {'status': status.HTTP_200_OK, 'message': 'context loaded', 'data': data}
    except CustomException as e:
        raise e

    except Exception as e:
        # import pdb;pdb.set_trace()
        raise CustomException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, status='Failed',
                              message='Internal server error', error=e)


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
async def create_mcq(request: Request,
                     current_user: Admin = Depends(get_current_user), ):
    try:
        forms = await request.form()
        # import pdb;pdb.set_trace()
        form_data = MultiDict(forms)
        if current_user.role == AdminRole.problem_setter.name:
            form_data["problem_setter"] = current_user.id
        form_data = await file_to_url(form_data)  # convert the image file to image path
        mcq_dict = dict(form_data)
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
        forms = await request.form()
        # import pdb;pdb.set_trace()
        form_data = MultiDict(forms)
        if current_user.role == AdminRole.problem_setter.name:
            form_data["problem_setter"] = current_user.id
        form_data = await file_to_url(form_data)

        session = SessionManager.create_session()
        existing_mcq = session.query(MCQ).filter(MCQ.id == mcq_id).first()

        if not existing_mcq:
            session.close()
            raise CustomException(status_code=status.HTTP_404_NOT_FOUND, status='Failed',
                                  message='MCQ not found')

        # Update the existing MCQ record with the new data
        clean_data = McqValidator.to_python(form_data)
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
