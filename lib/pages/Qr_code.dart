import 'package:flutter/material.dart';
import 'package:qrcode/qrcode.dart';
import 'package:treinamar/pages/ScannedImage.dart';


class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  QRCaptureController _captureController = QRCaptureController();

  @override
  void initState() {
    super.initState();
    print('initstate');
    _captureController.onCapture((data) {
      //print('onCapture----$data');
      _captureController.pause();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ScannedImage())).then((value) => 
          _captureController.resume()
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Scanear Código'),
        ),
        body: Center(
            child: Container(
              width: 250,
              height: 250,
              child: QRCaptureView(
              controller: _captureController,
            ),
            ),
        ),
      );
    }
  }
