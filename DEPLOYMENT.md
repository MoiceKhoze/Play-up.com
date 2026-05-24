# Django Movie Website - Complete Setup & Deployment Guide

## Table of Contents
1. [Project Overview](#project-overview)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [Running the Application](#running-the-application)
5. [Database Management](#database-management)
6. [Media Files](#media-files)
7. [Admin Panel](#admin-panel)
8. [Development](#development)
9. [Testing](#testing)
10. [Deployment](#deployment)

## Project Overview

**MovieHub** is a full-featured Django movie management system with the following capabilities:

- ✅ Complete CRUD operations for movies
- ✅ Responsive design (mobile-first)
- ✅ Pagination (2 movies per page)
- ✅ Image upload support
- ✅ Video link integration
- ✅ Search functionality
- ✅ Admin dashboard
- ✅ Performance optimizations
- ✅ Modern UI with Bootstrap 5

### Technology Stack

- **Backend**: Django 4.2
- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Database**: SQLite (development), PostgreSQL (production)
- **CSS Framework**: Bootstrap 5
- **Server**: Django development server (dev), Gunicorn (production)

## Installation

### Prerequisites

- Python 3.8 or higher
- pip (Python package installer)
- Virtual environment support
- ~500MB disk space

### Windows Installation

```bash
# Navigate to project directory
cd d:\project\Moise\movies\movie_project

# Create virtual environment
python -m venv venv

# Activate virtual environment
venv\Scripts\activate.bat

# Install dependencies
pip install -r requirements.txt

# Apply migrations
python manage.py migrate

# Create superuser (admin account)
python manage.py createsuperuser

# Run server
python manage.py runserver
```

### macOS/Linux Installation

```bash
# Navigate to project directory
cd /path/to/movie_project

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Apply migrations
python manage.py migrate

# Create superuser
python manage.py createsuperuser

# Run server
python manage.py runserver
```

## Configuration

### Settings File Location

The main settings file is located at:
```
movie_project/settings.py
```

### Key Settings

```python
# Debug mode (set to False in production)
DEBUG = True

# Allowed hosts
ALLOWED_HOSTS = ['*']

# Database (SQLite by default)
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# Media files (user uploads)
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

# Static files
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'

# Cache settings
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': 'unique-snowflake',
    }
}

# File upload limits
DATA_UPLOAD_MAX_MEMORY_SIZE = 5242880  # 5MB
FILE_UPLOAD_MAX_MEMORY_SIZE = 5242880  # 5MB
```

### Environment Variables

Create a `.env` file for sensitive data:

```env
SECRET_KEY=your-secret-key-here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
DATABASE_NAME=db.sqlite3
```

## Running the Application

### Development Server

```bash
# Activate virtual environment
venv\Scripts\activate.bat  # Windows
source venv/bin/activate   # macOS/Linux

# Run development server
python manage.py runserver

# Access application
# Main site: http://localhost:8000
# Admin: http://localhost:8000/admin
```

### Custom Port

```bash
python manage.py runserver 8001
```

### With Different Host

```bash
python manage.py runserver 0.0.0.0:8000
```

## Database Management

### Migrations

```bash
# Create migrations for model changes
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# View migration status
python manage.py showmigrations

# Undo migrations
python manage.py migrate app_name zero

# Specific migration
python manage.py migrate app_name 0001
```

### Database Operations

```bash
# Access Django shell
python manage.py shell

# Example shell commands
>>> from movie_app.models import Movie
>>> Movie.objects.all()
>>> movie = Movie.objects.get(id=1)
>>> movie.delete()
```

### Database Backup

```bash
# Windows
copy db.sqlite3 db.sqlite3.backup

# macOS/Linux
cp db.sqlite3 db.sqlite3.backup
```

### Backup and Restore

```bash
# Dump data
python manage.py dumpdata > backup.json

# Load data
python manage.py loaddata backup.json
```

## Media Files

### Upload Directory Structure

```
movie_project/
└── media/
    └── movies/
        ├── avatar.jpg
        ├── inception.png
        └── ...
```

### File Limits

- Maximum file size: 5MB (configurable)
- Allowed formats: JPG, PNG, GIF, WebP
- Recommended poster size: 300x450px
- Recommended aspect ratio: 2:3

### Accessing Media Files

In development, media files are automatically served by Django at `/media/`.

In production, use a web server like Nginx to serve media files.

## Admin Panel

### Accessing Admin

```
http://localhost:8000/admin
```

### Admin Features

- List all movies
- Filter by type and date
- Search by name or translator
- Edit movie details
- Delete movies
- Bulk actions

### Creating Movies via Admin

1. Log in with superuser credentials
2. Click "Movies" in the admin panel
3. Click "Add Movie" button
4. Fill in all fields
5. Click "Save"

## Development

### Project Structure

```
movie_project/
├── manage.py
├── requirements.txt
├── db.sqlite3
├── movie_project/
│   ├── settings.py
│   ├── urls.py
│   ├── wsgi.py
│   └── __init__.py
├── movie_app/
│   ├── migrations/
│   ├── templates/
│   ├── static/
│   ├── models.py
│   ├── views.py
│   ├── urls.py
│   ├── forms.py
│   ├── admin.py
│   └── apps.py
└── media/
    └── movies/
```

### Adding Features

1. **Add Model**: Update `movie_app/models.py`
2. **Create Migration**: `python manage.py makemigrations`
3. **Run Migration**: `python manage.py migrate`
4. **Update Views**: Modify `movie_app/views.py`
5. **Update Templates**: Edit HTML templates
6. **Update URLs**: Add routes to `movie_app/urls.py`
7. **Test**: Access and verify functionality

### Static Files

```bash
# Collect static files for production
python manage.py collectstatic --noinput
```

### Running Tests

```bash
# Run all tests
python manage.py test

# Run specific test
python manage.py test movie_app.tests.MovieModelTest

# Run with verbose output
python manage.py test -v 2
```

## Testing

### Manual Testing Checklist

- [ ] Add a new movie
- [ ] View movie details
- [ ] Edit movie information
- [ ] Delete a movie
- [ ] Search for movies
- [ ] Test pagination
- [ ] Upload poster image
- [ ] Test on mobile device
- [ ] Check responsive design
- [ ] Verify admin panel access

### Browser Testing

- Chrome/Edge 90+
- Firefox 88+
- Safari 14+
- Mobile browsers

## Deployment

### Production Checklist

- [ ] Set `DEBUG = False`
- [ ] Update `SECRET_KEY`
- [ ] Update `ALLOWED_HOSTS`
- [ ] Configure PostgreSQL database
- [ ] Set up environment variables
- [ ] Collect static files
- [ ] Run migrations
- [ ] Set up SSL/TLS certificates
- [ ] Configure web server (Nginx)
- [ ] Set up application server (Gunicorn)
- [ ] Configure backups

### Production Configuration

```python
# settings.py changes for production
DEBUG = False
ALLOWED_HOSTS = ['yourdomain.com', 'www.yourdomain.com']
SECRET_KEY = os.getenv('SECRET_KEY')  # Use environment variable

# Use PostgreSQL
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.getenv('DATABASE_NAME'),
        'USER': os.getenv('DATABASE_USER'),
        'PASSWORD': os.getenv('DATABASE_PASSWORD'),
        'HOST': os.getenv('DATABASE_HOST'),
        'PORT': os.getenv('DATABASE_PORT'),
    }
}
```

### Deployment with Gunicorn

```bash
# Install Gunicorn
pip install gunicorn

# Run application
gunicorn movie_project.wsgi:application --bind 0.0.0.0:8000

# Run with multiple workers
gunicorn movie_project.wsgi:application --workers 4 --bind 0.0.0.0:8000
```

### Nginx Configuration

```nginx
server {
    listen 80;
    server_name yourdomain.com;

    location /static/ {
        alias /path/to/staticfiles/;
    }

    location /media/ {
        alias /path/to/media/;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### Docker Deployment

Create `Dockerfile`:

```dockerfile
FROM python:3.9

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["gunicorn", "movie_project.wsgi:application", "--bind", "0.0.0.0:8000"]
```

Build and run:

```bash
docker build -t moviehub .
docker run -p 8000:8000 moviehub
```

## Maintenance

### Regular Backups

```bash
# Weekly backup script
python manage.py dumpdata > backups/backup_$(date +%Y%m%d).json
```

### Monitoring

- Check server logs
- Monitor disk space
- Monitor database size
- Monitor CPU usage
- Check error logs

### Updates

```bash
# Update Django
pip install --upgrade Django

# Update all dependencies
pip install --upgrade -r requirements.txt
```

## Support

For issues, refer to:
- [Django Documentation](https://docs.djangoproject.com/)
- [Bootstrap Documentation](https://getbootstrap.com/)
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- [API.md](API.md)
- [QUICKSTART.md](QUICKSTART.md)

## License

This project is open source and available under the MIT License.
