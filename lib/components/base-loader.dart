import 'package:flutter/material.dart';

class BaseLoader extends StatelessWidget {
  final String text;
  const BaseLoader({Key? key, this.text = 'sedang mengunduh data...'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.only(bottom: 5),
            child: const CircularProgressIndicator(color: Colors.brown),
          ),
          Text(text)
        ],
      ),
    );
  }
}
