FROM python:3.12

WORKDIR /code

COPY requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "runserver", "manage.py", "runserver","0.0.0.0:8000"]