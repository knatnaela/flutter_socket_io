import 'dart:async';

class SocketIoService {
  final socketResponse = StreamController<String>();

  set addResponse(dynamic value) => socketResponse.sink.add(value);

  Stream<String> get getResponse => socketResponse.stream;

  void dispose() {
    socketResponse.close();
  }
}
