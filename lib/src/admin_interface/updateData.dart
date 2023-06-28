// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class Updatedata extends GetxController {
  static UserRepository get instance => Get.find();
  final _db1 = FirebaseFirestore.instance;

  updateDataProgress(context, List<String> chunks) async {
    if (chunks.isEmpty) {
      return;
    }
    ProgressDialog pd = ProgressDialog(context: context);

    /// show the state of preparation first.
    pd.show(
        max: chunks.length,
        msg: 'mise a jour en cours...',
        progressType: ProgressType.valuable,
        backgroundColor: const Color(0xff212121),
        progressValueColor: const Color(0xff3550B4),
        progressBgColor: Colors.white70,
        msgColor: Colors.white,
        valueColor: Colors.white);

    /// Added to test late loading starts
    await Future.delayed(const Duration(milliseconds: 3000));

    for (int i = 0; i < chunks.length; i++) {
// Get a reference to the document you want to update
      final documentId =
          chunks[i].split(";")[0].substring(3); // Replace with your document ID
      final docRef =
          FirebaseFirestore.instance.collection('Users').doc(documentId);
// Get the current data of the document
      await docRef.get().then((doc) async {
        if (doc.exists) {
          // Get the current value of the 'points' field
          final currentPoints = doc.data()!['points']
              as int; // Cast the value to an int if necessary

          final newPoints = chunks[i].split(";")[2].substring(7);
          int intValue = 0;
          try {
            intValue = int.parse(newPoints); // Convert the string to an integer
            print(intValue);
          } catch (e) {
            print(
                'Error: $e'); // Output: Error: FormatException: Invalid radix-10 number
          }
          final newData = {
            'points': currentPoints + intValue
          }; // Replace with the new value for the 'points' field
          await docRef.update(newData).then((value) async {
            pd.update(value: (i + 1), msg: 'File Downloading...');

            await Future.delayed(const Duration(milliseconds: 1000));
            // Update successful
          }).catchError((error) {
            Get.snackbar("mise a jours info", "erreur !! ",
                borderRadius: 20,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color.fromARGB(255, 255, 72, 72),
                colorText: Colors.black);
            return;
            // Handle errors here
          });
        } else {
          // Document does not exist
        }
      }).catchError((error) {
        // Handle errors here
      });
    }

    /// You can indicate here that the download has started.
    pd.close();
  }
}
