import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:artistar_app/quiz.dart';
import 'package:artistar_app/classement_page.dart';
import 'package:artistar_app/apropos_page.dart';

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});

  
  void _choisirNiveau(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(children: [
          Icon(Icons.tune, color: Colors.deepPurple),
          SizedBox(width: 8),
          Text("Choisis ton niveau"),
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _boutonNiveau(context, niveauFacile),
            SizedBox(height: 10),
            _boutonNiveau(context, niveauMoyen),
            SizedBox(height: 10),
            _boutonNiveau(context, niveauDifficile),
          ],
        ),
      ),
    );
  }

  Widget _boutonNiveau(BuildContext context, Niveau niveau) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => QuizPage(niveau: niveau)));
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: niveau.couleur.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: niveau.couleur.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Row(
          children: [
            Icon(niveau.icone, color: niveau.couleur, size: 32),
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(niveau.nom,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: niveau.couleur)),
                Text(niveau.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _confirmerQuitter(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quitter ARTISTAR ?"),
        content: Text("Tu veux vraiment quitter le jeu ?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Annuler")),
          TextButton(
            onPressed: () { Navigator.pop(context); SystemNavigator.pop(); },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text("Quitter"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ARTIST"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [

          // Logo + titre
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.music_note, size: 100, color: Colors.deepPurple),
                  SizedBox(height: 16),
                  Text("ARTIST",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,
                          color: Colors.deepPurple, letterSpacing: 4)),
                  SizedBox(height: 8),
                  Text("Retrouve le bon artiste parmi 9 !",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),

          
          Expanded(
            child: Row(
              children: [
              
                Expanded(
                  child: GestureDetector(
                    onTap: () => _choisirNiveau(context),
                    child: Container(
                      color: Colors.red.withValues(alpha: 0.15),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.play_arrow, size: 48, color: Colors.red),
                        Text("Jouer", style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                    ),
                  ),
                ),
          
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AProposPage())),
                    child: Container(
                      color: Colors.pink.withValues(alpha: 0.15),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.info, size: 48, color: Colors.purple),
                        Text("À propos"),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),

        
          Expanded(
            child: Row(
              children: [
              
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ClassementPage())),
                    child: Container(
                      color: Colors.amber.withValues(alpha: 0.15),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.emoji_events, size: 48, color: Colors.amber),
                        Text("Classement"),
                      ]),
                    ),
                  ),
                ),
              
                Expanded(
                  child: GestureDetector(
                    onTap: () => _confirmerQuitter(context),
                    child: Container(
                      color: Colors.blue.withValues(alpha: 0.15),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.exit_to_app, size: 48, color: Colors.blue),
                        Text("Quitter"),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}