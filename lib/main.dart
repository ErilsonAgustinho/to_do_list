import 'package:flutter/material.dart';

void main() {
  runApp(MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TO DO LIST',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  List<Atividade> _atividades = [];
  List<Atividade> _atividadesArquivadas = [];
  final _controladorAtividade = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TO DO LIST'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.watch_later),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AtividadesArquivadas()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controladorAtividade,
                    decoration: InputDecoration(
                      hintText: 'Qual a sua tarefa?',
                    ),
                  ),
                ),
                SizedBox(width: 19.0),
                ElevatedButton(
                  onPressed: () {
                    _adicionarAtividade();
                  },
                  child: Text('NOVO'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 151, 136),
                    minimumSize: Size(5, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _atividades.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_atividades[index].titulo),
                  subtitle: Text(_atividades[index].status),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_atividades[index].status == 'A fazer')
                        IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            setState(() {
                              _atividades[index].status = 'Em andamento';
                            });
                          },
                        ),
                      if (_atividades[index].status == 'Em andamento')
                        IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            setState(() {
                              _atividades[index].status = 'Feito';
                            });
                          },
                        ),
                      IconButton(
                        icon: Icon(Icons.archive),
                        onPressed: () {
                          setState(() {
                            _atividadesArquivadas.add(_atividades[index]);
                            _atividades.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _adicionarAtividade() {
    if (_controladorAtividade.text.isNotEmpty) {
      setState(() {
        _atividades.add(Atividade(titulo: _controladorAtividade.text, status: 'A fazer'));
        _controladorAtividade.clear();
      });
    }
  }
}

class Atividade {
  String titulo;
  String status;

  Atividade({required this.titulo, this.status = 'A fazer'});
}

class AtividadesArquivadas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arquivadas'),
      ),
      body: ListView.builder(
        itemCount: _PaginaPrincipalState()._atividadesArquivadas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_PaginaPrincipalState()._atividadesArquivadas[index].titulo),
            subtitle: Text(_PaginaPrincipalState()._atividadesArquivadas[index].status),
          );
        },
      ),
    );
  }
}