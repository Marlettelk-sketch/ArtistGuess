import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:artistar_app/artiste.dart';


class Niveau {
  final String nom;
  final String description;
  final int tempsParRound;
  final int pointsParReponse;
  final Color couleur;
  final IconData icone;

  const Niveau({
    required this.nom,
    required this.description,
    required this.tempsParRound,
    required this.pointsParReponse,
    required this.couleur,
    required this.icone,
  });
}

const Niveau niveauFacile = Niveau(
  nom: "Facile",
  description: "8 sec par artiste · +10 pts",
  tempsParRound: 8000,
  pointsParReponse: 10,
  couleur: Colors.green,
  icone: Icons.sentiment_satisfied,
);

const Niveau niveauMoyen = Niveau(
  nom: "Moyen",
  description: "5 sec par artiste · +20 pts",
  tempsParRound: 5000,
  pointsParReponse: 20,
  couleur: Colors.orange,
  icone: Icons.sentiment_neutral,
);

const Niveau niveauDifficile = Niveau(
  nom: "Difficile",
  description: "2 sec par artiste · +40 pts",
  tempsParRound: 2000,
  pointsParReponse: 40,
  couleur: Colors.red,
  icone: Icons.sentiment_very_dissatisfied,
);

final List<int> historiqueScores = [];

class QuizPage extends StatefulWidget {
  final Niveau niveau;
  const QuizPage({super.key, required this.niveau});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  int positionBonArtiste = 0;
  int score = 0;
  int combo = 1;
  int viesRestantes = 3;
  List<Artiste> artistesGrille = [];
  Artiste? artisteCible;


  static const int dureePartie = 60;
  int tempsRestant = dureePartie;
  Timer? _timerPartie;

  
  Timer? _timerRound;
  int tempsRoundMs = 0;
  int get tempsRoundTotal => widget.niveau.tempsParRound;

  bool _partieTerminee = false;

  @override
  void initState() {
    super.initState();
    _demarrerTimerPartie();
    nouveauRound();
  }

  @override
  void dispose() {
    _timerPartie?.cancel();
    _timerRound?.cancel();
    super.dispose();
  }

  void _demarrerTimerPartie() {
    _timerPartie = Timer.periodic(Duration(seconds: 1), (t) {
      if (_partieTerminee) { t.cancel(); return; }
      setState(() => tempsRestant--);
      if (tempsRestant <= 0) { t.cancel(); _afficherGameOver(); }
    });
  }

  void nouveauRound() {
    _timerRound?.cancel();
    final liste = List<Artiste>.from(toulesArtistes)..shuffle(Random());
    final neuf = liste.take(9).toList();
    final pos = Random().nextInt(9) + 1;
    setState(() {
      artistesGrille = neuf;
      positionBonArtiste = pos;
      artisteCible = neuf[pos - 1];
      tempsRoundMs = tempsRoundTotal;
    });
    _timerRound = Timer.periodic(Duration(milliseconds: 50), (t) {
      if (_partieTerminee) { t.cancel(); return; }
      setState(() => tempsRoundMs -= 50);
      if (tempsRoundMs <= 0) { t.cancel(); _mauvaisChoix(); }
    });
  }

  void onCaseCliquee(int numero) {
    _timerRound?.cancel();
    if (numero == positionBonArtiste) _bonChoix();
    else _mauvaisChoix();
  }

  void _bonChoix() {
    setState(() {
      score += widget.niveau.pointsParReponse * combo;
      combo++;
    });
    nouveauRound();
  }

  void _mauvaisChoix() {
    setState(() {
      combo = 1;
      viesRestantes--;
      if (viesRestantes < 0) viesRestantes = 0;
    });
    if (viesRestantes <= 0) _afficherGameOver();
    else nouveauRound();
  }

  void _afficherGameOver() {
    if (_partieTerminee) return;
    _partieTerminee = true;
    _timerPartie?.cancel();
    _timerRound?.cancel();
    
    historiqueScores.insert(0, score);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Game Over 💀"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Niveau : ${widget.niveau.nom}",
                style: TextStyle(color: widget.niveau.couleur, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Score final : $score pts",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Peux-tu faire mieux ?"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () { Navigator.pop(context); _reinitialiser(); },
            child: Text("Rejouer"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Quitter"),
          ),
        ],
      ),
    );
  }

  void _reinitialiser() {
    setState(() {
      score = 0; combo = 1; viesRestantes = 3;
      tempsRestant = dureePartie; _partieTerminee = false;
    });
    _demarrerTimerPartie();
    nouveauRound();
  }

  Color get _couleurTimer {
    if (tempsRestant > 30) return Colors.green;
    if (tempsRestant > 15) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("ARTISTAR — ${widget.niveau.nom}"),
        backgroundColor: widget.niveau.couleur,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: List.generate(3, (i) => Icon(
                Icons.favorite,
                color: i < viesRestantes ? Colors.white : Colors.white30,
                size: 22,
              )),
            ),
          ),
        ],
      ),
      body: Column(
        children: [

        
          Container(
            color: Colors.black87,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.timer, color: _couleurTimer, size: 28),
                SizedBox(width: 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: (tempsRestant / dureePartie).clamp(0.0, 1.0),
                      minHeight: 16,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation<Color>(_couleurTimer),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                SizedBox(
                  width: 56,
                  child: Text(
                    "$tempsRestant s",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _couleurTimer),
                  ),
                ),
              ],
            ),
          ),

        
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: widget.niveau.couleur.withValues(alpha: 0.10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Score : $score",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                        color: widget.niveau.couleur)),
                Expanded(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                        children: [
                          TextSpan(text: "Trouve : "),
                          TextSpan(
                            text: artisteCible?.nom ?? "—",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: widget.niveau.couleur, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      color: widget.niveau.couleur, borderRadius: BorderRadius.circular(20)),
                  child: Text("x$combo",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          
          Builder(builder: (_) {
            final pct = tempsRoundTotal > 0
                ? (tempsRoundMs / tempsRoundTotal).clamp(0.0, 1.0) : 0.0;
            Color c = Colors.blue;
            if (pct < 0.5) c = Colors.orange;
            if (pct < 0.25) c = Colors.red;
            return LinearProgressIndicator(
              value: pct, minHeight: 6,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(c),
            );
          }),

          
          Expanded(child: Row(children: [_caseArtiste(1), _caseArtiste(2), _caseArtiste(3)])),
          SizedBox(height: 0,width: 0),
          Expanded(child: Row(children: [_caseArtiste(4), _caseArtiste(5), _caseArtiste(6)])),
          SizedBox(height: 0, width: 0),
          Expanded(child: Row(children: [_caseArtiste(7), _caseArtiste(8), _caseArtiste(9)])),
          SizedBox(height: 0, width: 0),
        ],
      ),
    );
  }

  Widget _caseArtiste(int num) {
    if (artistesGrille.isEmpty) return Expanded(child: SizedBox());
    final artiste = artistesGrille[num - 1];
    return Expanded(
      child: InkWell(
        onTap: () => onCaseCliquee(num),
        child: Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 4, offset: Offset(0, 2))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(artiste.imagePath, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.deepPurple.withValues(alpha: 0.15),
                      child: Icon(Icons.person, size: 48,
                          color: Colors.deepPurple.withValues(alpha: 0.4)),
                    )),
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter, end: Alignment.topCenter,
                        colors: [Colors.black.withValues(alpha: 0.82), Colors.transparent],
                      ),
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Text(artiste.nom,
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,
                              color: Colors.white),
                          textAlign: TextAlign.center, maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      Text(artiste.genre,
                          style: TextStyle(fontSize: 8,
                              color: Colors.white.withValues(alpha: 0.7))),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}