.PHONY: help install install-dev test test-cov lint clean build check-dist upload-pypi install-cli

help:  ## Show this help message
	@echo "Starforge Python Library Template - Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install:  ## Install the package in development mode
	pip install -e .

install-dev:  ## Install the package with development dependencies
	pip install -e ".[dev]"

install-cli: install  ## Install the CLI tool
	@echo "CLI tool 'starforge_library_template' installed successfully!"
	@echo "Usage: starforge_library_template --help"

test:  ## Run the test suite
	python -m unittest discover tests/ -v

test-cov:  ## Run tests with coverage
	python -m coverage run -m unittest discover tests/ -v
	python -m coverage report --include="starforge_library_template/*"
	python -m coverage html --include="starforge_library_template/*"

lint:  ## Run linting checks
	pylint starforge_library_template/ --rcfile=pyproject.toml

clean:  ## Clean up build artifacts
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	rm -rf htmlcov/
	rm -rf .pytest_cache/
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete

build:  ## Build the package
	python -m build

check-dist:  ## Check distribution files
	twine check dist/*

upload-pypi:  ## Upload package to PyPI (requires PYPI_USERNAME and PYPI_PASSWORD env vars)
	twine upload --repository-url $(PYPI_REPOSITORY) -u $(PYPI_USERNAME) -p $(PYPI_PASSWORD) dist/*

demo:  ## Run a demo of the CLI tool
	@echo "=== Starforge Library Template CLI Demo ==="
	@echo ""
	@echo "1. Show help:"
	@echo "   python -m starforge_library_template --help"
	@echo ""
	@echo "2. Run the library:"
	@echo "   python -m starforge_library_template"
	@echo ""
	@echo "3. Import and use the library:"
	@echo "   python -c \"from starforge_library_template import HelloWorld; print(HelloWorld().greet())\""

