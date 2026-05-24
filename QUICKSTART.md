# Quick Start Guide

## Prerequisites
- Python 3.8 or higher
- pip (Python package manager)

## Installation Steps

### Windows

1. **Open Command Prompt or PowerShell** in the project directory

2. **Run the setup script**:
   ```bash
   setup.bat
   ```
   
   This will automatically:
   - Create a virtual environment
   - Install all dependencies
   - Run database migrations

3. **Start the development server**:
   ```bash
   venv\Scripts\activate.bat
   python manage.py runserver
   ```

4. **Access the application**:
   - Main website: http://localhost:8000
   - Admin panel: http://localhost:8000/admin

### macOS/Linux

1. **Open Terminal** in the project directory

2. **Run the setup script**:
   ```bash
   bash setup.sh
   ```

3. **Start the development server**:
   ```bash
   source venv/bin/activate
   python manage.py runserver
   ```

4. **Access the application**:
   - Main website: http://localhost:8000
   - Admin panel: http://localhost:8000/admin

## Manual Setup (If Scripts Don't Work)

### Step 1: Create Virtual Environment
```bash
# Windows
python -m venv venv
venv\Scripts\activate.bat

# macOS/Linux
python3 -m venv venv
source venv/bin/activate
```

### Step 2: Install Dependencies
```bash
pip install -r requirements.txt
```

### Step 3: Apply Migrations
```bash
python manage.py migrate
```

### Step 4: Create Superuser (Admin Account)
```bash
python manage.py createsuperuser
```

Follow the prompts to create your admin account.

### Step 5: Run Development Server
```bash
python manage.py runserver
```

## Common Commands

```bash
# Activate virtual environment (Windows)
venv\Scripts\activate.bat

# Activate virtual environment (macOS/Linux)
source venv/bin/activate

# Deactivate virtual environment
deactivate

# Run database migrations
python manage.py migrate

# Create migrations for models
python manage.py makemigrations

# Collect static files
python manage.py collectstatic

# Run tests
python manage.py test

# Open Django shell
python manage.py shell

# Create superuser
python manage.py createsuperuser

# Run development server on different port
python manage.py runserver 8001
```

## First Time Setup Checklist

- [ ] Install Python 3.8+
- [ ] Run setup script OR manual setup
- [ ] Create superuser account
- [ ] Access admin panel at http://localhost:8000/admin
- [ ] Add some test movies
- [ ] Visit http://localhost:8000 to view the website

## Useful URLs

- **Home**: http://localhost:8000
- **Admin Panel**: http://localhost:8000/admin
- **Add Movie**: http://localhost:8000/movie/create/
- **Search**: http://localhost:8000/search/

## Need Help?

See `TROUBLESHOOTING.md` for common issues and solutions.
