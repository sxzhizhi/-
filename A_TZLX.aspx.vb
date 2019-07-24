
Partial Class A_TZLX


    Inherits System.Web.UI.Page

    Private Sub A_TZLX_Load(sender As Object, e As EventArgs) Handles Me.Load
        Session("onelevel") = "2"
        If Session("iphone") = "" Then Response.Redirect("A_login.aspx")
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function saveTZLX(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        str1 = Replace(str1, "'", "")


        Dim sBillCode As String = ""


        rs = cPConn.Execute("Select * from DicTZLX where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cTZLXName='" & str1 & "'")

        If rs.RecordCount = 0 Then

            sBillCode = GetCode("TZLX", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
            cPConn.Execute("insert into DicTZLX(cTZLXCode,zDeptCode,cTZLXName)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & str1 & "')")
            Return "保存成功"
        Else
            Return "已存在"
        End If


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function saveTZLX1(str1 As String, str2 As String) As String
        'On Error Resume Next

        Dim rs, re As New ADODB.Recordset

        str2 = Replace(str2, "'", "")


        Dim sBillCode As String = ""


        rs = cPConn.Execute("Select * from DicTZLX where cTZLXCode='" & str1 & "' and zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
        If rs.RecordCount <> 0 Then

            re = cPConn.Execute("Select * from DicTZLX where cTZLXCode<>'" & rs.Fields("cTZLXCode").Value & "' and cTZLXName='" & str2 & "'")

            If re.RecordCount = 0 Then
                cPConn.Execute("update DicTZLX set cTZLXName='" & str2 & "' where cTZLXCode='" & str1 & "'")
                Return "保存成功"
            Else
                Return "已存在"
            End If



        Else
            sBillCode = GetCode("TZLX", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
            cPConn.Execute("insert into DicTZLX(cTZLXCode,zDeptCode,cTZLXName)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & str2 & "')")
            Return "保存成功"
        End If




    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function Del(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        rs = cPConn.Execute("select * from DicTZLX where cTZLXCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            cPConn.Execute("Delete from DicTZLX where cTZLXCode='" & str1 & "'")
            Return "删除成功"
        Else
            Return "已经删除"
        End If




    End Function


End Class
