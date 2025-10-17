import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  
  bool _isScanned = false;

  void _onDetect(BarcodeCapture capture) {
    if (_isScanned) return; // prevent multiple detections

    final Barcode? barcode = capture.barcodes.firstOrNull;
    final String? code = barcode?.rawValue;

    if (code != null) {
      setState(() => _isScanned = true);
      Navigator.pop(context, code); // return scanned data to previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Scan QR'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          MobileScanner(onDetect: _onDetect, fit: BoxFit.cover),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: Text(
                  'Point camera at a Qr code',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
