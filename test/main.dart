import 'package:flutter/material.dart';

void main() {
  final funcionario = Funcionario(TipoContratacao.clt);
  final funcionario2 = Funcionario(TipoContratacao.pj);
  debugPrint(funcionario.igual(funcionario2).toString());
  debugPrint(funcionario.differenca(funcionario2).toString());
}

abstract class Comparar<T> {
  bool igual(T outro);
  double differenca(T outro);
}

enum TipoContratacao implements Comparar<TipoContratacao> {
  clt(0.2),
  pj(0.1),
  estagio(0);

  const TipoContratacao(this.imposto);
  final double imposto;

  String get nome {
    switch (this) {
      case TipoContratacao.clt:
        return 'Contrato ';
      case TipoContratacao.pj:
        return 'Contrato PJ';
      case TipoContratacao.estagio:
        return 'Contrato Estágio';
    }
  }

  double valorImposto(double salarioBruto) {
    return salarioBruto * imposto;
  }

  @override
  bool igual(TipoContratacao outro) => outro.imposto == imposto;
  @override
  double differenca(TipoContratacao outro) => outro.imposto - imposto;
}

class Funcionario {
  final TipoContratacao tipoContratacao;

  Funcionario(this.tipoContratacao);

  String imprimirRegimeContratacao() {
    return tipoContratacao.nome;
  }

  calcularPagamentLiquido(double salarioBruto) {
    return salarioBruto - tipoContratacao.valorImposto(salarioBruto);
  }

  bool igual(Funcionario outro) => tipoContratacao.igual(outro.tipoContratacao);
  double differenca(Funcionario outro) =>
      tipoContratacao.differenca(outro.tipoContratacao);
}
