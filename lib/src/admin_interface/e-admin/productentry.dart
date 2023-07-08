import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../colors/colors.dart';
import '../../../utilities/dimention.dart';
import '../../../utilities/models/product.dart';
import '../../../utilities/string.dart';
import 'ProductController.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  _ProductEntryPageState createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  String imageUrl = "";
  final controller = Get.put(ProductController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantiteController = TextEditingController();
  String selectedText = "cp1";
  late TextEditingController _textEditingController;
  late ValueNotifier<String> _selectedTextNotifier;
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

  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _selectedTextNotifier = ValueNotifier<String>(Strings.categories[0]);

    _textEditingController.text = Strings
        .categories[0]; // Initialiser le contrôleur avec la première valeur

    _selectedTextNotifier.addListener(() {
      _textEditingController.text = _selectedTextNotifier.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrée de produit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Galerie'),
                              onTap: () {
                                Navigator.pop(context);
                                _chooseImage(ImageSource.gallery);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Appareil photo'),
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
                      : const Icon(Icons.add_a_photo, color: Colors.white),
                ),
              ),
              SizedBox(
                height: Dimenssion.height20dp / 2,
              ),
              TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline_outlined,
                        color: Mcolors.couleurPrincipal,
                      ),
                      labelText: 'Nom',
                      hintText: "Nom",
                      border: OutlineInputBorder())),
              SizedBox(
                height: Dimenssion.height20dp / 2,
              ),
              DropdownButtonFormField<String>(
                  value: _selectedTextNotifier.value,
                  decoration: const InputDecoration(
                    prefixIcon:
                        Icon(Icons.category, color: Mcolors.couleurPrincipal),
                    border: OutlineInputBorder(),
                  ),
                  hint: const Text('Sélectionnez un texte'),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTextNotifier.value = newValue!;
                    });
                  },
                  items: Strings.categories
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
              SizedBox(
                height: Dimenssion.height20dp / 2,
              ),
              TextFormField(
                  maxLines: 4,
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.description,
                        color: Mcolors.couleurPrincipal,
                      ),
                      labelText: 'Description',
                      hintMaxLines: 4,
                      border: OutlineInputBorder())),
              SizedBox(
                height: Dimenssion.height20dp / 2,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.euro,
                      color: Mcolors.couleurPrincipal,
                    ),
                    labelText: 'Prix',
                    hintText: "Prix",
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: Dimenssion.height20dp / 2,
              ),
              TextFormField(
                controller: _quantiteController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.production_quantity_limits,
                      color: Mcolors.couleurPrincipal,
                    ),
                    labelText: 'Quantity',
                    hintText: "Quantity",
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: Dimenssion.height20dp / 2,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = _nameController.text;
                  final String description = _descriptionController.text;
                  final double price = double.parse(_priceController.text);
                  final String categorie =
                      _selectedTextNotifier.value.toString();
                  final int quantiter = int.parse(_quantiteController.text);
                  if (_imageFile != null) {
                    // L'utilisateur a sélectionné une image
                    String imageUrl =
                        await controller.uploadImageToFirebase(_imageFile!);
                    DateTime now = DateTime.now();
                    int milliseconds = now.millisecondsSinceEpoch;
                    // Utilisez l'URL de l'image comme vous le souhaitez
                    final Product product = Product(
                        quatite: quantiter,
                        categorie: categorie,
                        id: milliseconds.toString(),
                        image: imageUrl,
                        name: name,
                        description: description,
                        price: price);
                    await controller.createProduct(product);
                  } else {
                    // L'utilisateur n'a pas sélectionné d'image
                    final Product product = Product(
                        id: TimeOfDay.now().toString(),
                        image: '',
                        quatite: quantiter,
                        categorie: categorie,
                        name: name,
                        description: description,
                        price: price);
                    await controller.createProduct(product);
                  }
                },
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
