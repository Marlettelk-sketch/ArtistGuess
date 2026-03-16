// Modèle de données représentant un artiste musical
class Artiste {
  final String nom;
  final String genre;
  final String imagePath;

  const Artiste({
    required this.nom,
    required this.genre,
    required this.imagePath,
  });
}

// ─────────────────────────────────────────────────────────────
// BASE DE DONNÉES — 9 artistes avec leurs vraies images
// Fichiers à placer dans : assets/images/artistes/
// ─────────────────────────────────────────────────────────────
const List<Artiste> toulesArtistes = [
  Artiste(
    nom: "Angélique Kidjo",
    genre: "Afropop / World",
    imagePath: "assets/images/artistes/Angelique.jpeg",
  ),
  Artiste(
    nom: "Didi B",
    genre: "Rap Ivoirien",
    imagePath: "assets/images/artistes/Didi_b.jpeg",
  ),
  Artiste(
    nom: "Fally Ipupa",
    genre: "Afropop / R&B",
    imagePath: "assets/images/artistes/Fally_Ipupa.jpeg",
  ),
  Artiste(
    nom: "Lynda",
    genre: "Pop / R&B FR",
    imagePath: "assets/images/artistes/Lynda.jpg",
  ),
  Artiste(
    nom: "Rema",
    genre: "Afrobeats",
    imagePath: "assets/images/artistes/Rema.jpeg",
  ),
  Artiste(
    nom: "Rihanna",
    genre: "Pop / R&B",
    imagePath: "assets/images/artistes/Rihanna.jpg",
  ),
  Artiste(
    nom: "Ronisia",
    genre: "R&B / Kizomba",
    imagePath: "assets/images/artistes/Ronisia.jpg",
  ),
  Artiste(
    nom: "Tiwa Savage",
    genre: "Afrobeats / R&B",
    imagePath: "assets/images/artistes/Tiwa_Savage.jpg",
  ),
  Artiste(
    nom: "Tyla",
    genre: "Afropop / R&B",
    imagePath: "assets/images/artistes/Tyla.jpg",
  ),
];