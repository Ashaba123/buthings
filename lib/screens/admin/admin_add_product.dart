import 'dart:io';
import 'package:buthings/components/rounded_button.dart';
import 'package:buthings/components/rounded_input_field.dart';
import 'package:buthings/constants.dart';
import 'package:buthings/models/product.dart';
import 'package:buthings/provider/product_provider.dart';
import 'package:buthings/services/authentication_service.dart';
import 'package:buthings/services/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'admin_view_products.dart';

class AdminAddProduct extends StatefulWidget {
  AdminAddProduct({Key? key}) : super(key: key);

  @override
  _AdminAddProductState createState() => _AdminAddProductState();
}

class _AdminAddProductState extends State<AdminAddProduct> {
  File? _image;
  final picker = ImagePicker();
  final formKey = GlobalKey<FormState>();
  var uuid = Uuid();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final stockController = TextEditingController();
  final priceController = TextEditingController();
  bool? saving = false;

  @override
  void dispose() {
    stockController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.purple,
                        child: _image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  _image!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(100)),
                                width: 150,
                                height: 150,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                Center(child: Text("Select an Image for Product")),
                SizedBox(height: kDefaultPadding),
                RoundedInputField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter a name!';
                    }
                    return null;
                  },
                  controller: nameController,
                  icon: Icons.edit,
                  hintText: 'Enter Name of Product',
                  textInputAction: TextInputAction.next,
                ),
                RoundedInputField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter a description!';
                    }
                    return null;
                  },
                  controller: descriptionController,
                  icon: Icons.edit,
                  hintText: 'Enter description',
                  textInputAction: TextInputAction.next,
                ),
                RoundedInputField(
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter a price!';
                    }
                    return null;
                  },
                  controller: priceController,
                  icon: Icons.edit,
                  hintText: 'Enter price',
                  textInputAction: TextInputAction.next,
                ),
                RoundedInputField(
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Enter Current Stock';
                    }
                    return null;
                  },
                  controller: stockController,
                  icon: Icons.edit,
                  hintText: 'Enter Current Stock',
                  textInputAction: TextInputAction.done,
                ),
                RoundedButton(
                  text: 'SAVE',
                  press: (_image == null)
                      ? null
                      : () async {
                          if (formKey.currentState!.validate()) {
                            final user = context
                                .read<IAuthenticationService>()
                                .currentUser();

                            //firebase Cloud storage store image
                            try {
                              String pic = (_image == null)
                                  ? "assets/images/logo.png"
                                  : _image!.path;

                              final snapshot = await context
                                  .read<IStorageService>()
                                  .uploadImage(_image!, pic);

                              if (snapshot.state == TaskState.success) {
                                //firestore image list
                                final String downloadUrl =
                                    await snapshot.ref.getDownloadURL();

                                List<MyImage>? imagesList = [];
                                imagesList.add(MyImage(downloadUrl));

                                _saveProduct(Product(
                                  id: uuid.v1(),
                                  createdBy: user!.email,
                                  orders: [],
                                  ratings: [],
                                  title: nameController.text,
                                  description: descriptionController.text,
                                  price: int.parse(priceController.text),
                                  stock: int.parse(stockController.text),
                                  image: downloadUrl,
                                  images: imagesList,
                                ));
                              }
                            } catch (e, trace) {
                              print(trace.toString());
                              print('product error:$e');
                            }
                          }
                        },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _imgFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  _imgFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _saveProduct(Product product) {
    Provider.of<ProductProvider>(context, listen: false).createProduct(product);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Successfully Saved")));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminViewProducts()));
  }
}
