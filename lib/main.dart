import 'package:flutter/material.dart';
import 'package:lab2/ChessBoard.dart' as chessboard;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Queens Demo',
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select board size'),
      ),
      body: Column(children: [
        for (var n in [4, 5, 6, 7, 8, 9, 10, 15])
          Center(
              child: TextButton(
            child: Text('Size = $n'),
            onPressed: () => _showResN(context, n),
          )),
      ]),
    );
  }

  _showResN(BuildContext context, int number) {
    var board = chessboard.ChessBoard(number);
    board.Solve();
    final res = board.solutions;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Scaffold(
                  body: ResPage(number, res),
                )));
  }
}

class ResPage extends StatelessWidget {
  final int _n;
  final _sol;
  ResPage(this._n, this._sol);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${(_sol as List).length} results for size$_n'),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: (_sol as List).length,
          itemBuilder: (context, i) => _boardItem(_sol[i])),
    );
  }

  Widget _boardItem(oneSol) {
    return Center(
        child: Column(
      children: [
        for (var y in oneSol)
          Row(
              children: List.generate(
                  _n,
                  (k) => Center(
                      heightFactor: 2,
                      widthFactor: 2,
                      child: Icon(
                        y[k] == 1 ? Icons.star : Icons.star_border,
                        color: (oneSol.indexOf(y) + k) % 2 == 0
                            ? Colors.brown
                            : const Color.fromARGB(255, 238, 211, 164),
                      ))))
      ],
    ));
  }
}
