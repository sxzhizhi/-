
Partial Class A_Setting

    Inherits System.Web.UI.Page

    <System.Web.Services.WebMethod()>
    Public Shared Function modifypassword(str1 As String, str2 As String, str3 As String) As String
        On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim pass1, pass2 As String
        pass1 = DigestStrToHexStr(str1)
        pass2 = DigestStrToHexStr(str2)

        rs = cPConn.Execute("select * from dbUser where cName='" & HttpContext.Current.Session("userid") & "'")

        If rs.Fields("cPass").Value <> pass1 Then
            Return "修改失败"
        Else
            cPConn.Execute("update dbUser set cPass='" & pass2 & "' where cName='" & HttpContext.Current.Session("userid") & "'")
            Return "修改成功"
        End If

    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function newcompany(str1 As String, str2 As String) As String
        On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim cnewcompany As String
        cnewcompany = str1
        cnewcompany = Replace(str1, "'", "")
        cnewcompany = Replace(cnewcompany, " ", "")


        rs = cPConn.Execute("Select * from dicDept where zDeptName='" & cnewcompany & "'")

        If rs.RecordCount <> 0 Then
            Return "存在"
        End If


        If HttpContext.Current.Session("username") = "" Then
            Dim sBillCode As String
            sBillCode = GetCode("Dept", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
            cPConn.Execute("insert into dicDept(zDeptCode,zDeptName)values('" & sBillCode & "','" & cnewcompany & "')")

            HttpContext.Current.Session("username") = cnewcompany
            HttpContext.Current.Session("usercode") = sBillCode
            HttpContext.Current.Session("Popdom") = "1"
            HttpContext.Current.Session("name") = str2

            cPConn.Execute("update dbuser set zDeptCode='" & sBillCode & "',Popdom='1',cadmin='1',cClassName='" & str2 & "' where cName='" & HttpContext.Current.Session("userid") & "'")

            Return "创建成功"
            'Popdom
        ElseIf HttpContext.Current.Session("Popdom") = "1" Then

            cPConn.Execute("update dicDept set zDeptName='" & cnewcompany & "' where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
            HttpContext.Current.Session("username") = cnewcompany
            Return "修改成功"
        Else
            Return "创建失败"
        End If






    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function joincompany(str1 As String, str2 As String, str3 As String) As String
        On Error Resume Next

        Dim rs, re As New ADODB.Recordset
        Dim cjoincompany As String
        Dim cName As String
        cjoincompany = Replace(str1, "'", "")
        cjoincompany = Replace(cjoincompany, " ", "")

        cName = str2

        If HttpContext.Current.Session("usercode") <> "" Then
            Return "已加入团队"

            'Popdom
        Else
            'If HttpContext.Current.Session("Popdom") = "1" Then
            '    Return "已加入团队"
            'End If



            rs = cPConn.Execute("select * from dicdept where zdeptcode='" & cjoincompany & "'")
            If rs.RecordCount <> 0 Then

                Dim sBillCode As String = ""
                Dim sBillCode1 As String = ""
                Dim cPhoneNumber As String = ""
                re = cPConn.Execute("Select * from dbuserView where zDeptCode='" & cjoincompany & "' and cAdmin='1'")
                If re.RecordCount <> 0 Then
                    cPhoneNumber = re.Fields("iPhoneNumber").Value
                End If

                sBillCode = GetCode("TZ", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                cPConn.Execute("insert into dbTZ(cCode,cJoinName,cPhoneNumber,zDeptCode,cBT,cNR,bView,dDate)values('" & sBillCode & "','" & HttpContext.Current.Session("iphone") & "','" & cPhoneNumber & "','" & rs.Fields("zDeptCode").Value & "','" & cName & ",申请加入','申请加入','0','" & Now() & "')")

                cPConn.Execute("update dbuser set cClassName='" & str2 & "' where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")
                sBillCode1 = GetCode("TL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                cPConn.Execute("insert into dbTZList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & cPhoneNumber & "','0','0')")

                HttpContext.Current.Session("name") = cName


                '发送微信模板
                Dim wxData As String = str3
                If re.Fields("wxName").Value <> "" Then
                    wxData = Right(wxData, Len(wxData) - 1)
                    wxData = "{""touser"":""" & re.Fields("wxName").Value & """," & wxData

                    SendTemp("", wxData)
                End If



                Return "申请提交成功"
            Else
                Return "团队ID不正确"
            End If


        End If






    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function joincompany1(str1 As String, str2 As String, str3 As String) As String
        On Error Resume Next

        Dim rs, re As New ADODB.Recordset
        Dim cjoincompany As String
        Dim cName As String
        cjoincompany = Replace(str1, "'", "")
        cjoincompany = Replace(cjoincompany, " ", "")
        cName = str2

        If HttpContext.Current.Session("usercode") <> "" Then
            Return "已加入团队"

            'Popdom
        Else
            'If HttpContext.Current.Session("Popdom") = "1" Then
            '    Return "已加入团队"
            'End If



            rs = cPConn.Execute("select * from dicdept where zdeptname='" & cjoincompany & "'")
            If rs.RecordCount <> 0 Then

                Dim sBillCode As String = ""
                Dim sBillCode1 As String = ""
                Dim cPhoneNumber As String = ""
                re = cPConn.Execute("Select * from dbuserView where zDeptname='" & cjoincompany & "' and cadmin='1'")
                If re.RecordCount <> 0 Then
                    cPhoneNumber = re.Fields("iPhoneNumber").Value
                End If

                sBillCode = GetCode("TZ", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                cPConn.Execute("insert into dbTZ(cCode,cJoinName,cPhoneNumber,zDeptCode,cBT,cNR,bView,dDate)values('" & sBillCode & "','" & HttpContext.Current.Session("iphone") & "','" & cPhoneNumber & "','" & rs.Fields("zDeptCode").Value & "','" & cName & ",申请加入','申请加入','0','" & Now() & "')")

                cPConn.Execute("update dbuser set cClassName='" & str2 & "' where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")
                sBillCode1 = GetCode("TL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                cPConn.Execute("insert into dbTZList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & cPhoneNumber & "','0','0')")
                HttpContext.Current.Session("name") = cName

                '发送微信模板
                Dim wxData As String = str3
                If re.Fields("wxName").Value <> "" Then
                    wxData = Right(wxData, Len(wxData) - 1)
                    wxData = "{""touser"":""" & re.Fields("wxName").Value & """," & wxData

                    SendTemp("", wxData)
                End If




                Return "申请提交成功"
            Else
                Return "团队ID不正确"
            End If


        End If






    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SendTemp(str1 As String, str2 As String) As String

        Dim rs As New ADODB.Recordset

        rs = cPConn.Execute("Select * from wxToken")
        If rs.RecordCount <> 0 Then
            str1 = IIf(IsDBNull(rs.Fields("accessToken").Value), "", rs.Fields("accessToken").Value)
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
    Public Shared Function SH(str1 As String, str2 As String) As String
        On Error Resume Next

        Dim rs, re As New ADODB.Recordset
        Dim cCode As String

        cCode = str1

        rs = cPConn.Execute("select * from [dbTZ] where cCode='" & cCode & "' and bView='0' and cNR='申请加入' ")
        If rs.RecordCount <> 0 Then

            cPConn.Execute("update dbuser set zDeptCode='" & rs.Fields("zDeptCode").Value & "' where iPhoneNumber='" & rs.Fields("cjoinname").Value & "'")
            cPConn.Execute("update dbTZ set bView='1' where cCode='" & cCode & "'")


            re = cPConn.Execute("Select wxName from dbuserview where iPhoneNumber='" & rs.Fields("cjoinname").Value & "'")

            '发送微信模板
            Dim wxData As String = str2
            If re.Fields("wxName").Value <> "" Then
                wxData = Right(wxData, Len(wxData) - 1)
                wxData = "{""touser"":""" & re.Fields("wxName").Value & """," & wxData

                SendTemp("", wxData)
            End If



            Return "更新成功"
        Else
            Return "更新失败"
        End If

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function exitcompany(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim cCode As String

        cCode = str1

        If HttpContext.Current.Session("Popdom") = "1" Then
            Return "创建者，不能退出"
        ElseIf HttpContext.Current.Session("usercode") = "" Then
            Return "退出失败"
        Else
            cPConn.Execute("update dbuser set zDeptCode='' where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")
            HttpContext.Current.Session("username") = ""
            HttpContext.Current.Session("usercode") = ""
            Return "退出成功"


        End If



    End Function

    Private Sub A_Setting_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("iphone") = "" Then Response.Redirect("A_login.aspx")
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function DelCY(str1 As String, str2 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        'Dim cGroupName As String = Replace(str1, "'", "")
        Dim cName() As String = Split(str2, ";")


        Dim sBillCode As String = ""
        Dim sBillCode1 As String = ""




        'sBillCode = GetCode("GK", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        'cPConn.Execute("insert into dbGroup(cCode,zDeptCode,cPhoneNumber,cGroupName)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & HttpContext.Current.Session("iphone") & "','" & cGroupName & "')")
        'sBillCode1 = GetCode("GL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date)
        'cPConn.Execute("insert into dbGroupList(cCode,cListCode,cPhoneNumber)values('" & sBillCode & "','" & sBillCode1 & "','" & cName(i) & "')")


        For i = 0 To UBound(cName) - 1

            cPConn.Execute("update dbuser set zDeptCode='',cDeptjob='' where iPhoneNumber='" & cName(i) & "'")


        Next

        Return "成功"

    End Function


End Class
