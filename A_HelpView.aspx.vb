
Partial Class A_HelpView


    Inherits System.Web.UI.Page

    <System.Web.Services.WebMethod()>
    Public Shared Function Save(str1 As String, str2 As String, str3 As String, str4 As String, str5 As String) As String
        'On Error Resume Next
        '设计思路在选择发送成员时，有可能又有直接的姓名，也有可能是部门，所以分别去判断一下，str3是姓名用户，str4是部门用用户
        Dim rs As New ADODB.Recordset
        Dim cBT As String
        Dim cNR As String
        Dim cName1 As String
        Dim cName() As String

        Dim cBZ As String = ""

        cBT = Replace(str1, "'", "")
        cNR = Replace(str2, "'", "")
        cNR = Replace(cNR, vbLf, ".")

        cBZ = str4


        Dim sBillCode As String = ""
        Dim sBillCode1 As String = ""

        sBillCode = GetCode("QK", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("insert into dbQK(cCode,cBT,cNR,cJoinName,cPhoneNumber,dDate,cBZ)values('" & sBillCode & "','" & cBT & "','" & cNR & "','" & HttpContext.Current.Session("iphone") & "','','" & Now() & "','" & cBZ & "')")



        If str3 <> "" Then
            cName1 = Left(str3, Len(str3) - 1)

            cName = Split(str3, ";")

            For i = 0 To UBound(cName) - 1
                sBillCode1 = GetCode("QL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                cPConn.Execute("insert into dbQKList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & cName(i) & "','0','0')")


                '发送微信模板
                Dim wxData As String = ""
                Dim wxName As String = ""

                rs = cPConn.Execute("select wxName,cClassName from dbUserView where iphonenumber='" & cName(i) & "'")
                If rs.Fields("wxName").Value <> "" Then

                    wxName = rs.Fields("wxName").Value

                    If wxName <> "" Then

                        wxData = "{" &
                                    """touser"":""" & wxName & """," &
                                    """template_id"":""gtU3LK0TmF98i_QfhlTXgA3KrEVaWUJzjCTk768JQKg""," &
                                    """url"":""http://my.aiwei.biz/aw/A_Help.aspx#HelpList1""," &
                                    """data"":{" &
                                        """first"":{" &
                                            """value"":""" & "来自你可能感兴趣的问题\n" & """," &
                                            """color"":""#FF0000""" &
                                        "}," &
                                        """keyword1"":{" &
                                        """value"":""" & rs.Fields("cClassName").Value & """," &
                                        """color"":""#173177""" &
                                        "}," &
                                        """keyword2"":{" &
                                        """value"":""" & HttpContext.Current.Session("name") & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """keyword3"":{" &
                                            """value"":""" & Format(Now(), "yyyy-MM-dd HH:mm") & "\n" & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """remark"":{" &
                                        """value"":""请点击详情查看！""," &
                                            """color"":""#173177""" &
                                        "}" &
                                    "}" &
                                "}"

                        SendTemp("", wxData)
                    End If




                    'SendTemp("", wxData)
                End If


            Next
            cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & HttpContext.Current.Session("iphone") & "','提交求助','" & sBillCode1 & "')")

        End If

        HttpContext.Current.Session("QKCode") = sBillCode

        Return "保存成功"

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function TJ(str1 As String, str2 As String, str3 As String) As String
        'On Error Resume Next

        Dim rs, re As New ADODB.Recordset
        Dim cCode As String = ""
        Dim delData As String = ""
        Dim html As String = ""
        Dim dDate As Date
        Dim cBT As String = ""
        str2 = Replace(str2, "'", "")
        Dim bNM = IIf(str3 = "1", 1, 0)
        Dim sBillCode As String = ""

        sBillCode = GetCode("QP", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("insert into dbQKList(cListCode,cCode,cPhoneNumber,cPL,dListDate,bNM)values('" & sBillCode & "','" & str1 & "','" & HttpContext.Current.Session("iphone") & "','" & str2 & "','" & Now() & "'," & bNM & ")")
        '回答加积分
        re = cPConn.Execute("Select iJF from dbuserview where iphonenumber='" & HttpContext.Current.Session("iphone") & "'")
        If re.RecordCount <> 0 Then
            Dim iJF = re.Fields("iJF").Value
            iJF = iJF + 3
            cPConn.Execute("update dbuser set iJF=" & iJF & " where iphonenumber='" & HttpContext.Current.Session("iphone") & "'")
        End If

        'rs = cPConn.Execute("Select cListCode,cCode from dbQKList where cListCode='" & str1 & "' and cPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")
        'If rs.RecordCount <> 0 Then

        '    cCode = rs.Fields("cCode").Value
        '    cPConn.Execute("insert into dbQKList(cListCode,cCode,cPhoneNumber,cPL,dListDate)values('" & sBillCode & "','" & cCode & "','" & HttpContext.Current.Session("iphone") & "','" & str2 & "','" & Now() & "')")
        '    '更新回答过
        '    cPConn.Execute("update dbQKList set bView='1' where cListCode='" & rs.Fields("cListCode").Value & "'")

        'End If

        'If str1 = "" Then
        '    'HttpContext.Current.Session("KCode")
        '    cPConn.Execute("insert into dbQKList(cListCode,cCode,cPhoneNumber,cPL,dListDate)values('" & sBillCode & "','" & HttpContext.Current.Session("KCode") & "','" & HttpContext.Current.Session("iphone") & "','" & str2 & "','" & Now() & "')")

        'End If


        ''发送微信模板
        'Dim wxData As String = str3
        'If rs.Fields("wxName").Value <> "" Then
        '    wxData = Right(wxData, Len(wxData) - 1)
        '    wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData

        '    SendTemp("", wxData)
        'End If

        rs = cPConn.Execute("Select cjoinname,dDate,cBT from dbQKListView where cCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then

            dDate = rs.Fields("dDate").Value
            cBT = rs.Fields("cBT").Value

            '发送微信信息
            Dim wxData As String = ""
            Dim wxName As String = ""

            rs = cPConn.Execute("select wxName,cClassName from dbUserView where iphonenumber='" & rs.Fields("cjoinname").Value & "'")
            If rs.Fields("wxName").Value <> "" Then

                wxName = rs.Fields("wxName").Value

                If wxName <> "" Then

                    wxData = "{" &
                                        """touser"":""" & wxName & """," &
                                        """template_id"":""YqQb1Uzr0AAalkeY-cf9hkYHx5ELR9wVffCsLYNf0IE""," &
                                        """url"":""http://my.aiwei.biz/aw/A_HelpView.aspx?code=" & str1 & """," &
                                        """data"":{" &
                                            """first"":{" &
                                                """value"":""" & "您的求助信息已得到回复\n" & """," &
                                                """color"":""#FF0000""" &
                                            "}," &
                                            """keyword1"":{" &
                                            """value"":""" & Format(dDate, "MM-dd HH:mm") & """," &
                                            """color"":""#173177""" &
                                            "}," &
                                            """keyword2"":{" &
                                            """value"":""" & cBT & """," &
                                                """color"":""#173177""" &
                                            "}," &
                                            """keyword3"":{" &
                                                """value"":""" & IIf(Len(str2) > 28, Left(str2, 25) & "...", str2) & "\n" & """," &
                                                """color"":""#173177""" &
                                            "}," &
                                            """remark"":{" &
                                            """value"":""点击查看全部回复！""," &
                                                """color"":""#173177""" &
                                            "}" &
                                        "}" &
                                    "}"

                    SendTemp("", wxData)
                End If




                'SendTemp("", wxData)
            End If

        End If










        rs = cPConn.Execute("Select * from dbQKListView where cCode='" & str1 & "' and cPL<>'' order by dListdate desc")

        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount()
                If rs.Fields("cPhoneNumber").Value = HttpContext.Current.Session("iphone") Then
                    delData = "<div style='float: right;padding-right: 5px; padding-left: 5px;' onclick=DelList('" & rs.Fields("cListCode").Value & "')> 删除 </div>" &
                                "<div style='float: right;padding-right: 5px; padding-left: 5px;' onclick=ModifyList('" & rs.Fields("cListCode").Value & "')>  </div>"
                    '"<div style='float: right;padding-right: 5px; padding-left: 5px;' onclick=ModifyList('" & re.Fields("cListCode").Value & "')> 修改 </div>"
                End If
                '"<div class='card facebook-card'><a href ='#HelpList1-2' onclick=''><div class='card-content'>" &
                html = html &
                    "<div class='card facebook-card' id='" & rs.Fields("cListCode").Value & "'><a href ='#' onclick=''><div class='card-content'>" &
                    "<div Class='facebook-avatar' style='padding-top: 10px; padding-left: 10px'>" &
                    "<div style = 'width:0.9rem; height:0.9rem; border-radius:50%; overflow:hidden;' >" &
                    "<img src='" & IIf(rs.Fields("bNM").Value, "img/img/WTZ_H.png", rs.Fields("Expr1").Value) & "' style='width: 0.9rem;'></div></div>" &
                    "<div Class='facebook-name' style='padding-top: 10px; font-size: 13px; color: #999999;'>" & IIf(rs.Fields("bNM").Value, "匿名用户", rs.Fields("cClassName").Value) & "</div>" &
                    "<div Class='card-content-inner'>" &
                    "<div style = 'color: #333333; font-size: 13px;' > " & rs.Fields("cPL").Value & "</div>" &
                    "<div style='color: #999999; font-size: 13px;'> " & Format(rs.Fields("dListDate").Value, "MM-dd HH:mm") & delData & "</div></div>" &
                    "</div></a></div>"



                rs.MoveNext()
                delData = ""
            Next
        Else
            html = ""

        End If


        Return html

    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function SaveAll(str1 As String, str2 As String, str3 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim cBT As String
        Dim cNR As String

        cBT = Replace(str1, "'", "")
        cNR = Replace(str2, "'", "")
        cNR = Replace(cNR, vbLf, ".")



        Dim sBillCode As String = ""
        Dim sBillCode1 As String = ""

        sBillCode = GetCode("QK", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("insert into dbQK(cCode,cBT,cNR,cJoinName,cPhoneNumber,dDate,cBZ)values('" & sBillCode & "','" & cBT & "','" & cNR & "','" & HttpContext.Current.Session("iphone") & "','','" & Now() & "','所有人')")




        rs = cPConn.Execute("Select * from dbUserView where iphonenumber<>'' and iphonenumber<>'" & HttpContext.Current.Session("iphone") & "'")
        If rs.RecordCount <> 0 Then
            For j = 1 To rs.RecordCount
                sBillCode1 = GetCode("QL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                cPConn.Execute("insert into dbQKList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & rs.Fields("iPhoneNumber").Value & "','0','0')")
                '发送微信模板
                'Dim wxData As String = str3
                'If rs.Fields("wxName").Value <> "" Then
                '    wxData = Right(wxData, Len(wxData) - 1)
                '    wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData

                '    SendTemp("", wxData)
                'End If


                rs.MoveNext()

            Next

        End If

        cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & HttpContext.Current.Session("iphone") & "','提交求助','" & sBillCode & "')")

        Return "保存成功"

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveGroup(str1 As String, str2 As String, str3 As String, str4 As String, str5 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim cBT As String
        Dim cNR As String

        Dim cUnit1 As String
        Dim cUnit() As String
        Dim cBZ As String = str4

        cBT = Replace(str1, "'", "")
        cNR = Replace(str2, "'", "")
        cNR = Replace(cNR, vbLf, ".")




        Dim sBillCode As String = ""
        Dim sBillCode1 As String = ""

        sBillCode = GetCode("TZ", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("insert into dbTZ(cCode,cBT,cNR,cJoinName,cPhoneNumber,dDate,cBZ)values('" & sBillCode & "','" & cBT & "','" & cNR & "','" & HttpContext.Current.Session("iphone") & "','','" & Now() & "','" & cBZ & "')")


        If str3 <> "" Then
            cUnit1 = Left(str3, Len(str3) - 1)
            cUnit = Split(str3, ";")

            For i = 0 To UBound(cUnit) - 1
                rs = cPConn.Execute("Select * from dbGroupListView where cCode='" & cUnit(i) & "'")
                If rs.RecordCount <> 0 Then
                    For j = 1 To rs.RecordCount
                        sBillCode1 = GetCode("TL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                        cPConn.Execute("insert into dbTZList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & rs.Fields("cPhoneNumberList").Value & "','0','0')")

                        '发送微信模板
                        Dim wxData As String = str5
                        If rs.Fields("wxName").Value <> "" Then
                            wxData = Right(wxData, Len(wxData) - 1)
                            wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData

                            SendTemp("", wxData)
                        End If
                        rs.MoveNext()

                    Next

                End If
            Next

        End If




        Return "保存成功"

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SavePL(str1 As String, str2 As String, str3 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim cCode As String = ""

        str2 = Replace(str2, "'", "")

        Dim sBillCode As String = ""

        sBillCode = GetCode("PL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        rs = cPConn.Execute("Select cCode from dbTZList where cListCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            cCode = rs.Fields("cCode").Value
        End If


        cPConn.Execute("insert into dbTZList(cListCode,cCode,cPhoneNumber,cPL,dListDate)values('" & sBillCode & "','" & cCode & "','" & HttpContext.Current.Session("iphone") & "','" & str2 & "','" & Now() & "')")


        ''发送微信模板
        'Dim wxData As String = str3
        'If rs.Fields("wxName").Value <> "" Then
        '    wxData = Right(wxData, Len(wxData) - 1)
        '    wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData

        '    SendTemp("", wxData)
        'End If



        Return "成功"

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ViewTZ(str1 As String, str2 As String) As String
        'On Error Resume Next
        '查看标志更新
        Dim rs As New ADODB.Recordset

        Dim iViewNumber As Integer = 1
        Dim wxName As String = ""

        rs = cPConn.Execute("Select * from dbTZListview where cListCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")
            Dim cCode As String = rs.Fields("cCode").Value
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
            Dim wxData As String = str2
            If wxName <> "" Then
                wxData = Right(wxData, Len(wxData) - 1)
                wxData = "{""touser"":""" & wxName & """," & wxData

                SendTemp("", wxData)
            End If
        End If







        Return "成功"

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function Del(str1 As String) As String
        'On Error Resume Next

        'Dim rs As New ADODB.Recordset

        'cPConn.Execute("delete from dbQK where cCode='" & str1 & "'")
        'cPConn.Execute("delete from dbQKList where cCode='" & str1 & "'")

        cPConn.Execute("update dbQK set bView='1' where cCode='" & str1 & "'")
        Return "删除成功"

        'rs = cPConn.Execute("select * from dbQKList where cListCode='" & str1 & "'")
        'If rs.RecordCount <> 0 Then
        '    cPConn.Execute("update dbQKList set bDel='1' where cListCode='" & str1 & "'")
        '    Return "删除成功"
        'Else
        '    Return "已经删除"
        'End If




    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function HL(str1 As String) As String
        'On Error Resume Next

        'Dim rs As New ADODB.Recordset

        cPConn.Execute("update dbQKList set bDel='1' where cCode='" & str1 & "' and cPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")


        'cPConn.Execute("delete from dbQK where cCode='" & str1 & "'")
        'cPConn.Execute("delete from dbQKList where cCode='" & str1 & "'")
        'Return "删除成功"

        'rs = cPConn.Execute("select * from dbQKList where cListCode='" & str1 & "'")
        'If rs.RecordCount <> 0 Then
        '    cPConn.Execute("update dbQKList set bDel='1' where cListCode='" & str1 & "'")
        '    Return "删除成功"
        'Else
        '    Return "已经删除"
        'End If

        Return "成功"


    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function DelList(str1 As String) As String
        'On Error Resume Next


        cPConn.Execute("delete from dbQKList where cListCode='" & str1 & "'")
        Return "删除成功"





    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function Save2(str1 As String, str2 As String, str3 As String) As String
        'On Error Resume Next

        str1 = Replace(str1, "'", "")
        str2 = Replace(str2, "'", "")
        str2 = Replace(str2, vbLf, ".")

        cPConn.Execute("update dbTZ set cBT='" & str1 & "',cNR='" & str2 & "',dDate='" & Now() & "' where cCode='" & str3 & "'")

        cPConn.Execute("update dbTZList set bDel='0',bView='0' where cCode='" & str3 & "'")

        cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & HttpContext.Current.Session("iphone") & "','修改通知内容','" & str3 & "')")


        Return "保存成功"

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function Del2(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        rs = cPConn.Execute("select * from dbTZ where cCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            cPConn.Execute("Delete from dbTZ where cCode='" & str1 & "'")
            cPConn.Execute("Delete from dbTZList where cCode='" & str1 & "'")
            cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & HttpContext.Current.Session("iphone") & "','删除通知内容','" & str1 & "')")

            Return "删除成功"
        Else
            Return "已经删除"
        End If




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function returnuser(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        Dim cCode As String = ""
        Dim user As String = ""

        rs = cPConn.Execute("Select * from dbTZListView where cListCode='" & str1 & "'")

        If rs.RecordCount <> 0 Then
            cCode = rs.Fields("cCode").Value
            user = IIf(IsDBNull(rs.Fields("cBZ").Value), "", rs.Fields("cBZ").Value)
            Return user
        Else

            Return "失败"

        End If

        'rs = cPConn.Execute("Select * from dbTZListView where cCode='" & cCode & "' order by cListcode")
        'If rs.RecordCount <> 0 Then
        '    'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")

        '    For i = 1 To rs.RecordCount
        '        user = user & rs.Fields("cClassName").Value & ";"
        '        rs.MoveNext()
        '    Next
        '    Return user
        'Else

        '    Return "失败"
        'End If


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function returnview(str1 As String) As String
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


        rs = cPConn.Execute("Select * from dbTZListView where cListCode='" & str1 & "'")

        If rs.RecordCount <> 0 Then
            cCode = rs.Fields("cCode").Value
        End If

        rs = cPConn.Execute("Select * from dbTZListView where cCode='" & cCode & "' and bView='1' order by dListdate")
        If rs.RecordCount <> 0 Then
            'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")

            For i = 1 To rs.RecordCount
                user1 = user1 & rs.Fields("cClassName").Value & "（" & Format(rs.Fields("dListDate").Value, "MM-dd HH:mm") & "）;" & "\n"
                iuser = iuser + 1

                rs.MoveNext()
            Next


        End If

        user1 = """" & user1 & ""","
        iuser1 = """" & iuser & ""","
        iuser = 0
        rs = cPConn.Execute("Select * from dbTZListView where cCode='" & cCode & "' and bView='0' order by cListcode")
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






        user2 = """" & user2 & ""","


        iuser2 = """" & iuser & """"

        user = "[" & user1 & user2 & iuser1 & iuser2 & ",""" & iuser3 & """]"




        Return user


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function returnPL(str1 As String) As String
        'On Error Resume Next
        Dim rs, re As New ADODB.Recordset
        Dim cCode As String = ""
        Dim html As String = ""
        Dim delData As String = ""

        rs = cPConn.Execute("Select * from dbTZListView where cListCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then

            cCode = rs.Fields("cCode").Value

            re = cPConn.Execute("Select * from dbTZListView where cCode='" & cCode & "' and cPL<>'' order by dListdate desc")

            If re.RecordCount <> 0 Then
                For i = 1 To re.RecordCount()
                    If re.Fields("cPhoneNumber").Value = HttpContext.Current.Session("iphone") Then
                        delData = "<div onclick=DelList('" & re.Fields("cListCode").Value & "')>删除</div>"
                    End If
                    html = html &
                        "<div style='padding-top: 5px;font-size: 13px' id='" & re.Fields("cListCode").Value & "'>" &
                        "<div style='width:1.5rem; height:1.5rem; border-radius:50%; overflow:hidden;float:left;margin-right:5px;margin-top:5px;'><img src='" & re.Fields("wxheadimgurlPL").Value & "' style='width: 1.5rem;'></div>" &
                        "<div style='float: left; color: #173177;'>" & re.Fields("cClassName").Value & "</div>" &
                        "<div style='float: right; color: #C0C0C0;'></div>" &
                        "<div style='padding-top: 20px; padding-left: 1px; color: #333333; left: 0px;font-size: 14px'>" & re.Fields("cPL").Value & "</div>" &
                        "<div style='float: left; color: #C0C0C0;'>" & Format(re.Fields("dListDate").Value, "MM-dd HH:mm") & "</div>" &
                        "<div style='float: right; color: #C0C0C0;'>" & delData & "</div><br />" &
                        "</div>"



                    re.MoveNext()
                    delData = ""
                Next
            Else
                html = "<div style='float: left; color: #C0C0C0;'>还没有人评论</div>"

            End If


            Return html
        Else
            Return "失败"
        End If












        Return html


    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function returnGZ(str1 As String) As String
        'On Error Resume Next
        Dim re As New ADODB.Recordset
        Dim cCode As String = ""
        Dim html As String = ""
        Dim delData As String = ""

        Dim ii As Integer = 0




        re = cPConn.Execute("Select count(cListCode) as number from dbQKListView where cCode='" & str1 & "' and cPL='' group by cCode")

        If re.RecordCount <> 0 Then
            ii = re.Fields("number").Value
        Else
            ii = 0
        End If


        Return ii

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function returnHDNumber(str1 As String) As String
        'On Error Resume Next
        Dim re As New ADODB.Recordset
        Dim cCode As String = ""
        Dim html As String = ""
        Dim delData As String = ""

        Dim ii As Integer = 0




        re = cPConn.Execute("Select count(cListCode) as number from dbQKListView where cCode='" & str1 & "' and cPL<>'' group by cCode")

        If re.RecordCount <> 0 Then
            ii = re.Fields("number").Value
        Else
            ii = 0
        End If


        Return ii

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function returnHD(str1 As String) As String
        'On Error Resume Next
        Dim re As New ADODB.Recordset
        Dim cCode As String = ""
        Dim html As String = ""
        Dim delData As String = ""





        re = cPConn.Execute("Select * from dbQKListView where cCode='" & str1 & "' and cPL<>'' order by dListdate asc")

        If re.RecordCount <> 0 Then
            For i = 1 To re.RecordCount()
                If re.Fields("cPhoneNumber").Value = HttpContext.Current.Session("iphone") Then
                    delData = "<div style='float: right;padding-right: 5px; padding-left: 5px;' onclick=DelList('" & re.Fields("cListCode").Value & "')> 删除 </div>" &
                                "<div style='float: right;padding-right: 5px; padding-left: 5px;' onclick=ModifyList('" & re.Fields("cListCode").Value & "')>  </div>"
                    '"<div style='float: right;padding-right: 5px; padding-left: 5px;' onclick=ModifyList('" & re.Fields("cListCode").Value & "')> 修改 </div>"
                End If
                '"<div class='card facebook-card'><a href ='#HelpList1-2' onclick=''><div class='card-content'>" &
                html = html &
                    "<div class='card facebook-card' id='" & re.Fields("cListCode").Value & "'><a href ='#' onclick=''><div class='card-content'>" &
                    "<div Class='facebook-avatar' style='padding-top: 10px; padding-left: 10px'>" &
                    "<div style = 'width:0.9rem; height:0.9rem; border-radius:50%; overflow:hidden;' >" &
                    "<img src='" & IIf(re.Fields("bNM").Value, "img/img/WTZ_H.png", re.Fields("Expr1").Value) & "' style='width: 0.9rem;'></div></div>" &
                    "<div Class='facebook-name' style='padding-top: 10px; font-size: 13px; color: #999999;'>" & IIf(re.Fields("bNM").Value, "匿名用户", re.Fields("cClassName").Value) & "</div>" &
                    "<div Class='card-content-inner'>" &
                    "<div style = 'color: #333333; font-size: 13px;' > " & re.Fields("cPL").Value & "</div>" &
                    "<div style='color: #999999; font-size: 13px;'> " & Format(re.Fields("dListDate").Value, "MM-dd") & delData & "</div></div>" &
                    "</div></a></div>"



                re.MoveNext()
                delData = ""
            Next
        Else
            html = ""

        End If

        HttpContext.Current.Session("KCode") = str1

        Return html

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
    Public Shared Function aa(strbase64 As String) As String

        'Dim file1 As HttpPostedFile = Convert.FromBase64String(strbase64)


        Dim filePath As String = "aaaaa"


        'Try
        '    Dim arr As Byte() = Convert.FromBase64String(strbase64)
        '    Dim MS As System.IO.MemoryStream = New IO.MemoryStream(arr)
        '    Dim bmp As System.Drawing.Bitmap = New System.Drawing.Bitmap(MS)


        '    bmp.Save(filePath, System.Drawing.Imaging.ImageFormat.Jpeg)
        '    MS.Close()
        'Catch ex As Exception

        'End Try
        Return "bbbb"

    End Function

    Private Sub A_HelpView_Load(sender As Object, e As EventArgs) Handles Me.Load

        Dim code As String = ""
        Dim html As String = ""
        Dim delData As String = ""
        Dim rs As New ADODB.Recordset

        If Session("QLCode") = "" Then
            code = Request.QueryString("code")
            Session("QLCode") = code

        Else
            code = Session("QLCode")

            'code = "TZ20180509-0007"
        End If

        If Session("iphone") <> "" Then
            Session("QLCode") = ""


            T_Code.Text = code
            T_Code1.Text = code
            rs = cPConn.Execute("Select * from dbQKListView where cCode='" & code & "'")
            If rs.RecordCount <> 0 Then
                BT.InnerText = rs.Fields("cBT").Value
                NR.InnerText = rs.Fields("cNR").Value
                imgPre2.Src = rs.Fields("cURL").Value
            End If

            rs = cPConn.Execute("Select count(cListCode) as number from dbQKListView where cCode='" & code & "' and cPL='' group by cCode")

            If rs.RecordCount <> 0 Then
                GZ.InnerText = rs.Fields("number").Value & " 人关注"
            Else
                GZ.InnerText = 0 & "人关注"
            End If

            rs = cPConn.Execute("Select count(cListCode) as number from dbQKListView where cCode='" & code & "' and cPL<>'' group by cCode")

            If rs.RecordCount <> 0 Then
                HDNumber.InnerText = rs.Fields("number").Value & " 个回答"
            Else
                HDNumber.InnerText = 0 & " 个回答"
            End If



            rs = cPConn.Execute("Select * from dbQKListView where cCode='" & code & "' and cPL<>'' order by dListdate Desc")

            If rs.RecordCount <> 0 Then
                For i = 1 To rs.RecordCount()
                    If rs.Fields("cPhoneNumber").Value = HttpContext.Current.Session("iphone") Then
                        delData = "<div style='float: right;padding-right: 5px; padding-left: 5px;' onclick=DelList('" & rs.Fields("cListCode").Value & "')> 删除 </div>" &
                                    "<div style='float: right;padding-right: 5px; padding-left: 5px;' onclick=ModifyList('" & rs.Fields("cListCode").Value & "')>  </div>"
                        '"<div style='float: right;padding-right: 5px; padding-left: 5px;' onclick=ModifyList('" & re.Fields("cListCode").Value & "')> 修改 </div>"
                    End If
                    '"<div class='card facebook-card'><a href ='#HelpList1-2' onclick=''><div class='card-content'>" &
                    html = html &
                        "<div class='card facebook-card' id='" & rs.Fields("cListCode").Value & "'><a href ='#' onclick=''><div class='card-content'>" &
                        "<div Class='facebook-avatar' style='padding-top: 10px; padding-left: 10px'>" &
                        "<div style = 'width:0.9rem; height:0.9rem; border-radius:50%; overflow:hidden;' >" &
                        "<img src='" & IIf(rs.Fields("bNM").Value, "img/img/WTZ_H.png", rs.Fields("Expr1").Value) & "' style='width: 0.9rem;'></div></div>" &
                        "<div Class='facebook-name' style='padding-top: 10px; font-size: 13px; color: #999999;'>" & IIf(rs.Fields("bNM").Value, "匿名用户", rs.Fields("cClassName").Value) & "</div>" &
                        "<div Class='card-content-inner'>" &
                        "<div style = 'color: #333333; font-size: 13px;' > " & rs.Fields("cPL").Value & "</div>" &
                        "<div style='color: #999999; font-size: 13px;'> " & Format(rs.Fields("dListDate").Value, "MM-dd HH:mm") & delData & "</div></div>" &
                        "</div></a></div>"



                    rs.MoveNext()
                    delData = ""
                Next
                HDList.InnerHtml = html
            Else
                HDList.InnerHtml = ""

            End If


        Else
            Response.Redirect("A_Login.aspx")
        End If

    End Sub
End Class
