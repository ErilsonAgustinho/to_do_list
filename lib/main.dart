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
                MaterialPageRoute(builder: (context) => AtividadesArquivadas(_atividadesArquivadas)),
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
                  child: Text('NOVO',style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
            child: ListView(
              children: [
                if (_atividades.any((atividade) => atividade.status == 'A fazer'))
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'A fazer',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                for (var atividade in _atividades)
                  if (atividade.status == 'A fazer')
                    ListTile(
                      title: Text(atividade.titulo),
                      subtitle: Text(atividade.status),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check),
                            onPressed: () {
                              setState(() {
                                atividade.status = 'Em andamento';
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.archive),
                            onPressed: () {
                              setState(() {
                                _atividadesArquivadas.add(atividade);
                                _atividades.remove(atividade);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                if (_atividades.any((atividade) => atividade.status == 'Em andamento'))
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Em andamento',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                for (var atividade in _atividades)
                  if (atividade.status == 'Em andamento')
                    ListTile(
                      title: Text(atividade.titulo),
                      subtitle: Text(atividade.status),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.done),
                            onPressed: () {
                              setState(() {
                                atividade.status = 'Feito';
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.archive),
                            onPressed: () {
                              setState(() {
                                _atividadesArquivadas.add(atividade);
                                _atividades.remove(atividade);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                if (_atividades.any((atividade) => atividade.status == 'Feito'))
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      'Feito',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                for (var atividade in _atividades)
                  if (atividade.status == 'Feito')
                    ListTile(
                      title: Text(atividade.titulo),
                      subtitle: Text(atividade.status),
                      trailing: IconButton(
                        icon: Icon(Icons.archive),
                        onPressed: () {
                          setState(() {
                            _atividadesArquivadas.add(atividade);
                            _atividades.remove(atividade);
                          });
                        },
                      ),
                    ),
              ],
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
  final List<Atividade> _atividadesArquivadas;

  AtividadesArquivadas(this._atividadesArquivadas);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Arquivadas'),
      ),
      body: ListView.builder(
        itemCount: _atividadesArquivadas.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_atividadesArquivadas[index].titulo),
            subtitle: Text(_atividadesArquivadas[index].status),
          );
        },
      ),
    );
  }
}
