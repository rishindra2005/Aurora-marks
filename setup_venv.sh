#!/bin/bash

# This script creates a virtual environment and installs dependencies from requirements.txt

# Define the virtual environment directory
VENV_DIR=".venv"

# Use python3 if available, otherwise use python
if command -v python3 &>/dev/null; then
    PYTHON_EXEC="python3"
else
    PYTHON_EXEC="python"
fi

# Check if the virtual environment directory exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment at $VENV_DIR"
    $PYTHON_EXEC -m venv $VENV_DIR
else
    echo "Virtual environment already exists at $VENV_DIR"
fi

# Determine the pip executable path based on OS
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
    PIP_EXEC="$VENV_DIR/bin/pip"
    ACTIVATION_MSG="source $VENV_DIR/bin/activate"
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    PIP_EXEC="$VENV_DIR/Scripts/pip.exe"
    ACTIVATION_MSG="source $VENV_DIR/Scripts/activate (for bash/git bash) or .\$VENV_DIR\Scripts\activate (for PowerShell)"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi


# Check if requirements.txt exists
if [ -f "requirements.txt" ]; then
    echo "Installing dependencies from requirements.txt..."
    "$PIP_EXEC" install -r requirements.txt
    echo "Dependencies installed successfully."
else
    echo "Warning: requirements.txt not found. No dependencies were installed."
fi

echo -e "\nSetup complete."
echo "To activate the virtual environment, run:"
echo "$ACTIVATION_MSG"
