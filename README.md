# Why use Flutter
- [Better performance vs React Native](https://nateshmbhat.medium.com/flutter-vs-react-native-performance-benchmarks-you-cant-miss-%EF%B8%8F-2e31905df9b4)


# Flutter project best practices

Some of the best practices regarding Flutter development that were gleaned from the project

- [Project structure](project-structure)
- [Infrastructure](#infrastructure)
- [API calls](api-calls)
- [Deployment](#deployment)
- [Best practices](#best-practices)
- [Agile](#agile)

## Project Structure

```
├── .circleci/                             
│ └── config.yml                         # circleci config file
├── .dart_tool                           # auto-generated files used by Flutter tool
├── android/                             # android config files
├── assets/                              # assets
│ ├── fonts                              # stored as ttf 
│ └── images
├── build/                               # compiled files
├── ios/                                 # ios config files
├── lib/                                 # proj critical code
│ ├── models/                            # classes and enums
│ ├── network/                           # makes api calls. subfolders include features(auth/dashboard) and resources
│ │ ├── resource/                              
│ │ │ ├── resource_api.dart              # api layer returns raw response data from backend
│ │ │ └── resource_repository.dart       # interfaces with api layer, handles business logic, data transformation and error detection
│ ├── providers/                         # providers that interface with their respective repository_providers
│ ├── utils/
│ │ └── helpers                          # data formatting, regex validation 
│ ├── views/
│ │ ├── pages                            # widgets
│ │ ├── partials                         # reusable widgets
│ │ └── split_view                       # main widget. contains navbar, footer etc.
│ ├── api_providers.dart                 # provide instances of API classes
│ ├── dio_service.dart                   # dio library setup
│ ├── dio_service_provider.dart          # provide instance of dio service
│ └── repository_providers.dart          # interfaces with api_providers to provide instances of repository classes
├── test/                                # tests
├── .gitignore
├── analysis_options.yaml                # includes Dart code analyser options: error, warnings, linting
├── CHANGELOG.md                         # Logs changes across versions
├── pubspec.lock                         # auto-generated after running flutter pub get
├── pubspec.yaml                         # config file
└── README.md                            


```
## Infrastructure
**CircleCI**
- Automatically deploys and runs tests everytime code is pushed to the project

**Internationalisation and localisation**
- [intl](https://pub.dev/packages/intl)
- [flutter_localization](https://pub.dev/packages/flutter_localization) 

**Riverpod**
- [Riverpod](https://riverpod.dev/) handles state management
- Providers are similar to ViewModel in Android

## API calls

**Setup**

1. Create network/dio_service.dart: setup constructor, get and post methods
2. Create network/dio_service_provider.dart: provides access to dio service

**Retrieving a resource from API call**

1. Create lib/network/resource/resource_api.dart. Declare methods that use dioService to call respective APIs. Return only raw response data.
2. Create lib/network/resource/resource_repository.dart. Declare methods that call upon ResourceAPI, do data transformation and error checking on the raw data.
3. In lib/network/api_providers.dart, declare providers that watch dioService and call resourceAPI using dioService.
4. In lib/network/repository_providers.dart, declare providers that watch resourceAPI provider and call resourceRepository using resourceAPI.
5. Create lib/providers/resource_provider.dart. Stores data from repository providers, used by rest of app.

## Deployment

## Best practices
**Code**

- Sort import statements alphabetically
- Add linter to project 

**Git**

Branch types:
- main
- development
- version
- feature (named after Jira ticket) 

[Commit style guide](https://gist.github.com/qoomon/5dfcdf8eec66a051ecd85625518cfd13)
[Changelog](https://keepachangelog.com/en/1.0.0/)

## Agile

Conduct [sprint retrospectives](https://www.atlassian.com/team-playbook/plays/retrospective#instructions)
