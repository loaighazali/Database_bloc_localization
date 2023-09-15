
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LunchScreen extends StatefulWidget {
  const LunchScreen({Key? key}) : super(key: key);

  @override
  State<LunchScreen> createState() => _LunchScreenState();
}

class _LunchScreenState extends State<LunchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login_screen');
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:  AlignmentDirectional.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors:[
              Colors.green.shade900,
              Colors.green.shade300,
            ] ),
      ),
      child: Text(
        'Data Base App',
        style: TextStyle(
          fontSize: 25.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
