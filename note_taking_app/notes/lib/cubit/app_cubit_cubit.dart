import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:notes/data/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

part 'app_cubit_state.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  final Database db;

  AppCubitCubit(this.db) : super(ListChanged(const [])) {
    getNotes();
  }

  void searchByString(String searchString) {//поиск
    if (state is ListChanged) {
      final list = (state as ListChanged).notes;
      final searched = list.where((element) => element.title.contains(searchString));
      emit(ListChanged(searched.toList()));
    }
  }

  Future<void> getNotes() async {//отображение записей
    final rawData = await db.query(
      'notes',
    );

    final notesList = List<NoteModel>.generate(
      rawData.length,
      (index) => NoteModel.fromMap(rawData[index]),
    );

    emit(ListChanged(notesList));
  }

  Future<void> createNewNote(NoteModel newNote) async {//добавление
    await db.insert(
      'notes',
      newNote.toMap(),
    );

    await getNotes();
  }

  Future<void> deleteNoteById(int id) async {//удаление
    await db.delete(
      'notes',
      where: 'id=?',
      whereArgs: [id],
    );

    await getNotes();
  }

  Future<void> editNoteById(int id, NoteModel editedNote) async {//редактирование
    await db.update(
      'notes',
      editedNote.toMap(),
      where: 'id=?',
      whereArgs: [id],
    );

    await getNotes();
  }
}
