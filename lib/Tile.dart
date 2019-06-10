import 'package:tic_tac_toe/Player.dart';

class Tile {
  final num id;
  Player owner;

  Tile(this.id);

  void setOwner(Player player) {
    if (owner == null) {
      owner = player;
    }
  }
}
