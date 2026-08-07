import '../models/bite_card.dart';

/// Règle rappel : petite bite = 1 à 4 cdr, grosse bite = 5 cdr à "cul sec".
final List<BiteCard> grosseBiteCards = [
  const BiteCard(
    id: 'grosse_1',
    size: BiteSize.grosse,
    action:
        "Pas de chance ! Tu dois agresser sexuellement le joueur à ta gauche (un conseil : bois)",
    sips: 8,
  ),
  const BiteCard(
    id: 'grosse_2',
    size: BiteSize.grosse,
    action: "Retiens ta respiration pendant 45 secondes",
    sips: 7,
  ),
  const BiteCard(
    id: 'grosse_3',
    size: BiteSize.grosse,
    action:
        "La personne à ta gauche doit te préparer une petite portion d'une recette improvisée avec les moyens à disposition (potentiellement dégueulasse)",
    sips: 9,
  ),
  const BiteCard(
    id: 'grosse_4',
    size: BiteSize.grosse,
    action: "Dessine sur ton corps une bite",
    sips: 5,
  ),
  const BiteCard(
    id: 'grosse_5',
    size: BiteSize.grosse,
    action: "Fais le tour de la table en imitant un animal de ton choix",
    culSec: true,
  ),
  const BiteCard(
    id: 'grosse_6',
    size: BiteSize.grosse,
    action: "Appelle ta mère pendant 1 minute en haut-parleur",
    culSec: true,
  ),
  const BiteCard(
    id: 'grosse_7',
    size: BiteSize.grosse,
    action:
        "Mets une photo de toi en story (si tu mets la Kiffance en musique, tu distribues un cul sec)",
    sips: 8,
  ),
  const BiteCard(
    id: 'grosse_8',
    size: BiteSize.grosse,
    action: "Fais un pile ou face : lèche la main de ton voisin (face = gauche, pile = droite)",
    sips: 6,
  ),
  const BiteCard(
    id: 'grosse_9',
    size: BiteSize.grosse,
    action:
        "Prends une cuillerée de la substance la plus piquante que vous possédez (tabasco, wasabi...)",
    sips: 5,
  ),
  const BiteCard(
    id: 'grosse_10',
    size: BiteSize.grosse,
    action: "Chaque joueur te met une pichenette dans l'épaule",
    culSec: true,
  ),
  const BiteCard(
    id: 'grosse_11',
    size: BiteSize.grosse,
    action:
        "Propose une nouvelle règle : si elle est validée par la majorité, tu réussis le défi et la règle est instaurée",
    sips: 5,
  ),
  const BiteCard(
    id: 'grosse_12',
    size: BiteSize.grosse,
    action: "DM ton ex",
    sips: 6,
  ),
  const BiteCard(
    id: 'grosse_13',
    size: BiteSize.grosse,
    action: "Tu dois boire un cdr par le nez (pas volée celle-là !)",
    sips: 7,
  ),
  const BiteCard(
    id: 'grosse_14',
    size: BiteSize.grosse,
    action: "Prends un shot de l'alcool le plus fort à votre disposition",
    sips: 5,
  ),
  const BiteCard(
    id: 'grosse_15',
    size: BiteSize.grosse,
    action:
        "Fais un pile ou face jusqu'à obtenir face : prends autant de cdr que de fois où tu as fait pile, et distribue le même nombre",
    sips: 6,
  ),
  const BiteCard(
    id: 'grosse_16',
    size: BiteSize.grosse,
    action: "Fais 20 pompes devant tout le monde",
    sips: 5,
  ),
  const BiteCard(
    id: 'grosse_17',
    size: BiteSize.grosse,
    action: "Chante une chanson d'amour à la personne à ta droite",
    sips: 6,
  ),
  const BiteCard(
    id: 'grosse_18',
    size: BiteSize.grosse,
    action: "Improvise un rap de 30 secondes sur un membre du groupe",
    sips: 6,
  ),
  const BiteCard(
    id: 'grosse_19',
    size: BiteSize.grosse,
    action: "Laisse le groupe choisir ta prochaine boisson (mélange autorisé)",
    culSec: true,
  ),
  const BiteCard(
    id: 'grosse_20',
    size: BiteSize.grosse,
    action: "Raconte ton pire moment de honte en public",
    sips: 5,
  ),
  const BiteCard(
    id: 'grosse_21',
    size: BiteSize.grosse,
    action: "Danse sans musique pendant 1 minute devant tout le monde",
    sips: 6,
  ),
  const BiteCard(
    id: 'grosse_22',
    size: BiteSize.grosse,
    action:
        "Le groupe choisit un surnom que tu dois utiliser pour le reste de la soirée (1 cdr à chaque oubli)",
    sips: 5,
  ),
  const BiteCard(
    id: 'grosse_23',
    size: BiteSize.grosse,
    action: "Fais deviner un mot par mime pendant 1 minute, sinon tu bois",
    culSec: true,
  ),
  const BiteCard(
    id: 'grosse_24',
    size: BiteSize.grosse,
    action: "Envoie un audio embarrassant à un ami",
    sips: 7,
  ),
  const BiteCard(
    id: 'grosse_25',
    size: BiteSize.grosse,
    action: "Bois ta prochaine tournée à l'envers (le dernier à finir boit un cdr de plus)",
    sips: 5,
  ),
  const BiteCard(
    id: 'grosse_26',
    size: BiteSize.grosse,
    action: "Laisse un joueur maquiller ton visage avec ce qu'il trouve",
    sips: 6,
  ),
  const BiteCard(
    id: 'grosse_27',
    size: BiteSize.grosse,
    action: "Raconte ton fantasme le plus bizarre",
    sips: 8,
  ),
  const BiteCard(
    id: 'grosse_28',
    size: BiteSize.grosse,
    action: "Fais un bras de fer avec la personne en face de toi, le perdant boit un cul sec",
    culSec: true,
  ),
  const BiteCard(
    id: 'grosse_29',
    size: BiteSize.grosse,
    action: "Imite un joueur de la table sans dire qui, les autres doivent deviner",
    sips: 5,
  ),
  const BiteCard(
    id: 'grosse_30',
    size: BiteSize.grosse,
    action: "Porte un vêtement d'un autre joueur jusqu'à la fin de ton prochain tour",
    sips: 6,
  ),
];

final List<BiteCard> petiteBiteCards = [
  const BiteCard(
    id: 'petite_1',
    size: BiteSize.petite,
    action: "Décris une de tes pires expériences au lit",
    sips: 2,
  ),
  const BiteCard(
    id: 'petite_2',
    size: BiteSize.petite,
    action: "Fais un compliment sincère à la personne en face de toi",
    sips: 1,
  ),
  const BiteCard(
    id: 'petite_3',
    size: BiteSize.petite,
    action: "Imite ton pire ami pendant 30 secondes",
    sips: 3,
  ),
  const BiteCard(
    id: 'petite_4',
    size: BiteSize.petite,
    action: "Bouffe une croquette (si y'en a pas, tant pis pour toi)",
    sips: 4,
  ),
  const BiteCard(
    id: 'petite_5',
    size: BiteSize.petite,
    action: "Enlève un vêtement (les chaussures ne comptent pas)",
    sips: 3,
  ),
  const BiteCard(
    id: 'petite_6',
    size: BiteSize.petite,
    action:
        "Le joueur à ta gauche choisit un joueur : tu dois verser une bonne louchée de son verre dans le tien",
    sips: 3,
  ),
  const BiteCard(
    id: 'petite_7',
    size: BiteSize.petite,
    action:
        "Le joueur à ta droite choisit un joueur : tu dois lui donner une critique très sincère",
    sips: 4,
  ),
  const BiteCard(
    id: 'petite_8',
    size: BiteSize.petite,
    action: "Dis qui, selon toi, suce le mieux",
    sips: 3,
  ),
  const BiteCard(
    id: 'petite_9',
    size: BiteSize.petite,
    action: "Envoie \"cc je joue à la biture\" à ton avant-dernier DM",
    sips: 4,
  ),
  const BiteCard(
    id: 'petite_10',
    size: BiteSize.petite,
    action: "Raconte une action gênante qui te hante",
    sips: 4,
  ),
  const BiteCard(
    id: 'petite_11',
    size: BiteSize.petite,
    action:
        "Tu dois boire avec ta main non dominante jusqu'à la fin de la partie (1 cdr à chaque fois qu'on te grille)",
    sips: 4,
  ),
  const BiteCard(
    id: 'petite_12',
    size: BiteSize.petite,
    action: "Syndrome du whisky dick : raconte ta prestation la plus gênante après avoir trop bu",
    sips: 4,
  ),
  const BiteCard(
    id: 'petite_13',
    size: BiteSize.petite,
    action: "Fais un compliment à chaque joueur de la table",
    sips: 2,
  ),
  const BiteCard(
    id: 'petite_14',
    size: BiteSize.petite,
    action: "Tu dois parler à voix basse pendant 2 tours",
    sips: 2,
  ),
  const BiteCard(
    id: 'petite_15',
    size: BiteSize.petite,
    action: "Choisis un joueur qui doit finir son verre avec toi",
    sips: 3,
  ),
  const BiteCard(
    id: 'petite_16',
    size: BiteSize.petite,
    action: "Raconte ta pire excuse pour rentrer tard",
    sips: 2,
  ),
  const BiteCard(
    id: 'petite_17',
    size: BiteSize.petite,
    action: "Imite l'accent d'un pays au choix pendant 1 minute",
    sips: 3,
  ),
  const BiteCard(
    id: 'petite_18',
    size: BiteSize.petite,
    action: "Fais 10 secondes de la grimace la plus moche possible",
    sips: 1,
  ),
  const BiteCard(
    id: 'petite_19',
    size: BiteSize.petite,
    action:
        "Le joueur à ta gauche choisit ce que tu dois dire avant chaque cdr pour le reste de la partie",
    sips: 3,
  ),
  const BiteCard(
    id: 'petite_20',
    size: BiteSize.petite,
    action: "Avoue le pire mensonge que tu aies dit récemment",
    sips: 4,
  ),
  const BiteCard(
    id: 'petite_21',
    size: BiteSize.petite,
    action: "Fais deviner ton métier ou ta passion sans parler",
    sips: 2,
  ),
  const BiteCard(
    id: 'petite_22',
    size: BiteSize.petite,
    action: "Change de place avec un joueur de ton choix",
    sips: 1,
  ),
  const BiteCard(
    id: 'petite_23',
    size: BiteSize.petite,
    action: "Raconte ta pire soirée arrosée",
    sips: 3,
  ),
  const BiteCard(
    id: 'petite_24',
    size: BiteSize.petite,
    action: "Tu dois répondre à toutes les questions par une question pendant 2 tours",
    sips: 3,
  ),
  const BiteCard(
    id: 'petite_25',
    size: BiteSize.petite,
    action: "Décris ton crush actuel sans donner son nom",
    sips: 4,
  ),
  const BiteCard(
    id: 'petite_26',
    size: BiteSize.petite,
    action: "Fais un check dans la main de chaque joueur en disant un compliment",
    sips: 1,
  ),
  const BiteCard(
    id: 'petite_27',
    size: BiteSize.petite,
    action: "Bois un cdr en équilibre sur un pied",
    sips: 2,
  ),
];
