import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_chat_app/blocs/qr_code_scanner_bloc.dart';
import 'package:we_chat_app/resources/colors.dart';
import '../resources/strings.dart';

class AddNewContactPage extends StatefulWidget {
  const AddNewContactPage({Key? key}) : super(key: key);

  @override
  State<AddNewContactPage> createState() => _AddNewContactPageState();
}

class _AddNewContactPageState extends State<AddNewContactPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isCameraPermissionGranted = false;
  Barcode? result;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.resumeCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QRCodeScanBloc(),
      child: Selector<QRCodeScanBloc, bool>(
        selector: (context, bloc) => bloc.isLoading,
        builder: (context, isLoading, child) => Expanded(
          child: (!isCameraPermissionGranted)
              ? Stack(
                  children: [
                    Consumer<QRCodeScanBloc>(
                      builder: (context, bloc, child) => QRView(
                        key: qrKey,
                        onQRViewCreated: (QRViewController controller) {
                          this.controller = controller;
                          controller.scannedDataStream.listen((scanData) async {
                            await controller.stopCamera();
                            result = scanData;
                            bloc
                                .onScanQR(result?.code ?? "")
                                .then((value) => Navigator.of(context).pop());
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: PRIMARY_COLOR,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 60,
                      child: Container(
                        decoration: BoxDecoration(
                            color: PRIMARY_COLOR,
                            borderRadius: BorderRadius.circular(4)),
                        child: TextButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            // Pick an image
                            final XFile? image = await picker.pickImage(
                                source: ImageSource.gallery);
                            if (image != null) {
                              // Handle the selected image
                            }
                          },
                          child: const Text(
                            "Select QR Code From Gallery",
                            style: TextStyle(
                              fontFamily: YORKIE_FONT,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
