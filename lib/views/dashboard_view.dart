import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taller_datos_abiertos/themes/app_theme.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final endpoints = [
      {'title': 'Regiones', 'icon': Icons.public, 'subtitle': 'Geografía Nacional'},
      {'title': 'Departamentos', 'icon': Icons.map, 'subtitle': 'División Política'},
      {'title': 'Presidentes', 'icon': Icons.person, 'subtitle': 'Historia de Colombia'},
      {'title': 'Atracciones', 'icon': Icons.castle, 'subtitle': 'Sitios Turísticos'},
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 100,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Colombia Open Data'),
              centerTitle: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildHorizontalCard(context, endpoints[index]),
                  );
                },
                childCount: endpoints.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => context.push('/list/${item['title']}'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: AppTheme.neonDecoration(),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                item['icon'], 
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  Text(
                    item['subtitle'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right, 
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}