/// Malus tiré avec une capote trouée : à faire avant de lire la bite choisie.
class MalusCard {
  const MalusCard({
    required this.id,
    required this.action,
    this.sips,
    this.discardsBonus = false,
  });

  final String id;
  final String action;

  /// Optionnel : certains malus imposent aussi de boire directement (en cdr).
  final int? sips;

  /// Si vrai, retire une capote saine (bonus) de l'inventaire du joueur, s'il en a une.
  final bool discardsBonus;
}
