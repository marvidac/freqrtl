import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String label;
  Function onPress;

  Button(this.label, this.onPress, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: () {
        onPress();
      }, child: Text(label))
    );
  }
}
