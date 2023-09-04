import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_generator_and_scanner/Page/qr_create_page.dart';
import 'package:qr_code_generator_and_scanner/Page/qr_scan_page.dart';


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home:  QR_Code(),
    );
  }
}

class QR_Code extends StatefulWidget {
  const QR_Code({super.key});

  @override
  State<QR_Code> createState() => _QR_CodeState();
}

class _QR_CodeState extends State<QR_Code>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  // bool isFlashOn = false;
  // bool isFontCamera = false;
  // MobileScannerController controller = MobileScannerController();



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black87),
        title:  const Text('QR Code Scanner'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.qr_code_scanner),
              text: 'Scan QR',
            ),
            Tab(
              icon: Icon(Icons.qr_code),
              text: 'Create QR',
            ),
            // Tab(
            //   icon: Icon(Icons.brightness_5_sharp),
            // ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          qr_scan_page(),
          qr_create_page(),
        ],
      ),
    );
  }
}
