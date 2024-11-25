import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ItemCode extends StatelessWidget {
  final String code;
  final String name;
  final String quantity;
  final String measurement;
  final String? localAddress;
  const ItemCode(
      {super.key,
      required this.code,
      required this.name,
      required this.quantity,
      required this.measurement,
      this.localAddress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR code generated for Item"),
        backgroundColor: Colors.blue[400],
        elevation: 3,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent[100],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Center(
                  child: Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                    color: Colors.purple[500], fontSize: 24),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              QrImageView(
                                data: code,
                                version: QrVersions.auto,
                                size: 300.0,
                              ),
                              const SizedBox(height: 10),
                              Text(quantity),
                              const SizedBox(height: 10),
                              Text(measurement),
                              const SizedBox(height: 10),
                              Text(localAddress ?? 'not defined'),
                            ],
                          ))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// void _takeScreenshot() async {
//     RenderRepaintBoundary boundary =
//         _key.currentContext!.findRenderObject() as RenderRepaintBoundary;

//     ui.Image image = await boundary.toImage();
//     ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     if (byteData != null) {
//       Uint8List pngBytes = byteData.buffer.asUint8List();

//       // Saving the screenshot to the gallery
//       final result = await ImageGallerySaver.saveImage(
//           Uint8List.fromList(pngBytes),
//           quality: 90,
//           name: 'screenshot-${DateTime.now()}.png');

//       if (kDebugMode) {
//         print(result);
//       }
//       setState(() {
//         _message = 'New screenshot successfully saved!';
//       });
//     }
//   }   https://www.kindacode.com/article/how-to-programmatically-take-screenshots-in-flutter/
//       take data from screen......
}
