import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; //to import File datatype
import 'dart:developer';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key,required this.getImage});
 final void Function (File image) getImage;// this function sends the file of image to the parent i.e. add_place where this imageg is added for a particular instance of place in the user_places provider file


  @override
  State<ImageInput> createState() {
    return _ImageInput();
  }
}

class _ImageInput extends State<ImageInput> {
  File? clickedImage;
  final ImagePicker picker = ImagePicker();
  void clickImage() async {
    
log('---------------------------');
    final XFile? photo =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (photo == null) {
      return;
    } 
      setState(() {
        clickedImage = File(photo.path); // conversion of XFile to normal File
      
         log('---------------------------imahe');
         print(clickedImage);
      });
      widget.getImage(clickedImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: clickImage,
        icon: const Icon(Icons.camera),
        label: const Text('Take a picture'));
if (clickedImage!=null) {
   content=GestureDetector(
              onTap: clickImage,
              child: Image.file(
                clickedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
}
    return Container(
      alignment: Alignment.center,
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: content
    );
  }
}
