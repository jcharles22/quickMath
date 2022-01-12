import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scores_cubit_state.dart';

class ScoresCubitCubit extends Cubit<ScoresCubitState> {
  ScoresCubitCubit() : super(ScoresCubitInitial());
}
