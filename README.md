# Student Quiz App

Simple Quiz App built with Flutter and Firebase for Authentication. 

## Tabel of Contents

1. [Installation](#installation)
2. [File Description](#files)
3. [Running](#running)

## Installation <a name="installation"></a>

The app is built using ```flutter```</br>
Firebase authentication file must be obtained from Google Firebase stored in the ios folder

## File Descrption <a name="files"></a>
Assests -  Consist of quiz files in json format
```
 [
    {
        "1": "Which of the following is not a C++ Header file ?",
        "2": "Which function finds out the Variable type in Python ?",
        "3": "Which of the following keyword is used to define a function in Python ?",
    },
    {
        "1": {
            "a": "conio.h",
            "b": "cstdlib.h",
            "c": "stdio.h",
            "d": "math.h"
        },
        "2": {
            "a": "typedef",
            "b": "typeof",
            "c": "type",
            "d": "find"
        },
        "3": {
            "a": "func",
            "b": "def",
            "c": "void",
            "d": "function"
        }      
    },
    {
        "1": "stdio.h",
        "2": "type",
        "3": "def"
    {
        "timer":"30"
    }
]
```
Images- Consists of images for each quiz. the quiz file name and image name must be named same.

## Running <a name="running"></a>
```
   git clone https://github.com/dhanushkr/Student-Quiz-App.git
   cd Student-Quiz-App
   flutter run
```
