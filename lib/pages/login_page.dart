import 'package:flutter/material.dart';
import 'dashboard_page.dart'; // importe sua tela de dashboard

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  void _mockLogin() {
    //final success = (email == 'teste@teste.com' && password == '123456');
    final success = true;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Login bem-sucedido!' : 'Falha no login.'),
      ),
    );

    if (success) {
      // Navega para Dashboard e remove a tela de login da pilha
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    }
  }

  void _loginWithGoogle() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Login com Google mockado.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image.asset('assets/logo.png', height: 120),
                const SizedBox(height: 32),
                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) => setState(() => email = value),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  onChanged: (value) => setState(() => password = value),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _mockLogin,
                  child: const Text('Entrar'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navegar para cadastro')),
                    );
                  },
                  child: const Text('Não tem conta? Cadastre-se'),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _loginWithGoogle,
                  icon: const Icon(Icons.login),
                  label: const Text('Entrar com Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
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
