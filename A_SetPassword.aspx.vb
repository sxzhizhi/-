
Partial Class A_SetPassword

    Inherits System.Web.UI.Page

    Private Sub but_Save_ServerClick(sender As Object, e As EventArgs) Handles but_Save.ServerClick
        Dim rs As New ADODB.Recordset
        Dim sMM As String
        '判断关键字段不能为空，做校验


        Password1.Text = Replace(Password1.Text, " ", "")
        Password1.Text = Replace(Password1.Text, "'", "")

        Password2.Text = Replace(Password2.Text, " ", "")
        Password2.Text = Replace(Password2.Text, "'", "")

        Password3.Text = Replace(Password3.Text, " ", "")
        Password3.Text = Replace(Password3.Text, "'", "")


        If Me.Password1.Text = "" Or Me.Password2.Text = "" Or Me.Password3.Text = "" Then

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>Msg1();</script>")

            Exit Sub

        End If

        rs = cPConn.Execute("select * from dbUser where cName='" & Session("userid") & "'")



        If rs.Fields("cPass").Value <> DigestStrToHexStr(Me.Password1.Text) Then

            Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>Msg2();</script>")
            Me.Password1.Focus()
            Exit Sub

        End If

        If Me.Password2.Text <> Me.Password3.Text Then
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>Msg3();</script>")
            Me.Password2.Focus()
            Exit Sub
        End If

        '保存数据


        sMM = DigestStrToHexStr(Me.Password3.Text)


        rs = cPConn.Execute("update dbUser set cPass='" & sMM & "' where cName='" & Session("userid") & "'")


        '提示保存完毕
        Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>SaveMsg();</script>")

        'Response.Redirect("A_Setting.aspx")

    End Sub
End Class
