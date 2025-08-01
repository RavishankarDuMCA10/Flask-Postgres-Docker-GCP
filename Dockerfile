FROM python:3.11-alpine

# Set working directory
WORKDIR /app

# Install PostgreSQL client and build dependencies
RUN apk add --no-cache postgresql-client libpq \
    && apk add --no-cache --virtual .build-deps gcc musl-dev libffi-dev

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Expose Flask port
EXPOSE 4000

# Run Flask
CMD ["flask", "run", "--host=0.0.0.0", "--port=4000"]
