import 'package:breakq/configs/app_globals.dart';
import 'package:breakq/configs/constants.dart';
import 'package:breakq/data/models/product_model.dart';
import 'package:breakq/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class BarcodeScanner extends StatefulWidget {
//   @override
//   _BarcodeScannerState createState() => _BarcodeScannerState();
// }

// class _BarcodeScannerState extends State<BarcodeScanner> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode result;
//   QRViewController controller;

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller.pauseCamera();
//     } else if (Platform.isIOS) {
//       controller.resumeCamera();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             flex: 5,
//             // To ensure the Scanner view is properly sizes after rotation
//             // we need to listen for Flutter SizeChanged notification and update controller
//             child: NotificationListener<SizeChangedLayoutNotification>(
//               onNotification: (notification) {
//                 // Future.microtask(() => controller. .updateDimensions(qrKey));
//                 return false;
//               },
//               child: SizeChangedLayoutNotifier(
//                 key: const Key('qr-size-notifier'),
//                 child: QRView(
//                   key: qrKey,
//                   onQRViewCreated: _onQRViewCreated,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Center(
//               child: (result != null)
//                   ? Text(
//                       'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}')
//                   : Text('Scan a code'),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
class BarcodeScanner {
  String scanText;

  Future<void> scan(BuildContext context) async {
    try {
      scanText = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      scanText = "Something went wrong!";
    }

    if (scanText != "-1") {
      /// To test the value of the barcode
      // showDialog(
      //     context: context,
      //     child: Builder(builder: (context) {
      //       return AlertDialog(
      //         title: Text("This is a temporary feature"),
      //         content: Text(
      //             "This is temporary, only to display the value of the barcode.\nThe reading of the barcode is : $scanText"),
      //         actions: [
      //           FlatButton(
      //               onPressed: () => Navigator.pop(context), child: Text("Ok"))
      //         ],
      //       );
      //     }),
      //     useRootNavigator: true);

      // Get the Product to display over here
      Product maggi = Product(
        id: 101,
        available: 10,
        categoryId: 12,
        image: AssetImages.maggi,
        salePrice: 50,
        maxPrice: 40,
        title: "Maggi Scanned",
        quantity: "500 gm",
      );
      getIt
          .get<AppGlobals>()
          .onProductPressed(maggi, context, then: () => this.scan(context));
    }
  }
}
