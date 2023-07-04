from pydantic import BaseModel, Field


class McqSchema(BaseModel):
    question: str
    question_img_url: str
    option_text_1: str
    option_img_url_1: str
    option_text_2: str
    option_img_url_2: str
    option_text_3: str
    option_img_url_3: str
    option_text_4: str
    option_img_url_4: str
    correct_ans: str = Field(..., not_empty=True)
    explanation: str = Field(..., not_empty=True)
    explanation_img: str
    hardness: str = Field(..., not_empty=True)
    categories: str = Field(..., not_empty=True)
    subject: int = Field(..., not_empty=True)
    chapter: int = Field(..., not_empty=True)
    problem_setter: int = Field(..., not_empty=True)
    verified: bool = False
    published: bool = False

    class Config:
        orm_mode = True
        # If you want to allow additional fields not defined in the schema, set `extra` to 'allow'.
        # extra = 'forbid'

