FROM python:3.9-slim
WORKDIR /code
COPY ./requirements.txt /code/requirements.txt
COPY index.html /code
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
COPY . /code/app
CMD ["fastapi", "run", "app/main.py", "--port", "8000"]