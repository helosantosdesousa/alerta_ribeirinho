import 'package:flutter/material.dart';
import 'report_incident_page.dart'; // Tela para reportar incidente
import 'shelter_page.dart';
import 'safe_page.dart';
import 'educational_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerta Ribeirinho'),
        backgroundColor: Colors.orange[800],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nível de alerta atual
          Container(
            width: double.infinity,
            color: Colors.orange[100],
            padding: const EdgeInsets.all(16),
            child: const Text(
              '⚠️ Alerta Laranja: Risco de Inundação Moderada',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),

          // Ações Rápidas
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Ações Rápidas',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _quickAction(Icons.report_problem, 'Reportar Incidente', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ReportIncidentPage(),
                    ),
                  );
                }),
                _quickAction(Icons.map, 'Ver Mapa', () {}),
                _quickAction(Icons.verified_user, 'Estou Seguro', () {
                  // Ação para estou seguro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SafePage()),
                  );
                }),
                _quickAction(Icons.location_city, 'Abrigos Próximos', () {
                  // Navega para tela de abrigos
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShelterPage()),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Feed de notícias
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Últimas Notícias da Defesa Civil',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.warning_amber),
                  title: Text('Alerta ${index + 1}'),
                  subtitle: const Text(
                    'Chuva intensa nas próximas 24h. Fique atento a possíveis alagamentos.',
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Menu de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange[800],
        onTap: (index) {
          // Tratar navegação pelo BottomNavigationBar
          switch (index) {
            case 0:
              // Início (aqui não muda nada, já está no Dashboard)
              break;
            case 1:
              break;
            case 2:
              // Reportar incidente
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReportIncidentPage()),
              );
              break;
            case 3:
              // Abrigos Próximos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ShelterPage()),
              );
              break;
            case 4:
              // Educar (implemente se quiser)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EducationalPage()),
              );
              break;
            case 5:
              // Perfil (implemente se quiser)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.report), label: 'Reportar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            label: 'Abrigos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Educar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  // Widget auxiliar para ações rápidas com callback onPressed
  Widget _quickAction(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        backgroundColor: Colors.orange[700],
        foregroundColor: Colors.white,
      ),
    );
  }
}
