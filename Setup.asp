<%
Response.AddHeader "Pragma", "No-Store"
Response.AddHeader "cache-control", "no-store, private, must-revalidate"
Response.Expires = -1
Response.ExpiresAbsolute = DateAdd("Y", -10, Now())
Response.CacheControl = "no-store, private, must-revalidate"

' =============================================================================
' 3A Lighting - Web-Based Setup & Initialization
'
' This page provides a web interface to:
' 1. Validate database connectivity
' 2. Run database setup scripts
' 3. Initialize users (Khim, Peter admin, template users)
' 4. Configure 3A Lighting instance
'
' SECURITY: This page should be deleted or password-protected after setup.
'           Consider removing this file in production.
' =============================================================================

Dim strAction, strStep, strMessage, bolSuccess, strSetupPassword

strAction = Trim(Request("action"))
strSetupPassword = "setup123" ' Change this to a secure password

%>
<!--#include virtual="/System/ssi_Functions.asp"-->
<!--#include virtual="/System/ssi_dbConn_open.inc"-->
<%

' Check if setup is being run
If strAction <> "" Then

    ' Verify password if action is requested
    If Trim(Request("password")) <> strSetupPassword Then
        strMessage = "<strong style='color:red;'>ERROR: Invalid password. Setup cancelled.</strong>"
        bolSuccess = False
    Else

        Select Case strAction

        ' =====================================================================
        ' STEP 1: Database Connectivity Check
        ' =====================================================================
        Case "test_db"
            On Error Resume Next

            Dim rsTest
            Set rsTest = Server.CreateObject("ADODB.RecordSet")
            rsTest.Open "SELECT COUNT(*) as cnt FROM Divisions", dbConn

            If Err.Number = 0 And Not (rsTest.BOF And rsTest.EOF) Then
                strMessage = "<strong style='color:green;'>✓ Database connection successful!</strong><br>" & _
                    "Found " & rsTest("cnt") & " division(s) in database."
                bolSuccess = True
            Else
                strMessage = "<strong style='color:red;'>ERROR: Database connection failed.</strong><br>" & _
                    "Error: " & Err.Description
                bolSuccess = False
            End If

            rsTest.Close
            Set rsTest = Nothing
            Err.Clear
            On Error GoTo 0

        ' =====================================================================
        ' STEP 2: Run User Setup
        ' =====================================================================
        Case "setup_users"
            On Error Resume Next

            Dim strSetupSQL, rsSetup
            Dim fso, objFile, strSetupPath

            ' Read setup-users.sql from Setup/3a-lighting/ directory
            strSetupPath = Server.MapPath("/Setup/3a-lighting/setup-users.sql")

            Set fso = Server.CreateObject("Scripting.FileSystemObject")

            If fso.FileExists(strSetupPath) Then
                Set objFile = fso.OpenTextFile(strSetupPath)
                strSetupSQL = objFile.ReadAll()
                objFile.Close
                Set objFile = Nothing

                ' Execute the SQL script
                ' Note: Access/Jet doesn't support multi-statement batches well,
                ' so we'll execute key statements individually

                dbConn.BeginTrans

                ' Delete existing access records (except template users)
                dbConn.Execute "DELETE FROM UsersAccess WHERE UserId NOT IN (SELECT UserId FROM Users WHERE Code IN ('20', '121', '122', 'Khim', 'Peter'))"

                ' Delete existing users (except template users)
                dbConn.Execute "DELETE FROM Users WHERE Code NOT IN ('20', '121', '122', 'Khim', 'Peter')"

                ' Get IDs
                Dim rsDivision, rsLocation
                Set rsDivision = dbConn.Execute("SELECT DivisionId FROM Divisions WHERE DivisionCode = '3AL'")
                Set rsLocation = dbConn.Execute("SELECT LocationId FROM Locations WHERE Company = '3A Lighting Pty Ltd' LIMIT 1")

                Dim intDivisionId, intLocationId
                If Not (rsDivision.BOF And rsDivision.EOF) Then
                    intDivisionId = rsDivision("DivisionId")
                Else
                    intDivisionId = 1
                End If

                If Not (rsLocation.BOF And rsLocation.EOF) Then
                    intLocationId = rsLocation("LocationId")
                Else
                    intLocationId = 1
                End If

                rsDivision.Close
                rsLocation.Close
                Set rsDivision = Nothing
                Set rsLocation = Nothing

                ' Insert Khim
                dbConn.Execute "INSERT INTO Users (Code, Name, Initials, PW, UserTypeId, DivisionId, LocationId, Active, HoursPerDay, DaysPerWeek, Email, Phone) VALUES ('Khim', 'Khim', 'KH', 'password123', 2, " & intDivisionId & ", " & intLocationId & ", -1, 8, 5, 'khim@3a-lighting.com.au', '02 5550 1234')"

                Dim rsKhim
                Set rsKhim = dbConn.Execute("SELECT UserId FROM Users WHERE Code = 'Khim'")
                Dim intKhimUserId
                intKhimUserId = rsKhim("UserId")
                rsKhim.Close
                Set rsKhim = Nothing

                ' Grant Khim access
                dbConn.Execute "INSERT INTO UsersAccess (UserId, DivisionId, Visible, Manager, Quotes, RFQ, PurchaseOrders, Payroll) VALUES (" & intKhimUserId & ", " & intDivisionId & ", -1, -1, -1, -1, -1, 0)"

                ' Insert Peter (Admin)
                dbConn.Execute "INSERT INTO Users (Code, Name, Initials, PW, UserTypeId, DivisionId, LocationId, Active, HoursPerDay, DaysPerWeek, Email, Phone) VALUES ('Peter', 'Peter Bardenhagen', 'PB', 'password123', 1, " & intDivisionId & ", " & intLocationId & ", -1, 8, 5, 'peter@bardenhagen.xyz', '02 5550 1234')"

                Dim rsPeter
                Set rsPeter = dbConn.Execute("SELECT UserId FROM Users WHERE Code = 'Peter'")
                Dim intPeterUserId
                intPeterUserId = rsPeter("UserId")
                rsPeter.Close
                Set rsPeter = Nothing

                ' Grant Peter (admin) access to all modules
                dbConn.Execute "INSERT INTO UsersAccess (UserId, DivisionId, Visible, Manager, Quotes, RFQ, PurchaseOrders, Payroll) VALUES (" & intPeterUserId & ", " & intDivisionId & ", -1, -1, -1, -1, -1, -1)"

                dbConn.CommitTrans

                If Err.Number = 0 Then
                    strMessage = "<strong style='color:green;'>✓ User setup completed successfully!</strong><br>" & _
                        "<br><strong>Accounts Created:</strong><ul>" & _
                        "<li><strong>Khim</strong> - Operator (Password: password123)</li>" & _
                        "<li><strong>Peter</strong> - Administrator (Password: password123)</li>" & _
                        "</ul>" & _
                        "<p style='color:#555; font-size:12px;'><strong>IMPORTANT:</strong> Change passwords immediately in production!</p>"
                    bolSuccess = True
                Else
                    dbConn.RollbackTrans
                    strMessage = "<strong style='color:red;'>ERROR: User setup failed.</strong><br>" & _
                        "Error: " & Err.Description
                    bolSuccess = False
                End If
                Err.Clear
                On Error GoTo 0

                Set fso = Nothing
            Else
                strMessage = "<strong style='color:red;'>ERROR: Setup file not found.</strong><br>" & _
                    "Expected: /Setup/3a-lighting/setup-users.sql"
                bolSuccess = False
            End If

        ' =====================================================================
        ' STEP 3: Summary
        ' =====================================================================
        Case "summary"
            strMessage = "<strong style='color:green;'>✓ Setup process complete!</strong><br>" & _
                "<br><strong>Next Steps:</strong><ul>" & _
                "<li>Log in with <strong>Username: Khim</strong>, <strong>Password: password123</strong></li>" & _
                "<li>Or log in as admin with <strong>Username: Peter</strong>, <strong>Password: password123</strong></li>" & _
                "<li><strong>IMPORTANT:</strong> Change all passwords immediately</li>" & _
                "<li>Delete or password-protect this Setup.asp file</li>" & _
                "</ul>" & _
                "<p><strong>Access Configured:</strong></p>" & _
                "<ul>" & _
                "<li>Khim: Full operator access (Visible, Quotes, RFQ, Purchase Orders)</li>" & _
                "<li>Peter: Full admin access (all modules + Payroll)</li>" & _
                "</ul>"
            bolSuccess = True

        End Select
    End If
End If

%>

<!DOCTYPE html>
<html>
<head>
    <title>3A Lighting - Setup & Initialization</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            background: #f5f7f8;
            color: #08121a;
            font-family: Inter, "Segoe UI", Arial, sans-serif;
            padding: 40px 20px;
        }
        .container {
            max-width: 700px;
            margin: 0 auto;
            background: #fff;
            border: 1px solid #d9e3e5;
            border-top: 4px solid #00c8c8;
            padding: 32px;
            border-radius: 4px;
        }
        .logo {
            height: 40px;
            margin-bottom: 24px;
            display: block;
        }
        h1 {
            margin: 0 0 8px 0;
            font-size: 28px;
            color: #08121a;
        }
        .subtitle {
            color: #6a7b81;
            margin-bottom: 24px;
            font-size: 14px;
        }
        .steps {
            margin: 32px 0;
        }
        .step {
            margin-bottom: 20px;
            padding: 16px;
            background: #f5f7f8;
            border-left: 3px solid #00c8c8;
            border-radius: 2px;
        }
        .step h3 {
            margin: 0 0 8px 0;
            font-size: 16px;
            color: #08121a;
        }
        .step p {
            margin: 0 0 12px 0;
            color: #555;
            font-size: 14px;
        }
        .step form {
            margin-top: 12px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
            font-size: 13px;
        }
        input[type=password], input[type=text] {
            width: 100%;
            padding: 8px 10px;
            border: 1px solid #b8c9cd;
            font-size: 13px;
            margin-bottom: 12px;
            border-radius: 3px;
        }
        button {
            background: #00c8c8;
            border: 0;
            color: #08121a;
            font-weight: bold;
            padding: 10px 16px;
            cursor: pointer;
            border-radius: 3px;
            font-size: 13px;
        }
        button:hover {
            background: #15dede;
        }
        .message {
            margin: 20px 0;
            padding: 16px;
            background: #f0f5f6;
            border-left: 3px solid #00c8c8;
            border-radius: 2px;
        }
        .warning {
            background: #fff3cd;
            border-left-color: #ff9800;
            color: #856404;
            margin: 20px 0;
            padding: 12px;
            border-radius: 2px;
        }
        .success {
            background: #d4edda;
            border-left-color: #28a745;
            color: #155724;
        }
        .error {
            background: #f8d7da;
            border-left-color: #dc3545;
            color: #721c24;
        }
        .code {
            background: #f5f7f8;
            padding: 8px 12px;
            border-radius: 3px;
            font-family: monospace;
            font-size: 12px;
            display: inline-block;
            margin: 0 4px;
        }
        .footer {
            margin-top: 32px;
            padding-top: 16px;
            border-top: 1px solid #d9e3e5;
            font-size: 12px;
            color: #6a7b81;
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="/images/Logos/3a-lighting-logo-light.svg" class="logo" alt="3A Lighting">

        <h1>3A Lighting Setup</h1>
        <p class="subtitle">Initialize database and user accounts</p>

        <% If strMessage <> "" Then %>
        <div class="message <% If bolSuccess Then %>success<% Else %>error<% End If %>">
            <%= strMessage %>
        </div>
        <% End If %>

        <div class="warning">
            <strong>⚠️ Security Notice:</strong> This setup page provides direct database access.
            Delete or password-protect this file after setup is complete.
        </div>

        <div class="steps">
            <!-- STEP 1: Test Database -->
            <div class="step">
                <h3>Step 1: Test Database Connection</h3>
                <p>Verify that the database is accessible and properly configured.</p>
                <form method="post">
                    <label for="pwd1">Setup Password:</label>
                    <input type="password" name="password" id="pwd1" placeholder="Enter setup password" required>
                    <input type="hidden" name="action" value="test_db">
                    <button type="submit">Test Connection</button>
                </form>
            </div>

            <!-- STEP 2: Setup Users -->
            <div class="step">
                <h3>Step 2: Initialize Users & Access</h3>
                <p>Create user accounts for Khim (operator) and Peter (admin).</p>
                <form method="post">
                    <label for="pwd2">Setup Password:</label>
                    <input type="password" name="password" id="pwd2" placeholder="Enter setup password" required>
                    <input type="hidden" name="action" value="setup_users">
                    <button type="submit">Create Users</button>
                </form>
            </div>

            <!-- STEP 3: Summary -->
            <div class="step">
                <h3>Step 3: Finalize Setup</h3>
                <p>Review setup completion and next steps.</p>
                <form method="post">
                    <input type="hidden" name="action" value="summary">
                    <button type="submit">View Summary</button>
                </form>
            </div>
        </div>

        <div class="footer">
            <strong>Default Credentials (CHANGE IMMEDIATELY):</strong><br>
            • <span class="code">Khim</span> / <span class="code">password123</span> (Operator)<br>
            • <span class="code">Peter</span> / <span class="code">password123</span> (Administrator)<br><br>
            Setup password: <span class="code"><%= strSetupPassword %></span><br>
            (Configure in Setup.asp line 18)
        </div>
    </div>
</body>
</html>

<!--#include virtual="/System/ssi_dbConn_close.inc"-->
