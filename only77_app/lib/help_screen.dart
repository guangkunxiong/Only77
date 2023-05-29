import 'package:only77_app/app_theme.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      color: isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor:
              isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
          body: Column(
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.only(
              //       top: MediaQuery.of(context).padding.top,
              //       left: 16,
              //       right: 16),
              //   child: Image.asset('assets/images/helpImage.png'),
              // ),
              Container(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  '有问题学面对面沟通 嘻嘻',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isLightMode ? Colors.black : Colors.white),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.only(top: 16),
              //   child: Text(
              //     '嘻嘻',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         fontSize: 16,
              //         color: isLightMode ? Colors.black : Colors.white),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
