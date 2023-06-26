import uvicorn
from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware
from starlette.responses import JSONResponse
from core.exception import CustomException
from core.middleware import user_middleware
from modules.admin.main import router as user_router
# from modules.pages.main import router as page_router

app = FastAPI()
# app.add_middleware(user_middleware)
app.middleware("http")(user_middleware)
app.include_router(
    user_router,
    prefix="/admin",
    tags=["admin"],
)

origins = [
    "http://localhost:4200",
    "https://localhost.tiangolo.com",
    "http://localhost",
    "http://localhost:8080",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# app.include_router(
#     page_router,
#     prefix="/page",
#     tags=["page"],
# )


# Custom Exception_handler --------------------------------
@app.exception_handler(Exception)
async def custom_exception_handler(request, exc):
    return JSONResponse(status_code=exc.status_code,
                        content={"status": exc.status, "message": exc.message, "error": exc.error})


@app.exception_handler(CustomException)
async def custom_exception_handler(request, exc: CustomException):
    return JSONResponse(status_code=exc.status_code,
                        content={"status": exc.status, "message": exc.message, "error": exc.error})


if __name__ == "__main__":
    print("program running")
    # uvicorn.run(app, host='0.0.0.0', port=8000)
    # uvicorn.run(app, host='localhost', port=8000)
    uvicorn.run(app)
