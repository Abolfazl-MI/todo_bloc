import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zefyrka/zefyrka.dart';

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({Key? key}) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  ZefyrController controller = ZefyrController();
  bool editable = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPress(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('title'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete_outlined)),
            IconButton(
                onPressed: () {
                  setState(() {
                    editable = !editable;
                    print(editable);
                  });
                },
                icon: const Icon(Icons.edit_outlined)),
          ],
        ),
        body: Column(
          children: [
            ZefyrToolbar.basic(
              controller: controller,
            ),
            ZefyrEditor(
              controller: controller,
              readOnly: false,
              autofocus: true,
              showCursor: true,
              padding: const EdgeInsets.all(10),
              scrollable: true,
              focusNode: FocusNode(
                canRequestFocus: true,
              ),
            )
          ],
        ),
      ),
    );
  }

// change update models
  Future<bool> _onBackPress(BuildContext context) async {
    return (await showCupertinoModalPopup(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Alert! are sure to Exit??'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('cancle')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil((Route route) => route.settings.name == '/');
                  },
                  child: const Text('save and exit')),
            ],
          ),
        )) ??
        false;
  }
}
