import '../models/malus_card.dart';

/// Malus (capote trouée) : à faire AVANT de lire la bite tirée.
final List<MalusCard> malusCards = [
  const MalusCard(
    id: 'malus_1',
    action: "Enlève un vêtement de ton choix",
  ),
  const MalusCard(
    id: 'malus_2',
    action: "Donne 3 cdr de ton verre à la personne à ta droite",
    sips: 3,
  ),
  const MalusCard(
    id: 'malus_3',
    action: "Tu dois parler avec un accent pendant les 3 prochains tours",
  ),
  const MalusCard(
    id: 'malus_4',
    action: "Échange ta place avec un autre joueur",
  ),
  const MalusCard(
    id: 'malus_5',
    action: "Les autres joueurs doivent choisir le prochain verre que tu te sers",
  ),
  const MalusCard(
    id: 'malus_6',
    action: "Ton oncle passe par là",
    sips: 4,
  ),
  const MalusCard(
    id: 'malus_7',
    action: "L'hôte de la soirée prend 6 cdr, ça lui apprendra à ranger tiens",
    sips: 6,
  ),
  const MalusCard(
    id: 'malus_8',
    action:
        "Ton partenaire t'annonce qu'il/elle a une MST : défausse une de tes capotes saines si tu en as une",
    discardsBonus: true,
  ),
  const MalusCard(
    id: 'malus_9',
    action: "Yarr !!! Tout le monde prend 3 cdr",
    sips: 3,
  ),
  const MalusCard(
    id: 'malus_10',
    action: "Lève-toi et fais 10 tours sur toi-même",
  ),
  const MalusCard(
    id: 'malus_11',
    action: "Échange ton verre avec celui du joueur à ta gauche",
  ),
  const MalusCard(
    id: 'malus_12',
    action: "Tu dois finir ton verre actuel avant de continuer",
  ),
  const MalusCard(
    id: 'malus_13',
    action: "Le joueur à ta droite décide de ta prochaine boisson",
  ),
  const MalusCard(
    id: 'malus_14',
    action: "Capote fantôme : perds une de tes capotes saines si tu en as une",
    discardsBonus: true,
  ),
  const MalusCard(
    id: 'malus_15',
    action: "Porte tes vêtements à l'envers jusqu'à ton prochain tour",
  ),
  const MalusCard(
    id: 'malus_16',
    action: "Tu ne peux plus dire ton propre prénom pour le reste de la partie (1 cdr par oubli)",
  ),
  const MalusCard(
    id: 'malus_17',
    action: "Distribue 4 cdr à la personne de ton choix",
    sips: 4,
  ),
  const MalusCard(
    id: 'malus_18',
    action: "Tu dois grimacer à chaque cdr que tu bois jusqu'à ton prochain tour",
  ),
  const MalusCard(
    id: 'malus_19',
    action: "Le groupe choisit une punition improvisée pour toi",
  ),
  const MalusCard(
    id: 'malus_20',
    action: "Saute 3 fois en criant le nom du jeu avant de continuer",
  ),
];
