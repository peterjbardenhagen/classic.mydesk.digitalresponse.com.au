<%
' Error Logging Include File
' Logs errors to /logs directory for debugging

Sub LogError(strTitle, strMessage, strDetails)
    On Error Resume Next

    Dim fso, logFile, logPath, timestamp

    timestamp = Now()
    logPath = Server.MapPath("/logs/error_" & Format(timestamp, "yyyy-mm-dd") & ".txt")

    Set fso = Server.CreateObject("Scripting.FileSystemObject")

    If fso.FileExists(logPath) Then
        Set logFile = fso.OpenTextFile(logPath, 8) ' Append mode
    Else
        Set logFile = fso.CreateTextFile(logPath, True)
    End If

    logFile.WriteLine "[" & Format(timestamp, "yyyy-mm-dd hh:mm:ss") & "] " & strTitle
    logFile.WriteLine "Message: " & strMessage
    If strDetails <> "" Then
        logFile.WriteLine "Details: " & strDetails
    End If
    logFile.WriteLine "Request: " & Request.ServerVariables("REQUEST_METHOD") & " " & Request.ServerVariables("PATH_INFO")
    logFile.WriteLine "Remote IP: " & Request.ServerVariables("REMOTE_ADDR")
    logFile.WriteLine "---"
    logFile.WriteLine ""

    logFile.Close
    Set logFile = Nothing
    Set fso = Nothing

    On Error GoTo 0
End Sub
%>
