
Partial Class A_Iofo

    Inherits System.Web.UI.Page

    Private Sub A_Iofo_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Session("iphone") = "" Then Response.Redirect("A_login.aspx")

        Session("onelevel") = "0"


        Dim rs As New ADODB.Recordset

        Session("AppNumber") = 0
        rs = cPConn.Execute("select count(cPhoneNumber) as number from [dbTZ] where cPhoneNumber='" & Session("iphone") & "' and zDeptCode='" & Session("usercode") & "' and bView='0' and cNR='申请加入' group by cPhoneNumber")

        If rs.RecordCount <> 0 Then

            Session("AppNumber") = rs.Fields("number").Value

        End If



        Session("IofoNumber") = 0
        rs = cPConn.Execute("select count(cPhoneNumber) as number from [dbTZListView] where cPhoneNumber='" & Session("iphone") & "' and zDeptCode='" & Session("usercode") & "' and bDel='0' and bView='0' group by cPhoneNumber")

        If rs.RecordCount <> 0 Then

            Session("IofoNumber") = rs.Fields("number").Value

        End If

        Session("AddrNumber") = 0
        rs = cPConn.Execute("select count(cPhoneNumber) as number from [dbTZ] where cPhoneNumber='" & Session("iphone") & "' and zDeptCode='" & Session("usercode") & "' and bView='0' and cNR<>'申请加入' group by cPhoneNumber")

        If rs.RecordCount <> 0 Then

            Session("AddrNumber") = rs.Fields("number").Value

        End If

    End Sub


End Class
