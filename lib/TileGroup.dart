import 'package:tic_tac_toe/Tile.dart';

class TileGroup {
  final List<Tile> tiles;
  TileGroup(this.tiles);

  bool cannotBeWon = false;

  bool winConditionMet () {
    if (cannotBeWon) return false;
    num owner;
    for(var t in tiles) {
      {
        if (t.owner == null) return false;
        if (owner == null) {
          owner = t.owner.id;
        } else {
          if (owner != t.owner.id) {
            cannotBeWon = true;
            return false;
          }
        }
      }
    }
    return true;
  }

  bool containsTile(num tileId) {
    for(var t in tiles) {
      if (t.id == tileId) {
        return true;
      }
    }
    return false;
  }
}