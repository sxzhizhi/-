
Partial Class A_Unit


    Inherits System.Web.UI.Page

    Private Sub A_Unit_Load(sender As Object, e As EventArgs) Handles Me.Load
        Session("onelevel") = "2"
        If Session("iphone") = "" Then Response.Redirect("A_login.aspx")
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function saveunit(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        str1 = Replace(str1, "'", "")


        Dim sBillCode As String = ""


        rs = cPConn.Execute("Select * from DicUnit where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cUnitName='" & str1 & "'")

        If rs.RecordCount = 0 Then

            sBillCode = GetCode("Unit", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
            cPConn.Execute("insert into DicUnit(cUnitCode,zDeptCode,cUnitName)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & str1 & "')")
            Return "保存成功"
        Else
            Return "已存在"
        End If


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function saveunit1(str1 As String, str2 As String) As String
        'On Error Resume Next

        Dim rs, re As New ADODB.Recordset

        str2 = Replace(str2, "'", "")


        Dim sBillCode As String = ""


        rs = cPConn.Execute("Select * from DicUnit where cUnitCode='" & str1 & "' and zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
        If rs.RecordCount <> 0 Then

            re = cPConn.Execute("Select * from DicUnit where cUnitCode<>'" & rs.Fields("cUnitCode").Value & "' and cUnitName='" & str2 & "'")

            If re.RecordCount = 0 Then
                cPConn.Execute("update DicUnit set cUnitName='" & str2 & "' where cUnitCode='" & str1 & "'")
                Return "保存成功"
            Else
                Return "已存在"
            End If



        Else
            sBillCode = GetCode("Unit", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
            cPConn.Execute("insert into DicUnit(cUnitCode,zDeptCode,cUnitName)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & str2 & "')")
            Return "保存成功"
        End If




    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function Del(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        rs = cPConn.Execute("select * from DicUnit where cUnitCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            cPConn.Execute("Delete from DicUnit where cUnitCode='" & str1 & "'")
            Return "删除成功"
        Else
            Return "已经删除"
        End If




    End Function


End Class
