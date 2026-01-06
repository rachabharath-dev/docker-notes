# Use official Python base image
FROM python:3.10-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app.py .

# Expose application port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]


  EXPLAINATION OF DOCKERFILE :

1️⃣ FROM python:3.10-slim
FROM python:3.10-slim

🔹 What it means:

This is the base image

Docker needs an OS + Python to run your app

python:3.10-slim already has:

Linux OS

Python 3.10 installed

🔹 Why slim?

Smaller image size

Faster downloads

Less storage

🧠 Rule:
Every Dockerfile must start with FROM (except scratch images)

2️⃣ WORKDIR /app
WORKDIR /app

🔹 What it means:

Creates a folder /app inside the container

Sets it as the current working directory

🔹 Why this is needed:

Instead of writing paths again and again:

/app/app.py
/app/requirements.txt


Docker automatically runs commands inside /app

🧠 Rule:
After WORKDIR, all commands run inside that folder


  3️⃣ COPY requirements.txt .
COPY requirements.txt .

🔹 What it means:

Copies requirements.txt

From your local machine

To /app directory inside the container

🔹 Why copy requirements first?

So Docker can cache layers
If code changes but dependencies don’t → Docker won’t reinstall packages

🧠 Best practice:
Copy dependencies first, then app code


  4️⃣ RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

🔹 What it means:

Runs a Linux command inside the container

Installs Python packages (Flask)

🔹 Why --no-cache-dir?

Prevents storing pip cache

Keeps image small

🧠 Rule:

RUN → used to install software or run setup commands

Executes at image build time

5️⃣ COPY app.py .
COPY app.py .

🔹 What it means:

Copies your application code

From local → container /app

🧠 Now your container has:

Python

Flask

Your application code


  6️⃣ EXPOSE 5000
EXPOSE 5000

🔹 What it means:

Tells Docker:

“My app runs on port 5000”

🔹 Important:

It does NOT open the port

It’s just documentation / metadata

Actual port opening happens here:

docker run -p 5000:5000


🧠 Think of EXPOSE as a hint

7️⃣ CMD ["python", "app.py"]
CMD ["python", "app.py"]

🔹 What it means:

Command to start the application

Runs when container starts, not during build

🔹 Difference between RUN and CMD
RUN	CMD
Executes while building image	Executes when container runs
Used for setup	Used to start app

🧠 Rule:

Only one CMD per Dockerfile (last one wins)
