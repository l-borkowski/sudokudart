import 'dart:convert';

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
    emit(state.copyWith(
      isLoading: true,
      error: null,
    ));
    newSudoku();
    emit(state.copyWith(isLoading: false));
  }

  void newSudoku() {
    final sudoku = Sudoku(emptySquares: state.numberOfSquares);
    final _list = sudoku.newSudoku;
    final _solvedList = sudoku.sudokuSolved;
    emit(state.copyWith(
      sudokuList: _list,
      startingList: deepCopy(_list),
      solvedList: _solvedList,
    ));
  }

  void numberChanges(String text) {
    try {
      emit(state.copyWith(
        error: null,
      ));
      final newNumber = int.parse(text);
      if (newNumber > 0 && newNumber < 70) {
        emit(state.copyWith(numberOfSquares: newNumber));
      } else {
        emit(state.copyWith(error: 'Number out of range'));
      }
    } catch (e) {
      throw Exception();
    }
  }

  void showSolution() {
    emit(state.copyWith(
      sudokuList: state.solvedList,
    ));
  }

  void checkSudoku() {
    emit(state.copyWith(
      showToast: true,
      error: null,
    ));
    final isEqual = Sudoku.isSolved(state.sudokuList);
    if (isEqual) {
      emit(state.copyWith(isCorrectSudoku: true));
    } else {
      emit(state.copyWith(isCorrectSudoku: false));
    }
    emit(state.copyWith(showToast: false));
  }

  void increaseNumber(Position position) {
    if (isChangeable(position.x, position.y)) {
      var _copiedList = state.sudokuList;
      var _selectedSquare = state.sudokuList[position.x][position.y];
      if (_selectedSquare == 9) {
        _selectedSquare = 0;
      } else {
        _selectedSquare++;
      }
      _copiedList[position.x][position.y] = _selectedSquare;
      emit(state.copyWith(sudokuList: [[]]));
      emit(state.copyWith(sudokuList: _copiedList));
    }
  }

  void decreaseNumber(Position position) {
    if (isChangeable(position.x, position.y)) {
      var _copiedList = state.sudokuList;
      var _selectedSquare = state.sudokuList[position.x][position.y];
      if (_selectedSquare == 0) {
        _selectedSquare = 9;
      } else {
        _selectedSquare--;
      }
      _copiedList[position.x][position.y] = _selectedSquare;
      emit(state.copyWith(sudokuList: [[]]));
      emit(state.copyWith(sudokuList: _copiedList));
    }
  }

  List<List<int>> deepCopy(List<List<int>> source) {
    return source.map((e) => e.toList()).toList();
  }

  bool isChangeable(x, y) => state.startingList[x][y] == 0;

  bool? shouldChangeColor(x, y) {
    if (x >= 0 && x < 3 && y > 2 && y < 6) {
      return true;
    } else if (x >= 3 && x < 6 && ((y >= 0 && y < 3) || (y >= 6 && y < 9))) {
      return true;
    } else if (x >= 6 && x < 9 && y > 2 && y < 6) {
      return true;
    }
  }
}
