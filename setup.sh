#!/bin/bash
echo "Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate
echo "Installing dependencies..."
pip install -r requirements.txt
echo "Running migrations..."
python manage.py migrate
echo ""
echo "========================================"
echo "Setup complete!"
echo "========================================"
echo ""
echo "To start the development server:"
echo "  source venv/bin/activate"
echo "  python manage.py runserver"
echo ""
echo "To access the application:"
echo "  Open http://localhost:8000 in your browser"
echo ""
echo "To access admin panel:"
echo "  Open http://localhost:8000/admin in your browser"
echo ""
