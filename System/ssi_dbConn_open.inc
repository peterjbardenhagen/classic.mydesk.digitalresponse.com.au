<%
' Database Connection Include File
' Opens connection to Access database for 3A Lighting application

<!--#include virtual="/System/ssi_ErrorLog.inc"-->

Dim dbConn, strDBPath

' Set database path - configure this for your deployment
strDBPath = "c:\database\3a-lighting.mdb"

' Create connection object
Set dbConn = Server.CreateObject("ADODB.Connection")

' Build connection string for Access database (no password required)
Dim strConnStr
strConnStr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & strDBPath & ";"

On Error Resume Next
dbConn.Open strConnStr

If Err.Number <> 0 Then
    LogError "Database Connection Error", "Failed to open database: " & strDBPath, Err.Description

    Response.Write "<p style='color:red;'><strong>ERROR: Database connection failed.</strong><br>"
    Response.Write "Path: " & strDBPath & "<br>"
    Response.Write "Error: " & Err.Description & "<br>"
    Response.Write "Check /logs directory for error details.</p>"
    Err.Clear
End If

On Error GoTo 0
%>
