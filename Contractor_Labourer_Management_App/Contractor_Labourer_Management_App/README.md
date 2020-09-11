# Labour-Contractor management System

## flutter_fire (The Shramik App)

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

-------------------------------------------------------------------------------------------


steps to run the project:

    a. Open the project in Android studio or Vscode. 
        for android studio: (https://www.google.com/search?q=run+a+flutter+project&oq=run+a+flutter+project+&aqs=chrome..69i57j0l7.10807j0j4&sourceid=chrome&ie=UTF-8#qidu=UgwP_yTYPPwzywAVg3p4AaABGg&ugcqalb=ugcaa)

        for vsCode : (https://flutter.dev/docs/development/tools/devtools/vscode)

    b. Setup your android emulator, either virtual or real android with developers mode on.
    c. Build the project after installing the extensions and dependencies installed in pubspec.yaml
    d. Navigation through pages is already explained in slides. (with screenshots and their functionality).

Backend:

    a. we used firebase for the backend management.
    b. used firestore for databases and firebase storage for media files.
    c. so all the backend process functions are made separately (modularly) in ./lib/services folder.
    d. ./lib/pages contains all the pages for the android application.

---------------------------------------------------------------------------------------------------

Thigs to be done :

    a. show the list of requests with buttons approve or reject on the description page of a job avialable on myjob page of a contractor, which was created when a interested labour send request to that job.
    b. Extension could be added to make fone calls and many more can be extended to make it more user friendly, (like Hindi or local language, etc).
