<%
' Utility Functions Include File
' Common functions used throughout the application

Function FormatDate(dtDate)
    FormatDate = Format(dtDate, "dd/mm/yyyy")
End Function

Function FormatCurrency(curAmount)
    FormatCurrency = Format(curAmount, "$#,##0.00")
End Function

Function EscapeHTML(strText)
    EscapeHTML = Replace(Replace(Replace(Replace(strText, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"), """", "&quot;")
End Function
%>
