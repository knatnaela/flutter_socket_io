import 'package:flutter/material.dart';
import 'package:flutter_socket_io/socket_io/socket_io_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.service}) : super(key: key);
  final SocketIoService service;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: StreamBuilder(
            stream: service.getResponse,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Center(
                child: Text(snapshot.data ?? "Not Data"),
              );
            }),
      ),
    );
  }
}
