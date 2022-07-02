import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_socket_io/socket_io/socket_io_service.dart';
import 'package:flutter_socket_io/view/home_page.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  connectAndListen();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        final isValidHost = host == "192.168.43.180:3000";
        return isValidHost;
      });
  }
}

SocketIoService socketIoService = SocketIoService();
void connectAndListen() async {
  IO.Socket socket = IO.io('http://192.168.43.180:3000/',
      OptionBuilder().setTransports(['websocket']).build());
  socket.onConnect((_) {
    print('connect');
  });
  socket.onConnecting((data) => print('connecting'));
  socket.onConnectError((data) => print("onConnect Error: $data"));
  socket.on('msg', (data) => socketIoService.socketResponse.add(data));
  socket.onDisconnect((_) => print('disconnect'));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Socket IO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(service: socketIoService),
    );
  }
}
