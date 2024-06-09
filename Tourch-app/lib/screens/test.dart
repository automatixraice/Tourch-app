import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool _isTorchOn = false; // Initially off
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Torch App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isTorchOn ? 'Torch is On' : 'Torch is Off'),
            ElevatedButton(
              onPressed: () => _toggleTorch(),
              child: Text(_isTorchOn ? 'Turn Off Torch' : 'Turn On Torch'),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleTorch() async {
    try {
      print("run");
      if (_isTorchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        _isTorchOn = !_isTorchOn;
      });
    } on Exception catch (e) {
      print('Error toggling torch: $e');
      // Handle the error appropriately, e.g., show a user message
    }
  }
}
