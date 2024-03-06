import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generate_pdf/screens/custom_textfiel.dart';
import 'package:generate_pdf/services/pdf_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController companyName = TextEditingController();

  TextEditingController itemN = TextEditingController();
  TextEditingController itemQ = TextEditingController();
  TextEditingController itemUp = TextEditingController();
  TextEditingController itemT = TextEditingController();
  // TextEditingController companyName = TextEditingController();
  // TextEditingController companyName = TextEditingController();
  // TextEditingController companyName = TextEditingController();
  // TextEditingController companyName = TextEditingController();
  // TextEditingController companyName = TextEditingController();

  List _orders = [];
  // Fetch order from json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString("assets/orders.json");
    final data = await json.decode(response);
    setState(() {
      _orders = data['records'];
    });
  }

  final pdfServices = PdfServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Generator")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              customTextfield(hint: 'Company Name'),
              Text('item 1'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: customTextfield(
                          controller: itemN, hint: 'Item Name')),
                  Expanded(
                      child:
                          customTextfield(controller: itemQ, hint: 'quntity')),
                  Expanded(
                      child: customTextfield(
                          controller: itemUp, hint: 'unit price')),
                  Expanded(
                      child: customTextfield(controller: itemT, hint: 'total')),
                ],
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      final data = await pdfServices.generateInvoice(
                          companyName: companyName.text.trim(),
                          invoiceNumber: '223234',
                          invoiceDate: '2/02/2024',
                          dueDate: '3/02/2024',
                          items: [
                            [
                              itemN.text.trim(),
                              itemQ.text.trim(),
                              itemUp.text.trim(),
                              itemT.text.trim()
                            ],
                            ['Item 2', '1', '\$15.00', '\$15.00'],
                            ['Item 3', '3', '\$8.00', '\$24.00'],
                          ],
                          subtotal: '59',
                          tax: '6',
                          total: '65');
                      pdfServices.savePdfFile('kashif', data);
                    },
                    child: const Text("Generate EMS PDF")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
