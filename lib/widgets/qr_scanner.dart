import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:state_secret/widgets/android_transaction.dart';
import 'package:state_secret/widgets/ios_transaction.dart';



class QRScanner extends StatefulWidget {
  @override
  _QRScannerState createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Map<String, String>? upiDetails;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code Scanner"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (upiDetails != null)
                    ? Column(
                        children: [
                          Text('Payee Name: ${upiDetails!["pn"] ?? "Unknown"}'),
                          Text('UPI ID: ${upiDetails!["pa"] ?? "Unknown"}'),
                          Text('Transaction Note: ${upiDetails!["tn"] ?? "None"}'),
                          SizedBox(height: 20),
                          // Platform-specific transaction widget
                          Platform.isIOS
                              ? IOSTransactionWidget(upiDetails: upiDetails!)
                              : AndroidTransactionWidget(upiDetails: upiDetails!),
                        ],
                      )
                    : Text('Scan a UPI QR code'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        upiDetails = parseUPIData(scanData.code);
      });
    });
  }

  // Parse UPI QR Code data
  Map<String, String>? parseUPIData(String? data) {
    if (data == null || !data.startsWith("upi://pay")) {
      return null;
    }
    try {
      final Uri uri = Uri.parse(data);
      return uri.queryParameters;
    } catch (e) {
      print("Error parsing UPI data: $e");
      return null;
    }
  }
}
