import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

//Column -> abaixo do outro
//Row -> do lado do outro
//Stack -> em cima do outro

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final alturaController = TextEditingController();
  final pesoController = TextEditingController();

  var image = 'images/abaixo.jpg';
  var message = '';
  double imc = 0;

  void calculaImc() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text);
    imc = peso / (altura * altura);

    if (imc < 18.5) {
      setState(() {
        image = 'images/abaixo.jpg';

        message = 'Abaixo do peso';
      });
    } else if (imc >= 18.5 && imc <= 24.9) {
      setState(() {
        image = 'images/ideal.jpg';

        message = 'Peso normal';
      });
    } else if (imc >= 25 && imc <= 29.9) {
      setState(() {
        image = 'images/excesso.jpg';

        message = 'Sobrepeso';
      });
    } else if (imc >= 30 && imc < 34.9) {
      setState(() {
        image = 'images/obesidade1.jpg';

        message = 'Obesidade 1';
      });
    } else {
      setState(() {
        image = 'images/obesidade2.jpg';

        message = 'Obesidade 2';
      });
    }
  }

  void handlerLimpar() {
    setState(() {
      alturaController.clear();
      pesoController.clear();
      imc = 0;
      message = '';
      image = 'images/abaixo.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cálculo IMC'),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      controller: alturaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Altura (cm)",
                      ),
                    ),
                    TextField(
                      controller: pesoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Peso (kg)',
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () => calculaImc(),
                        child: const Text('Calcular'),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () => handlerLimpar(),
                        child: const Text('Limpar'),
                      ),
                    )
                  ],
                ),
              )
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Center(
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 300,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white.withOpacity(0.5),
                    margin: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        if (imc != 0)
                        Center(
                          child: Text(
                            'IMC: ${imc.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (message != '')
                        Center(
                          child: Text(
                          message,
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
