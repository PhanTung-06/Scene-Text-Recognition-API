import uvicorn
from fastapi import FastAPI, Request, File, UploadFile, Form
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates

import shutil
import gdown 

from utils.detector import Detector
from detectron2.data.detection_utils import read_image

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")

@app.get("/", response_class=HTMLResponse)
async def index(request: Request):
    return templates.TemplateResponse("index.html", {
        "request": request
    })



@app.post("/", response_class=HTMLResponse)
async def create_upload_files(request: Request, image: UploadFile = File(...)):
    with open("./static/images/test.jpg", "wb") as buffer:
        shutil.copyfileobj(image.file, buffer)

    url_model = "https://drive.google.com/file/d/15AI1jK6jQkxClQoClohajXW_CjtYBWYl/view?usp=sharing"
    output = "trained_model.pth"
    gdown.download(url_model, output)

    detector = Detector('configs/BAText/VinText/attn_R_50.yaml','trained_model.pth')
    img = read_image('./static/images/test.jpg', format='BGR')
    prediction, vis = detector.predict(img)
    vis.save("./static/images/output.jpg")

    return templates.TemplateResponse("result.html", {
        "request": request
    })
        


