import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/app_cubit_cubit.dart';
import 'package:notes/data/models/note_model.dart';

class EditNoteScreen extends StatefulWidget {
  final AppCubitCubit cubit;
  final NoteModel note;
  const EditNoteScreen({super.key, required this.cubit, required this.note});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final controller = TextEditingController();
  final noteController = TextEditingController();
  Color _color = Colors.green;

  @override
  void initState() {//передача нужных пареметров
    controller.text = widget.note.title;
    noteController.text = widget.note.content;
    _color = widget.note.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {
    return AppBar(
      title: const Text(
        'Update note',
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Title',
            textAlign: TextAlign.start,
              style:TextStyle(color: Colors.brown,fontSize: 20, fontWeight: FontWeight.bold)
          ),

          TextField(
            controller: controller,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),

          const SizedBox(height: 30),
          const Text('Note',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.brown, fontSize: 20, fontWeight: FontWeight.bold)
          ),

          TextField(
            minLines: 14,
            maxLines: 14,
            controller: noteController,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),

          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  _color = Colors.green;
                },
                child: const Text('Green',
                  style: TextStyle(color: Colors.brown,fontSize: 17),
                ),
              ),
              TextButton(
                onPressed: () {
                  _color = Colors.amberAccent;
                },
                child: const Text('Yellow',
                  style: TextStyle(color: Colors.brown,fontSize: 17),
                ),
              ),
              TextButton(
                onPressed: () {
                  _color = Colors.blue;
                },
                child: const Text('Blue',
                  style: TextStyle(color: Colors.brown,fontSize: 17),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Container(height: 55,width: 200,
        child: TextButton(
            onPressed: () async {
              if (controller.text.isEmpty || noteController.text.isEmpty) {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fill all the fields'),
                  ),
                );
                return;
              }
              await widget.cubit.editNoteById(
                  widget.note.id,
                  NoteModel(
                    id: 0,
                    title: controller.text,
                    content: noteController.text,
                    dateTime: DateTime.now(),
                    color: _color,
                  ));
              if (mounted) Navigator.of(context).pop();
            },
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown)),

          child: const Text('Update note',
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        ],
      ),
      ],
    ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    noteController.dispose();
    super.dispose();
  }
}
