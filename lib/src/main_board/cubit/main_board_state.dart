part of 'main_board_cubit.dart';

@freezed
class MainBoardState with _$MainBoardState {
  const factory MainBoardState({
    @Default(false) bool isLoading,
    @Default(false) bool isCorrectSudoku,
    @Default(false) bool showToast,
    @Default([]) List<List<int>> sudokuList,
    @Default([]) List<List<int>> startingList,
    @Default([]) List<List<int>> solvedList,
    @Default(40) int numberOfSquares,
    String? error,
  }) = _MainBoardState;

  factory MainBoardState.initial() => const _MainBoardState();
}
