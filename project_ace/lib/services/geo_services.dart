import 'package:geolocator/geolocator.dart';
import 'package:project_ace/services/user_services.dart';

class LocationServices {
/*
  final location = Location();
  LocationData? _locData;
  bool? _serviceEnabled;
  bool _loading = false;
  StreamSubscription<LocationData>? _locDataStream;
  PermissionStatus? _permissionStatus;
  String? _error;
  Future _checkPermissions() async {
    final PermissionStatus status = await location.hasPermission();
    setState(() {
      _permissionStatus = status;
    });
  }

  Future _requestPermissions() async {
    if (_permissionStatus != PermissionStatus.granted) {
      final PermissionStatus status = await location.requestPermission();
      setState(() {
        _permissionStatus = status;
      });
    }
  }

  Future _checkService() async {
    final bool service = await location.serviceEnabled();
    setState(() {
      _serviceEnabled = service;
    });
  }

  Future _requestService() async {
    if (_serviceEnabled == true) {
      return;
    }
    final bool serviceRequest = await location.requestService();
    setState(() {
      _serviceEnabled = serviceRequest;
    });
  }

  Future _getLocation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final LocationData locResults = await location.getLocation();
      setState(() {
        _locData = locResults;
        _loading = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future _listenLocation() async {
    _locDataStream = location.onLocationChanged.handleError((dynamic e) {
      if (e is PlatformException) {
        setState(() {
          _error = e.toString();
        });
      }
      _locDataStream?.cancel();
      setState(() {
        _locDataStream = null;
      });
    }).listen((LocationData current) {
      setState(() {
        _error = null;
        _locData = current;
      });
    });
    setState(() {});
  }

  Future _stopListen() async {
    _locDataStream?.cancel();
    setState(() {
      _locDataStream = null;
    });
  }

  @override
  void dispose() {
    _locDataStream?.cancel();
    setState(() {
      _locDataStream = null;
    });
    super.dispose();
  }
   */
}
