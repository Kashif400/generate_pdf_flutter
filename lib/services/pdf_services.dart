// // import 'dart:ffi';
// // import 'dart:io';
// // import 'dart:typed_data';
// // import 'package:open_file/open_file.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:pdf/pdf.dart';
// // import 'package:pdf/widgets.dart' as pw;

// // class PdfServices {
// //   Future<Uint8List> generatePdf() async {
// //     final pdf = pw.Document();
// //     pdf.addPage(pw.Page(
// //         pageFormat: PdfPageFormat.a4,
// //         build: (content) {
// //           return pw.Center(child: pw.Text('hello world'));
// //         }));

// //     return pdf.save();
// //   }

// //   Future<void> savePdfFile(String fileName, Uint8List byteList) async {
// //     final output = await getTemporaryDirectory();
// //     var filePath = "${output.path}/$fileName.pdf";
// //     final file = File(filePath);
// //     await file.writeAsBytes(byteList);
// //     await OpenFile.open(filePath);
// //   }
// // }

// import 'dart:io';
// import 'dart:typed_data';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class PdfServices {
//   Future<Uint8List> generateInvoice() async {
//     final pdf = pw.Document();

//     // Add a page to the PDF
//     pdf.addPage(pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       margin: pw.EdgeInsets.all(20.0),
//       build: (context) => [
//         // Invoice header
//         _buildHeader(),

//         // Invoice information
//         _buildInvoiceInfo(),

//         // Invoice items
//         _buildInvoiceItems(),

//         // Invoice total
//         _buildTotal(),
//       ],
//     ));

//     // Save the PDF and return the bytes
//     return pdf.save();
//   }

//   pw.Widget _buildHeader() {
//     return pw.Row(
//       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//       children: [
//         pw.Text('Your Company Name',
//             style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//         pw.Text('Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//       ],
//     );
//   }

//   pw.Widget _buildInvoiceInfo() {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         _buildInfoRow('Invoice Number:', 'INV2022001'),
//         _buildInfoRow('Date:', '2022-03-15'),
//         _buildInfoRow('Due Date:', '2022-03-30'),
//       ],
//     );
//   }

//   pw.Widget _buildInfoRow(String title, String value) {
//     return pw.Row(
//       children: [
//         pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//         pw.SizedBox(width: 10),
//         pw.Text(value),
//       ],
//     );
//   }

//   pw.Widget _buildInvoiceItems() {
//     // return pw.TableOfContent();
//     return pw.Table.fromTextArray(
//       headers: ['Description', 'Quantity', 'Unit Price', 'Total'],
//       data: [
//         ['Item 1', '2', '\$10.00', '\$20.00'],
//         ['Item 2', '1', '\$15.00', '\$15.00'],
//         ['Item 3', '3', '\$8.00', '\$24.00'],
//       ],
//       cellAlignments: {
//         0: pw.Alignment.centerLeft,
//         1: pw.Alignment.centerRight,
//         2: pw.Alignment.centerRight,
//         3: pw.Alignment.centerRight,
//       },
//     );
//   }

//   pw.Widget _buildTotal() {
//     return pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         pw.SizedBox(height: 20),
//         _buildTotalRow('Subtotal', '\$59.00'),
//         _buildTotalRow('Tax (7%)', '\$4.13'),
//         pw.Divider(),
//         _buildTotalRow('Total', '\$63.13',
//             style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
//       ],
//     );
//   }

//   pw.Widget _buildTotalRow(String title, String value, {pw.TextStyle? style}) {
//     return pw.Row(
//       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//       children: [
//         pw.Text(title),
//         pw.Text(value, style: style),
//       ],
//     );
//   }

//   Future<void> savePdfFile(String fileName, Uint8List byteList) async {
//     final output = await getTemporaryDirectory();
//     var filePath = "${output.path}/$fileName.pdf";
//     final file = File(filePath);
//     await file.writeAsBytes(byteList);
//     await OpenFile.open(filePath);
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfServices {
  Future<Uint8List> generateInvoice({
    required String companyName,
    required String invoiceNumber,
    required String invoiceDate,
    required String dueDate,
    required List<List<String>> items,
    required String subtotal,
    required String tax,
    required String total,
  }) async {
    final pdf = pw.Document();

    // Add a page to the PDF
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(20.0),
      build: (context) => [
        // Invoice header
        _buildHeader(companyName),

        // Invoice information
        _buildInvoiceInfo(invoiceNumber, invoiceDate, dueDate),

        // Invoice items
        _buildInvoiceItems(items),

        // Invoice total
        _buildTotal(subtotal, tax, total),
      ],
    ));

    // Save the PDF and return the bytes
    return pdf.save();
  }

  pw.Widget _buildHeader(String companyName) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(companyName,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.Text('Invoice', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _buildInvoiceInfo(
      String invoiceNumber, String invoiceDate, String dueDate) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Invoice Number:', invoiceNumber),
        _buildInfoRow('Date:', invoiceDate),
        _buildInfoRow('Due Date:', dueDate),
      ],
    );
  }

  pw.Widget _buildInfoRow(String title, String value) {
    return pw.Row(
      children: [
        pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(width: 10),
        pw.Text(value),
      ],
    );
  }

  pw.Widget _buildInvoiceItems(List<List<String>> items) {
    return pw.Table.fromTextArray(
      headers: ['Description', 'Quantity', 'Unit Price', 'Total'],
      data: items,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
    );
  }

  pw.Widget _buildTotal(String subtotal, String tax, String total) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.SizedBox(height: 20),
        _buildTotalRow('Subtotal', subtotal),
        _buildTotalRow('Tax (7%)', tax),
        pw.Divider(),
        _buildTotalRow('Total', total,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _buildTotalRow(String title, String value, {pw.TextStyle? style}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(title),
        pw.Text(value, style: style),
      ],
    );
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenFile.open(filePath);
  }
}
