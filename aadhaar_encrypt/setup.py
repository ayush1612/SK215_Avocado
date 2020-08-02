from setuptools import setup

setup(
    name="AadhaarCrypt",
    version="0.1",
    license="GPL-3.0",
    install_requires=["flask_cors", "flask", "pycrypto", "pycryptodome"],
    long_description=open("README.md").read()
)
