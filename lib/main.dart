import 'package:flutter/material.dart';

void main() => runApp(CalculadoraIMC());

class CalculadoraIMC extends StatelessWidget {
  const CalculadoraIMC({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      home: const TelaIMC(),
    );
  }
}

class TelaIMC extends StatefulWidget {
  const TelaIMC({super.key});

  @override
  _TelaIMCState createState() => _TelaIMCState();
}

class _TelaIMCState extends State<TelaIMC> {
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  double resultado = 0;
  String mensagem = '';
  String imagem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            if (imagem != '') Image.asset(
              imagem,
              height: 200.0,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: alturaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (cm)',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso (kg)',
              ),
            ),
            const SizedBox(height: 32.0),
            Container(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  double altura = double.parse(alturaController.text) / 100;
                  double peso = double.parse(pesoController.text);
                  resultado = peso / (altura * altura);
                  if (resultado < 18.5) {
                    mensagem = 'Abaixo do peso';
                    imagem = 'images/abaixo.jpg';
                  } else if (resultado < 25) {
                    mensagem = 'Peso normal';
                    imagem = 'images/ideal.jpg';
                  } else if (resultado < 30) {
                    mensagem = 'Sobrepeso';
                    imagem = 'images/excesso.jpg';
                  } else if (resultado < 35) {
                    mensagem = 'Obesidade grau 1';
                    imagem = 'images/obesidade1.jpg';
                  } else {
                    mensagem = 'Obesidade grau 2';
                    imagem = 'images/obesidade2.jpg';
                  }
                  setState(() {});
                },
                child: const Text(
                  'Calcular',
                  style: TextStyle(color: Colors.white, fontSize: 24.0)
                )
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Resultado: ${resultado.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Classificação: $mensagem',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}