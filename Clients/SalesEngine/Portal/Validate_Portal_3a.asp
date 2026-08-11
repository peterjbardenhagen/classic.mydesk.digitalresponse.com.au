<%
' 3A Lighting Portal Validator
' Sets up session configuration for 3A Lighting and redirects to main application

Session("Prefix") = "3a"
Session("PortalCompany") = "3A Lighting"
Session("WorkingDir") = "/Clients/SalesEngine3a"
Session("ClientId") = "3a-lighting"

' Redirect to the 3A Lighting portal home
Response.Redirect("/Clients/SalesEngine3a/DefaultFrame.asp")
Response.End
%>
