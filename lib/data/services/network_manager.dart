import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkManager {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  NetworkManager() {
    _connectivity.onConnectivityChanged.listen((status) {
      final isConnected = status != ConnectivityResult.none;
      _controller.add(isConnected);
    });
  }

  Stream<bool> get onConnectivityChanged => _controller.stream;

  Future<bool> checkConnection() async {
    final status = await _connectivity.checkConnectivity();
    return status != ConnectivityResult.none;
  }

  void dispose() => _controller.close();
}
