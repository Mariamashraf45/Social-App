import 'package:flutter/cupertino.dart';

class ErrorDisplayPost extends StatelessWidget {
  final String message ;
  const ErrorDisplayPost({super.key, required this.message});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(child: Text(message,textAlign: TextAlign.center,style: const TextStyle(fontSize: 25),),),
    );
  }
}
