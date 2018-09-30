from solcbuild import JSTemplate

jst = JSTemplate("template.js")

jst.abi = "AaaaA"
jst.bin = "BoooB"

print(jst.compilar())