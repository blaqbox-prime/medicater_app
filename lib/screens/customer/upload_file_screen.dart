import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicater_app/constants.dart';
import 'package:medicater_app/providers/accountProvider.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/screens/common/w_Title.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

class UploadFile extends StatefulWidget {
  final String fileTitle;

  UploadFile({Key? key, required this.fileTitle}) : super(key: key);

  @override
  _UploadFileState createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  File? _imageFile;
  File? _tmpFile;
  String? base64Image;
  final _imagePicker = ImagePicker();
  late String? type = widget.fileTitle.toLowerCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarTextStyle: TextStyle(color: Colors.black87),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: bg_color,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(text1: "Upload\n", text2: widget.fileTitle),
            SizedBox(height: 25),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: (Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_imageFile != null
                      ? _imageFile!.path
                      : "Upload a ${widget.fileTitle} file"),
                  ElevatedButton(
                      onPressed: () => {_pickImageFromGallery()},
                      child: Text("upload"))
                ],
              )),
            ))
          ],
        ),
      ),
    );
  }

  Future<Null> _pickImageFromGallery() async {
    final _pickedFile =
        await _imagePicker.getImage(source: ImageSource.gallery);
    base64Image = base64Encode(File(_pickedFile!.path).readAsBytesSync());
    String fileName = File(_pickedFile.path).path.split('/').last;
    MysqlService db = new MysqlService();
    // call uploadfile
    uploadDecision(fileName: fileName, base64Image: base64Image!, type: type!);
    setState(() {
      this._imageFile = File(_pickedFile.path);
    });
  }

  void uploadDecision(
      {required String fileName,
      String? productId,
      required String base64Image,
      required String type}) {
    MysqlService db = new MysqlService();
    if (type == "logo") {
      final pharmId = Provider.of<SellerProvider>(context, listen: false).id;
      db.uploadFile(
          fileName: fileName,
          base64Image: base64Image,
          type: type,
          pharmId: pharmId);
    }
    if (type == "prescription") {
      final custId = Provider.of<AccountProvider>(context, listen: false)
          .customerDetails
          .custId;
      db.uploadFile(
          fileName: fileName,
          base64Image: base64Image,
          type: type,
          custId: custId);
    }
    if (type == "id") {
      final custId = Provider.of<AccountProvider>(context, listen: false)
          .customerDetails
          .custId;
      db.uploadFile(
          fileName: fileName,
          base64Image: base64Image,
          type: type,
          custId: custId);
    }
  }
}
