import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  String result = '0';
  String? errorText;

  void calculate(String operation) {
    final a = double.tryParse(firstController.text.trim());
    final b = double.tryParse(secondController.text.trim());

    if (a == null || b == null) {
      setState(() {
        errorText = 'Enter valid numbers in both fields.';
      });
      return;
    }

    if (operation == '/' && b == 0) {
      setState(() {
        errorText = 'Cannot divide by zero.';
      });
      return;
    }

    double value;
    switch (operation) {
      case '+':
        value = a + b;
        break;
      case '-':
        value = a - b;
        break;
      case '*':
        value = a * b;
        break;
      default:
        value = a / b;
    }

    setState(() {
      errorText = null;
      result = value == value.truncateToDouble()
          ? value.toInt().toString()
          : value.toStringAsFixed(4).replaceFirst(RegExp(r'0+$'), '');
    });
  }

  void clear() {
    firstController.clear();
    secondController.clear();
    setState(() {
      result = '0';
      errorText = null;
    });
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: firstController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            decoration: const InputDecoration(
              labelText: 'First Number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: secondController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Second Number',
              border: OutlineInputBorder(),
            ),
          ),
          if (errorText != null) ...[
            const SizedBox(height: 12),
            Text(errorText!, style: const TextStyle(color: Colors.red)),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => calculate('+'),
                  child: const Text('+'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => calculate('-'),
                  child: const Text('−'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => calculate('*'),
                  child: const Text('×'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => calculate('/'),
                  child: const Text('÷'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: clear, child: const Text('Clear')),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text('Result'),
                  const SizedBox(height: 8),
                  Text(
                    result,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
