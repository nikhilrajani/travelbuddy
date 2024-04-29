import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travelbuddy/models/user.dart';
import 'package:travelbuddy/providers/user_provider.dart';
import 'package:travelbuddy/resources/firestore_methods.dart';
import 'package:travelbuddy/utils/colors.dart';
import 'package:travelbuddy/utils/utils.dart';

class ProfilePic extends StatelessWidget {
  final String photoUrl;

  const ProfilePic({super.key, required this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(photoUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _captionController.dispose();
    _sourceController.dispose();
    _destinationController.dispose();
    _dateController.dispose();
    _weightController.dispose();
    _priceController.dispose();
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  void postTravel(String uid, String username, String profImage) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _captionController.text,
        _sourceController.text,
        _destinationController.text,
        _dateController.text,
        _weightController.text,
        _priceController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        showSnackBar('Posted!', context);
        clearData();
        setState(() {
          _isLoading = false;
        });
      } else {
        showSnackBar(res, context);
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void clearData() {
    setState(() {
      _file = null;
      _captionController.text = "";
      _sourceController.text = "";
      _destinationController.text = "";
      _weightController.text = "";
      _priceController.text = "";
      _dateController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: clearData,
        ),
        title: const Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () =>
                  postTravel(user.uid, user.username, user.photoUrl),
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          _isLoading
              ? const LinearProgressIndicator()
              : const Padding(
                  padding: EdgeInsets.only(top: 0),
                ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          user.photoUrl,
                        ),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _captionController,
                  decoration: const InputDecoration(
                    hintText: 'Write a caption...',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                height: 45,
                width: 45,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: _file == null
                      ? Center(
                          child: IconButton(
                            icon: const Icon(Icons.upload),
                            onPressed: () => _selectImage(context),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _sourceController,
                  decoration: const InputDecoration(
                    hintText: 'Source...',
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _destinationController,
                  decoration: const InputDecoration(
                    hintText: 'Destination...',
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Journey',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _weightController,
                  decoration: const InputDecoration(
                    hintText: 'Weight Allowance...',
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    hintText: 'Price...',
                    border: InputBorder.none,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
