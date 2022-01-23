class Sudoku {
  /// Sudoku constructor with default value of 30 empty squares
  ///
  /// [emptySquares] specifies how many boxes should be left empty
  Sudoku({int emptySquares = 30}) {
    _emptySquares = emptySquares;
    _sudoku = List.generate(9, (i) => List.generate(9, (j) => 0));
    _fillValues();
  }

  late int _emptySquares;
  late List<List<int>> _sudoku;
  late List<List<int>> _sudokuSolved;

  ///Unsolved sudoke is stored there
  List<List<int>> get newSudoku => _sudoku;

  ///Solved sudoku is stored here
  List<List<int>> get sudokuSolved => _sudokuSolved;

  ///Function to create new sudoku
  void _fillValues() {
    _fillDiagonal();
    _fillRemaining(0, 3);
    _sudokuSolved = _sudoku.map((e) => e.toList()).toList();
    _removeClues();
  }

  ///Loop that goes throught diagonal axis boxes that a're 3x3
  void _fillDiagonal() {
    for (var i = 0; i < 9; i += 3) {
      _fillBox(i, i);
    }
  }

  ///Fils 3x3 boxes while checking if number is used in box
  void _fillBox(int row, int column) {
    int number;
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        do {
          number = _randomGenerator();
        } while (!_unUsedInBox(row, column, number));
        _sudoku[row + i][column + j] = number;
      }
    }
  }

  ///Checks if number is used in box
  bool _unUsedInBox(int rowStart, int columnStart, int number) {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (_sudoku[rowStart + i][columnStart + j] == number) {
          return false;
        }
      }
    }
    return true;
  }

  ///Returns random number from shuffled list that contains numbers [1-9]
  static int _randomGenerator() {
    var numberList = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9]..shuffle();
    return numberList[0];
  }

  ///Checks if it's safe to place number in selected square
  bool _checkIfSafe(int i, int j, int number) =>
      (_unUsedInRow(i, number) && _unUsedInColumn(j, number)) &&
      _unUsedInBox(i - (i % 3), j - (j % 3), number);

  bool _unUsedInRow(int i, int number) {
    for (var j = 0; j < 9; j++) {
      if (_sudoku[i][j] == number) {
        return false;
      }
    }
    return true;
  }

  bool _unUsedInColumn(int j, int number) {
    for (var i = 0; i < 9; i++) {
      if (_sudoku[i][j] == number) {
        return false;
      }
    }
    return true;
  }

  /// Fils remaining boxes and checks if all boxes are already filled
  /// or is already filled diagonal or if inputed number is valid
  bool _fillRemaining(int i, int j) {
    if ((j >= 9) && (i < (9 - 1))) {
      i = i + 1;
      j = 0;
    }
    if ((i >= 9) && (j >= 9)) {
      return true;
    }
    if (i < 3) {
      if (j < 3) {
        j = 3;
      }
    } else {
      if (i < (9 - 3)) {
        if (j == ((i ~/ 3) * 3)) {
          j = j + 3;
        }
      } else {
        if (j == (9 - 3)) {
          i = i + 1;
          j = 0;
          if (i >= 9) {
            return true;
          }
        }
      }
    }
    for (var number = 1; number <= 9; number++) {
      if (_checkIfSafe(i, j, number)) {
        _sudoku[i][j] = number;
        if (_fillRemaining(i, j + 1)) {
          return true;
        }
        _sudoku[i][j] = 0;
      }
    }
    return false;
  }

  ///Function that removes selected number of squares
  void _removeClues() {
    while (_emptySquares > 0) {
      var row = _randomGenerator() - 1;
      var column = _randomGenerator() - 1;
      while (_sudoku[row][column] == 0) {
        row = _randomGenerator() - 1;
        column = _randomGenerator() - 1;
      }

      _sudoku[row][column] = 0;
      _emptySquares--;
    }
  }

  ///Function that checks sudoku rules to provided sudoku list and return true
  ///if sudoku is solved otherwise false
  static bool isSolved(List<List<int>> sudoku) {
    if (!isValidConfiguration(sudoku)) {
      return false;
    }
    for (var i = 0; i < 9; i++) {
      if (sudoku[i].contains(0)) {
        return false;
      }
    }
    return true;
  }

  static bool isValidConfiguration(List<List<int?>> sudoku) {
    bool notInRow(List<List<int?>> sudoku, int rowNumber) {
      var numberSet = <int>{};
      for (var i = 0; i < 9; i++) {
        if (numberSet.contains(sudoku[rowNumber][i])) {
          return false;
        } else if (sudoku[rowNumber][i] != 0 && sudoku[rowNumber][i] != null) {
          numberSet.add(sudoku[rowNumber][i]!);
        }
      }
      return true;
    }

    bool notInColumn(List<List<int?>> sudoku, int columnNumber) {
      var numberSet = <int>{};
      for (var i = 0; i < 9; i++) {
        if (numberSet.contains(sudoku[i][columnNumber])) {
          return false;
        } else if (sudoku[i][columnNumber] != 0 &&
            sudoku[i][columnNumber] != null) {
          numberSet.add(sudoku[i][columnNumber]!);
        }
      }
      return true;
    }

    bool notInBox(List<List<int?>> sudoku, int startRow, int startColumn) {
      var numberSet = <int>{};
      for (var row = 0; row < 3; row++) {
        for (var column = 0; column < 3; column++) {
          if (numberSet
              .contains(sudoku[row + startRow][column + startColumn])) {
            return false;
          } else if (sudoku[row + startRow][column + startColumn] != 0 &&
              sudoku[row + startRow][column + startColumn] != null) {
            numberSet.add(sudoku[row + startRow][column + startColumn]!);
          }
        }
      }
      return true;
    }

    bool isValid(List<List<int?>> sudoku, int rowNumber, int columnNumber) =>
        notInRow(sudoku, rowNumber) &&
        notInColumn(sudoku, columnNumber) &&
        notInBox(
            sudoku, rowNumber - rowNumber % 3, columnNumber - columnNumber % 3);

    bool containsValidValues(List<List<int?>> sudoku) {
      var validValueSet = <int?>{1, 2, 3, 4, 5, 6, 7, 8, 9, 0, null};
      for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 9; j++) {
          if (!validValueSet.contains(sudoku[i][j])) {
            return false;
          }
        }
      }
      return true;
    }

    try {
      for (var i = 0; i < 9; i++) {
        for (var j = 0; j < 9; j++) {
          if (!isValid(sudoku, i, j)) {
            return false;
          }
        }
      }
    } on RangeError {
      return false;
    }

    if (!containsValidValues(sudoku)) {
      return false;
    }
    return true;
  }
}
