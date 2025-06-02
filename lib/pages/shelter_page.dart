import 'package:flutter/material.dart';

class Shelter {
  final String name;
  final String address;
  final double distanceKm;
  final int capacity;
  final int occupied;
  final bool hasWater;
  final bool hasFood;
  final bool hasMattresses;
  final String routeUrl;

  Shelter({
    required this.name,
    required this.address,
    required this.distanceKm,
    required this.capacity,
    required this.occupied,
    required this.hasWater,
    required this.hasFood,
    required this.hasMattresses,
    required this.routeUrl,
  });

  double get occupancyRate => occupied / capacity;

  Color get occupancyColor {
    final rate = occupancyRate;
    if (rate < 0.7) return Colors.green;
    if (rate < 0.9) return Colors.amber;
    return Colors.red;
  }

  String get occupancyStatus {
    final rate = occupancyRate;
    if (rate < 0.7) return "Vagas Disponíveis";
    if (rate < 0.9) return "Poucas Vagas";
    return "Lotado";
  }
}

class ShelterPage extends StatelessWidget {
  final List<Shelter> shelters = [
    Shelter(
      name: 'Abrigo Central',
      address: 'Rua das Flores, 123',
      distanceKm: 1.2,
      capacity: 100,
      occupied: 50,
      hasWater: true,
      hasFood: true,
      hasMattresses: false,
    ),
    Shelter(
      name: 'Abrigo Bairro Alto',
      address: 'Av. das Palmeiras, 456',
      distanceKm: 3.4,
      capacity: 80,
      occupied: 70,
      hasWater: true,
      hasFood: false,
      hasMattresses: true,
    ),
    Shelter(
      name: 'Abrigo Vila Nova',
      address: 'Travessa dos Pinheiros, 789',
      distanceKm: 5.0,
      capacity: 50,
      occupied: 50,
      hasWater: false,
      hasFood: true,
      hasMattresses: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abrigos Próximos'),
        backgroundColor: Colors.orange[800],
      ),
      body: ListView.builder(
        itemCount: shelters.length,
        itemBuilder: (context, index) {
          final shelter = shelters[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: shelter.occupancyColor,
              radius: 12,
            ),
            title: Text(shelter.name),
            subtitle: Text(
              '${shelter.address}\nDistância: ${shelter.distanceKm.toStringAsFixed(1)} km',
            ),
            isThreeLine: true,
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ShelterDetailsPage(shelter: shelter),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ShelterDetailsPage extends StatelessWidget {
  final Shelter shelter;

  const ShelterDetailsPage({super.key, required this.shelter});

  Widget _resourceRow(String label, bool available) {
    return Row(
      children: [
        Icon(
          available ? Icons.check_circle : Icons.cancel,
          color: available ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  void _openRoute(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Abrir rota para: ${shelter.routeUrl}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final occupied = shelter.occupied;
    final capacity = shelter.capacity;
    final availableSpots = capacity - occupied;

    return Scaffold(
      appBar: AppBar(
        title: Text(shelter.name),
        backgroundColor: Colors.orange[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shelter.address,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),

            Text('Capacidade: $capacity'),
            Text('Ocupados: $occupied'),
            Text('Vagas disponíveis: $availableSpots'),
            const SizedBox(height: 16),

            Text(
              'Recursos disponíveis:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _resourceRow('Água', shelter.hasWater),
            _resourceRow('Comida', shelter.hasFood),
            _resourceRow('Colchões', shelter.hasMattresses),

            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _openRoute(context),
                icon: const Icon(
                  Icons.navigation,
                  color: Color.fromARGB(255, 6, 70, 165),
                ),
                label: const Text(
                  'Mostrar rota',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
