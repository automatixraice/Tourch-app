import 'dart:async';
import 'dart:ffi' show ffi;

import 'package:flutter/material.dart';
import 'package:torch_controller/torch_controller.dart';
import 'package:torch_light/torch_light.dart';
import 'package:touchapp/utils/services.dart';

class HomePge extends StatefulWidget {
  const HomePge({super.key});

  @override
  State<HomePge> createState() => _HomePgeState();
}

class _HomePgeState extends State<HomePge> with SingleTickerProviderStateMixin {
  late AnimationController _animationcontroller;
  bool isClicked = true;
  String _activeStatis = "Turn on";
  final controller = TorchController();
  Color color = Colors.white;
  double fontSize = 20;
  Timer? _timer;
  int dropdownValue = 0;
  @override
  void initState() {
    super.initState();
    _animationcontroller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    fontSize = 40;
    color = Colors.white;
    TorchController().initialize();
  }

  @override
  void dispose() {
    super.dispose();
    // Cancel the timer when the widget is disposed to avoid memory leaks
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel(); // Cancel the timer if it's running
      _timer = null; // Reset the timer reference
    }
  }

  @override
  Widget build(BuildContext context) {
    final sz = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          if (isClicked) {
            _animationcontroller.forward();
            fontSize = 50;
            color = Colors.red;

            dropdownValue == 0
                ? _stopTimer()
                : _timer = Timer.periodic(Duration(milliseconds: dropdownValue),
                    (timer) {
                    controller.toggle();
                  });
          } else {
            _stopTimer();
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
          setState(() {});
        },
        child: Stack(children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: sz.height * 0.01),
            margin: EdgeInsets.symmetric(
                vertical: sz.height * 0.3, horizontal: sz.width * 0.4),
            child: Icon(
              isClicked ? Icons.flash_off_rounded : Icons.flash_on_rounded,
              size: sz.width / 5,
              color: isClicked ? Colors.white : Colors.blue,
              shadows: [
                Shadow(
                  color: color,
                  blurRadius: sz.width * 0.2,
                )
              ],
            ),
          ),
          Positioned.fill(
              top: sz.height * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_activeStatis,
                      style: TextStyle(color: color, fontSize: fontSize)),
                  SizedBox(
                    height: sz.height * 0.05,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          "Lever of blinking levels :",
                          style: TextStyle(
                              color: Colors.white, fontSize: sz.height * 0.02),
                        ),
                        SizedBox(
                          width: sz.width * 0.6,
                          child: DropdownButtonFormField(
                              isExpanded: true,
                              hint: const Text("Duration"),
                              elevation: 20,
                              alignment: Alignment.center,
                              borderRadius: BorderRadius.circular(20),
                              icon: const Icon(Icons.punch_clock_rounded),
                              dropdownColor: Colors.black87,
                              iconEnabledColor: Colors.blue,
                              value: dropdownValue,
                              items: const [
                                DropdownMenuItem(
                                  child: Text("0.25"),
                                  value: 300,
                                ),
                                DropdownMenuItem(
                                  child: Text("0.5"),
                                  value: 600,
                                ),
                                DropdownMenuItem(
                                  child: Text("0.75"),
                                  value: 800,
                                ),
                                DropdownMenuItem(
                                  child: Text("0"),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: Text("1"),
                                  value: 1000,
                                ),
                                DropdownMenuItem(
                                  child: Text("2"),
                                  value: 2000,
                                ),
                                DropdownMenuItem(
                                  child: Text("5"),
                                  value: 5000,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  dropdownValue = value!.toInt();
                                });
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ))
        ]),
      ),
      bottomSheet: Container(
          padding: EdgeInsets.symmetric(vertical: sz.height * 0.05),
          child: Image.asset(
            "assets/arlogo.png",
          )),
    );
  }
}
