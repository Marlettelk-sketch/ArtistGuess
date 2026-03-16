import 'package:flutter/material.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("À propos"),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Niveaux de difficulté ---
            _sectionTitre(Icons.speed, "Niveaux de difficulté", Colors.orange),
            SizedBox(height: 12),
            _carte(
              Colors.orange,
              Column(
                children: [
                  _ligne("Facile", "8 sec · +10 pts par réponse", Colors.green),
                  Divider(height: 16),
                  _ligne("Moyen", "5 sec · +20 pts par réponse", Colors.orange),
                  Divider(height: 16),
                  _ligne(
                    "Difficile",
                    "2 sec · +40 pts par réponse",
                    Colors.red,
                  ),
                ],
              ),
            ),

            SizedBox(height: 28),
            // --- Système de points ---
            _sectionTitre(Icons.star, "Système de points", Colors.amber),
            SizedBox(height: 12),
            _carte(
              Colors.amber,
              Column(
                children: [
                  _ligne("Bonne réponse", "Points × combo", Colors.green),
                  Divider(height: 16),
                  _ligne(
                    "Combo",
                    "Augmente à chaque bonne réponse",
                    Colors.green,
                  ),
                  Divider(height: 16),
                  _ligne("Mauvaise réponse", "Combo remis à x1", Colors.red),
                ],
              ),
            ),

            SizedBox(height: 28),
            // --- À propos de l'app ---
            _sectionTitre(Icons.info_outline, "À propos de l'app", Colors.pink),
            SizedBox(height: 12),
            _carte(
              Colors.pink,
              Column(
                children: [
                  _ligne("Nom", "ARTISTAR", Colors.grey[800]!),
                  Divider(height: 16),
                  _ligne("Version", "1.0.0", Colors.grey[800]!),
                  Divider(height: 16),
                  _ligne("Technologie", "Flutter / Dart", Colors.grey[800]!),
                  Divider(height: 16),
                  _ligne("Artistes", "9 artistes africains", Colors.grey[800]!),
                ],
              ),
            ),

            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back),
                label: Text("Retour à l'accueil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Widgets auxiliaires ---
  Widget _sectionTitre(IconData icone, String titre, Color couleur) {
    return Row(
      children: [
        Icon(icone, color: couleur, size: 26),
        SizedBox(width: 10),
        Text(
          titre,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: couleur,
          ),
        ),
      ],
    );
  }

  Widget _carte(Color couleur, Widget contenu) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: couleur.withAlpha(77)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: contenu,
    );
  }

  Widget _ligne(String label, String valeur, Color couleurValeur) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        Text(
          valeur,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: couleurValeur,
          ),
        ),
      ],
    );
  }
}
