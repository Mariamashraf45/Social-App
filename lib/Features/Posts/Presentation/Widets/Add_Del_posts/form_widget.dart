import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
   FormWidget({super.key});
final _formKKey = GlobalKey<FormState>();
TextEditingController _titlecontroller = TextEditingController();
TextEditingController _bodycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key:_formKKey ,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ) ,

      ),
    );
  }
}
