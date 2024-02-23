import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_ieee/constants/colors.dart';
import 'package:qr_ieee/constants/text_style.dart';
import 'package:qr_ieee/data/model/Person.dart';
import 'package:qr_ieee/data/web_services/web_Service.dart';

import '../../constants/strings.dart';

class ScanScreen extends StatefulWidget {
  static const String routeName = 'scan';

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with TickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String? result;
  QRViewController? controller;
  bool isFlashOn = false;
  bool isScanning = false;
  bool useFrontCamera = false;
  late AnimationController pulsatingController;
  late AnimationController fadeInOutController;

  @override
  void initState() {
    super.initState();
    pulsatingController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    fadeInOutController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30, color: MyColor.White),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(qrscanner, style: TextAppStyle.scanerbar()),
        backgroundColor: MyColor.Accent,
        actions: [
          IconButton(
            icon: Icon(isFlashOn ?Icons.flash_on:Icons.flash_off, size: 40, color: MyColor.White),
            onPressed: _toggleFlash,
          ),
          IconButton(
            icon: Icon(isScanning ? Icons.stop : Icons.play_arrow, size: 40, color: MyColor.White),
            onPressed: _toggleScanning,
          ),
          IconButton(
            icon: Icon(Icons.flip_camera_android, size: 40, color: MyColor.White),
            onPressed: _toggleCamera,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _buildQRView(),
                if (isScanning) _buildPulsatingAnimation(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: _buildResultDisplay(),
          ),
          _buildResetButton(),
        ],
      ),
    );
  }

  Widget _buildQRView() {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: isScanning ? MyColor.Accent : Colors.greenAccent,
        borderRadius: 13,
        borderLength: 33,
        borderWidth: 14,
        cutOutSize: 310,
      ),
      onPermissionSet: (controller, permission) => _onPermissionSet(controller, permission),
    );
  }

  Widget _buildResultDisplay() {
    return AnimatedBuilder(
      animation: fadeInOutController,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Opacity(
              opacity: fadeInOutController.value,
              child: result != null
                  ? _buildResultText('QR Code Data: \n\n${result}')
                  : _buildResultText('Scan a QR code'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultText(String text) {
    return Text(
      text,
      style: TextAppStyle.btnStyle(),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPulsatingAnimation() {
    return Opacity(
      opacity: 0.5 + pulsatingController.value * 0.5,
      child: Icon(
        Icons.center_focus_weak,
        size: 200,
        color: MyColor.Accent,
      ),
    );
  }

  Widget _buildResetButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _resetScan,
        child: Text(resetscan,style: TextAppStyle.scanerText(),),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async{
      controller.pauseCamera();

      dynamic person = await QrWebServices(Dio()).getPersonData(code: scanData.code??"");
      print('______________________________________________');

      print(person.runtimeType);
      print(person);

      setState(() {
        print('1');
        if(person is Person){
          result = person.name;
          print(person.name);
          print('2');

        }

        else{
          result = person['status'];
          print('3');

        }
        print('4');
        isScanning = false;
        fadeInOutController.forward(from: 0.0);
      });
    });
  }

  void _onPermissionSet(QRViewController controller, bool permission) {
    if (!permission) {

    }
  }

  void _toggleScanning() {
    if (controller != null) {
      if (isScanning) {
        controller!.stopCamera();
      } else {
        controller!.resumeCamera();
      }
      setState(() {
        isScanning = !isScanning;
      });
    }
  }

  void _toggleFlash() {
    if (controller != null) {
      controller!.toggleFlash();
      setState(() {
        isFlashOn = !isFlashOn;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isFlashOn ? 'Flashlight On' : 'Flashlight Off'),
            duration: Duration(seconds: 1),
          ),
        );
      });
    }
  }

  void _toggleCamera() {
    if (controller != null) {
      controller!.flipCamera();
      setState(() {
        useFrontCamera = !useFrontCamera;
      });
    }
  }

  void _resetScan() {
    if (controller != null) {
      controller!.resumeCamera();
    }
    setState(() {
      result = null;
      isScanning = true;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    pulsatingController.dispose();
    fadeInOutController.dispose();
    super.dispose();
  }
}