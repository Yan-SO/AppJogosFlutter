class Jogo {
  final String? id;
  final String nome;
  final String? statusCampanha;
  final String? statusplatina;
  final int nota;
  String? texto;
  final String plataforme;
  final String urlImagem;

  Jogo({
    this.id,
    required this.urlImagem,
    required this.nome,
    this.statusCampanha,
    this.statusplatina,
    required this.nota,
    required this.plataforme,
    this.texto,
  });
  setTexto(String texto) {
    this.texto = texto;
  }

  Jogo.fronJson(Map<String, dynamic> json)
      : id = json['_id'],
        nome = json['nome'],
        nota = json['nota'],
        plataforme = json['plataforme'] ?? 'não informado',
        statusCampanha = json['statusCampanha'] ?? 'não informado',
        statusplatina = json['statusplatina'] ?? 'não informado',
        texto = json['texto'],
        urlImagem = json['urlImagem'];

  Map<String, dynamic> toJson() {
    if (id == null) {
      return {
        'nome': nome,
        'nota': nota,
        'statusCampanha': statusCampanha,
        'statusplatina': statusplatina,
        'plataforme': plataforme,
        'urlImagem': urlImagem,
        'texto': texto,
      };
    } else {
      return {
        'id': id,
        'nome': nome,
        'nota': nota,
        'statusCampanha': statusCampanha,
        'statusplatina': statusplatina,
        'plataforme': plataforme,
        'urlImagem': urlImagem,
        'texto': texto,
      };
    }
  }

  Map<String, dynamic> toJsonId() {
    return {'_id': id};
  }
}
