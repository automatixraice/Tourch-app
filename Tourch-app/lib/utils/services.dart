import 'dart:async';

import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:torch_light/torch_light.dart';
import 'package:touchapp/screens/HomePage.dart';

void trorchControllerService(
    bool isClicked,
    AnimationController _animationcontroller,
    double fontSize,
    Color color,
    int dropdownValue,
    Timer? _timer,
    String _activeStatis) async {
  final controller = TorchController();

  if (isClicked) {
    _animationcontroller.forward();
    fontSize = 50;
    color = Colors.red;

    dropdownValue == 0
        ? _stopTimer(_timer!)
        : _timer =
            Timer.periodic(Duration(milliseconds: dropdownValue), (timer) {
            controller.toggle();
          });
  } else {
    _stopTimer(_timer!);
    _animationcontroller.reverse();
    fontSize = 40;
    color = Colors.white;
  }
  isClicked = !isClicked;
  if (_activeStatis == "Turn off") {
    _activeStatis = "Turn on";
    await TorchLight.disableTorch();
  } else {
    await TorchLight.enableTorch();
    _activeStatis = "Turn off";
  }
}

void _stopTimer(Timer _timer) {
  if (_timer != null) {
    _timer!.cancel(); // Cancel the timer if it's running
    // _timer = null; // Reset the timer reference
  }
}
