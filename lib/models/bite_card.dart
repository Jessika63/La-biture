enum BiteSize { grosse, petite }

extension BiteSizeInfo on BiteSize {
  String get label => this == BiteSize.grosse ? "Grosse bite" : "Petite bite";

  BiteSize get opposite =>
      this == BiteSize.grosse ? BiteSize.petite : BiteSize.grosse;
}

class BiteCard {
  const BiteCard({
    required this.id,
    required this.size,
    required this.action,
    this.sips,
    this.culSec = false,
  }) : assert(culSec || sips != null, 'Une carte doit avoir des cdr ou être un cul sec');

  final String id;
  final BiteSize size;
  final String action;

  /// Nombre de cdr (coups de rein), `null` si [culSec] est vrai.
  final int? sips;

  /// Si vrai, remplace le nombre de cdr par "cul sec".
  final bool culSec;

  String get sipsLabel => culSec ? "Cul sec" : "$sips cdr";
}
