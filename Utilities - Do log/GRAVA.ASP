<% 
path_do_arquivo = "/"
Const forReading = 1, forWriting = 2, forAppending = 8
Const TriDef = -2, TriTrue = -1, TriFalse = 0

Dia = Day(Date()) 
if Dia < 10 then Dia = "0" & Dia 
Mes = Month(Date())
if mes < 10 then mes = "0" & mes
Ano = Year(Date())

'a linha abaixo gera o nome do arquivo de acordo com o dia. (todo dia tem que ser criado um arquivo novo)
arquivo = path_do_arquivo & Ano & Mes & Dia & ".log"

'a linha abaixo abre a inst?ncia com o objeto Scripting. FileSystemObject
Set ObjFSO = CreateObject("Scripting.FileSystemObject")
'abaixo, ? feita a verifica??o da exist?ncia do arquivo procurado. Caso ele ainda n?o exista (o que ocorre 1 vez por dia, no primeiro acesso), ele ? criado
If ObjFSO.FileExists(arquivo) = False then
'abaixo, a linha que cria o arquivo TXT especificado
objFSO.CreateTextFile(arquivo)
End If
'a linha abaixo abre o arquivo desejado. Lembre-se, ou ele j? existe ou ele foi criado na rotina acima.
Set ObjFile = objFSO.GetFile(arquivo)
'a linha abaixo diz o tipo de manipula??o que ser? utilizada no arquivo TXT, no caso ? para adicionar dados.
Set objStream = ObjFile.OpenAsTextStream(forAppending,TriDef) 

'abaixo, s?o criadas algumas vari?veis com valores que ser?o colocados no LOG (hora, IP, vers?o do Browser)
Hora = Time()
IpNum = Request.ServerVariables("REMOTE_ADDR")
'BrowVer = Request.ServerVariables("HTTP_USER_AGENT")
Indique=request.form("indique")

'o comando WriteLine, abaixo, grava os dados no arquivo TXT especificado.
ObjStream.WriteLine Hora & " | " & Dia & "/" & Mes & "/" & Ano & " | " & Indique & " | " & IpNum & " --> "

'abaixo, o objeto ObjStream ? fechado
ObjStream.close 
Set ObjStream = nothing
%>
