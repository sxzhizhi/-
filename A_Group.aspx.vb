
Partial Class A_Group


    Inherits System.Web.UI.Page

    Private Sub A_Group_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Session("iphone") = "" Then Response.Redirect("A_login.aspx")

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveGroup(str1 As String, str2 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        Dim cGroupName As String = Replace(str1, "'", "")
        Dim cName() As String = Split(str2, ";")


        Dim sBillCode As String = ""
        Dim sBillCode1 As String = ""




        sBillCode = GetCode("GK", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("insert into dbGroup(cCode,zDeptCode,cPhoneNumber,cGroupName)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & HttpContext.Current.Session("iphone") & "','" & cGroupName & "')")

        For i = 0 To UBound(cName) - 1
            sBillCode1 = GetCode("GL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

            cPConn.Execute("insert into dbGroupList(cCode,cListCode,cPhoneNumber)values('" & sBillCode & "','" & sBillCode1 & "','" & cName(i) & "')")

        Next

        Return "保存成功"

    End Function

End Class
