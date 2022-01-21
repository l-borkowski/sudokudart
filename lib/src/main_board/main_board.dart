import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sudokudart/injection.dart';
import 'package:sudokudart/src/main_board/cubit/main_board_cubit.dart';

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
class MainBoard extends StatefulWidget {
  const MainBoard({
    Key? key,
  }) : super(key: key);

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainBoardCubit>();
    final state = context.watch<MainBoardCubit>().state;
    final board = state.sudokuList;
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
            Wrap(
              runSpacing: 10,
              children: [
                for (var i = 0; i < state.sudokuList.length; i++)
                  for (var j = 0; j < state.sudokuList.elementAt(i).length; j++)
                    _NumberTile(
                      number: state.sudokuList[i][j],
                      onTap: () => cubit.increaseNumber(Position(i, j)),
                      unchangeable: board[i][j] != 0,
                    ),
              ],
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () => cubit.newSudoku(),
              child: Text('New gane'),
            )
          ],
        ),
      ),
    );
  }
}

class _NumberTile extends StatefulWidget {
  const _NumberTile({
    Key? key,
    required this.number,
    required this.onTap,
    required this.unchangeable,
  }) : super(key: key);

  final int number;
  final VoidCallback onTap;
  final bool unchangeable;

  @override
  State<_NumberTile> createState() => _NumberTileState();
}

class _NumberTileState extends State<_NumberTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.unchangeable ? () {} : widget.onTap,
      child: Container(
        height: 30,
        width: 30,
        color: Colors.grey,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Center(
          child: Text(
            widget.number == 0 ? '' : widget.number.toString(),
            style: TextStyle(
                fontWeight: widget.unchangeable ? FontWeight.bold : null),
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
