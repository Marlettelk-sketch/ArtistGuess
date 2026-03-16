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

            _sectionTitre(Icons.sports_esports, "Comment jouer", Colors.deepPurple),
            SizedBox(height: 12),
            _regle("1", Colors.deepPurple, "Un nom d'artiste s'affiche en haut de l'écran."),
            _regle("2", Colors.deepPurple, "Trouve et clique sur la bonne case dans la grille 3×3."),
            _regle("3", Colors.deepPurple, "Tu as 60 secondes — le chrono est visible par tous !"),
            _regle("4", Colors.deepPurple, "Enchaîne les bonnes réponses pour activer le COMBO."),
            _regle("5", Colors.deepPurple, "Tu as 3 vies. Mauvaise réponse ou timeout = -1 vie."),
            _regle("6", Colors.deepPurple, "Game Over quand tu n'as plus de vies ou de temps."),

            SizedBox(height: 28),
            _sectionTitre(Icons.speed, "Niveaux de difficulté", Colors.orange),
            SizedBox(height: 12),
            _carte(Colors.orange, Column(children: [
              _ligne("Facile",    "8 sec · +10 pts par réponse", Colors.green),
              Divider(height: 16),
              _ligne("Moyen",    "5 sec · +20 pts par réponse", Colors.orange),
              Divider(height: 16),
              _ligne("Difficile","2 sec · +40 pts par réponse", Colors.red),
            ])),

            SizedBox(height: 28),
            _sectionTitre(Icons.star, "Système de points", Colors.amber),
            SizedBox(height: 12),
            _carte(Colors.amber, Column(children: [
              _ligne("Bonne réponse",   "Points × combo", Colors.green),
              Divider(height: 16),
              _ligne("Combo",           "Augmente à chaque bonne réponse", Colors.green),
              Divider(height: 16),
              _ligne("Mauvaise réponse","Combo remis à x1", Colors.red),
            ])),

            SizedBox(height: 28),
            _sectionTitre(Icons.info_outline, "À propos de l'app", Colors.pink),
            SizedBox(height: 12),
            _carte(Colors.pink, Column(children: [
              _ligne("Nom",         "ARTISTAR", Colors.grey[800]!),
              Divider(height: 16),
              _ligne("Version",     "1.0.0", Colors.grey[800]!),
              Divider(height: 16),
              _ligne("Technologie", "Flutter / Dart", Colors.grey[800]!),
              Divider(height: 16),
              _ligne("Artistes",    "9 artistes africains", Colors.grey[800]!),
            ])),

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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitre(IconData icone, String titre, Color couleur) {
    return Row(children: [
      Icon(icone, color: couleur, size: 26),
      SizedBox(width: 10),
      Text(titre, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: couleur)),
    ]);
  }

  Widget _regle(String num, Color couleur, String texte) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 28, height: 28,
          decoration: BoxDecoration(color: couleur, shape: BoxShape.circle),
          child: Center(child: Text(num,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
        ),
        SizedBox(width: 12),
        Expanded(child: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(texte, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
        )),
      ]),
    );
  }

  Widget _carte(Color couleur, Widget contenu) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: couleur.withValues(alpha: 0.3)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: contenu,
    );
  }

  Widget _ligne(String label, String valeur, Color couleurValeur) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
      Text(valeur, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: couleurValeur)),
    ]);
  }
}