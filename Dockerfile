# Use official Python image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy project files into container
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Run the app
CMD ["python", "app.py"]

# NOTE: When building, use the custom network to avoid DNS issues:
# sudo docker build --network=my-custom-net -t my-python-app .
