FROM python:3.12-alpine

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade -r requirements.txt

#ENV POSTGRES_HOST=${POSTGRES_HOST}
#ENV POSTGRES_PORT=${POSTGRES_PORT}
#ENV POSTGRES_NAME=${POSTGRES_NAME}
#ENV POSTGRES_USER=${POSTGRES_USER}
#ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

COPY . .

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
EXPOSE 8000