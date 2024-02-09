import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:qr_ieee/constants/strings.dart';
import 'package:qr_ieee/constants/text_style.dart';
import 'package:qr_ieee/presentation/screens/ScanScreen.dart';

import '../../constants/colors.dart';
import 'generateScreen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = 'homeScreen';
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              MyColor.Additional,

              MyColor.secondary,

            ],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .55,
                height: MediaQuery.of(context).size.height * .060,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ScanScreen.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        scan,
                        style: TextAppStyle.btnStyle(),
                      ),
                    )),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width * .55,
                height: MediaQuery.of(context).size.height * .060,

                child: ElevatedButton(

                    onPressed: () {
                      Navigator.pushNamed(context, GenerateScreen.routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(generate, style: TextAppStyle.btnStyle()),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
