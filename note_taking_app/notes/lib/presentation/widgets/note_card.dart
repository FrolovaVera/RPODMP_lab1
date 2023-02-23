import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/app_cubit_cubit.dart';
import 'package:notes/data/models/note_model.dart';
import 'package:notes/presentation/pages/deatiled_note_screen.dart';
import 'package:notes/presentation/pages/edit_note_screen.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final AppCubitCubit cubit;

  const NoteCard({super.key, required this.note, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailedNoteScreen(
              note: note,
            ),
          ),
        );
      },
      leading: Icon(
        Icons.folder_shared,
        color: note.color,
      ),
      title: Text(
        note.title,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.brown
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditNoteScreen(
                    cubit: cubit,
                    note: note,
                  ),
                ),
              );
            },
            child: const Icon(Icons.edit),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<AppCubitCubit>(context).deleteNoteById(note.id);
            },
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
