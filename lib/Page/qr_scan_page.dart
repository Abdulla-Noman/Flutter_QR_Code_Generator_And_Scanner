import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class qr_scan_page extends StatefulWidget {
  const qr_scan_page({Key? key}) : super(key: key);

  @override
  State<qr_scan_page> createState() => _qr_scan_pageState();
}

class _qr_scan_pageState extends State<qr_scan_page> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrView(context),
            Positioned(bottom: 30, child: buildResult()),
            Positioned(top: 20, child: buildControlButtons()),
          ],
        )
      ),
    );
  }

  Widget buildControlButtons() => Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
            onPressed: () async {
              await controller?.toggleFlash();
            },
            icon: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                 if (snapshot.data !=null) {
                   return Icon(
                     snapshot.data! ? Icons.flash_on : Icons.flash_off,color: Colors.white,);
                 } else {
                   return Container();
                 }
                },
            )
        ),
        IconButton(
            onPressed: () async {
              await controller?.flipCamera();
              setState(() {

              });
            },
            icon: FutureBuilder(
              future: controller?.getCameraInfo(),
              builder: (context, snapshot) {
                if (snapshot.data !=null) {
                  return const Icon(Icons.switch_camera,color: Colors.white,);
                } else {
                  return Container();
                }
              },
            )
        ),
      ],
    ),
  );

  Widget buildResult() =>  Container(
    height: 30,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Center(
      child: Text(
            barcode !=null ? 'Result : ${barcode!.code}':'Scan a code!',
            style: TextStyle(color: Colors.white),
            maxLines: 3,
      ),
    ),
  );

  Widget buildQrView(BuildContext context) => QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderRadius: 10,
      borderLength: 20,
      borderWidth: 10,
      // cutOutBottomOffset: MediaQuery.of(context).size.width * 0.9,
      cutOutSize: MediaQuery.of(context).size.width * 0.8,
    ),
  );

  void onQRViewCreated (QRViewController controller) {
    setState(() =>this.controller =  controller);

    controller.scannedDataStream
      .listen((barcode) => setState(() => this.barcode = barcode ));
  }

}
