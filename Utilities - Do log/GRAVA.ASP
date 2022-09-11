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

'a linha abaixo abre a instância com o objeto Scripting. FileSystemObject
Set ObjFSO = CreateObject("Scripting.FileSystemObject")
'abaixo, é feita a verificação da existência do arquivo procurado. Caso ele ainda não exista (o que ocorre 1 vez por dia, no primeiro acesso), ele é criado
If ObjFSO.FileExists(arquivo) = False then
'abaixo, a linha que cria o arquivo TXT especificado
objFSO.CreateTextFile(arquivo)
End If
'a linha abaixo abre o arquivo desejado. Lembre-se, ou ele já existe ou ele foi criado na rotina acima.
Set ObjFile = objFSO.GetFile(arquivo)
'a linha abaixo diz o tipo de manipulação que será utilizada no arquivo TXT, no caso é para adicionar dados.
Set objStream = ObjFile.OpenAsTextStream(forAppending,TriDef) 

'abaixo, são criadas algumas variáveis com valores que serão colocados no LOG (hora, IP, versão do Browser)
Hora = Time()
IpNum = Request.ServerVariables("REMOTE_ADDR")
'BrowVer = Request.ServerVariables("HTTP_USER_AGENT")
Indique=request.form("indique")

'o comando WriteLine, abaixo, grava os dados no arquivo TXT especificado.
ObjStream.WriteLine Hora & " | " & Dia & "/" & Mes & "/" & Ano & " | " & Indique & " | " & IpNum & " --> "

'abaixo, o objeto ObjStream é fechado
ObjStream.close 
Set ObjStream = nothing
%>
