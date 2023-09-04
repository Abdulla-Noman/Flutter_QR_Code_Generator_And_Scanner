import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class qr_create_page extends StatefulWidget {
  const qr_create_page({Key? key}) : super(key: key);

  @override
  State<qr_create_page> createState() => _qr_create_pageState();
}

class _qr_create_pageState extends State<qr_create_page> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImageView(
                data: controller.text,
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(height: 40,),
              buildTextField(context),
            ],
          ),
        ),
      )
    );
  }

  Widget buildTextField(BuildContext context) =>TextField(
    controller: controller,
    style: const TextStyle(
      // color: Colors.,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the data',
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
        ),
      ),

      suffixIcon: IconButton(
          onPressed: () => setState(() {}),
          icon: const Icon(Icons.done,size: 30,)
      )
    ),
  );
}
