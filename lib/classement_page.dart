import 'package:flutter/material.dart';
import 'package:artistar_app/quiz.dart';

class ClassementPage extends StatelessWidget {
  const ClassementPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupère les scores de la session depuis la liste globale
    final scores = List<int>.from(historiqueScores)
      ..sort((a, b) => b.compareTo(a));

    return Scaffold(
      appBar: AppBar(
        title: Text("Classement"),
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[50],
      body: scores.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_events_outlined, size: 80, color: Colors.grey[300]),
                  SizedBox(height: 16),
                  Text("Pas encore de scores.\nJoue une partie !",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[500])),
                ],
              ),
            )
          : Column(
              children: [
                // Podium top 3
                if (scores.length >= 1) _buildPodium(scores),
                // Liste complète
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: scores.length,
                    itemBuilder: (context, i) {
                      final medailles = {0: "🏆", 1: "🥈", 2: "🥉"};
                      final couleurs = [Colors.amber, Colors.grey, Colors.brown[300]!];
                      final estTop = i < 3;
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: estTop
                                ? couleurs[i].withValues(alpha: 0.4)
                                : Colors.grey.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(
                                color: estTop ? couleurs[i] : Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: estTop && i == 0
                                    ? Icon(Icons.emoji_events, color: Colors.white, size: 18)
                                    : Text("#${i + 1}",
                                        style: TextStyle(
                                            color: estTop ? Colors.white : Colors.grey[600],
                                            fontWeight: FontWeight.bold, fontSize: 13)),
                              ),
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: Text("${scores[i]} pts",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold,
                                      color: estTop ? couleurs[i] : Colors.grey[800])),
                            ),
                            if (medailles.containsKey(i))
                              Text(medailles[i]!, style: TextStyle(fontSize: 22)),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPodium(List<int> scores) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (scores.length >= 2)
            _colonnePodium(rang: 2, score: scores[1], couleur: Colors.grey, hauteur: 70),
          SizedBox(width: 8),
          _colonnePodium(rang: 1, score: scores[0], couleur: Colors.amber, hauteur: 90),
          SizedBox(width: 8),
          if (scores.length >= 3)
            _colonnePodium(rang: 3, score: scores[2], couleur: Colors.brown[300]!, hauteur: 55),
        ],
      ),
    );
  }

  Widget _colonnePodium({required int rang, required int score,
      required Color couleur, required double hauteur}) {
    final medailles = {1: "🏆", 2: "🥈", 3: "🥉"};
    return Column(children: [
      Text(medailles[rang]!, style: TextStyle(fontSize: 24)),
      SizedBox(height: 4),
      Text("$score pts",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: couleur)),
      SizedBox(height: 4),
      Container(
        width: 70, height: hauteur,
        decoration: BoxDecoration(
          color: couleur.withValues(alpha: 0.2),
          border: Border.all(color: couleur, width: 2),
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        child: Center(child: Text("#$rang",
            style: TextStyle(fontWeight: FontWeight.bold, color: couleur, fontSize: 18))),
      ),
    ]);
  }
}