
Partial Class A_Power


    Inherits System.Web.UI.Page

    Private Sub A_Power_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("iphone") = "" Then Response.Redirect("A_login.aspx")
    End Sub


    <System.Web.Services.WebMethod()>
    Public Shared Function SaveAll(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset


        Dim sBillCode As String = ""


        rs = cPConn.Execute("Select * from dbUser where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")

        cPConn.Execute("Delete from DicPower where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and iphone='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount
                sBillCode = GetCode("Power", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                cPConn.Execute("insert into DicPower(cPowerCode,zDeptCode,iPhoneNumber,iphone,cBZ)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & rs.Fields("iPhoneNumber").Value & "','" & str1 & "','全部成员')")
                rs.MoveNext()
            Next


        End If

        Return "保存成功"

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DelAll(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset


        Dim sBillCode As String = ""

        cPConn.Execute("Delete from DicPower where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and iphone='" & str1 & "'")

        'rs = cPConn.Execute("Select * from dbUser where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")

        'cPConn.Execute("Delete from DicPower where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and iphone='" & str1 & "'")
        'If rs.RecordCount <> 0 Then
        '    For i = 1 To rs.RecordCount
        '        sBillCode = GetCode("Power", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
        '        cPConn.Execute("insert into DicPower(cPowerCode,zDeptCode,iPhoneNumber,iphone,cBZ)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & rs.Fields("iPhoneNumber").Value & "','" & str1 & "','全部成员')")
        '        rs.MoveNext()
        '    Next


        'End If

        Return "保存成功"

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveUnit(str1 As String, str2 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset


        Dim sBillCode As String = ""


        rs = cPConn.Execute("Select * from dbuser where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cDeptJob='" & str2 & "'")

        cPConn.Execute("Delete from DicPower where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and iphone='" & str1 & "' and cBZ='全部成员'")
        'cPConn.Execute("Delete from DicPower where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and iphone='" & str1 & "' and cBZ='部门'")

        cPConn.Execute("Delete from DicPower where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and iphone='" & str1 & "'")


        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount
                sBillCode = GetCode("Power", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                cPConn.Execute("insert into DicPower(cPowerCode,zDeptCode,iPhoneNumber,iphone,cBZ)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & rs.Fields("iPhoneNumber").Value & "','" & str1 & "','部门')")
                rs.MoveNext()
            Next


        End If

        Return "保存成功"

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveUser(str1 As String, str2 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset


        Dim sBillCode As String = ""
        sBillCode = GetCode("Power", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("Delete from DicPower where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and iphone='" & str1 & "' and cBZ='全部成员'")

        cPConn.Execute("Delete from DicPower where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cBZ='成员' and iphone='" & str1 & "' and iphoneNumber='" & str2 & "'")

        cPConn.Execute("insert into DicPower(cPowerCode,zDeptCode,iPhoneNumber,iphone,cBZ)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & str2 & "','" & str1 & "','成员')")


        'rs = cPConn.Execute("Select * from dbuser where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cDeptJob='" & str2 & "'")

        'cPConn.Execute("Delete from DicPower where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and iphone='" & str1 & "'")

        'If rs.RecordCount <> 0 Then
        '    For i = 1 To rs.RecordCount
        '        sBillCode = GetCode("Power", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
        '        cPConn.Execute("insert into DicPower(cPowerCode,zDeptCode,iPhoneNumber,iphone,cBZ)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & rs.Fields("iPhoneNumber").Value & "','" & str1 & "','" & str2 & "')")
        '        rs.MoveNext()
        '    Next


        'End If

        Return "保存成功"

    End Function
End Class
