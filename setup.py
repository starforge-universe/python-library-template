import os
import pathlib

from setuptools import setup, find_packages

here = pathlib.Path(__file__).parent.resolve()

def load_requirements():
    try:
        with open(os.environ['REQUIREMENTS'], 'r') as f:
            return f.read().splitlines()
    except IndexError:
        raise ValueError("Error: You must specify 'REQUIREMENTS' variable with full path of requirements.txt")

def extract_version() -> str:
    try:
        return os.environ['VERSION']
    except IndexError:
        raise ValueError("Error: You must specify 'VERSION' variable with version number")

long_description = (here / "README.md").read_text(encoding="utf-8")

setup(
    name='starforge_python_library_template',
    version=extract_version(),
    description='Starforge Python library template',
    long_description=long_description,
    long_description_content_type="text/markdown",
    author='Starforge Worker',
    author_email='star.forge.worker@gmail.com',
    url='https://github.com/starforge-universe/python-library-template',
    package_dir={"": "src"},
    packages=find_packages(where="src"),
    python_requires='>=3.10',
    install_requires=load_requirements(),
    classifiers=[
        'Programming Language :: Python :: 3',
        'Operating System :: OS Independent',
    ]
)
