import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ReportIncidentPage extends StatefulWidget {
  const ReportIncidentPage({super.key});

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedIncidentType;
  final List<String> _incidentTypes = [
    'Alagamento',
    'Deslizamento',
    'Pessoa em Perigo',
    'Via Bloqueada',
  ];

  String _description = '';
  LatLng _currentPosition = LatLng(-23.5505, -46.6333);

  final MapController _mapController = MapController();

  void _pickMedia() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Inserir foto ou vídeo')));
  }

  void _sendReport() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reporte enviado!\nTipo: $_selectedIncidentType\nDescrição: $_description\nLocalização: (${_currentPosition.latitude.toStringAsFixed(5)}, ${_currentPosition.longitude.toStringAsFixed(5)})',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportar Incidente'),
        backgroundColor: Colors.orange[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tipo de Incidente',
                  border: OutlineInputBorder(),
                ),
                items: _incidentTypes
                    .map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    )
                    .toList(),
                value: _selectedIncidentType,
                onChanged: (val) => setState(() => _selectedIncidentType = val),
                validator: (val) =>
                    val == null ? 'Por favor, selecione um tipo.' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                onSaved: (val) => _description = val ?? '',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Descrição obrigatória' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickMedia,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Adicionar Foto/Vídeo'),
              ),
              const SizedBox(height: 24),
              Text(
                'Localização (arraste o pino para ajustar):',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 300,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(center: _currentPosition, zoom: 13),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _currentPosition,
                          width: 80,
                          height: 80,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              final localPoint = _mapController
                                  .latLngToScreenPoint(_currentPosition);
                              final newPoint = CustomPoint(
                                localPoint.x + details.delta.dx,
                                localPoint.y + details.delta.dy,
                              );
                              final newLatLng = _mapController.pointToLatLng(
                                newPoint,
                              );

                              setState(() {
                                _currentPosition = newLatLng;
                              });
                            },
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _sendReport,
                child: const Text('Enviar Reporte'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
