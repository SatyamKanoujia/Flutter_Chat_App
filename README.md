# Flutter Chat App with Node.js, WebSockets and MySQL

A Flutter Chat App built with Node.js, MySQL, and WebSockets.

This is a Flutter Chat App without Firebase, but if it doesn't fit for you,
it can still be an example of a template to build your Flutter Chat UI

The Node.js server uses [Askless](https://github.com/RodrigoBertotti/askless-flutter-client) 
for streaming data changes to the Flutter App
through WebSockets, 
so the Flutter widgets are updated in realtime.

Because this project uses TypeORM, you can easily change the database to make this
a Flutter Chat App with PostgreSQL, rather than with MySQL

The text messages are also saved in the user device with [Hive](https://pub.dev/packages/hive), 
so the user doesn't need to be connected to the internet to see his received messages.

## Why Askless?

### :muscle: **Stream data from PostgreSQL, MySQL or other database** to your Flutter App through websockets

The Askless Framework (Backend in Node.js) is designed to make your Flutter App
stream data in without Firebase, create your own routes that interact with your database,
call `route.notifyChanges(..)` when something changes so the users will receive the changes!

### :airplane: Skip websocket details and focus in your application!

Askless Design is a result of thorough analysis to make websockets in Flutter easy and productive.
It can be tricky to build websockets to transport data from a database from scratch for your Flutter App:

<sup>:grey_exclamation:</sup> you need to add logic to handle different kinds of data that will move through the websockets

:grey_exclamation: **Authentication events come first**, so you don't want to your client receive data he doesn't have permission to.

:grey_exclamation: If the websockets disconnect, either because of the user device or because of the server, we need to 
**try to connect back again** as soon as possible

:grey_exclamation: Ops! The user was receiving data by websockets, but he lost connection for a second and connected again, 
now we need to **handle authentication BEFORE sending data again**

:grey_exclamation: We may want to know once the user started streaming data and when the user received data, so we can know
data was received, so an additional event like "message_received" needs to be added and handled in the App and backend, more work to
simply add a double-check icon in your chat app once the message is delivered

:white_check_mark: **You don't need to mull over implementing these details anymore** :grinning: **Askless is here to make your life easier!**

## ⚠️ Video and audio calls may not work when users are on different networks ⚠️

This project relies on the [flutter-webrtc](https://github.com/flutter-webrtc/flutter-webrtc) plugin, and even though there's a [similar issue](https://github.com/flutter-webrtc/flutter-webrtc/issues/1606) from a dev in the webrtc plugin page, 
I can't say for sure if it's either a bug in the plugin, in my code, or something else, but for some unknown reason, 
using TURN servers doesn't work in my tests (you can test this behavior by setting `'iceTransportPolicy': 'relay'`),
which means that video and audio calls may not work when users are on different networks,
[click here](https://github.com/RodrigoBertotti/flutter_chat_app_with_nodejs/issues/9) to make a suggestion or check the discussion

## Getting started

1. Go to `nodejs_websocket_backend` and install the dependencies by running `npm install`

2. The Node.js server uses TypeORM, TypeORM supports several databases like [MySQL, PostgreSQL, MariaDB, SQLite, MS SQL Server, Oracle, SAP Hana and WebSQL](https://www.tutorialspoint.com/typeorm/typeorm_quick_guide.htm#:~:text=TypeORM%20supports%20multiple%20databases%20like,functionality%20is%20RDBMS%2Dspecific%20concepts.).
   So the first step is to configure the database of your choice. Add your **database configuration** on `nodejs_websocket_backend/src/environment/db.ts`,
don't commit this file to your repository

3. In `nodejs_websocket_backend/src/environment/jwt-private.key`, replace the JWT private key with your own random text,
don't also commit this file to your repository

4. Start your node.js backend server by running the command `npm run dev`,
it will print its URL in the console (local network).

5. Go to the App created with Flutter on `flutter_app/lib/core/data/data_sources/connection_remote_ds.dart`
   and replace the `serverUrl` with the URL and port that your node.js backend is running

6. Go to `flutter_app/lib/environment.dart` and replace the `localStorageEncryptionKey` with your own random text.
don't commit this file to your repository as well.

7. Run `flutter pub get` to get the Flutter dependencies

8. Run the Flutter project on your device :) 

## WebRTC - STUN/TURN Servers

You can edit WebRTC configuration on the `flutter_app/lib/core/data/data_sources/connection_remote_ds.dart` file
