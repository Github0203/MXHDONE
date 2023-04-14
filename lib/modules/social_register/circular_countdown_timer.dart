import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'dart:async'; 




class circular_countdown_timer extends StatefulWidget {
  ///


  /// Home page
  circular_countdown_timer({
    Key? key,
  }) : super(key: key);

  @override
  _circular_countdown_timerState createState() => _circular_countdown_timerState();
}

///
/// Page state
///
class _circular_countdown_timerState extends State<circular_countdown_timer> {
  // Controller
  final CountdownController _controller = CountdownController(autoStart: true);

 Timer? _timer;
int _start = 10;
void startTimer() {
  const oneSec = const Duration(seconds: 1);
  _timer = Timer.periodic(
    oneSec,
    (Timer timer) => setState(
      () {
        if (_start < 1) {
          timer.cancel();
        } else {
          _start = _start - 1;
        }
      },
    ),
  );
}
@override
void dispose() {
  _timer!.cancel();
  super.dispose();
}
Widget build(BuildContext context) {
  return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            startTimer();
          },
          child: Text("start"),
        ),
        Text("$_start")
      ],
    );
}
}