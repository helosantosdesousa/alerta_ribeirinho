import 'package:flutter/material.dart';

class SafePage extends StatefulWidget {
  const SafePage({super.key});

  @override
  State<SafePage> createState() => _SafePageState();
}

class _SafePageState extends State<SafePage> {
  bool notifyContacts = false;

  void _markAsSafe() {
    String message = 'Usuário marcado como seguro.';
    if (notifyContacts) {
      message += ' Contatos de emergência foram notificados.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estou Seguro'),
        backgroundColor: Colors.orange[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _markAsSafe,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                minimumSize: const Size(double.infinity, 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Marcar como Seguro',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Checkbox(
                  value: notifyContacts,
                  onChanged: (bool? value) {
                    setState(() {
                      notifyContacts = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    'Notificar contatos de emergência cadastrados',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
