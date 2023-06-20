import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utilities/models/product.dart';
import 'ProductController.dart';

class ProductEntryPage extends StatefulWidget {
  @override
  _ProductEntryPageState createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  String imageUrl = "";
  final controller = Get.put(ProductController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  File? _imageFile;

  Future<void> _requestPermissions() async {
    final PermissionStatus cameraPermissionStatus =
        await Permission.camera.request();
    final PermissionStatus storagePermissionStatus =
        await Permission.storage.request();

    if (cameraPermissionStatus.isGranted && storagePermissionStatus.isGranted) {
      // Les autorisations ont été refusées. Affichez un message à l'utilisateur ou effectuez d'autres actions nécessaires.
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permissions refusées'),
          content: const Text(
              'Veuillez accorder les autorisations pour utiliser la caméra et le stockage.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _chooseImage(ImageSource source) async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.request();
    PermissionStatus storagePermissionStatus =
        await Permission.storage.request();

    if (cameraPermissionStatus.isGranted && storagePermissionStatus.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } else if (cameraPermissionStatus.isDenied ||
        storagePermissionStatus.isDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permissions refusées'),
          content: const Text(
              'Veuillez accorder les autorisations pour utiliser la caméra et le stockage.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrée de produit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('Galerie'),
                            onTap: () {
                              Navigator.pop(context);
                              _chooseImage(ImageSource.gallery);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('Appareil photo'),
                            onTap: () {
                              Navigator.pop(context);
                              _chooseImage(ImageSource.camera);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _imageFile != null
                    ? Image.file(_imageFile!, fit: BoxFit.cover)
                    : Icon(Icons.add_a_photo, color: Colors.white),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Prix',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final String name = _nameController.text;
                final String description = _descriptionController.text;
                final double price = double.parse(_priceController.text);

                if (_imageFile != null) {
                  // L'utilisateur a sélectionné une image
                  String imageUrl =
                      await controller.uploadImageToFirebase(_imageFile!);
                  // Utilisez l'URL de l'image comme vous le souhaitez
                  final Product product =
                      Product(imageUrl, name, description, price);
                  await controller.createProduct(product);
                } else {
                  // L'utilisateur n'a pas sélectionné d'image
                  final Product product = Product('', name, description, price);
                  await controller.createProduct(product);
                }
              },
              child: Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
