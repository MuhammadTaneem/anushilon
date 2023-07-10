from typing import Union
from fastapi import File, UploadFile
from pydantic import BaseModel


# class McqSchema(BaseModel):
#     question: Union[str, None]
#     question_img_url: Union[str, File, None]
#     option_text_1: Union[str, None]
#     option_img_url_1: Union[str, None, File]
#     option_text_2: Union[str, None]
#     option_img_url_2: Union[str, None, File]
#     option_text_3: Union[str, None]
#     option_img_url_3: Union[str, None, File]
#     option_text_4: Union[str, None]
#     option_img_url_4: Union[str, None, File]
#     correct_ans: Union[str, None]
#     explanation: Union[str, None]
#     explanation_img: Union[str, None, File]
#     hardness: Union[str, None]
#     categories: Union[str, None]
#     subject: Union[str, None]
#     chapter: Union[str, None]
#     problem_setter: Union[int, None]
#     verified: bool = False
#     published: bool = False
#
#     class Config:
#         orm_mode = True

#
# class McqSchema(BaseModel):
#     question: Union[str, None]
#     question_img_url: Union[str, UploadFile, None]
#     option_text_1: Union[str, None]
#     option_img_url_1: Union[str, UploadFile, None]
#     option_text_2: Union[str, None]
#     option_img_url_2: Union[str, UploadFile, None]
#     option_text_3: Union[str, None]
#     option_img_url_3: Union[str, UploadFile, None]
#     option_text_4: Union[str, None]
#     option_img_url_4: Union[str, UploadFile, None]
#     correct_ans: Union[str, None]
#     explanation: Union[str, None]
#     explanation_img: Union[str, UploadFile, None]
#     hardness: Union[str, None]
#     categories: Union[str, None]
#     subject: Union[str, None]
#     chapter: Union[str, None]
#     problem_setter: Union[int, None]
#     verified: bool = False
#     published: bool = False
#
#     class Config:
#         orm_mode = True


#
# class McqSchema(BaseModel):
#     question: Union[str, None]
#     question_img_url: Union[str, None]
#     option_text_1: Union[str, None]
#     option_img_url_1: Union[str, None]
#     option_text_2: Union[str, None]
#     option_img_url_2: Union[str, None]
#     option_text_3: Union[str, None]
#     option_img_url_3: Union[str, None]
#     option_text_4: Union[str, None]
#     option_img_url_4: Union[str, None]
#     correct_ans: Union[str, None]
#     explanation: Union[str, None]
#     explanation_img: Union[str, None]
#     hardness: Union[str, None]
#     categories: Union[str, None]
#     subject: Union[str, None]
#     chapter: Union[str, None]
#     problem_setter: Union[int, None]
#     verified: bool = False
#     published: bool = False
#
#     class Config:
#         orm_mode = True


class McqSchema(BaseModel):
    question: Union[str, None] = None
    option_text_1: Union[UploadFile, None]
    option_text_2: Union[UploadFile, None]


    class Config:
        orm_mode = True