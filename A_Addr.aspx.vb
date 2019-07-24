
Partial Class A_Addr

    Inherits System.Web.UI.Page

    Private Sub A_Addr_Load(sender As Object, e As EventArgs) Handles Me.Load
        Session("onelevel") = "2"
        If Session("iphone") = "" Then Response.Redirect("A_login.aspx")

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

    <System.Web.Services.WebMethod()>
    Public Shared Function returnlist(str1 As String) As String
        'On Error Resume Next
        Dim re As New ADODB.Recordset
        Dim delData As String
        Dim html As String = ""




        re = cPConn.Execute("Select * from dbGroupListView where cCode='" & str1 & "' order by cClassName")

        If re.RecordCount <> 0 Then
            For i = 1 To re.RecordCount()


                delData = "<div style='font-size:13px;' onclick=DelListName('" & re.Fields("cListCode").Value & "')>移除</div>"

                'html = html &
                '    "<div style='padding-top: 5px;font-size: 13px' id='" & re.Fields("cListCode").Value & "'>" &
                '    "<div style='float: left; color: #173177;'>" & re.Fields("cClassName").Value & "</div>" &
                '    "<div style='float: right; color: #C0C0C0;'></div>" &
                '    "<div style='padding-top: 20px; padding-left: 1px; color: #333333; left: 0px;font-size: 14px'>" & re.Fields("cPL").Value & "</div>" &
                '    "<div style='float: left; color: #C0C0C0;'>" & Format(re.Fields("dListDate").Value, "MM-dd HH:mm") & "</div>" &
                '    "<div style='float: right; color: #C0C0C0;'>" & delData & "</div><br />" &
                '    "</div>"

                html = html & "<ul id='" & re.Fields("cListCode").Value & "'><li><div Class='item-content'><div Class='item-media'></div><div Class='item-inner'><div Class='item-title-row'>" &
              "<div Class='item-title'>" & re.Fields("cClassNamelist").Value & "</div></div><div Class='item-subtitle' style='color #999999; font-size: 13px;'></div></div>" & delData & "</div></li></ul>"


                re.MoveNext()
                delData = ""

            Next

        Else

            Return "失败"

        End If


        Return html




    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DelList(str1 As String) As String
        'On Error Resume Next


        cPConn.Execute("Delete from dbGroup where cCode='" & str1 & "'")
        cPConn.Execute("Delete from dbGroupList where cCode='" & str1 & "'")

        Return "删除成功"



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DelListName(str1 As String) As String
        'On Error Resume Next


        cPConn.Execute("Delete from dbGroupList where cListCode='" & str1 & "'")

        Return "删除成功"



    End Function



    <System.Web.Services.WebMethod()>
    Public Shared Function joinfriend(str1 As String, str2 As String) As String
        On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim cjoincompany As String
        Dim cName As String
        cName = Replace(str1, "'", "")
        cName = Replace(cName, " ", "")

        If cName = HttpContext.Current.Session("iphone") Then
            Return "不存在"
        End If
        rs = cPConn.Execute("select * from dbfriend where cPhoneNumber='" & HttpContext.Current.Session("iphone") & "' and cFPhoneNumber='" & cName & "'")
        If rs.RecordCount <> 0 Then
            Return "存在"
        End If

        rs = cPConn.Execute("select * from dbuser where cname='" & cName & "' and zDeptCode<>'" & HttpContext.Current.Session("usercode") & "'")
        If rs.RecordCount <> 0 Then

            Dim sBillCode As String = ""
            Dim sBillCode1 As String = ""
            Dim cPhoneNumber As String = rs.Fields("iPhoneNumber").Value



            sBillCode = GetCode("TZ", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
            cPConn.Execute("insert into dbTZ(cCode,cJoinName,cPhoneNumber,zDeptCode,cBT,cNR,bView,dDate)values('" & sBillCode & "','" & HttpContext.Current.Session("iphone") & "','" & cPhoneNumber & "','" & rs.Fields("zDeptCode").Value & "','请求加你为好友','" & rs.Fields("cClassname").Value & "(" & cName & "),请求加你为好友','0','" & Now() & "')")

            'sBillCode1 = GetCode("TL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
            'cPConn.Execute("insert into dbTZList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & cPhoneNumber & "','0','0')")

            '发送微信模板
            Dim wxData As String = str2
            If rs.Fields("wxName").Value <> "" Then
                wxData = Right(wxData, Len(wxData) - 1)
                wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData

                SendTemp("", wxData)
            End If
            Return "成功"
        Else
            Return "不存在"
        End If

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SendTemp(str1 As String, str2 As String) As String

        Dim rs As New ADODB.Recordset

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
    Public Shared Function SH(str1 As String) As String
        On Error Resume Next

        Dim rs, re As New ADODB.Recordset
        Dim cCode As String

        cCode = str1

        rs = cPConn.Execute("select * from [dbTZ] where cCode='" & cCode & "' and bView='0' and cBT='请求加你为好友' ")
        If rs.RecordCount <> 0 Then
            Dim sBillCode As String = ""

            '审核者
            Dim cJoinName As String = rs.Fields("cJoinName").Value
            '请求者
            Dim cPhoneNumber As String = rs.Fields("cPhoneNumber").Value

            cPConn.Execute("Delete from dbFriend where cPhoneNumber='" & cJoinName & "' and cFPhoneNumber='" & cPhoneNumber & "'")
            cPConn.Execute("Delete from dbFriend where cPhoneNumber='" & cPhoneNumber & "' and cFPhoneNumber='" & cJoinName & "'")

            sBillCode = GetCode("FD", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
            '各个添加好友
            cPConn.Execute("insert into dbFriend(cCode,cPhoneNumber,cFPhoneNumber)values('" & sBillCode & "','" & cJoinName & "','" & cPhoneNumber & "')")

            cPConn.Execute("insert into dbFriend(cCode,cPhoneNumber,cFPhoneNumber)values('" & sBillCode & "','" & cPhoneNumber & "','" & cJoinName & "')")

            cPConn.Execute("update dbtz set bview='1' where cCode='" & cCode & "'")


            Return "成功"
        Else
            Return "失败"
        End If

    End Function

End Class
