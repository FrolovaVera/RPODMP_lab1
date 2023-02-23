import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/app_cubit_cubit.dart';
import 'package:notes/data/models/note_model.dart';

class CreateNoteScreen extends StatefulWidget {
  final AppCubitCubit cubit;
  const CreateNoteScreen({super.key, required this.cubit});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final controller = TextEditingController();
  final noteController = TextEditingController();
  Color _color = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {//шапка для создания записи
    return AppBar(
      title: const Text(
        'Create new note',
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Title',//заголовок
              textAlign: TextAlign.start,
              style:TextStyle(color: Colors.brown,fontSize: 20, fontWeight: FontWeight.bold)
          ),

          TextField(
            controller: controller,
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),

          const SizedBox(height: 30),
          const Text('Note',//запись
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
              TextButton(//цвета
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
                     onPressed: () async {//описывает действия при нажатии
                       if (controller.text.isEmpty || noteController.text.isEmpty) {
                         ScaffoldMessenger.of(context).clearSnackBars();
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(
                             content: Text('Fill all the fields'),
                           ),
                         );
                         return;
                       }
                       await widget.cubit.createNewNote(NoteModel(//передаваемые значения
                         id: 0,
                         title: controller.text,
                         content: noteController.text,
                         dateTime: DateTime.now(),
                         color: _color,
                         )
                       );

                       if (mounted) Navigator.of(context).pop();
                    },

                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.brown)),
                    child: const Text('Create note',
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
