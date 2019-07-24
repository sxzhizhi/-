
Partial Class A_Login
    Inherits System.Web.UI.Page

    Protected Sub Btn_Login_Click(sender As Object, e As EventArgs) Handles Btn_Login.Click
        On Error GoTo errhand
        Dim rs, re As New ADODB.Recordset
        Dim cWebUser As String
        Dim cWebPassword As String

        If email.Text = "" Then
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>Msg1();</script>")
            'Me.Label1.Visible = True
            'Me.Label2.Visible = False
            'Me.Label3.Visible = False
            'Me.Label4.Visible = False
            email.Focus()
            Exit Sub
        End If

        If password.Text = "" Then
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>Msg2();</script>")
            'Me.Label1.Visible = False
            'Me.Label2.Visible = True
            'Me.Label3.Visible = False
            'Me.Label4.Visible = False
            password.Focus()
            Exit Sub
        End If



        cWebUser = Replace(email.Text, " ", "")
        cWebUser = Replace(email.Text, "'", "")

        cWebPassword = Replace(password.Text, " ", "")
        cWebPassword = Replace(password.Text, "'", "")

        '连接数据库文档，如不能成功则不执行
        If ReadSystemSet() = False Then Exit Sub


        If bMLink = False Then

            bMLink = main01()

        End If

        rs = cPConn.Execute("Select * from dbUserView where cName='" & cWebUser & "'")

        If rs.RecordCount = 0 Then

            '判断手机号
            re = cPConn.Execute("select * from dbUserView where iphoneNumber='" & cWebUser & "'")
            If re.RecordCount = 0 Then
                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>Msg3();</script>")
                'Me.Label1.Visible = False
                'Me.Label2.Visible = False
                'Me.Label3.Visible = True
                'Me.Label4.Visible = False

                Dim cookie As New HttpCookie("user_rqd")
                Response.AppendCookie(cookie)
                cookie.Expires = DateTime.Now.AddDays(-1)

                Dim cookie2 As New HttpCookie("wxuser_rqd")
                Response.AppendCookie(cookie2)
                cookie2.Expires = DateTime.Now.AddDays(-1)


                Me.email.Focus()
                'LinkButton1_Click(sender, e)
                Exit Sub
            Else
                If re.Fields("cPass").Value <> DigestStrToHexStr(cWebPassword) Then


                    Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>Msg3();</script>")
                    Dim cookie1 As New HttpCookie("user_rqd")
                    Response.AppendCookie(cookie1)
                    cookie1.Expires = DateTime.Now.AddDays(-1)

                    Dim cookie2 As New HttpCookie("wxuser_rqd")
                    Response.AppendCookie(cookie2)
                    cookie2.Expires = DateTime.Now.AddDays(-1)

                    Me.password.Focus()

                    Exit Sub
                Else

                    '当前用户
                    Session("iphone") = cWebUser
                    Session("userid") = re.Fields("cName").Value
                    Session("name") = re.Fields("cClassName").Value
                    Session("job") = re.Fields("cDeptJob").Value
                    Session("email") = re.Fields("cEmail").Value
                    '为1公司创建用户
                    Session("Popdom") = re.Fields("Popdom").Value
                    '所属公司名称
                    Session("username") = re.Fields("zDeptName").Value
                    '所属公司编码
                    Session("usercode") = re.Fields("zDeptCode").Value

                    Session("url") = re.Fields("wxheadimgurl").Value


                    re.Close()
                    re = Nothing

                    GoTo Login

                End If



            End If

        Else

            If rs.Fields("cPass").Value <> DigestStrToHexStr(cWebPassword) Then

                Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>Msg3();</script>")

                'Me.Label1.Visible = False
                'Me.Label2.Visible = False
                'Me.Label3.Visible = True
                'Me.Label4.Visible = False


                Dim cookie1 As New HttpCookie("user_rqd")
                Response.AppendCookie(cookie1)
                cookie1.Expires = DateTime.Now.AddDays(-1)

                Dim cookie2 As New HttpCookie("wxuser_rqd")
                Response.AppendCookie(cookie2)
                cookie2.Expires = DateTime.Now.AddDays(-1)

                Me.password.Focus()
                'LinkButton1_Click(sender, e)
                Exit Sub
            Else

                '当前用户
                Session("userid") = cWebUser
                Session("iphone") = rs.Fields("iphoneNumber").Value
                Session("name") = rs.Fields("cClassName").Value
                Session("job") = rs.Fields("cDeptJob").Value
                Session("email") = rs.Fields("cEmail").Value
                '为1公司创建用户
                Session("Popdom") = rs.Fields("Popdom").Value
                '所属公司名称
                Session("username") = rs.Fields("zDeptName").Value

                Session("url") = rs.Fields("wxheadimgurl").Value
                '所属公司编码
                Session("usercode") = rs.Fields("zDeptCode").Value
                'SQL条件
                Session("sWhere") = ""


                'If Left(Session("usercode"), 2) = "KB" Then
                '    Session("username") = rs.Fields("zDeptName").Value
                '    '分管领导手机号
                '    Session("iphone") = rs.Fields("iphone").Value
                '    Session("sWhere") = " where TBR='" & Session("userid") & "' "
                '    Session("bSH") = False
                'ElseIf Left(Session("usercode"), 2) = "FB" Then
                '    Session("username") = "中心领导"
                '    Session("sWhere") = " where YHM='" & Session("userid") & "' "
                '    Session("bSH") = True
                'Else
                '    'Session("username") = "超级管理员"
                '    Session("sWhere") = " where TBR='" & Session("userid") & "' "
                '    Session("bSH") = False
                'End If



                '项目编码
                Session("Code") = ""
                '初始
                Session("bMLoadCode") = 0

            End If

Login:
            Dim cookie As New HttpCookie("user_rqd")
            cookie.Values.Add("uname_rqd", HttpUtility.UrlEncode(email.Text))
            cookie.Values.Add("pwd_rqd", HttpUtility.UrlEncode(password.Text))
            Response.AppendCookie(cookie)
            cookie.Expires = DateTime.Now.AddDays(500)


            cPLogin = True

            rs.Close()
            rs = Nothing

            'If Session("username") = "中心领导" Then
            '    Response.Redirect("M_Index.aspx")
            'Else
            '    Response.Redirect("M_ZJIndex.aspx")
            'End If

            If Session("TZCode") <> "" Then
                Response.Redirect("A_NoticeView.aspx")
            ElseIf Session("QLCode") <> "" Then
                Response.Redirect("A_HelpView.aspx")
            Else
                Response.Redirect("A_App.aspx")
            End If

            'Response.Redirect("A_App.aspx")






errhand:
            If Err.Number <> 0 Then
                Select Case Err.Number
                    Case Else
                        'MsgBox("错 误 号：" & Err.Number & vbCrLf &
                        '"错误信息：" & Err.Description & vbCr &
                        '       vbTab & "    录入的查询条件不正确，请重试！" &
                        '  "", vbInformation, "提示")
                        'bMLink = False

                        Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>alert('" + Trim(Replace(Err.Description, "'", "")) + "')</script>")


                        Me.Label1.Visible = False
                        Me.Label2.Visible = False
                        Me.Label3.Visible = False
                        'Me.Label4.Visible = False
                        Exit Sub
                End Select
            End If
        End If



    End Sub

    Private Sub A_Login_Load(sender As Object, e As EventArgs) Handles Me.Load

        '如果是登陆成功后用户注销的话，出现登录界面

        '
        'If Session("bExit") = True Then Exit Sub

        '连接数据库文档，如不能成功则不执行
        If ReadSystemSet() = False Then Exit Sub

        '连接数据库
        If bMLink = False Then
            bMLink = main01()
        End If

        '微信用户id
        Dim openid As String = ""

        Dim rs As New ADODB.Recordset

        If IsNothing(Request.Item("user_rqd")) = False Then

            email.Text = HttpUtility.UrlDecode(Request.Cookies("user_rqd")("uname_rqd"))
            password.Text = HttpUtility.UrlDecode(Request.Cookies("user_rqd")("pwd_rqd"))

            Call Btn_Login_Click(sender, e)

        ElseIf IsNothing(Request.Item("wxuser_rqd")) = False Then

            'Dim rs As New ADODB.Recordset

            Session("iphone") = HttpUtility.UrlDecode(Request.Cookies("wxuser_rqd")("wxuname_rqd"))
            'Session("openid") = HttpUtility.UrlDecode(Request.Cookies("wxuser_rqd")("wxopenid_rqd"))

            rs = cPConn.Execute("Select * from dbuserview where iphoneNumber='" & Session("iphone") & "'")
            If rs.RecordCount <> 0 Then

                '当前用户
                HttpContext.Current.Session("userid") = rs.Fields("cname").Value
                HttpContext.Current.Session("openid") = rs.Fields("wxname").Value
                HttpContext.Current.Session("url") = rs.Fields("wxheadimgurl").Value
                HttpContext.Current.Session("name") = rs.Fields("cClassName").Value
                HttpContext.Current.Session("job") = rs.Fields("cDeptJob").Value
                HttpContext.Current.Session("email") = rs.Fields("cEmail").Value
                '为1就是公司管理人员用户
                HttpContext.Current.Session("Popdom") = rs.Fields("Popdom").Value
                '所属公司名称
                HttpContext.Current.Session("username") = rs.Fields("zDeptName").Value
                '所属公司编码
                HttpContext.Current.Session("usercode") = rs.Fields("zDeptCode").Value
                '是否为首次微信用户登录
                HttpContext.Current.Session("WXUser") = False

            End If
            If Session("TZCode") <> "" Then
                Response.Redirect("A_NoticeView.aspx")
            ElseIf Session("QLCode") <> "" Then
                Response.Redirect("A_HelpView.aspx")
            Else
                Response.Redirect("A_App.aspx")
            End If


        End If





        '如果没有cookies执行下面的
        Dim code = Request.QueryString("code")
        '需要更新微信的时执行或是单击了微信登录时执行
        If code <> Nothing Then
            '获取当前微信用户ID
            openid = GetOpenid(code)

            Dim aa = Right(openid, Len(openid) - InStr(openid, "openid") + 1)

            Dim bb = Left(aa, InStr(aa, "scope") - 4)

            openid = Right(bb, Len(bb) - 9)

            Dim cc As String = ""

            '调用微信获取信息
            cc = GetWX(openid)

            'Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>alert('" & cc & "！')</script>")


            If cc = "未关注" Then
                '打开关注页面
                Response.Redirect("A_Follow.aspx")
            ElseIf cc = "成功" Then

                If Session("TZCode") <> "" Then
                    Response.Redirect("A_NoticeView.aspx")
                ElseIf Session("QLCode") <> "" Then
                    Response.Redirect("A_HelpView.aspx")
                Else
                    Response.Redirect("A_App.aspx")
                End If

            ElseIf cc = "失败" Then
                Response.Redirect("A_Login1.aspx")
            End If


        Else

            Dim appid As String = "wxd19bd0389e56e567"
            Dim redirect_uri As String = "http%3a%2f%2fmy.aiwei.biz%2faw"
            Dim url As String = String.Format("https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect", appid, redirect_uri)
            Response.Redirect(url)

        End If


    End Sub

    Public Shared Function main01() As Boolean
        On Error GoTo errhand
        Dim mSql As String



        cPConn.CursorLocation = ADODB.CursorLocationEnum.adUseClient
        cPConn.ConnectionTimeout = 10
        cPConn.CommandTimeout = 0



        mSql = "Provider=SQLOLEDB;server=" & mServer & ";database=" & mDataBase & ";uid=" & mUser & ";pwd=" & mPassWord
        'mSql = "Provider=SQLOLEDB;server=" & mServer & ";database=" & mDataBase & ";uid=conn_wl;pwd=" & mPassWord
        'mSql = "Data Source=" & mServer & ";Initial Catalog=" & mDataBase & ";User ID=" & mUser & ";Password=" & mPassWord


        'mSql = "Provider=SQLOLEDB.1;Password=" & mPassWord & ";Persist Security Info=True;User ID=" & mUser & ";Initial Catalog=" & mDataBase & ";Data Source=" & mServer
        'mSql = "Data Source=47.94.23.102;Initial Catalog=WSN_TY;User ID=sa;Password=p@ssw0rd"
        'mSql = "PROVIDER=MSDataShape;Data PROVIDER=MSDASQL;uid=as;pwd=p@ssw0rd;DRIVER=SQL Server;DATABASE=WSN_TY;WSID=GQSOFT;SERVER=47.94.23.102"



        cPConn.Open(mSql)

        main01 = True

        On Error GoTo 0

        Exit Function
errhand:
        Select Case Err.Number
            Case -2147467259
                'MsgBox(vbCrLf & "数据库管理服务器中数据库管理程序未启动，请先打开该程序。" & vbCrLf & _
                '        vbCrLf & _
                '       "或指定的服务器不存在。", vbOKOnly + vbInformation, "提示")
                main01 = False
                Exit Function
            Case 3705
                'MsgBox("错 误 号：" & Err.Number & vbCrLf & "错误信息：" & Err.Description & _
                '    vbCrLf & "请通知系统管理员！", vbOKOnly + vbSystemModal, "提示")
                main01 = False
                Exit Function
            Case Else
                'MsgBox("错 误 号：" & Err.Number & vbCrLf & "错误信息：" & Err.Description & _
                '    vbCrLf & "请通知系统管理员！", vbOKOnly + vbSystemModal, "提示")
                main01 = False
                Exit Function
        End Select

        Err.Clear()
Err_Hand:
        'MsgBox("系统文件错误，请通知系统管理员...", vbOKOnly + vbInformation, "提示")
        main01 = False



    End Function
    Public Function ReadSystemSet() As Boolean
        'On Error Resume Next
        'Dim oFSO As New Scripting.FileSystemObject
        'Dim tTextStream As Scripting.TextStream
        'cPHostName = GetHostName()
        'If cPHostName = "Cancel" Then
        '    MsgBox("主机名称不能正确取得！请通知系统管理员...", MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "提示")
        '    Exit Sub
        'End If

        Dim Fso = Server.CreateObject("Scripting.FileSystemObject")
        Dim Filen = Server.MapPath("App_Code/AiWei.ini")
        Dim StrBuf As String

        Dim sServer As String = ""
        Dim sDataBase As String = ""
        Dim sUser As String = ""
        Dim sPassWord As String = ""
        Dim sDomain As String = ""

        Dim Site_Config = Fso.OpenTextFile(Filen, 1)

        Do While Not Site_Config.AtEndOfStream

            StrBuf = Site_Config.ReadLine
            If StrBuf = "[Data]" Then
                StrBuf = Site_Config.ReadLine
                If LCase(Left(StrBuf, InStr(1, StrBuf, "=") - 1)) = "server" Then
                    sServer = Trim(Mid(StrBuf, InStr(1, StrBuf, "=") + 1))
                End If

                StrBuf = Site_Config.ReadLine
                If LCase(Left(StrBuf, InStr(1, StrBuf, "=") - 1)) = "database" Then
                    sDataBase = Trim(Mid(StrBuf, InStr(1, StrBuf, "=") + 1))
                End If

                StrBuf = Site_Config.ReadLine

                If LCase(Left(StrBuf, InStr(1, StrBuf, "=") - 1)) = "user" Then
                    sUser = Trim(Mid(StrBuf, InStr(1, StrBuf, "=") + 1))
                End If

                StrBuf = Site_Config.ReadLine
                If LCase(Left(StrBuf, InStr(1, StrBuf, "=") - 1)) = "password" Then
                    sPassWord = Trim(Mid(StrBuf, InStr(1, StrBuf, "=") + 1))
                End If

                StrBuf = Site_Config.ReadLine
                If LCase(Left(StrBuf, InStr(1, StrBuf, "=") - 1)) = "domain" Then
                    sDomain = Trim(Mid(StrBuf, InStr(1, StrBuf, "=") + 1))
                End If
            End If
        Loop



        If sServer = "" Or sDataBase = "" Or sUser = "" Or sPassWord = "" Or sDomain = "" Then GoTo Err_Hand

        mServer = sServer
        mDataBase = sDataBase
        mUser = sUser
        mPassWord = sPassWord
        mDomain = sDomain

        ReadSystemSet = True
        Exit Function


Err_Hand:
        'MsgBox("系统文件错误，请正确部署系统或咨询售后技术支持...", vbOKOnly + vbInformation, "提示")
        ReadSystemSet = False
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function EyeData(str As String) As String
        If str = "" Then
            Return "请选择日期!"
            Exit Function
        End If
        Dim rs As New ADODB.Recordset
        Dim str1 As String = ""

        Dim DDJG As String = IIf(HttpContext.Current.Session("TJDDJG") = "请选择", "", " and DDJGMC='" & HttpContext.Current.Session("TJDDJG") & "'")

        If HttpContext.Current.Session("TJData") = "1" Then

            rs = cPConn.Execute("select DDJGMC,count(DDJGMC) as mc from HZXXBView where zNDName='" & HttpContext.Current.Session("TJND") & "' " & DDJG & " group by DDJGMC  ")
            If rs.RecordCount <> 0 Then
                'str1 = rs.Fields("GLJG").Value
                For i = 0 To rs.RecordCount - 1
                    'str1 += """" + rs.Fields("GLJGMC").Value.ToString + ""","
                    str1 += """" + rs.Fields("DDJGMC").Value.ToString + """," & """" + rs.Fields("MC").Value.ToString + ""","
                    rs.MoveNext()
                Next
            Else
                Return "没有数据!"
                Exit Function
            End If

        ElseIf HttpContext.Current.Session("TJData") = "2" Then
            rs = cPConn.Execute("select SSFS,count(SSFS) as FS from HZXXBView where zNDName='" & HttpContext.Current.Session("TJND") & "' " & DDJG & " group by SSFS  ")
            If rs.RecordCount <> 0 Then
                'str1 = rs.Fields("GLJG").Value
                For i = 0 To rs.RecordCount - 1
                    'str1 += """" + rs.Fields("GLJGMC").Value.ToString + ""","
                    str1 += """" + rs.Fields("SSFS").Value.ToString + """," & """" + rs.Fields("FS").Value.ToString + ""","
                    rs.MoveNext()
                Next
            Else
                Return "没有数据!"
                Exit Function
            End If
        ElseIf HttpContext.Current.Session("TJData") = "3" Then

            rs = cPConn.Execute("select FYQK,count(FYQK) as QK from HZXXBView where zNDName='" & HttpContext.Current.Session("TJND") & "' " & DDJG & " group by FYQK  ")
            If rs.RecordCount <> 0 Then
                'str1 = rs.Fields("GLJG").Value
                For i = 0 To rs.RecordCount - 1
                    'str1 += """" + rs.Fields("GLJGMC").Value.ToString + ""","
                    str1 += """" + rs.Fields("FYQK").Value.ToString + """," & """" + rs.Fields("QK").Value.ToString + ""","
                    rs.MoveNext()
                Next
            Else
                Return "没有数据!"
                Exit Function
            End If




        ElseIf HttpContext.Current.Session("TJData") = "4" Then

            rs = cPConn.Execute("select XB,count(XB) as B from HZXXBView where zNDName='" & HttpContext.Current.Session("TJND") & "' " & DDJG & " group by XB  ")
            If rs.RecordCount <> 0 Then
                'str1 = rs.Fields("GLJG").Value
                For i = 0 To rs.RecordCount - 1
                    'str1 += """" + rs.Fields("GLJGMC").Value.ToString + ""","
                    str1 += """" + rs.Fields("XB").Value.ToString + """," & """" + rs.Fields("B").Value.ToString + ""","
                    rs.MoveNext()
                Next
            Else
                Return "没有数据!"
                Exit Function
            End If



        End If


        'Call SendSms()

        str1 = Strings.Left(str1, Strings.Len(str1) - 1)

        Return "[" + str1 + "]"

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SendSms(str As String) As String

        Dim client As New Aliyun.MNS.MNSClient("LTAIUBpwuKt4IglZ", "srfKyLFo9VyESZjVXoee56MUb8Zu7a", "http://1102294392831800.mns.cn-beijing.aliyuncs.com/")

        Dim topic As Aliyun.MNS.Topic
        topic = client.GetNativeTopic("sms.topic-cn-beijing")




        Dim messageAttributes As New Aliyun.MNS.Model.MessageAttributes

        Dim batchSmsAttributes As New Aliyun.MNS.Model.BatchSmsAttributes

        batchSmsAttributes.FreeSignName = "爱为办公系统"

        batchSmsAttributes.TemplateCode = "SMS_126085009"

        'Dictionary<string, string> param = new Dictionary<string, string>()


        Dim param As New Dictionary(Of String, String)

        Dim s As String = "0123456789"

        Dim x As String = ""
        For i = 1 To 6
            x = x & Mid(s, Int(Rnd() * Len(s) + 1), 1)
        Next
        x = x * Now.Second
        If Len(x) > 6 Then
            x = Left(x, 6)
        End If


        param.Add("code", "" & x & "")

        batchSmsAttributes.AddReceiver("" & str & "", param)

        messageAttributes.BatchSmsAttributes = batchSmsAttributes
        'PublishMessageRequest request = New PublishMessageRequest();

        Dim request As New Aliyun.MNS.Model.PublishMessageRequest
        request.MessageAttributes = messageAttributes


        request.MessageBody = "smsmessage"



        'PublishMessageResponse resp = topic.PublishMessage(request)

        Dim resp As New Aliyun.MNS.Model.PublishMessageResponse()

        resp = topic.PublishMessage(request)


        Console.WriteLine(resp.MessageId)

        HttpContext.Current.Session("iphone") = str
        HttpContext.Current.Session("iphoneCode") = x

        Return "发送成功"

        Exit Function


Err_Hand:


        Return "发送失败"

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function iPhoneLog(str1 As String, str2 As String) As String
        On Error Resume Next

        Dim rs As New ADODB.Recordset

        If str1 = HttpContext.Current.Session("iphone") And str2 = HttpContext.Current.Session("iphoneCode") Then

            'Response.Redirect("A_App.aspx")


            rs = cPConn.Execute("select * from dbuserView where iphoneNumber='" & str1 & "'")
            If rs.RecordCount = 0 Then

                cPConn.Execute("insert into dbuser (iphonenumber,cName) values('" & str1 & "','" & str1 & "')")
                HttpContext.Current.Session("userid") = str1
                HttpContext.Current.Session("iphone") = str1

            Else

                HttpContext.Current.Session("userid") = rs.Fields("cName").Value
                HttpContext.Current.Session("iphone") = str1
                HttpContext.Current.Session("name") = rs.Fields("cClassName").Value
                HttpContext.Current.Session("job") = rs.Fields("cDeptJob").Value
                HttpContext.Current.Session("email") = rs.Fields("cEmail").Value

                '为1公司创建用户
                HttpContext.Current.Session("Popdom") = rs.Fields("Popdom").Value
                '所属公司名称
                HttpContext.Current.Session("username") = rs.Fields("zDeptName").Value
                '所属公司编码
                HttpContext.Current.Session("usercode") = rs.Fields("zDeptCode").Value


            End If

            '当前用户


            Return "登录成功"
        Else
            Return "登录失败"
        End If



    End Function





    <System.Web.Services.WebMethod()>
    Public Shared Function iPhoneReg(str1 As String, str2 As String, str3 As String) As String
        On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim pass As String

        pass = DigestStrToHexStr(str3)

        If str1 = HttpContext.Current.Session("iphone") And str2 = HttpContext.Current.Session("iphoneCode") Then

            rs = cPConn.Execute("select * from dbuser where iphoneNumber='" & str1 & "'")
            If rs.RecordCount = 0 Then


                cPConn.Execute("insert into dbuser (cName,iphonenumber,cpass) values('" & str1 & "','" & str1 & "','" & pass & "')")

            Else
                Return "已经注册"
            End If

            '当前用户
            HttpContext.Current.Session("userid") = str1
            HttpContext.Current.Session("iphone") = str1


            Return "注册成功"
        Else
            Return "注册失败"
        End If



    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function iPhoneModify(str1 As String, str2 As String, str3 As String) As String
        On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim pass As String
        pass = DigestStrToHexStr(str3)

        If str1 = HttpContext.Current.Session("iphone") And str2 = HttpContext.Current.Session("iphoneCode") Then

            rs = cPConn.Execute("select * from dbuser where iphoneNumber='" & str1 & "'")
            If rs.RecordCount = 0 Then
                cPConn.Execute("insert into dbuser (iphonenumber,cpass) values('" & str1 & "','" & pass & "')")
            Else
                cPConn.Execute("update dbuser set cpass='" & pass & "' where iphoneNumber='" & str1 & "'")
            End If

            '当前用户
            HttpContext.Current.Session("userid") = str1

            Return "修改成功"
        Else
            Return "修改失败"
        End If



    End Function



    Public Function icookies() As String
        icookies = ""

        Dim cookie As New HttpCookie("user_rqd")
        cookie.Values.Add("uname_rqd", HttpUtility.UrlEncode(email.Text))
        cookie.Values.Add("pwd_rqd", HttpUtility.UrlEncode(password.Text))
        Response.AppendCookie(cookie)
        cookie.Expires = DateTime.Now.AddDays(500)


        Return icookies
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function GetOpenid(str1 As String) As String


        Dim rs As New ADODB.Recordset
        Dim strReturn As String = ""
        If bMLink = False Then
            bMLink = main01()
        End If


        rs = cPConn.Execute("Select * from WXToken")
        If rs.RecordCount <> 0 Then

            Dim appid As String = rs.Fields("appid").Value
            Dim secret As String = rs.Fields("secret").Value
            'str1 = "001k0uUd0ewhLA1rqHUd00YvUd0k0uUm"

            Dim tokenUrl As String = String.Format("https://api.weixin.qq.com/sns/oauth2/access_token?appid={0}&secret={1}&code={2}&grant_type=authorization_code", appid, secret, str1)


            Dim we As New Net.WebClient
            strReturn = we.DownloadString(tokenUrl)
        End If

        Return strReturn


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetWX(str1 As String) As String
        Dim strReturn As String = ""
        Dim rs As New ADODB.Recordset

        Dim openid As String = str1

        Dim subscribe As String = ""        '是否关注公众号0是没有，1是关注，如果没关注后面无信息
        Dim nickname As String = ""         '昵称
        Dim sex As String = ""              '值为1时是男性，值为2时是女性，值为0时是未知
        Dim city As String = ""             '城市
        Dim province As String = ""         '省份
        Dim headimgurl As String = ""       '头像地址

        Dim aa As String = ""
        Dim bb As String = ""
        rs = cPConn.Execute("Select * from WXToken")
        If rs.RecordCount <> 0 Then

            'Dim appid As String = rs.Fields("appid").Value
            'Dim secret As String = rs.Fields("secret").Value
            Dim token As String = rs.Fields("accesstoken").Value
            Dim tokenUrl As String = String.Format("https://api.weixin.qq.com/cgi-bin/user/info?access_token={0}&openid={1}&lang=zh_CN", token, openid)
            Dim we As New Net.WebClient

            we.Encoding = Encoding.UTF8

            strReturn = we.DownloadString(tokenUrl)

        End If



        aa = Right(strReturn, Len(strReturn) - InStr(strReturn, "subscribe") + 1)
        bb = Left(aa, InStr(aa, "openid") - 3)
        subscribe = Right(bb, Len(bb) - 11)

        If subscribe = "1" Then

            aa = Right(strReturn, Len(strReturn) - InStr(strReturn, "nickname") + 1)

            bb = Left(aa, InStr(aa, "sex") - 4)

            nickname = Right(bb, Len(bb) - 11)


            aa = Right(strReturn, Len(strReturn) - InStr(strReturn, "sex") + 1)

            bb = Left(aa, InStr(aa, "language") - 3)
            '一般来说最后减多少和sex加2
            sex = Right(bb, Len(bb) - 5)
            sex = IIf(sex = "1", "男", "女")

            aa = Right(strReturn, Len(strReturn) - InStr(strReturn, "city") + 1)

            bb = Left(aa, InStr(aa, "province") - 4)
            '一般来说最后减多少和sex加2
            city = Right(bb, Len(bb) - 7)


            aa = Right(strReturn, Len(strReturn) - InStr(strReturn, "province") + 1)

            bb = Left(aa, InStr(aa, "country") - 4)
            '一般来说最后减多少和sex加2
            province = Right(bb, Len(bb) - 11)



            aa = Right(strReturn, Len(strReturn) - InStr(strReturn, "headimgurl") + 1)

            bb = Left(aa, InStr(aa, "subscribe_time") - 4)
            '一般来说最后减多少和sex加2
            headimgurl = Right(bb, Len(bb) - 13)

            headimgurl = Replace(headimgurl, "\", "")

        Else
            Return "未关注"
        End If
        'HttpContext.Current.Session("nickname") = subscribe & "," & nickname & "," & sex & "," & city & "," & province & "," & headimgurl
        'HttpContext.Current.Session("url") = headimgurl


        If openid <> Nothing Then
            '返回成功
            rs = cPConn.Execute("Select * from dbuserview where wxname='" & openid & "'")

            If rs.RecordCount <> 0 Then

                If rs.Fields("binit").Value <> 1 Then
                    cPConn.Execute("update dbuser set binit=1,wxheadimgurl ='" & headimgurl & "',wxnickname='" & nickname & "',cSex='" & sex & "',wxCity='" & city & "',wxProvince='" & province & "' where wxname='" & openid & "'")
                    HttpContext.Current.Session("url") = headimgurl
                Else
                    HttpContext.Current.Session("url") = IIf(IsDBNull(rs.Fields("wxheadimgurl").Value), "", rs.Fields("wxheadimgurl").Value)
                End If

                '当前用户
                HttpContext.Current.Session("name") = rs.Fields("cClassName").Value
                HttpContext.Current.Session("iphone") = rs.Fields("iphoneNumber").Value
                HttpContext.Current.Session("userid") = rs.Fields("cname").Value
                HttpContext.Current.Session("job") = rs.Fields("cDeptJob").Value
                HttpContext.Current.Session("email") = rs.Fields("cEmail").Value
                '为1公司创建用户
                HttpContext.Current.Session("Popdom") = rs.Fields("Popdom").Value
                '所属公司名称
                HttpContext.Current.Session("username") = rs.Fields("zDeptName").Value

                '所属公司编码
                HttpContext.Current.Session("usercode") = rs.Fields("zDeptCode").Value
                HttpContext.Current.Session("openid") = rs.Fields("wxname").Value

                '是否为首次微信用户
                HttpContext.Current.Session("WXUser") = True

            Else
                Dim sBillCode = GetCode("US", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

                cPConn.Execute("insert into dbuser(wxname,iphoneNumber,cClassName,wxnickname,wxheadimgurl,binit,wxCity,wxProvince,csex)values('" & openid & "','" & sBillCode & "','" & nickname & "','" & nickname & "','" & headimgurl & "',1,'" & city & "','" & province & "','" & sex & "')")

                HttpContext.Current.Session("iphone") = sBillCode
                HttpContext.Current.Session("openid") = openid

                HttpContext.Current.Session("userid") = sBillCode
                HttpContext.Current.Session("name") = nickname
                HttpContext.Current.Session("url") = headimgurl
                HttpContext.Current.Session("job") = ""
                HttpContext.Current.Session("email") = ""
                '为1公司创建用户
                HttpContext.Current.Session("Popdom") = ""
                '所属公司名称
                HttpContext.Current.Session("username") = ""

                '所属公司编码
                HttpContext.Current.Session("usercode") = ""
                '是否为首次微信用户
                HttpContext.Current.Session("WXUser") = True



            End If

            Return "成功"

        Else
            Return "失败"
        End If


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function WX(str1 As String) As String
        Dim strReturn As String = ""



        Dim JSON As Object
        JSON = CreateObject("MSScriptControl.ScriptControl")
        JSON.Language = "JScript"
        JSON = "{""name"":""傅红雪"",""age"":""24"",""profession"":""刺客""}"

        'JSON.eval("JSON=" & strReturn & ";JSON.access_token;")
        'json中获取指定数据下面是（access_token）
        Return JSON.eval(JSON = "{""name"":""傅红雪"",""age"":""24"",""profession"":""刺客""}" & ";JSON.age;")


    End Function

End Class
