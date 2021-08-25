import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicater_app/models/product.dart';
import 'package:medicater_app/providers/productProvider.dart';
import 'package:medicater_app/providers/sellerProvider.dart';
import 'package:medicater_app/services/mysql_service.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  ProductForm({this.product});

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  File? _imageFile;
  File? _tmpFile;
  String? base64Image;
  final _imagePicker = ImagePicker();
  //---- Insert Text Controllers Here. ----------------------
  TextEditingController? prodTitle;
  TextEditingController? prodDesc;
  TextEditingController? prodRecc;
  TextEditingController? prodCat;
  TextEditingController? prodPrice;

  @override
  void initState() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    prodTitle = TextEditingController(text: productProvider.product!.name);
    prodDesc =
        TextEditingController(text: productProvider.product!.description);
    prodRecc =
        TextEditingController(text: productProvider.product!.recommendation!);
    prodCat = TextEditingController(
        text: productProvider.product!.category != null
            ? productProvider.product!.category!.join(",")
            : "");
    prodPrice = TextEditingController(
        text: productProvider.product!.price != null
            ? productProvider.product!.price!.toStringAsFixed(2)
            : "");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context, listen: true);
    final seller = Provider.of<SellerProvider>(context, listen: false);

    return Form(
      key: _key,
      child: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: bg_color, style: BorderStyle.solid, width: 2)),
              alignment: Alignment.center,
              child: productProvider.product!.img == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle,
                          color: accent_color,
                          size: 46,
                        ),
                        Text(
                          _imageFile == null
                              ? "no Image available"
                              : _imageFile!.path,
                          style: TextStyle(color: Colors.black87),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          onPressed: () async {
                            await _pickImageFromGallery();
                          },
                          color: primary_color,
                          textColor: Colors.white,
                          child: Text("Upload Image File"),
                        )
                      ],
                    )
                  : Stack(fit: StackFit.expand, children: [
                      Image.network(
                        productProvider.product!.img!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white60,
                            ),
                            onPressed: () => _pickImageFromGallery(),
                          ))
                    ])),
          textFieldContainer(
            title: "Product Title",
            child: TextFormField(
              onChanged: (value) => productProvider.setTitle(value),
              controller: prodTitle,
              autovalidateMode: AutovalidateMode.always,
              validator: (value) {
                if (value == "" || value == null) {
                  return "Title cannot be empty";
                }
                return null;
              },
              decoration:
                  InputDecoration.collapsed(hintText: "Enter Product Title"),
              maxLines: 1,
              textCapitalization: TextCapitalization.words,
            ),
          ),
          textFieldContainer(
              title: "Product Description",
              child: TextFormField(
                onChanged: (value) => productProvider.setDesc(value),
                controller: prodDesc,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration.collapsed(
                    hintText: "Enter Product Description"),
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
              )),
          textFieldContainer(
              title: "Recommendations",
              child: TextFormField(
                onChanged: (value) => productProvider.setRec(value),
                controller: prodRecc,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration.collapsed(
                    hintText:
                        "Enter Intake Recommendations. e.g: Take 2 capsules 3 times a day after meals"),
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
              )),
          textFieldContainer(
              title: "Categories",
              child: TextFormField(
                onChanged: (value) => productProvider.setCategories(value),
                controller: prodCat,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration.collapsed(
                    hintText:
                        "Enter Product Catagories. Separate each category with a comma e.g: Antibiotics, multi-vitamins, etc "),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              )),
          textFieldContainer(
              title: "Price",
              child: TextFormField(
                controller: prodPrice,
                keyboardType: TextInputType.number,
                onChanged: (value) => productProvider.setPrice(value),
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Price cannot be empyty or null";
                  }
                  return null;
                },
                decoration: InputDecoration.collapsed(hintText: "Enter  Price"),
              )),
          ElevatedButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                print(prodTitle!.text);
                productProvider.saveProduct(seller.id!);
                Navigator.pop(context, true);
              }
            },
            child: Container(
              child: Text(
                "Save Product",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                // useRootNavigator: true,
                builder: (ctx) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          "cancel",
                          style: TextStyle(color: Colors.black87),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text(
                          "delete",
                          style: TextStyle(color: Colors.red),
                        )),
                  ],
                  title: Text("Are you sure?"),
                ),
              ).then((delete) {
                print(delete);
                if (delete == true) {
                  var db = MysqlService();
                  db.deletProduct(productProvider.product!.productId!);
                  Navigator.of(context).pop(true);
                }
              });
            },
            child: Container(
              child: Text(
                "Delete Product",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<Null> _pickImageFromGallery() async {
    final _pickedFile =
        await _imagePicker.getImage(source: ImageSource.gallery);
    base64Image = base64Encode(File(_pickedFile!.path).readAsBytesSync());
    String fileName = File(_pickedFile.path).path.split('/').last;
    MysqlService db = new MysqlService();
    db.uploadProductImage(
        fileName,
        Provider.of<ProductProvider>(context, listen: false)
            .product!
            .productId!,
        base64Image!);

    setState(() {
      this._imageFile = File(_pickedFile.path);
      Provider.of<ProductProvider>(context, listen: false).product!.img =
          this._imageFile!.path;
    });
  }

  Widget textFieldContainer({required Widget child, required String title}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          ),
          SizedBox(height: 5),
          Container(
            alignment: Alignment.center,
            //height: 50,

            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: child,
          ),
          Center(
            child: Container(
                height: 3,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: accent_color,
                            style: BorderStyle.solid,
                            width: 1)))),
          ),
        ],
      ),
    );
  }
}
