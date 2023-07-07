import 'package:fav_place/widgets/image_input.dart';
import 'package:fav_place/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';// to import the File? datatype

import 'package:fav_place/providers/user_places.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? imageGet;

  void _getImage(File image) {
    imageGet =
        image; // function to receive the image file from image_input.dart to be added on the provider
  }

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || imageGet == null) {
      showDialog(
          context: context,
          builder: (cntx) => AlertDialog(
                title: const Text('Invalid input'),
                content:
                    const Text('Please enter a valid place name with image'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(cntx);
                      },
                      child: Text(
                        'Okay',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ))
                ],
              ));
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle, imageGet!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            const SizedBox(height: 10),
            //Image Input
            ImageInput(getImage: _getImage),
            const SizedBox(height: 16),
            const LocationInput(),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
