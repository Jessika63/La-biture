import 'bonus_effect.dart';

class Player {
  Player(this.name);

  final String name;
  final List<BonusEffect> bonusInventory = [];
  bool immuneToNextMalus = false;
  int totalSipsDrunk = 0;
  int totalCulSecs = 0;
}
