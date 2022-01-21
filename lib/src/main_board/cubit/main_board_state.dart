part of 'main_board_cubit.dart';

@freezed
class MainBoardState with _$MainBoardState {
  const factory MainBoardState({
    @Default(false) bool isLoading,
    @Default([]) List<List<int>> sudokuList,
  }) = _MainBoardState;

  factory MainBoardState.initial() => const _MainBoardState();
}
