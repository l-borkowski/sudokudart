import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sudokudart/injection.dart';
import 'package:sudokudart/src/hook/use_bloc_listener.dart';
import 'package:sudokudart/src/main_board/cubit/main_board_cubit.dart';
import 'package:sudokudart/src/widgets/toast.dart';

import '../settings/settings_view.dart';

class MainBoardPage extends StatelessWidget {
  const MainBoardPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBoardCubit>(
      create: (context) => getIt<MainBoardCubit>()..init(),
      child: const MainBoard(),
    );
  }
}

/// Displays a list of SampleItems.
class MainBoard extends HookWidget {
  const MainBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainBoardCubit>();
    final state = context.watch<MainBoardCubit>().state;
    final board = state.sudokuList;

    useCubitListener<MainBoardCubit, MainBoardState>(
      cubit,
      (state, context) {
        if (state.showToast) {
          Toast.show(
            Text(
              state.isCorrectSudoku == true
                  ? 'Sudoku solved correctly'
                  : 'Not this time, there\'re some mistakes',
            ),
          );
        }
        if (state.error != null) {
          Toast.show(
            const Text(
              'Only valid numbers are between 1 and 70',
            ),
          );
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            SizedBox(
              width: 9 * 40,
              child: Wrap(
                runSpacing: 10,
                children: [
                  for (var i = 0; i < board.length; i++)
                    for (var j = 0; j < board.elementAt(i).length; j++)
                      _NumberTile(
                        number: board[i][j],
                        onTap: () => cubit.increaseNumber(Position(i, j)),
                        onSecondaryTap: () =>
                            cubit.decreaseNumber(Position(i, j)),
                        p: Position(i, j),
                        darkerTile: cubit.shouldChangeColor(i, j) ?? false,
                      ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: cubit.newSudoku,
              child: const Text('New gane'),
            ),
            TextButton(
              onPressed: cubit.checkSudoku,
              child: const Text('Check'),
            ),
            TextButton(
              onPressed: cubit.showSolution,
              child: const Text('Show solution'),
            ),
            const SizedBox(height: 10),
            const Text('Number of empty squares'),
            SizedBox(
              width: 50,
              child: TextField(
                textAlign: TextAlign.center,
                onChanged: cubit.numberChanges,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _NumberTile extends StatelessWidget {
  const _NumberTile(
      {Key? key,
      required this.number,
      required this.onTap,
      required this.onSecondaryTap,
      required this.p,
      required this.darkerTile})
      : super(key: key);

  final int number;
  final VoidCallback onTap;
  final VoidCallback onSecondaryTap;
  final Position p;
  final bool darkerTile;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainBoardCubit>();
    final isChangeable = cubit.isChangeable(p.x, p.y);
    return GestureDetector(
      onTap: onTap,
      onSecondaryTap: onSecondaryTap,
      child: Container(
        height: 30,
        width: 30,
        color: darkerTile
            ? Colors.grey.withOpacity(0.9)
            : Colors.grey.withOpacity(0.5),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            number == 0 ? '' : number.toString(),
            style: TextStyle(
              fontWeight: isChangeable ? null : FontWeight.bold,
              color: isChangeable ? ThemeData().hintColor : null,
            ),
          ),
        ),
      ),
    );
  }
}

class Position {
  const Position(this.x, this.y);

  final int x;
  final int y;
}
