import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Player.dart';
import 'package:tic_tac_toe/Tile.dart';
import 'package:tic_tac_toe/TileGroup.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  num _moves = 0;
  bool _gameOver = false;
  num _activePlayer;
  Player _winner;

  List<Tile> _tiles;
  List<Player> _players;
  List<TileGroup> _tileGroups;
  List<TileGroup> _winningGroups;

  @override
  void initState() {
    super.initState();
    _tiles = _initializeTiles();
    _tileGroups = _initializeTileGroups(_tiles);
    _winningGroups = <TileGroup>[];
    _players = _initializePlayers();
    _activePlayer = 0;
  }

  List<Tile> _initializeTiles() {
    return <Tile>[
      Tile(1),
      Tile(2),
      Tile(3),
      Tile(4),
      Tile(5),
      Tile(6),
      Tile(7),
      Tile(8),
      Tile(9),
    ];
  }

  List<TileGroup> _initializeTileGroups(List<Tile> tiles) {
    return <TileGroup>[
      TileGroup(<Tile>[tiles[0], tiles[1], tiles[2]]),
      TileGroup(<Tile>[tiles[0], tiles[3], tiles[6]]),
      TileGroup(<Tile>[tiles[0], tiles[4], tiles[8]]),
      TileGroup(<Tile>[tiles[1], tiles[4], tiles[7]]),
      TileGroup(<Tile>[tiles[2], tiles[5], tiles[8]]),
      TileGroup(<Tile>[tiles[3], tiles[4], tiles[5]]),
      TileGroup(<Tile>[tiles[6], tiles[4], tiles[2]]),
      TileGroup(<Tile>[tiles[6], tiles[7], tiles[8]]),
    ];
  }

  List<Player> _initializePlayers() {
    return <Player>[
      Player(1, Colors.blue, 'images/cross.png'),
      Player(2, Colors.red, 'images/circle.png')
    ];
  }

  Function _handleTilePress(Tile tile) {
    return () {
      if (_gameOver) {
        _handleReset();
        return;
      }
      this.setState(() {
        if (tile.owner == null) {
          _moves++;
          tile.setOwner(_players[_activePlayer]);

          for (var tg in _tileGroups) {
            if (tg.containsTile(tile.id) && !tg.cannotBeWon) {
              if (tg.winConditionMet()) _winningGroups.add(tg);

              if (_winningGroups.length > 0) {
                _winner = _players[_activePlayer];
                _gameOver = true;
              }
            }
          }

          if (_moves == _tiles.length && _winner == null) _gameOver = true;
          if (!_gameOver) _activePlayer = _activePlayer == 0 ? 1 : 0;
        }
      });
    };
  }

  Function _handleReset() {
    setState(() {
      _tiles = _initializeTiles();
      _tileGroups = _initializeTileGroups(_tiles);
      _winningGroups = <TileGroup>[];
      _players = _initializePlayers();
      _activePlayer = 0;
      _moves = 0;
      _gameOver = false;
      _winner = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(9.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 9,
                mainAxisSpacing: 9
              ),
              itemCount: _tiles.length,
              itemBuilder: (t, i) => new SizedBox(
                height: 100,
                width: 100,
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: _handleTilePress(_tiles[i]),
                  child: Container(
                    padding: EdgeInsets.all(9.0),
                    decoration: BoxDecoration(
                      color: _tiles[i].owner == null ? Colors.transparent : _tiles[i].owner.color
                    ),
                    child: _tiles[i].owner == null ? null : _tiles[i].owner.marker,
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
