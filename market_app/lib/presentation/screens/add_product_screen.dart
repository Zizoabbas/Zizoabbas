import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:market_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:market_app/logic/blocs/products_bloc/product_bloc.dart';
import 'package:market_app/logic/providers/user_provider.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _key = GlobalKey<FormState>();
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  File? image;
  String? urlz;
  Future pickimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imagepath = File(image.path);
      final imagename = File(image.name);
      File file = File(image.path);
      try {
        await _storage.ref("file/$imagename").putFile(file);
        // ignore: empty_catches
      } on firebase_core.FirebaseException catch (e) {}

      final downloadurl =
          await _storage.ref("file/$imagename").getDownloadURL();
      final url = downloadurl.toString();
      setState(() => this.image = imagepath);
      setState(() => urlz = url);
    } on PlatformException catch (e) {
      print("faild to pick image :$e");
    }
  }

  Future pickimage2() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imagepath = File(image.path);
      final imagename = File(image.name);
      File file = File(image.path);
      try {
        await _storage.ref("file/$imagename").putFile(file);
        // ignore: empty_catches
      } on firebase_core.FirebaseException catch (e) {}

      final downloadurl =
          await _storage.ref("file/$imagename").getDownloadURL();
      final url = downloadurl.toString();
      setState(() => this.image = imagepath);
      setState(() => urlz = url);
    } on PlatformException catch (e) {
      print("faild to pick image :$e");
    }
  }

  // final ImagePicker _picker = ImagePicker();
  bool _validating = false;
  bool _uploading = false;
  Map<String, dynamic> data = {};
  // firebase_storage.FirebaseStorage storage =
  //     firebase_storage.FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            autovalidateMode: _validating
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => data['name'] = value,
                  decoration: InputDecoration(
                    hintText: "your product name",
                    label: Text("Title"),
                  ),
                  validator: (value) {
                    if (value!.length < 4) {
                      return "Tile Can noy be less than 4 letters";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (value) => data['description'] = value,
                  minLines: 3,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "your product description",
                    label: Text("Description"),
                  ),
                  validator: (value) {
                    /* if (value!.length < 150) {
                      return "Tile Can noy be less than 4 letters";
                    } */
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (value) => data['price'] = value,
                  decoration: InputDecoration(
                    hintText: "your product price",
                    label: Text("price"),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    /* if (value!.length < 4) {
                      return "Tile Can noy be less than 4 letters";
                    } */
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (value) => data['amount'] = value,
                  decoration: InputDecoration(
                    hintText: "your product amount",
                    label: Text("amount"),
                  ),
                  validator: (value) {
                    /* if (value!.length < 4) {
                      return "Tile Can noy be less than 4 letters";
                    }
                    return null; */
                  },
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text("Choose image Source"),
                                actions: [
                                  TextButton(
                                    onPressed: () => pickimage(),
                                    child: Text("Camera"),
                                  ),
                                  TextButton(
                                    onPressed: () => pickimage2(),
                                    child: Text("Gallery"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Text("Choose Image")),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        child: image == null
                            ? Center(
                                child: Text(
                                  "No Image Choosen",
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ],
                  ),
                ),
                _uploading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              _uploading = true;
                            });
                            data['imageUrl'] = urlz;
                            data['owner_id'] =
                                await RepositoryProvider.of<UserProvider>(
                                        context)
                                    .getUserId();
                            BlocProvider.of<ProductsBloc>(context)
                                .add(AddProduct(data));
                            setState(() {
                              _uploading = false;
                            });
                            Navigator.of(context).pop();
                          } else {
                            setState(() {
                              _validating = true;
                            });
                          }
                        },
                        child: Text("Add Product"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//   Future<String?> uploadFile(String filePath) async {
//     File file = File(filePath);
//     String? imageUrl;
//     try {
//       await firebase_storage.FirebaseStorage.instance
//           .ref('products/123456${p.extension(file.path)}')
//           .putFile(file);
//       imageUrl = await firebase_storage.FirebaseStorage.instance
//           .ref('products/123456${p.extension(file.path)}')
//           .getDownloadURL();
//     } on FirebaseException catch (e) {
//       // e.g, e.code == 'canceled'
//     }
//     return imageUrl;
//   }
// }
