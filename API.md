# API Documentation

## Overview

MovieHub provides a complete web interface for managing movies. This document describes all available endpoints and their usage.

## Base URL

```
http://localhost:8000
```

## Authentication

Currently, the application uses Django's session-based authentication. For the admin panel, use superuser credentials.

## Endpoints

### 1. Movie List (Home Page)

**Endpoint**: `GET /`

**Description**: Display all movies with pagination (2 per page)

**Parameters**:
- `page` (optional): Page number (default: 1)

**Response**: HTML page with movie list

**Example**:
```
GET http://localhost:8000/?page=1
```

### 2. Movie Detail

**Endpoint**: `GET /movie/<id>/`

**Description**: Display detailed information about a specific movie

**Parameters**:
- `id` (required): Movie ID

**Response**: HTML page with movie details and video player

**Example**:
```
GET http://localhost:8000/movie/1/
```

### 3. Create Movie

**Endpoint**: `GET /movie/create/` (Form)  
**Endpoint**: `POST /movie/create/` (Submit)

**Description**: Display form to create a new movie or submit new movie data

**POST Parameters**:
- `name` (required): Movie title (string, max 255 characters)
- `video_link` (required): Video URL (must be valid URL)
- `movie_type` (required): Genre choice (action, comedy, drama, horror, thriller, romance, sci-fi, animation, documentary)
- `translator_name` (required): Translator name (string, max 255 characters)
- `image` (optional): Poster image file (ImageField)
- `csrftoken` (required): CSRF token from form

**Response**: 
- GET: HTML form
- POST: Redirect to movie detail page on success

**Example**:
```bash
POST http://localhost:8000/movie/create/
Content-Type: multipart/form-data

name=Avatar
video_link=https://www.youtube.com/watch?v=example
movie_type=sci-fi
translator_name=John Smith
image=<file>
```

### 4. Update Movie

**Endpoint**: `GET /movie/<id>/edit/` (Form)  
**Endpoint**: `POST /movie/<id>/edit/` (Submit)

**Description**: Display form to edit an existing movie or submit updated data

**Parameters**:
- `id` (required): Movie ID

**POST Parameters**: (Same as Create Movie)

**Response**: 
- GET: HTML form with current movie data
- POST: Redirect to movie detail page on success

**Example**:
```
GET http://localhost:8000/movie/1/edit/
POST http://localhost:8000/movie/1/edit/
```

### 5. Delete Movie

**Endpoint**: `GET /movie/<id>/delete/` (Confirmation)  
**Endpoint**: `POST /movie/<id>/delete/` (Confirm Delete)

**Description**: Display confirmation page or delete a movie

**Parameters**:
- `id` (required): Movie ID

**Response**:
- GET: HTML confirmation page
- POST: Redirect to movie list after deletion

**Example**:
```
GET http://localhost:8000/movie/1/delete/
POST http://localhost:8000/movie/1/delete/
```

### 6. Search Movies

**Endpoint**: `GET /search/`

**Description**: Search movies by name or type with pagination

**Parameters**:
- `q` (optional): Search query
- `page` (optional): Page number (default: 1)

**Response**: HTML page with search results (2 per page)

**Example**:
```
GET http://localhost:8000/search/?q=action&page=1
```

## Data Model

### Movie Object

```json
{
  "id": 1,
  "name": "Avatar",
  "image": "/media/movies/avatar.jpg",
  "video_link": "https://www.youtube.com/watch?v=...",
  "movie_type": "sci-fi",
  "movie_type_display": "Science Fiction",
  "translator_name": "John Smith",
  "created_at": "2026-05-24T10:30:00Z",
  "updated_at": "2026-05-24T10:30:00Z"
}
```

### Movie Type Choices

```
action       -> Action
comedy       -> Comedy
drama        -> Drama
horror       -> Horror
thriller     -> Thriller
romance      -> Romance
sci-fi       -> Science Fiction
animation    -> Animation
documentary  -> Documentary
```

## Admin Panel

**Endpoint**: `GET /admin/`

**Description**: Django admin interface for managing all movies

**Features**:
- List all movies
- Filter by type and creation date
- Search by name or translator
- Bulk operations
- Detailed movie editing

## Status Codes

- `200 OK`: Request successful
- `301/302 Redirect`: Redirect to another page
- `404 Not Found`: Movie not found
- `405 Method Not Allowed`: Wrong HTTP method
- `500 Server Error`: Internal server error

## Error Handling

### Form Validation Errors

If form validation fails, the form is redisplayed with error messages indicating which fields have issues.

**Common Validation Errors**:
- Name is required and must be unique
- Video link must be a valid URL
- Movie type must be selected
- Translator name is required
- Image file must be a valid image format

## Rate Limiting

Currently no rate limiting is implemented. In production, consider adding:
- IP-based rate limiting
- User-based rate limiting
- API key authentication

## Pagination

All list endpoints support pagination with 2 items per page.

**Pagination Parameters**:
- `page`: Page number (starting from 1)

**Example**:
```
GET http://localhost:8000/?page=2
```

## Search Features

### Search by Name

```
GET http://localhost:8000/search/?q=avatar
```

### Search by Type

```
GET http://localhost:8000/search/?q=sci-fi
```

### Combined Search

The search is case-insensitive and searches both name and type fields.

## Performance

- **Average Response Time**: 200-500ms
- **Database Queries**: Optimized with select_related/prefetch_related
- **Caching**: Enabled for frequently accessed data
- **Lazy Loading**: Images load as users scroll

## Future API Enhancements

Planned for future versions:
- RESTful JSON API
- Authentication tokens
- Rate limiting
- Webhooks
- Advanced filtering
- Batch operations
- Export functionality

## Example Workflows

### Add a New Movie

1. `GET /movie/create/` - Get the form
2. Fill in the form fields
3. `POST /movie/create/` - Submit the form
4. Redirected to `GET /movie/<id>/` - View the new movie

### Search and Edit

1. `GET /search/?q=avatar` - Search for movies
2. Click on a movie result
3. `GET /movie/1/` - View movie details
4. Click edit button
5. `GET /movie/1/edit/` - Get edit form
6. `POST /movie/1/edit/` - Submit changes
7. Redirected to `GET /movie/1/` - View updated movie

### Delete a Movie

1. `GET /movie/1/` - View movie details
2. Click delete button
3. `GET /movie/1/delete/` - Get confirmation page
4. Confirm deletion
5. `POST /movie/1/delete/` - Delete movie
6. Redirected to `GET /` - Movie list

## Notes

- All responses are HTML pages rendered with Django templates
- CSRF protection is enabled on all POST requests
- Session authentication is used for security
- File uploads are limited to 5MB by default
- Images are stored in the `media/movies/` directory
