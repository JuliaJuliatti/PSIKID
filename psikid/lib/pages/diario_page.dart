import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _salvarEntrada() async {
    final texto = _controller.text.trim();
    if (texto.isNotEmpty) {
      await FirebaseFirestore.instance.collection('diario_emocoes').add({
        'texto': texto,
        'data': Timestamp.now(),
      });
      _controller.clear();
      setState(() {}); // Recarrega o histórico
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Diário de Emoções')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Como foi seu dia?',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _salvarEntrada,
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Histórico',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('diario_emocoes')
                    .orderBy('data', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final texto = data['texto'] ?? '';
                      final dataHora = (data['data'] as Timestamp).toDate();

                      return Card(
                        child: ListTile(
                          title: Text(texto),
                          subtitle: Text(
                            '${dataHora.day}/${dataHora.month}/${dataHora.year} - ${dataHora.hour}:${dataHora.minute.toString().padLeft(2, '0')}',
                          ),
                          trailing: IconButton(
                            icon:  Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Excluir entrada?'),
                                  content: const Text(
                                      'Tem certeza que deseja excluir esta entrada do diário?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text('Excluir'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await FirebaseFirestore.instance
                                    .collection('diario_emocoes')
                                    .doc(docs[index].id)
                                    .delete();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
