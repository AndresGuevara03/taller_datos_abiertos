import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taller_datos_abiertos/services/api_service.dart';
import 'package:taller_datos_abiertos/models/president_model.dart';
import 'package:taller_datos_abiertos/themes/app_theme.dart';

class DataListView extends StatefulWidget {
  final String endpointTitle;
  const DataListView({super.key, required this.endpointTitle});

  @override
  State<DataListView> createState() => _DataListViewState();
}

class _DataListViewState extends State<DataListView> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    if (widget.endpointTitle == 'Regiones') {
      _futureData = _apiService.getRegions();
    } else if (widget.endpointTitle == 'Departamentos') {
      _futureData = _apiService.getDepartments();
    } else if (widget.endpointTitle == 'Presidentes') {
      _futureData = _apiService.getPresidents();
    } else if (widget.endpointTitle == 'Atracciones') {
      _futureData = _apiService.getAttractions();
    } else {
      _futureData = Future.value([]); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.endpointTitle),
        backgroundColor: AppTheme.background,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: AppTheme.primary),
                  SizedBox(height: 24),
                  Text(
                    'Cargando datos...',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                ],
              ),
            );
          } 
          
          else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
                    const SizedBox(height: 24),
                    const Text(
                      'Error de conexión',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          } 
          
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No se encontraron resultados'),
            );
          }

          final data = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              String displayTitle = item.name;
              if (item is PresidentModel) {
                displayTitle = '${item.name} ${item.lastName}';
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () {
                    context.push('/detail', extra: {
                      'title': displayTitle,
                      'description': item.description,
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: AppTheme.glassDecoration(),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              displayTitle[0].toUpperCase(),
                              style: const TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              if (item is PresidentModel)
                                const Text(
                                  'Presidente de Colombia',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios, 
                          size: 14, 
                          color: AppTheme.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}