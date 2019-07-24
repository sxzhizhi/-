
Partial Class A_NoticeView
    Inherits System.Web.UI.Page

    Private Sub A_NoticeView_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim code As String = ""
        Dim rs As New ADODB.Recordset

        If Session("TZCode") = "" Then
            code = Request.QueryString("code")
            Session("TZCode") = code

        Else
            code = Session("TZCode")

            'code = "TZ20180509-0007"
        End If

        If Session("iphone") <> "" Then
            Session("TZCode") = ""

            rs = cPConn.Execute("Select * from dbTZListView where cCode='" & code & "' and cPhoneNumber='" & Session("iphone") & "'")
            If rs.RecordCount <> 0 Then
                Me.T_Code1.Text = rs.Fields("cListCode").Value
                T_BT1.Text = rs.Fields("cBT").Value
                name.InnerText = rs.Fields("cJoinClassName").Value & " (" & Format(rs.Fields("dDate").Value, "MM月dd日 HH:mm") & ")"
                T_cJoinName1.InnerText = "通知：" & rs.Fields("cBZ").Value
                T_NR1.Text = rs.Fields("cNR").Value
                Me.imgPre1.Src = rs.Fields("cURL").Value
                '更新当前用户查看标志
                Call ViewTZ(T_Code1.Text, "")
                '返加更新已看、未看、评论及内部
                Call returnData(code)
            Else
                Response.Redirect("A_App.aspx")
            End If
        Else
            Response.Redirect("A_Login.aspx")
        End If

    End Sub


    Function returnData(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        Dim cCode As String = ""
        Dim user As String = ""
        '已看用户名单
        Dim user1 As String = ""
        '未看用户名单
        Dim user2 As String = ""



        Dim iuser As Integer = 0

        '已看用户名单数量
        Dim iuser1 As String = ""
        '未看用户名单数量
        Dim iuser2 As String = ""
        '用户名单数量
        Dim iuser3 As String = ""




        cCode = str1


        rs = cPConn.Execute("Select * from dbTZListView where cCode='" & cCode & "' and bView='1' and cPL='' order by dListdate")
        If rs.RecordCount <> 0 Then
            'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")

            For i = 1 To rs.RecordCount
                user1 = user1 & rs.Fields("cClassName").Value & "（" & Format(rs.Fields("dListDate").Value, "MM-dd HH:mm") & "）;" & vbCrLf
                iuser = iuser + 1

                rs.MoveNext()
            Next


        End If

        'user1 = """" & user1 & ""","
        'iuser1 = """" & iuser & ""","
        user1 = user1
        iuser1 = iuser
        iuser = 0
        rs = cPConn.Execute("Select * from dbTZListView where cCode='" & cCode & "' and bView='0' and cPL='' order by cListcode")
        If rs.RecordCount <> 0 Then
            'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")

            For i = 1 To rs.RecordCount
                user2 = user2 & rs.Fields("cClassName").Value & ";"

                iuser = iuser + 1
                rs.MoveNext()
            Next


        End If

        rs = cPConn.Execute("Select count(cListCode) as number from dbTZListView where cCode='" & cCode & "' and cPL<>'' group by cCode ")
        If rs.RecordCount <> 0 Then
            'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")


            iuser3 = rs.Fields("number").Value

        Else
            iuser3 = "0"

        End If

        'user2 = """" & user2 & ""","

        'iuser2 = """" & iuser & """"

        user2 = user2

        iuser2 = iuser

        user = "[" & user1 & user2 & iuser1 & iuser2 & ",""" & iuser3 & """]"

        view1.InnerText = user1
        view2.InnerText = user2
        view3.InnerText = "已看" & iuser1
        view4.InnerText = "未看" & iuser2
        view5.InnerText = "评论" & iuser3

        Dim delData As String = ""
        Dim html As String = ""
        rs = cPConn.Execute("Select * from dbTZListView where cCode='" & cCode & "' and cPL<>'' order by dListdate desc")

        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount()
                If rs.Fields("cPhoneNumber").Value = HttpContext.Current.Session("iphone") Then
                    delData = "<div onclick=DelList('" & rs.Fields("cListCode").Value & "')>删除</div>"
                End If
                html = html &
                        "<div style='padding-top: 5px;font-size: 13px' id='" & rs.Fields("cListCode").Value & "'>" &
                        "<div style='width:1.5rem; height:1.5rem; border-radius:50%; overflow:hidden;float:left;margin-right:5px;margin-top:5px;'><img src='" & rs.Fields("wxheadimgurlPL").Value & "' style='width: 1.5rem;'></div>" &
                        "<div style='float: left; color: #173177;'>" & rs.Fields("cClassName").Value & "</div>" &
                        "<div style='float: right; color: #C0C0C0;'></div>" &
                        "<div style='padding-top: 20px; padding-left: 1px; color: #333333; left: 0px;font-size: 14px'>" & rs.Fields("cPL").Value & "</div>" &
                        "<div style='float: left; color: #C0C0C0;'>" & Format(rs.Fields("dListDate").Value, "MM-dd HH:mm") & "</div>" &
                        "<div style='float: right; color: #C0C0C0;'>" & delData & "</div><br />" &
                        "</div>"



                rs.MoveNext()
                delData = ""
            Next
        Else
            html = "<div style='float: left; color: #C0C0C0;'>还没有人评论</div>"

        End If


        Me.PL.InnerHtml = html


        Return "成功"

    End Function

    Function ViewTZ(str1 As String, str2 As String) As String
        'On Error Resume Next
        '查看标志更新
        Dim rs As New ADODB.Recordset
        Dim iViewNumber As Integer = 1
        Dim wxName As String = ""
        Dim cCode As String = ""



        rs = cPConn.Execute("Select * from dbTZListview where cListCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")
            cCode = rs.Fields("cCode").Value
            Dim bTS As Boolean = rs.Fields("bTS").Value
            wxName = rs.Fields("wxName").Value

            '标志更新过的话就不再更新了
            If rs.Fields("bView").Value = "0" Then

                cPConn.Execute("update dbTZList set bView='1',dListDate='" & Now() & "' where cListCode='" & str1 & "'")

            End If



            If bTS = False Then
                rs = cPConn.Execute("Select count(cListCode) as number,wxName from dbTZListView where cCode='" & cCode & "' and bView='0' group by cCode,wxName ")

                If rs.RecordCount = 0 Then

                    iViewNumber = 0
                    '工作完成只提醒一次
                    cPConn.Execute("update dbTZList set bTS='1' where cCode='" & cCode & "'")

                End If

            End If



        End If




        If iViewNumber = 0 Then
            '发送微信模板
            'Dim wxData As String = str2
            If wxName <> "" Then

                Dim wxData As String = "{" &
                    """touser"":""" & wxName & """," &
                    """template_id"":""vI8NQ0GS9nqh854QGrDN4O1eVrsqWfMkw5W9xdZLgsg""," &
                    """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & cCode & """," &
                    """data"":{" &
                        """first"":{" &
                            """value"":""通知全部查看\n""," &
                            """color"":""#FF0000""" &
                        "}," &
                        """keyword1"":{" &
                        """value"":""" & T_BT1.Text & """," &
                        """color"":""#173177""" &
                        "}," &
                        """keyword2"":{" &
                        """value"":""" & Replace(T_cJoinName1.InnerText, "通知：", "") & """," &
                            """color"":""#173177""" &
                        "}," &
                        """keyword3"":{" &
                            """value"":""" & Format(Now(), "yyyy-MM-dd HH:mm") & "\n" & """," &
                            """color"":""#173177""" &
                        "}," &
                        """remark"":{" &
                        """value"":""您发送的通知，成员已全部查看！""," &
                            """color"":""#173177""" &
                        "}" &
                    "}" &
                "}"


                'wxData = Right(wxData, Len(wxData) - 1)
                'wxData = "{""touser"":""" & wxName & """," & wxData

                SendTemp("", wxData)
            End If
        End If



        Return "成功"

    End Function




    <System.Web.Services.WebMethod()>
    Public Shared Function SendTemp(str1 As String, str2 As String) As String

        Dim rs As New ADODB.Recordset
again:
        rs = cPConn.Execute("Select * from wxToken")
        If rs.RecordCount <> 0 Then
            str1 = IIf(IsDBNull(rs.Fields("accessToken").Value), "", rs.Fields("accessToken").Value)
            'str1 = "8_l7xX4pKowshqeBKBFKRmgiuHSIoJfk_udi5EXvGXyHJc2uELGxqk9GhWM3CYnwzLRraEZgietopRUlqU1pZGf0vP7FBFZLCiyEQ8QWNTp86l4ETTjvi69Ry6R2-5MaglDVsuqZpUAK4kXc_TFCKaAHANKS"
        Else
            Return "失败"
        End If


        Dim url As String = String.Format("https://api.weixin.qq.com/cgi-bin/message/template/send?access_token={0}", str1)
        Dim hwr As Net.WebRequest = Net.WebRequest.Create(url)

        hwr.Method = "POST"
        hwr.ContentType = "application/x-www-form-urlencoded"
        Dim payload As Byte()
        payload = System.Text.Encoding.UTF8.GetBytes(str2)  ' 通过UTF-8编码  
        hwr.ContentLength = payload.Length
        Dim writer As IO.Stream = hwr.GetRequestStream()

        writer.Write(payload, 0, payload.Length)
        writer.Close()

        Dim result As Net.WebResponse = hwr.GetResponse()
        Dim strMsg As String = WebResponseGet(result) '此句是获得上面URl返回的数据 
        If Right(Left(strMsg, 12), 1) = "0" Then

            Return "成功"

        ElseIf Right(Left(strMsg, 16), 5) = "40001" Then
            'AccessToken过期，重新加载
            Call GetAccessToken()
            GoTo again
        Else
            Return "失败"
        End If



    End Function




    <System.Web.Services.WebMethod()>
    Public Shared Function WebResponseGet(webResponse As Net.HttpWebResponse) As String
        Dim responseReader As IO.StreamReader = Nothing
        Dim responseData As String = ""
        Try
            responseReader = New IO.StreamReader(webResponse.GetResponseStream())
            responseData = responseReader.ReadToEnd()

        Catch ex As Exception
            Throw
        Finally
            webResponse.GetResponseStream().Close()
            responseReader.Close()
            responseReader = Nothing

        End Try


        Return responseData

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetAccessToken() As String

        Dim rs As New ADODB.Recordset
        Dim cToken As String = ""

        rs = cPConn.Execute("Select * from WXToken")
        If rs.RecordCount <> 0 Then
            Dim grant_type = "client_credential"
            Dim appid As String = rs.Fields("appid").Value
            Dim secret As String = rs.Fields("secret").Value
            Dim tokenUrl As String = String.Format("https://api.weixin.qq.com/cgi-bin/token?grant_type={0}&appid={1}&secret={2}", grant_type, appid, secret)

            Dim we As New Net.WebClient
            Dim strReturn = we.DownloadString(tokenUrl)

            Dim JSON As Object
            JSON = CreateObject("MSScriptControl.ScriptControl")
            JSON.Language = "JScript"

            'json中获取指定数据下面是（access_token）
            cToken = JSON.eval("JSON=" & strReturn & ";JSON.access_token;")
            If cToken <> Nothing Then
                '返加成功
                cPConn.Execute("update WXToken set AccessToken='" & cToken & "'")
                Return "成功"
            Else
                '返加失败
                Return "失败"
            End If
            JSON = Nothing

        Else
            Return "失败"
        End If



        '{"access_token""7_UuIYJ8Kv2QUF9hLoUXp2IVYsT8cf4E2HwKQ6S9oIaNuQGiwM8Ec9b8ZJkW5ToC7K9S-vGNTVoIaxnbxHOEw3o_i5duP65uBbbhCrcMXXphPA7wea-pKCxVHEpaeED66g4Z5M-osNZhhX4InSKVHcADAUFR","expires_in"7200}

    End Function
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

End Class
