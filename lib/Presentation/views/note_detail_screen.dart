import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc/Presentation/views/home_screen.dart';
import 'package:zefyrka/zefyrka.dart';

class NoteDetailScreen extends StatefulWidget {
  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  ZefyrController controller = ZefyrController();
  bool editable = true;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPress(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text('title'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.delete_outlined)),
            IconButton(
                onPressed: () {
                  setState(() {
                    editable = !editable;
                    print(editable);
                  });
                },
                icon: Icon(Icons.edit_outlined)),
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
              padding: EdgeInsets.all(10),
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
            title: Text('Alert! are sure to Exit??'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('cancle')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .popUntil((Route route) => route.settings.name == '/');
                  },
                  child: Text('save and exit')),
            ],
          ),
        )) ??
        false;
  }
}
