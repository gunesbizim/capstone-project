import 'dart:io';
import 'package:capstone_project/core/enums/profile_picture_enum.dart';
import 'package:capstone_project/services/authentication_service.dart';
import 'package:capstone_project/services/fire_store_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class UserDetailService with  ChangeNotifier{
  
  final String filePath = "package:capstone_project/views/hompage/services/user_detail_service.dart:";

  String url = "";

  final _picker = ImagePicker();

  late File? _image;
  late Reference storageReference;
  FireStoreService _fireStoreService = FireStoreService.instance;
  static final UserDetailService instance = UserDetailService._init();
  UserDetailService._init();


  Future<Map<String, String>> getUserDetails() async{
    print("$filePath Getting user details from Firestore Service");
    return await _fireStoreService.getUserDetails();
  }


  Future _setProfilePicture(ProfilePictureEnums mode) async {
      print("$filePath Setting profile pictue");

    if (mode == ProfilePictureEnums.UPDATE) {
      //update existing image in firestore
      await storageReference.delete();
    }
    try {
      await storageReference
          .putFile(_image!)
          .whenComplete(() => print("file uploaded"));

      await storageReference.getDownloadURL().then((fileURL) {
        url = fileURL;
        _fireStoreService.updateField(
            collection: "pilots", field: "ppURL", value: url);
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<String> selectImage(ProfilePictureEnums mode) async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _getStorageInstance();
      print(
          "----------------------------------------------------------------------------------------------------------------");
      _image = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      );
      await _setProfilePicture(mode);
    } else {
      print('No image selected.');
    }

    return url;
  }

  void _getStorageInstance() {
    storageReference = FirebaseStorage.instance
        .ref()
        .child('profile_pictures')
        .child(AuthenticationService.instance.user!.uid)
        .child(
            "${AuthenticationService.instance.user!.uid}_pp${p.extension(_image!.path)}");
  }
}
