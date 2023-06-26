from pydantic import BaseModel


class Header:
    token: str


class Admin(BaseModel):
    full_name: str
    email: str

    class Config:
        orm_mode = True


class ReadAdmin(Admin):
    id: int | None

    class Config:
        orm_mode = True
