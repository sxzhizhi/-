
Partial Class A_Upload
    Inherits System.Web.UI.Page

    Private Sub A_Upload_Load(sender As Object, e As EventArgs) Handles Me.Load



        Dim file1 As HttpPostedFile = Request.Files(0)

        Dim fileStream = file1.InputStream


        Dim key_id As String = "LTAIUBpwuKt4IglZ"
        Dim key_secret As String = "srfKyLFo9VyESZjVXoee56MUb8Zu7a"
        Dim endpoint As String = "https://oss-cn-beijing.aliyuncs.com"
        Dim client As New Aliyun.OSS.OssClient(endpoint, key_id, key_secret)
        Dim FileName = System.IO.Path.GetFileName(file1.FileName)
        Dim SplitFileName = FileName.Split(".")
        Dim AtterFileName = Session("NoticeCode") + "." + SplitFileName(1)



        Try
            client.PutObject("aiwei-image", "TZ/" & AtterFileName, fileStream)
            cPConn.Execute("update dbTZ set cURL='https://aiwei-image.oss-cn-beijing.aliyuncs.com/TZ/" & AtterFileName & "' where cCode='" & Session("NoticeCode") & "'")

            Console.WriteLine("Put object succeeded")

        Catch ex As Exception
            Console.WriteLine("Put object failed, {0}", ex.Message)
        End Try


        'If file1.ContentLength < 5000000 Then

        '    If file1.ContentType.Contains("image/") Then


        '        'Dim img As System.Drawing.Image = System.Drawing.Image.FromStream(file1.InputStream)
        '        Dim FileName = System.IO.Path.GetFileName(file1.FileName)

        '        ''Dim msg As String = String.Empty
        '        ''Dim File_error As String = String.Empty
        '        ''Dim imgurl As String = String.Empty

        '        Dim SplitFileName = FileName.Split(".")

        '        ''Dim AtterFileName = DateTime.Now.ToString("yyyMMddHHmmss") + "." + SplitFileName(1)
        '        Dim AtterFileName = Session("NoticeCode") + "." + SplitFileName(1)
        '        'img.Save(Server.MapPath("/Notice/" + AtterFileName))

        '        cPConn.Execute("update dbTZ set cURL='http://my.aiwei.biz/aw/Notice/" & AtterFileName & "' where cCode='" & Session("NoticeCode") & "'")

        '        'msg = "上传成功！"
        '        'imgurl = "/" + AtterFileName


        '        'Dim res As String = "{ error:'" + File_error + "', msg:'" + msg + "',imgurl:'" + imgurl + "'}"
        '        'Response.Write(res)
        '        'Response.End()

        '    Else
        '        Response.Write("<script>alert('该文件不是图片格式！');</script>")
        '    End If
        'Else
        '    Response.Write("<script>alert('文件不能大于5M！');</script>")
        'End If

    End Sub



    <System.Web.Services.WebMethod()>
    Public Shared Function test(str1 As String) As String
        'On Error Resume Next


        'Dim files As HttpFileCollection = str1
        'Dim aaa As HtmlForm = str1

        Dim key_id As String = "LTAIUBpwuKt4IglZ"
        Dim key_secret As String = "srfKyLFo9VyESZjVXoee56MUb8Zu7a"
        Dim endpoint As String = "https://oss-cn-beijing.aliyuncs.com"
        Dim client As New Aliyun.OSS.OssClient(endpoint, key_id, key_secret)


        Try

            Dim Str As String = str1

            Dim binaryData As Byte() = Encoding.ASCII.GetBytes(Str)
            Dim requestContent As System.IO.MemoryStream = New IO.MemoryStream(binaryData)

            client.PutObject("aiwei-image", "dyp", requestContent)

            Console.WriteLine("Put object succeeded")

        Catch ex As Exception
            Console.WriteLine("Put object failed, {0}", ex.Message)
        End Try

        Return "成功"





    End Function
End Class
