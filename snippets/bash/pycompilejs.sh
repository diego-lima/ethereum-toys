# serve para gerar um JS que já tem os abi (passando o arquivo .abi em $1) e o bin (passando o .bin em $2)
# esses dois arquivos devem ter sido gerados na compilação do .sol
# e esse JS também já compila e faz tudo de acordo com o template
# que pode ser facilmente importado no geth via loadScript
pycompilejs () {
	python /home/diego/projetos/ethereum/snippets/python/compile.py $1 $2
}
