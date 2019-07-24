
Partial Class A_WorkView

    Inherits System.Web.UI.Page
    <System.Web.Services.WebMethod()>
    Public Shared Function ViewRB(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim aa As New A_WorkView
        rs = cPConn.Execute("Select * from RBView where cCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")
            aa.T_RBNR.Text = rs.Fields("cNR").Value

        End If
        Return "成功"

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function Save(str1 As String, str2 As String) As String
        On Error Resume Next

        'Dim rs, re As New ADODB.Recordset
        Dim dDate As String
        Dim cNR As String
        dDate = str1
        cNR = str2

        Dim sBillCode As String = ""

        sBillCode = GetCode("Day", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
        cPConn.Execute("insert into RB(cCode,dDate,cNR,iPhoneNumber,dRBDate)values('" & sBillCode & "','" & dDate & "','" & cNR & "','" & HttpContext.Current.Session("iphone") & "','" & Now() & "')")

        Return "保存成功"

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function Save1(str1 As String, str2 As String, str3 As String) As String
        On Error Resume Next

        Dim rs As New ADODB.Recordset

        rs = cPConn.Execute("select * from RBView where cCode='" & str3 & "'")
        If rs.RecordCount <> 0 Then
            cPConn.Execute("update RB set dDate='" & str1 & "',cNR='" & str2 & "' where cCode='" & str3 & "'")
        Else
            Dim sBillCode As String = ""

            sBillCode = GetCode("Day", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
            cPConn.Execute("insert into RB(cCode,dDate,cNR,iPhoneNumber,dRBDate)values('" & sBillCode & "','" & str1 & "','" & str2 & "','" & HttpContext.Current.Session("iphone") & "','" & Now() & "')")

        End If


        Return "保存成功"

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Del(str1 As String) As String
        On Error Resume Next

        Dim rs As New ADODB.Recordset

        rs = cPConn.Execute("select * from RBView where cCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            cPConn.Execute("Delete from RB where cCode='" & str1 & "'")
            Return "删除成功"
        Else
            Return "已经删除"
        End If




    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SetRBDate(str1 As String) As String

        HttpContext.Current.Session("dRBDate") = str1

        Return "赋值成功"





    End Function

    Private Sub A_WorkView_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Session("iphone") = "" Then Response.Redirect("A_login.aspx")
    End Sub
End Class
