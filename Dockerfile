FROM python:3.9-slim
WORKDIR /code
COPY ./requirements.txt /code/
COPY ./index.html /code/
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt
COPY main.py /code/
CMD ["fastapi", "run", "main.py", "--port", "8000"]