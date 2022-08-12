import 'package:flutter/cupertino.dart';

import 'package:stack_trace/stack_trace.dart';

class ErrorScreen extends StatelessWidget{
  const ErrorScreen(Object e, StackTrace trace, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const Center(
      child: Text('Please Restart app'),
    );
  }

}