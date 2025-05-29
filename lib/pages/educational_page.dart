import 'package:flutter/material.dart';

class EducationalPage extends StatelessWidget {
  const EducationalPage({super.key});

  final List<_Article> articles = const [
    _Article(
      title: 'Como montar seu Kit de Emergência',
      content:
          'Um kit de emergência deve conter água, alimentos não perecíveis, lanterna, pilhas extras, rádio, medicamentos, documentos importantes e itens de higiene pessoal.',
    ),
    _Article(
      title: 'O que fazer Antes/Durante/Depois de uma Enchente',
      content:
          'Antes: prepare um plano de evacuação e organize seus pertences. Durante: evite áreas alagadas e busque locais seguros. Depois: retorne somente quando for seguro e evite contato com água contaminada.',
    ),
    _Article(
      title: 'Identificando Sinais de Risco',
      content:
          'Fique atento a sinais como aumento do nível da água, rachaduras em muros, quedas de árvores e alertas oficiais para antecipar riscos.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educação'),
        backgroundColor: Colors.orange[800],
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return ListTile(
            title: Text(article.title),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArticleDetailPage(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _Article {
  final String title;
  final String content;
  const _Article({required this.title, required this.content});
}

class ArticleDetailPage extends StatelessWidget {
  final _Article article;
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Colors.orange[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          article.content,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
