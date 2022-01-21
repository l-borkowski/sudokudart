import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sudokudart/src/main_board/main_board.dart';
import 'package:sudokudart/src/main_board/sudoku_generator.dart';

part 'main_board_state.dart';
part 'main_board_cubit.freezed.dart';

@injectable
class MainBoardCubit extends Cubit<MainBoardState> {
  MainBoardCubit() : super(MainBoardState.initial());

  void init() async {
    newSudoku();
    emit(state.copyWith(isLoading: false));
  }

  void newSudoku() {
    final _list = SudokuGenerator(emptySquares: 40).newSudoku;
    emit(state.copyWith(sudokuList: _list));
  }

  void increaseNumber(Position position) {
    var _copiedList = state.sudokuList;
    var _selectedSquare = state.sudokuList[position.x][position.y];
    if (_selectedSquare == 9) {
      _selectedSquare = 0;
    } else {
      _selectedSquare++;
    }
    _copiedList[position.x][position.y] = _selectedSquare;
    emit(state.copyWith(sudokuList: List.from(_copiedList)));
  }
}
