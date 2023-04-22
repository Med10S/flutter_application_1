import 'package:flutter/material.dart';

class compte extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<compte> {
    final _formKey = GlobalKey<FormState>();

  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();
  final TextEditingController _textController5 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Champs de saisie d\'entiers'),
      ),
      body: Form(
        key: _formKey,

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _textController1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Champ 1'),
                validator: (value) {
                  if (value!.isEmpty) return 'Veuillez entrer une valeur';
                  int? parsedValue = int.tryParse(value);
                  if (parsedValue == null) return 'Veuillez entrer un nombre entier';
                  return null;
                },
              ),
              TextFormField(
                controller: _textController2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Champ 2'),
                validator: (value) {
                  // Validation personnalisée pour le champ 2
                  // Retourne une chaîne de caractères d'erreur si la validation échoue, sinon retourne null
                  // Vous pouvez personnaliser cette validation pour chaque champ de saisie
                  // en modifiant cette fonction de rappel (validator)
                  return null;
                },
              ),
              TextFormField(
                controller: _textController3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Champ 3'),
                validator: (value) {
                  // Validation personnalisée pour le champ 3
                  return null;
                },
              ),
              TextFormField(
                controller: _textController4,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Champ 4'),
                validator: (value) {
                  // Validation personnalisée pour le champ 4
                  return null;
                },
              ),
              TextFormField(
                controller: _textController5,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Champ 5'),
                validator: (value) {
                  // Validation personnalisée pour le champ 5
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Valider les champs de texte
                  if (_formKey.currentState!.validate()) {
                    // Utiliser les valeurs saisies dans les champs de texte
                     int champ1 = int.parse(_textController1.text);
                    int champ2 = int.parse(_textController2.text);
                    int champ3 = int.parse(_textController3.text);
                    int champ4 = int.parse(_textController4.text);
                    int champ5 = int.parse(_textController5.text);
        
                    // Utiliser les valeurs saisies dans les champs de texte
                    // Faites ce que vous voulez avec les valeurs entières ici
                    // Vous pouvez les utiliser pour effectuer des calculs, les afficher, etc.
        
                    // Exemple d'utilisation :
                    print('Champ 1 : $champ1');
                    print('Champ 2 : $champ2');
                    print('Champ 3 : $champ3');
                    print('Champ 4 : $champ4');
                    print('Champ 5 : $champ5');
                  }
                },
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}