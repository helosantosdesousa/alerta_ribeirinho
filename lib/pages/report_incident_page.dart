import 'package:flutter/material.dart';

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
  // Simulação de localização (latitude e longitude)
  double _latitude = -23.5505;
  double _longitude = -46.6333;

  void _pickMedia() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funcionalidade de foto/vídeo mockada.')),
    );
  }

  void _sendReport() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Aqui você enviaria os dados para o backend ou serviço
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Reporte enviado!\nTipo: $_selectedIncidentType\nDescrição: $_description\nLocalização: ($_latitude, $_longitude)',
          ),
        ),
      );

      // Opcional: limpar campos ou voltar à tela anterior
      // Navigator.pop(context);
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
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
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

              // Placeholder do mapa
              Text(
                'Localização (ajuste o pino):',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                height: 200,
                color: Colors.grey[300],
                child: Stack(
                  children: [
                    const Center(child: Text('Mapa - placeholder')),
                    // Simulação de pino que pode ser movido
                    Positioned(
                      left: 90,
                      top: 80,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            // Apenas uma simulação básica de movimento do pino no container
                            double newLeft = (90 + details.delta.dx).clamp(0, 200 - 30);
                            double newTop = (80 + details.delta.dy).clamp(0, 200 - 30);
                            // Não atualizamos latitude/longitude reais, só posição visual
                          });
                        },
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    )
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
