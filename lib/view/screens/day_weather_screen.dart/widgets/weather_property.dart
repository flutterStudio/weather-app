import 'package:flutter/material.dart';

class WeatherProperty extends StatelessWidget {
  final String? property;
  final String? value;

  const WeatherProperty({Key? key, this.property, this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${property ?? '  '} ",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
        ),
        Expanded(child: Container()),
        Text(
          "${value ?? '  '} ",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
