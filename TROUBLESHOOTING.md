# Troubleshooting Guide

## Common Issues and Solutions

### 1. ModuleNotFoundError: No module named 'django'

**Problem**: Django is not installed or virtual environment is not activated.

**Solutions**:
- Make sure virtual environment is activated
- Install dependencies: `pip install -r requirements.txt`
- Check Python version: `python --version` (should be 3.8+)

### 2. Port 8000 Already in Use

**Problem**: Another application is using port 8000.

**Solutions**:
```bash
# Use a different port
python manage.py runserver 8001

# On Windows, find and kill process using port 8000
netstat -ano | findstr :8000
taskkill /PID <PID> /F

# On macOS/Linux
lsof -i :8000
kill -9 <PID>
```

### 3. Static Files Not Loading

**Problem**: CSS and JavaScript files are not showing up.

**Solutions**:
```bash
# Collect static files
python manage.py collectstatic --noinput

# In development, ensure DEBUG = True in settings.py
```

### 4. Media Files Not Loading (Movie Images)

**Problem**: Uploaded movie images are not displaying.

**Solutions**:
- Ensure `MEDIA_ROOT` and `MEDIA_URL` are set in `settings.py`
- Check that the `media/` directory exists
- Verify file permissions on the media directory
- In DEBUG mode, Django should serve media files automatically

### 5. Database Locked Error

**Problem**: "database is locked" error when running migrations or accessing the site.

**Solutions**:
```bash
# Delete the database and start fresh
del db.sqlite3

# Run migrations again
python manage.py migrate

# Create new superuser
python manage.py createsuperuser
```

### 6. No Module Named 'PIL' or 'pillow'

**Problem**: Pillow (image library) is not installed.

**Solutions**:
```bash
# Install Pillow
pip install Pillow

# Or reinstall requirements
pip install -r requirements.txt
```

### 7. Migrations Not Applied

**Problem**: Changes to models are not reflected in the database.

**Solutions**:
```bash
# Create new migrations
python manage.py makemigrations

# Apply migrations
python manage.py migrate
```

### 8. CSRF Token Missing Error

**Problem**: "CSRF token missing or incorrect" when submitting forms.

**Solutions**:
- Ensure DEBUG = True in development
- Check that `{% csrf_token %}` is in all forms
- Clear browser cookies and cache
- Ensure Django middleware is properly configured

### 9. Superuser Cannot Login to Admin

**Problem**: Cannot access admin panel with superuser credentials.

**Solutions**:
```bash
# Create a new superuser
python manage.py createsuperuser

# Or reset password
python manage.py changepassword username
```

### 10. ImportError: Cannot Import Name 'url' from 'django.urls'

**Problem**: Using Django 4.x with Django 3.x URL patterns.

**Solutions**:
- Ensure using Django 4.2.0 as specified in requirements.txt
- Update URL patterns to use `path()` instead of `url()`

## Performance Issues

### Slow Page Loading

**Solutions**:
1. Enable caching in `settings.py`
2. Use pagination (already enabled - 2 movies per page)
3. Optimize images before uploading
4. Enable query optimization
5. Use `select_related()` and `prefetch_related()` in views

### High Memory Usage

**Solutions**:
1. Reduce pagination page size if needed
2. Close unused browser tabs
3. Restart development server periodically
4. Check for memory leaks in custom code

## Database Issues

### Migration Conflicts

**Problem**: Can't apply migrations due to conflicts.

**Solutions**:
```bash
# Reset migrations (WARNING: loses data)
python manage.py migrate movie_app zero
python manage.py migrate
```

### Corrupted Database

**Problem**: Database file is corrupted or unrecoverable.

**Solutions**:
```bash
# Backup current database (if possible)
copy db.sqlite3 db.sqlite3.backup

# Delete database
del db.sqlite3

# Recreate database
python manage.py migrate

# Create new superuser
python manage.py createsuperuser

# Add data again
# Use admin panel or write a script to populate
```

## Security Issues

### Debug Mode

**Problem**: Running with DEBUG = True in production.

**Solutions**:
- In production, set `DEBUG = False` in `settings.py`
- Ensure `ALLOWED_HOSTS` contains your domain
- Use environment variables for sensitive settings

### Secret Key Exposed

**Problem**: SECRET_KEY is visible in repository.

**Solutions**:
- Generate new SECRET_KEY
- Use environment variables from `.env` file
- Never commit `.env` to version control

## File Upload Issues

### File Too Large

**Problem**: Cannot upload large video or image files.

**Solutions**:
```python
# In settings.py, increase these values:
DATA_UPLOAD_MAX_MEMORY_SIZE = 10485760  # 10MB
FILE_UPLOAD_MAX_MEMORY_SIZE = 10485760  # 10MB
```

### Invalid File Type

**Problem**: Cannot upload certain file types.

**Solutions**:
- Check file extension is allowed
- For images: use .jpg, .jpeg, .png, .gif, .webp
- For videos: use links (YouTube, Vimeo, etc.)

## Browser Compatibility Issues

### Old Browser Not Loading Styles

**Problem**: Website looks broken in old browsers.

**Solutions**:
- Use modern browser (Chrome 90+, Firefox 88+, Safari 14+)
- Check Bootstrap 5 compatibility
- Ensure CSS features are supported

## Getting Help

1. Check this troubleshooting guide
2. Check Django documentation: https://docs.djangoproject.com/
3. Check Bootstrap documentation: https://getbootstrap.com/docs/
4. Review error messages carefully - they often indicate the problem
5. Check console for JavaScript errors (F12 in browser)

## Reporting Issues

When reporting bugs, include:
1. Error message (full traceback)
2. Steps to reproduce
3. Python version
4. Django version
5. Operating system
6. Browser (if UI related)
