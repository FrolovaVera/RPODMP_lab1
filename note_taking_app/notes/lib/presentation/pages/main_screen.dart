import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/app_cubit_cubit.dart';
import 'package:notes/data/models/note_model.dart';
import 'package:notes/presentation/pages/create_note_screen.dart';

import '../widgets/note_card.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final controller = TextEditingController();
  bool _isSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFab(
        context,
        BlocProvider.of<AppCubitCubit>(context),
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar() {//кнопка редактирования
    return AppBar(
      leading: const Icon(Icons.folder_shared_outlined
      ),
      centerTitle: true,
        title: TextField(
        controller: controller,
        ),
      actions: [
        _buildSearchBtn(),
      ],
    );
  }

  Widget _buildSearchBtn() {//поиск в баннере
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        if (controller.text.isEmpty) {
          BlocProvider.of<AppCubitCubit>(context).getNotes();
        } else {
          BlocProvider.of<AppCubitCubit>(context).searchByString(controller.text);
        }
      },
      child: const Icon(
        Icons.search,
        size: 25,
      ),
    );
  }

  Widget _buildBody() {//тело приложения
    return BlocBuilder<AppCubitCubit, AppCubitState>(
      builder: (context, state) {
        if (state is ListChanged) {
          final notes = state.notes;
          return ListView.separated(//список записей
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteCard(
                cubit: BlocProvider.of<AppCubitCubit>(context),
                note: NoteModel(
                  id: note.id,
                  title: note.title,
                  color: note.color,
                  content: note.content,
                  dateTime: note.dateTime,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }

  Widget _buildFab(BuildContext context, AppCubitCubit cubit) {//кнопка добавления
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateNoteScreen(
              cubit: cubit,
            ),
          ),
        );
      },
    );
  }
}
