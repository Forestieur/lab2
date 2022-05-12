// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:collection/collection.dart';

class ChessBoard {
  ChessBoard(int inputSize) {
    size = inputSize;
    CreateBoard();
  }

  int? size;
  int count = 0;
  List<List<int>>? board;
  var Queen = 1;
  var solutions;

  CreateBoard() {
    board = List.generate(size!, (i) => List.filled(size!, 0, growable: false),
        growable: false);
    solutions = List.generate(
        725,
        (i) => List.generate(
            size!, (j) => List.filled(size!, 0, growable: false),
            growable: false),
        growable: true);
  }

  CheckResult() {
    // check for sum of elements is 8
    var summary = 0;
    for (int i = 0; i < size!; i++) {
      summary += board![i].sum;
    }
    if (summary != size) return 1;

    // check for sum of elements of every row is <=1
    for (int i = 0; i < size!; i++) {
      if (board![i].sum > 1) return 1;
    }

    // check for sum of elements of every column is <=1
    var sumCol = 0;
    for (int i = 0; i < size!; i++) {
      sumCol = 0;
      for (int j = 0; j < size!; j++) {
        sumCol = sumCol + board![j][i];
      }
      if (sumCol > 1) return 1;
    }

    // check for sum of elements of every diagonal is <=1
    var diagonalSum = 0;

    int j;
    int row;
    int column;
    for (int i = 1; i < size!; i++) {
      j = 0;
      row = i;
      do {
        diagonalSum += board![row][j];
        row--;
        j++;
      } while (row >= 0);
      if (diagonalSum > 1) return 1;
      diagonalSum = 0;
    }

    int i;
    for (int j = 1; j < size!; j++) {
      i = size! - 1;
      column = j;

      do {
        diagonalSum += board![i][column];
        i--;
        column++;
      } while (i >= 0 && column <= size! - 1);
      if (diagonalSum > 1) return 1;
      diagonalSum = 0;
    }
    for (int j = 0; j < size!; j++) {
      i = 0;
      column = j;

      do {
        diagonalSum += board![i][column];
        i++;
        column++;
      } while (i <= size! - 1 && column <= size! - 1);
      if (diagonalSum > 1) return 1;
      diagonalSum = 0;
    }

    for (int i = size! - 2; i >= 0; i--) {
      j = 0;
      row = i;

      do {
        diagonalSum += board![row][j];
        row++;
        j++;
      } while (row <= size! - 1);
      if (diagonalSum > 1) return 1;
      diagonalSum = 0;
    }

    return 0;
  }

  Recursion(int row) {
    if (!(row < size!)) {
      return;
    }

    for (int column_n = 0; column_n < size!; column_n++) {
      if (board![row][column_n] == 0) {
        board![row][column_n] = Queen;

        if (row == size! - 1) {
          if (CheckResult() == 0) {
            for (int i = 0; i < size!; i++) {
              for (int j = 0; j < size!; j++) {
                solutions?[count][i][j] = board![i][j];
              }
            }
            count++;
            print(count);
          }
        }
        Recursion(row + 1);
        board![row][column_n] = 0;
      }
    }
  }

  Solve() {
    Recursion(0);
    solutions.removeRange(count, solutions.length);
  }
}
