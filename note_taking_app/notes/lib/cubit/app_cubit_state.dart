part of 'app_cubit_cubit.dart';

@immutable
abstract class AppCubitState extends Equatable {}

class ListChanged extends AppCubitState {
  final List<NoteModel> notes;

  ListChanged(this.notes);

  @override
  List<Object?> get props => [notes];
}
