import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobile_application/app/storage/firebase_storage/storage.dart';
import 'package:file_picker/file_picker.dart';

/*
 * Page for testing interaction with firebase cloudstorage.
 */
class StorageView extends StatefulWidget {
  const StorageView({super.key});

  @override
  StorageState createState() => StorageState();
}

class StorageState extends State<StorageView> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase cloud storage"),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final results = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['png', 'jpg'],
                );

                if (results == null) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No file selected")));
                  return;
                }

                final path = results.files.single.path!;
                final filename = results.files.single.name;

                storage.uploadFile(path, filename);
              },
              child: const Text("Upload file"),
            ),
          ),
          FutureBuilder(
              future: storage.listFiles(),
              builder:
                  (BuildContext context, AsyncSnapshot<ListResult> snapShot) {
                if (snapShot.hasError) {
                  return const Text("Something went wrong");
                }
                else if (snapShot.connectionState == ConnectionState.done &&
                    snapShot.hasData) {
                  return SizedBox(
                    height: 50,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: snapShot.data!.items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                snapShot.data!.items[index].name,
                              ),
                            ),
                          );
                        }),
                  );
                } else if (snapShot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Container();
                }
              }),
          FutureBuilder(
              future: storage.downloadURL('test/test-image.jpg'),
              builder:
                  (BuildContext context, AsyncSnapshot<String> snapShot) {
                if (snapShot.connectionState == ConnectionState.done &&
                    snapShot.hasData) {
                  return SizedBox(
                    width: 300,
                    height: 250,
                    child: Image.network(
                      snapShot.data!,
                      fit: BoxFit.cover,
                    ),
                  );
                } else if (snapShot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }
}
