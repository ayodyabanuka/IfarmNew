import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRScanner extends StatefulWidget {
  QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

var getResult = 'QR Code Result';

class _QRScannerState extends State<QRScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                scanQRCode();
              },
              child: const Text('Scan QR')),
          const SizedBox(
            height: 20.0,
          ),
          Text(getResult),
        ],
      ),
    ));
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }
}
