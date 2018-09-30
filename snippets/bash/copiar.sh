# serve para copiar um arquivo passado como argumento $1 para o clipboard
#
#

copiar () {
        cat $1 | xclip -sel clipboard
}

