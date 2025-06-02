import 'package:flutter/material.dart';
import 'report_incident_page.dart';
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
        title: const Text(
          'Alerta Ribeirinho',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.orange[800],
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SafePage()),
                  );
                }),
                _quickAction(Icons.location_city, 'Abrigos Próximos', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShelterPage()),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // feed de noticias
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

      //  navbar embaixo
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange[800],
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              // mapa
              break;
            case 2:
              // reportar
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReportIncidentPage()),
              );
              break;
            case 3:
              // abrigos
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ShelterPage()),
              );
              break;
            case 4:
              // educacao
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EducationalPage()),
              );
              break;
            case 5:
              // perfil
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
