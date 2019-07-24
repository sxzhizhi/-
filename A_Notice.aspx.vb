
Partial Class A_Notice

    Inherits System.Web.UI.Page

    <System.Web.Services.WebMethod()>
    Public Shared Function Save(str1 As String, str2 As String, str3 As String, str4 As String, str5 As String, str6 As String) As String
        'On Error Resume Next
        '设计思路在选择发送成员时，有可能又有直接的姓名，也有可能是部门，所以分别去判断一下，str3是姓名用户，str4是部门用用户
        Dim rs As New ADODB.Recordset
        Dim cBT As String
        Dim cNR As String
        Dim cName1 As String
        Dim cName() As String
        Dim cUnit1 As String
        Dim cUnit() As String
        Dim cBZ As String = ""

        cBT = Replace(str1, "'", "")
        cNR = Replace(str2, "'", "")
        cNR = Replace(cNR, vbLf, ".")

        cBZ = str5


        Dim sBillCode As String = ""
        Dim sBillCode1 As String = ""

        sBillCode = GetCode("TZ", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("insert into dbTZ(cCode,cBT,cNR,cJoinName,cPhoneNumber,dDate,cBZ)values('" & sBillCode & "','" & cBT & "','" & cNR & "','" & HttpContext.Current.Session("iphone") & "','','" & Now() & "','" & cBZ & "')")








        If str4 <> "" Then
            cUnit1 = Left(str4, Len(str4) - 1)
            cUnit = Split(str4, ";")

            For i = 0 To UBound(cUnit) - 1
                rs = cPConn.Execute("Select * from dbUserView where cDeptJob='" & cUnit(i) & "'")
                If rs.RecordCount <> 0 Then
                    For j = 1 To rs.RecordCount
                        sBillCode1 = GetCode("TL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                        cPConn.Execute("insert into dbTZList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & rs.Fields("iPhoneNumber").Value & "','0','0')")

                        '发送微信模板
                        Dim wxData As String = str6
                        If rs.Fields("wxName").Value <> "" Then
                            wxData = Right(wxData, Len(wxData) - 1)

                            Dim wxData1 As String = """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," & """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & ""","

                            wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData1 & wxData

                            wxData = "{" &
                                    """touser"":""" & rs.Fields("wxName").Value & """," &
                                    """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," &
                                    """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & """," &
                                    """data"":{" &
                                        """first"":{" &
                                            """value"":""通知提醒\n""," &
                                            """color"":""#FF0000""" &
                                        "}," &
                                        """keyword1"":{" &
                                        """value"":""" & cBT & """," &
                                        """color"":""#173177""" &
                                        "}," &
                                        """keyword2"":{" &
                                        """value"":""" & cBZ & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """keyword3"":{" &
                                            """value"":""" & Format(Now(), "yyyy-MM-dd HH:mm") & "\n" & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """remark"":{" &
                                        """value"":""点击详情，系统自动反馈通知人已收到并查看通知！""," &
                                            """color"":""#FF0000""" &
                                        "}" &
                                    "}" &
                                "}"








                            SendTemp("", wxData)
                        End If
                        rs.MoveNext()

                    Next

                End If
            Next

            'cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & HttpContext.Current.Session("iphone") & "','发送通知','" & sBillCode1 & "')")

        End If
        If str3 <> "" Then
            cName1 = Left(str3, Len(str3) - 1)

            cName = Split(str3, ";")

            For i = 0 To UBound(cName) - 1
                sBillCode1 = GetCode("TL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                cPConn.Execute("insert into dbTZList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & cName(i) & "','0','0')")
                '发送微信模板
                Dim wxData As String = str6

                rs = cPConn.Execute("select wxName from dbUserView where iphonenumber='" & cName(i) & "'")
                If rs.Fields("wxName").Value <> "" Then
                    wxData = Right(wxData, Len(wxData) - 1)

                    'wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData
                    Dim wxData1 As String = """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," & """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & ""","

                    wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData1 & wxData
                    wxData = "{" &
                                    """touser"":""" & rs.Fields("wxName").Value & """," &
                                    """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," &
                                    """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & """," &
                                    """data"":{" &
                                        """first"":{" &
                                            """value"":""通知提醒\n""," &
                                            """color"":""#FF0000""" &
                                        "}," &
                                        """keyword1"":{" &
                                        """value"":""" & cBT & """," &
                                        """color"":""#173177""" &
                                        "}," &
                                        """keyword2"":{" &
                                        """value"":""" & cBZ & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """keyword3"":{" &
                                            """value"":""" & Format(Now(), "yyyy-MM-dd HH:mm") & "\n" & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """remark"":{" &
                                        """value"":""点击详情，系统自动反馈通知人已收到并查看通知！""," &
                                            """color"":""#FF0000""" &
                                        "}" &
                                    "}" &
                                "}"

                    SendTemp("", wxData)
                End If


            Next
            'cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & HttpContext.Current.Session("iphone") & "','发送通知','" & sBillCode1 & "')")

        End If
        cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & HttpContext.Current.Session("iphone") & "','发送通知','" & sBillCode & "')")

        HttpContext.Current.Session("NoticeCode") = sBillCode

        Return "保存成功"

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

        sBillCode = GetCode("TZ", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("insert into dbTZ(cCode,cBT,cNR,cJoinName,cPhoneNumber,dDate,cBZ)values('" & sBillCode & "','" & cBT & "','" & cNR & "','" & HttpContext.Current.Session("iphone") & "','','" & Now() & "','全部成员')")

        If HttpContext.Current.Session("usercode") <> "" Then


            rs = cPConn.Execute("Select * from dbUserView where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
            If rs.RecordCount <> 0 Then
                For j = 1 To rs.RecordCount
                    sBillCode1 = GetCode("TL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))
                    cPConn.Execute("insert into dbTZList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & rs.Fields("iPhoneNumber").Value & "','0','0')")
                    '发送微信模板
                    Dim wxData As String = str3
                    If rs.Fields("wxName").Value <> "" Then
                        wxData = Right(wxData, Len(wxData) - 1)
                        Dim wxData1 As String = """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," & """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & ""","

                        wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData1 & wxData


                        wxData = "{" &
                                    """touser"":""" & rs.Fields("wxName").Value & """," &
                                    """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," &
                                    """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & """," &
                                    """data"":{" &
                                        """first"":{" &
                                            """value"":""通知提醒\n""," &
                                            """color"":""#FF0000""" &
                                        "}," &
                                        """keyword1"":{" &
                                        """value"":""" & cBT & """," &
                                        """color"":""#173177""" &
                                        "}," &
                                        """keyword2"":{" &
                                        """value"":""全部成员""," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """keyword3"":{" &
                                            """value"":""" & Format(Now(), "yyyy-MM-dd HH:mm") & "\n" & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """remark"":{" &
                                        """value"":""点击详情，系统会自动反馈通知人已收到并查看通知！""," &
                                            """color"":""#FF0000""" &
                                        "}" &
                                    "}" &
                                "}"



                        SendTemp("", wxData)
                    End If


                    rs.MoveNext()

                Next

            End If
        Else
            sBillCode1 = GetCode("TL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

            cPConn.Execute("insert into dbTZList(cListCode,cCode,cPhoneNumber,bView,bDel)values('" & sBillCode1 & "','" & sBillCode & "','" & HttpContext.Current.Session("iphone") & "','0','0')")

            '发送微信模板
            Dim wxData As String = str3
            If HttpContext.Current.Session("openid") <> "" Then
                wxData = Right(wxData, Len(wxData) - 1)
                Dim wxData1 As String = """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," & """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & ""","

                wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData1 & wxData
                wxData = "{" &
                                    """touser"":""" & rs.Fields("wxName").Value & """," &
                                    """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," &
                                    """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & """," &
                                    """data"":{" &
                                        """first"":{" &
                                            """value"":""通知提醒\n""," &
                                            """color"":""#FF0000""" &
                                        "}," &
                                        """keyword1"":{" &
                                        """value"":""" & cBT & """," &
                                        """color"":""#173177""" &
                                        "}," &
                                        """keyword2"":{" &
                                        """value"":""全部成员""," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """keyword3"":{" &
                                            """value"":""" & Format(Now(), "yyyy-MM-dd HH:mm") & "\n" & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """remark"":{" &
                                        """value"":""点击详情，系统自动反馈通知人已收到并查看通知！""," &
                                            """color"":""#FF0000""" &
                                        "}" &
                                    "}" &
                                "}"
                SendTemp("", wxData)
            End If
        End If

        HttpContext.Current.Session("NoticeCode") = sBillCode

        cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & HttpContext.Current.Session("iphone") & "','发送通知','" & sBillCode & "')")

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
                            Dim wxData1 As String = """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," & """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & ""","

                            wxData = "{""touser"":""" & rs.Fields("wxName").Value & """," & wxData1 & wxData
                            wxData = "{" &
                                    """touser"":""" & rs.Fields("wxName").Value & """," &
                                    """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," &
                                    """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & sBillCode & """," &
                                    """data"":{" &
                                        """first"":{" &
                                            """value"":""通知提醒\n""," &
                                            """color"":""#FF0000""" &
                                        "}," &
                                        """keyword1"":{" &
                                        """value"":""" & cBT & """," &
                                        """color"":""#173177""" &
                                        "}," &
                                        """keyword2"":{" &
                                        """value"":""" & cBZ & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """keyword3"":{" &
                                            """value"":""" & Format(Now(), "yyyy-MM-dd HH:mm") & "\n" & """," &
                                            """color"":""#173177""" &
                                        "}," &
                                        """remark"":{" &
                                        """value"":""点击详情，系统自动反馈通知人已收到并查看通知！""," &
                                            """color"":""#FF0000""" &
                                        "}" &
                                    "}" &
                                "}"
                            SendTemp("", wxData)
                        End If
                        rs.MoveNext()

                    Next

                End If
            Next

        End If



        HttpContext.Current.Session("NoticeCode") = sBillCode

        cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & HttpContext.Current.Session("iphone") & "','发送通知','" & sBillCode & "')")

        Return "保存成功"

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function SendTX(str1 As String, str2 As String, str3 As String) As String
        'On Error Resume Next

        Dim rs, re As New ADODB.Recordset
        rs = cPConn.Execute("select * from [dbTZListView] where cCode='" & str1 & "' and bView='0' and cPL='' ")
        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount
                Dim wxData As String = ""

                Dim wxName As String = ""
                re = cPConn.Execute("select wxName from dbUserView where iphonenumber='" & rs.Fields("cPhoneNumber").Value & "'")
                wxName = re.Fields("wxName").Value

                If wxName <> "" Then

                    wxData = "{" &
                    """touser"":""" & wxName & """," &
                    """template_id"":""4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ""," &
                    """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & str1 & """," &
                    """data"":{" &
                        """first"":{" &
                            """value"":""通知提醒\n""," &
                            """color"":""#FF0000""" &
                        "}," &
                        """keyword1"":{" &
                        """value"":""" & str2 & """," &
                        """color"":""#173177""" &
                        "}," &
                        """keyword2"":{" &
                        """value"":""" & str3 & """," &
                            """color"":""#173177""" &
                        "}," &
                        """keyword3"":{" &
                            """value"":""" & Format(Now(), "yyyy-MM-dd HH:mm") & "\n" & """," &
                            """color"":""#173177""" &
                        "}," &
                        """remark"":{" &
                        """value"":""点击详情，系统会自动反馈通知人已收到并查看通知！""," &
                            """color"":""#FF0000""" &
                        "}" &
                    "}" &
                "}"

                    SendTemp("", wxData)
                End If
                rs.MoveNext()

            Next


        End If


        Return "成功"

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
        Dim rs, re As New ADODB.Recordset
        Dim A_Notice As New A_Notice
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
                re = cPConn.Execute("Select count(cListCode) as number,wxName from dbTZListView where cCode='" & cCode & "' and bView='0' group by cCode,wxName ")

                If re.RecordCount = 0 Then

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
                'wxData = Right(wxData, Len(wxData) - 1)
                'wxData = "{""touser"":""" & wxName & """," & wxData



                wxData = "{" &
                    """touser"":""" & wxName & """," &
                    """template_id"":""vI8NQ0GS9nqh854QGrDN4O1eVrsqWfMkw5W9xdZLgsg""," &
                    """url"":""http://my.aiwei.biz/aw/A_NoticeView.aspx?code=" & rs.Fields("cCode").Value & """," &
                    """data"":{" &
                        """first"":{" &
                            """value"":""通知全部查看\n""," &
                            """color"":""#FF0000""" &
                        "}," &
                        """keyword1"":{" &
                        """value"":""" & rs.Fields("cBT").Value & """," &
                        """color"":""#173177""" &
                        "}," &
                        """keyword2"":{" &
                        """value"":""" & rs.Fields("cBZ").Value & """," &
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








                SendTemp("", wxData)
            End If
        End If







        Return "成功"

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function Del(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        rs = cPConn.Execute("select * from dbTZList where cListCode='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            cPConn.Execute("update dbTZList set bDel='1' where cListCode='" & str1 & "'")
            Return "删除成功"
        Else
            Return "已经删除"
        End If




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DelList(str1 As String) As String
        'On Error Resume Next


        cPConn.Execute("delete from dbTZList where cListCode='" & str1 & "'")
        Return "删除成功"





    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function Save2(str1 As String, str2 As String, str3 As String, str4 As String) As String
        'On Error Resume Next

        str1 = Replace(str1, "'", "")
        str2 = Replace(str2, "'", "")
        str2 = Replace(str2, vbLf, ".")

        If str4 <> "" Then
            HttpContext.Current.Session("NoticeCode") = str3
        Else
            HttpContext.Current.Session("NoticeCode") = ""

            cPConn.Execute("update dbTZ set cURL='' where cCode='" & str3 & "'")

        End If

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
        Dim A_Notice As New A_Notice
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
        Dim A_Notice As New A_Notice
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

        rs = cPConn.Execute("Select * from dbTZListView where cCode='" & cCode & "' and bView='1' and cPL='' order by dListdate")
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




    End Function
    Private Sub A_Notice_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Session("iphone") = "" Then Response.Redirect("A_login.aspx")
        Me.T_Name.Text = Session("name")

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function return_classname(str1 As String) As String
        'On Error Resume Next
        Dim rs, re As New ADODB.Recordset
        Dim cCode As String = ""
        Dim html As String = ""
        Dim delData As String = ""

        rs = cPConn.Execute("Select * from dbuserview where cdeptjob='" & str1 & "'")
        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount()
                html = html & "<li><Label Class='label-checkbox item-content' onclick='checkclassname();'>" &
                          "<input type = 'checkbox' name='checkboxclass' value ='" & rs.Fields("cClassName").Value & "' />" &
                          "<div Class='item-media'><i class='icon icon-form-checkbox'></i></div>" &
                          "<div Class='item-inner'>" &
                            "<div Class='item-title-row'>" &
                              "<div Class='item-title'>" & rs.Fields("cClassName").Value & "</div>" &
                              "<div Class='item-after' style='font-size: small' id='d" & i & "'>" & rs.Fields("iPhoneNumber").Value & "</div></div></div></label><li>"

                rs.MoveNext()
            Next
            Return html
        Else
            Return "失败"
        End If




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

    <System.Web.Services.WebMethod()>
    Public Shared Function ReturnTZLX(str1 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset
        str1 = ""
        rs = cPConn.Execute("Select * from DicTZLX where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount
                'str1 = str1 & rs.Fields("cUnitName").Value & ","
                str1 += """" + rs.Fields("cTZLXName").Value + ""","


                rs.MoveNext()

            Next
            str1 = Left(str1, Len(str1) - 1)

            str1 = "[" & str1 & "]"
            Return str1
        Else

            Return "error"

        End If





    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function test(str1 As String) As String
        'On Error Resume Next

        Return "成功"





    End Function

End Class
