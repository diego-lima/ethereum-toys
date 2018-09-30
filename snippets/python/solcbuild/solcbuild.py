# encoding: utf-8

from os.path import isfile
from os import remove, system as terminal

import re

class Var:
    """
    Receber string "<<nome|descricao|padrao>>"
    Setar propriedades nome, descricao e padrao
    """
    # O template da variável. Algo como '<<nome|descricao>>'
    template: str = None
    # O nome da variável
    nome: str = None
    # A descrição da variável
    descricao: str = None
    # O valor padrão da variável, caso não seja fornecido na compilação
    valor: str = None
    # span do match: onde começa e onde termina
    span: tuple = None

    def __init__(self, match: 'Match do re.finditer'):
        self.template = match.group() # Pega o texto template
        self.span = match.span() # Pega o começo e fim 

        string = self.template.replace("<<","").replace(">>","") # remover '<<' e '>>'
        itens = string.split("|")

        if len(itens) < 2 or len(itens) > 3:
            raise Exception("Formato de variável inválido. Tente '<nome|descricao|padrao (opcional)>'")

        self.nome = itens[0]
        self.descricao = itens[1]
        self.valor = None if len(itens) < 3 else itens[2]

    def span_deslocado(self, shift):
        """
        Quando você substitui um texto "<<var|uma var>>" por "123", essa troca não deixa a string template
        com o mesmo tamanho. Na verdade, isso resulta num desajustamento do span das outras variáveis que vierem
        à frente. Esse desajustamento precisa ser compensado por um deslocamento do span, que é o que
        essa função faz.
        """
        inicio, fim = self.span
        return inicio - shift, fim - shift


    def __repr__(self):
        return self.nome


class JSTemplate:
    """
    Receber *.js como template
    Achar variaveis
    Criar lista de variaveis necessarias, opcionais e todas
    """
    # O template em JS
    template: str = None
    # Lista de variaveis encontradas no template
    variaveis: list = None

    def __init__(self, input: str):
        if isfile(input):
            # Iremos ler o conteúdo do arquivo e jogar no template
            with open(input,"r") as myf:
                self.template = myf.read()

        else:
            raise Exception("Arquivo {} não encontrado".format(input))

        self.variaveis = []
        self.carregarVariaveis()

    def carregarVariaveis(self):
        variaveis = re.finditer(r"<<.+>>",self.template,re.IGNORECASE)

        for variavel in variaveis:
            self.variaveis.append(Var(variavel))

    def listarObrigatorias(self):
        return [str(x) for x in self.variaveis if not x.padrao]

    def listarOpcionais(self):
        return [str(x) for x in self.variaveis if x.padrao]

    def listarTodas(self):
        return [str(x) for x in self.variaveis]

    def buscarVariavel(self, nome):
        for x in self.variaveis:
                if str(x) == nome:
                    return x
        raise Exception('Variável não encontrada')

    def compilar(self):
        """
        Realiza o enxerto no template. Ou seja, onde tem <<algumavariavel|descricao>>,
        substitui tudo, incluindo '<<' e '>>', pelo valor da variavel.
        """
        template_compilada = self.template
        shift = 0
        for variavel in self.variaveis:
            inicio, fim = variavel.span_deslocado(shift)
            shift += fim - inicio - len(variavel.valor)
            template_compilada = template_compilada[:inicio] + variavel.valor + template_compilada[fim:]

        return template_compilada

    def __getattr__(self, name):
        """
        Permite fazer
        jst = JSTemplate("algumarquivo.js")
        jst.abi # abi é uma das variaveis dentro de jst.variaveis
        """
        try:
            return self.buscarVariavel(name)
        except:
            if hasattr(super(), "__getattr__"):
                return super().__getattr__(name)
            raise AttributeError(name)

    def __setattr__(self, name, value):
        """
        Permite fazer
        jst = JSTemplate("algumarquivo.js")
        jst.abi = 22 # abi é uma das variaveis dentro de jst.variaveis
        """
        try:
            variavel = self.buscarVariavel(name)
            variavel.valor = value
        except:
            super().__setattr__(name, value)


if __name__ == "__main__":
    """
    Recebe um arquvivo <nome>.sol
    Apaga os arquivos <nome>.js, <nome>.bin, <nome>.abi
    Compila o contrato <nome>.sol
    Re-gera os arquivos <nome>.js, <nome>.bin, <nome>.abi
    """

    import argparse

    template_padrao = "/home/diego/projetos/ethereum/snippets/python/solcbuild/template.js"

    parser = argparse.ArgumentParser(description='Pipeline de compilação de um contrato Solidity. Recebe o *.sol, e gera *.bin, *.abi e *.js')
    parser.add_argument('nome', action="store", help="Arquivo *.sol contendo o contrato a ser buildado")
    parser.add_argument('--template', action="store", help="O arquivo *.js que contém o template de código JS para deploy do contrato",
                        default=template_padrao)

    argumentos = parser.parse_args()

    # Ler o arquivo *.js de template
    template = JSTemplate(argumentos.template)

    if not isfile(argumentos.nome):
        raise Exception("Arquivo {} não encontrado".format(argumentos.nome))

    nome = argumentos.nome.replace(".sol", "") # Transformar 'contrato.sol' em 'contrato'
    nome = nome.split('/')[-1] # Transformar em caminho relativo
    
    # limpar rastros anteriores (arquivos js, abi, bin)
    for formato in ['js', 'abi', 'bin']:
        arquivo = "{}.{}".format(nome, formato)
        if isfile(arquivo):
            remove(arquivo)

    # compilar o arquivo *.sol
    terminal("solc -o . --bin --abi {}".format(argumentos.nome))

    # Ler os arquivos *.abi e *.bin
    abi = open("{}.abi".format(nome), "r").read()
    bin = open("{}.bin".format(nome), "r").read()

    

    template.abi = abi
    template.bin = bin

    # Salvar o novo arquivo *.js
    js = open("{}.js".format(nome), "w")
    js.write(template.compilar())
    js.close()




