import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_ieee/constants/colors.dart';
import 'package:qr_ieee/constants/text_style.dart';

class GenerateScreen extends StatefulWidget {
  static String routeName = 'generate';

  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _textEditingController = TextEditingController();
  String? qrData;
  bool _isError = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator',style: TextAppStyle.scanerText(),),
        backgroundColor: MyColor.Primary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              MyColor.Primary,
              MyColor.White,

              MyColor.lavender,

            ],
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Center(
                    key: ValueKey<String>(_isError ? 'error' : qrData ?? ''),
                    child: _isError
                        ? FadeTransition(
                      opacity: Tween<double>(begin: 0.0, end: 1.0)
                          .animate(CurvedAnimation(
                          parent: _animationController,
                          curve: Curves.easeInOut)),
                      child: Text(
                        'Invalid input',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                        : QrImageView(
                      data: qrData ?? '1234567890',
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  hintText: 'E.g., Your text here',
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  suffixIcon: AnimatedOpacity(
                    opacity: _textEditingController.text.isNotEmpty ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _textEditingController.clear();
                          qrData = null;
                          _isError = false;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    qrData = _textEditingController.text;
                    _isError = qrData!.isEmpty;
                    _animationController.forward(from: 0.0);
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text('Generate QR Code',style: TextAppStyle.scanerText(),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
