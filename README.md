
<style>
.gist-data{
    height:250px; // Any height
    overflow-y: visible;
}
</style>

# <span style="color:#A0522D">SoluBloc</span> <span style="color: #707070">v-1.0</span>
> [color=#DEB887]<b><i>A coding pattern for building fast mobile apps with flutter at scale.</i></b>



## Introduction 
The main goal of SoluBloc is to define a specific way to structure code so that it can be easy for someone new to understand the structure.

It is a pattern for developing flutter application using bloc, singletones and streams to manage data. It also uses jaquar_orm package for data.


## Basics
### Folder structure

SoluBloc has a pattern for structuring code into package depending on the functionality of the code.

| Android Studio | VS Code |
| -------- | -------- |
| ![](https://i.imgur.com/OzEYjDW.png)   | ![](https://i.imgur.com/YVX5hQ8.png)|

- api
This folder houses 2 main components of api divided into files.
![](https://i.imgur.com/Zc85jjQ.png)
    - `api.dart` contains `Api` class where all endpoint calls for apis are defined.
    - `dio_api.dart` contains `DioApi`, the base class that is implemented by `Api`. Here is where all the interceptors for requests and responses are implemented.

- bloc
This folder contains all business logic components for the app. The main reason for it being placed as a top level folder is because code from one bloc can be shared from different `screens` or `widgets`.
All files under this folder should use the format `*_bloc` i.e `counter_bloc` for a business logic component that handles the counter.
The `Bloc` class which is implemented by all classes in this folder has a function called `notifyChanges()` which should be called to notify the provider of any changes that take place.
The general structure of code should be as desplayed below.


{%gist mordeccai/23e8aea5ade68c17b6d76fe160db504b%}

