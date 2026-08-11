<%
' Close database connection
If Not (dbConn Is Nothing) Then
    On Error Resume Next
    dbConn.Close
    Set dbConn = Nothing
    On Error GoTo 0
End If
%>
