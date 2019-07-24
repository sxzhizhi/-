
Partial Class Default2
    Inherits System.Web.UI.Page

    Private Sub Default2_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim files As HttpFileCollection = Request.Files
        Dim msg As String = String.Empty



        Dim File_error As String = String.Empty

        Dim imgurl As String

        If (files.Count > 0) Then

            files(0).SaveAs(Server.MapPath("/") + System.IO.Path.GetFileName(files(0).FileName))
            'msg = " 成功! 文件大小为:" + files(0).ContentLength
            msg = " 成功!"
            imgurl = "/" + files(0).FileName
            Dim res As String = "{ Error:'" + File_error + "', msg:'" + msg + "',imgurl:'" + imgurl + "'}"
            Response.Write(res)
            Response.End()

        End If



    End Sub
End Class
