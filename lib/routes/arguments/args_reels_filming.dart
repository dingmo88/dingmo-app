import 'package:camera/camera.dart';

class ReelsFilmingArgs {
  final bool pushReplacementHome;
  final CameraDescription backCamera;
  final CameraDescription frontCamera;
  ReelsFilmingArgs(
      {required this.frontCamera,
      required this.backCamera,
      this.pushReplacementHome = false});
}
