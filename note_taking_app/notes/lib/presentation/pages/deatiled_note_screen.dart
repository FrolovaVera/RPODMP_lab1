import 'package:flutter/material.dart';
import 'package:notes/data/models/note_model.dart';

class DetailedNoteScreen extends StatelessWidget {
  final NoteModel note;
  const DetailedNoteScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
      title: Text(
        note.title,
      ),
      actions: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              note.dateTime.toString(),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBody() {
    return Text(
      note.content,
      style: const TextStyle(fontSize: 25),
    );
  }
}
