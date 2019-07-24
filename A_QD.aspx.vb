
Partial Class A_QD


    Inherits System.Web.UI.Page

    Private Sub A_QD_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim rs As New ADODB.Recordset
        rs = cPConn.Execute("Select * from KQQD where cName='" & Session("iphone") & "' and CONVERT(varchar(100), dQDtime, 112) ='" & Format(SrvDate(), "yyyyMMdd") & "' and cQDJD='上班签到'")

        If rs.RecordCount <> 0 Then
            Me.SB.InnerText = "已签到"
            SBAddr.InnerText = rs.Fields("cQDWD").Value & "（" & Format(rs.Fields("dQDTime").Value, "HH:mm") & "）"

            rs = cPConn.Execute("Select * from KQQD where cName='" & Session("iphone") & "' and CONVERT(varchar(100), dQDtime, 112) ='" & Format(SrvDate(), "yyyyMMdd") & "' and cQDJD='下班签退'")

            If rs.RecordCount <> 0 Then
                Me.XB.InnerText = "已签退"
                XBAddr.InnerText = rs.Fields("cQDWD").Value & "（" & Format(rs.Fields("dQDTime").Value, "HH:mm") & "）"

            End If


        Else
            Me.XB.InnerText = "签退"
            'rs = cPConn.Execute("Select * from KQQD where cName='" & Session("iphone") & "' and CONVERT(varchar(100), dQDtime, 112) ='" & Format(SrvDate(), "yyyyMMdd") & "' and cQDJD='下班签退'")

            'If rs.RecordCount <> 0 Then
            '    Me.XB.InnerText = "已签退"
            '    XBAddr.InnerText = rs.Fields("cQDWD").Value & "（" & Format(rs.Fields("dQDTime").Value, "HH:mm") & "）"

            'End If


        End If




        rs = cPConn.Execute("Select * from KQDW where zDeptCode='" & Session("usercode") & "'")
        If rs.RecordCount <> 0 Then

            Me.SBTime.InnerText = Format(rs.Fields("dQDTime").Value, "HH:mm")
            Me.XBTime.InnerText = Format(rs.Fields("dQTTime").Value, "HH:mm")

        Else
            cPConn.Execute("insert into KQDW(zDeptCode,dQDTime,dQTTime)values('" & Session("usercode") & "','09:00','18:00')")
            Me.SBTime.InnerText = "09:00"
            Me.XBTime.InnerText = "18:00"

        End If




    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function SetQD(str1 As String) As String
        Dim rs As New ADODB.Recordset

        Dim SB As String = "未签到"
        Dim XB As String = "未签退"
        Dim cSBTime As String = ""      '管理员设置的上班时间
        Dim cXBTime As String = ""      '管理员设置的下班时间
        Dim cSB As String = ""          '上班考勤情况
        Dim cXB As String = ""          '下班考勤情况

        rs = cPConn.Execute("Select * from KQQD where dQD='" & str1 & "' and cQDJD='上班签到' and cName='" & HttpContext.Current.Session("iphone") & "'")
        If rs.RecordCount <> 0 Then

            SB = rs.Fields("cQDWD").Value & "（" & Format(rs.Fields("dQDTime").Value, "HH:mm") & "）"
            cSBTime = Format(rs.Fields("dQTTime").Value, "HH:mm")
            cSB = rs.Fields("cBZ").Value
        End If

        rs = cPConn.Execute("Select * from KQQD where dQD='" & str1 & "' and cQDJD='下班签退' and cName='" & HttpContext.Current.Session("iphone") & "'")
        If rs.RecordCount <> 0 Then

            XB = rs.Fields("cQDWD").Value & "（" & Format(rs.Fields("dQDTime").Value, "HH:mm") & "）"
            cXBTime = Format(rs.Fields("dQTTime").Value, "HH:mm")
            cXB = rs.Fields("cBZ").Value
        End If


        SB = """" & SB & ""","
        XB = """" & XB & ""","

        cSBTime = """" & cSBTime & ""","
        cXBTime = """" & cXBTime & ""","

        cSB = """" & cSB & ""","
        cXB = """" & cXB & """"



        Return "[" & SB & XB & cSBTime & cXBTime & cSB & cXB & "]"





    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function TJKQ(str1 As String) As String
        Dim rs As New ADODB.Recordset

        Dim div1 As Object = 0
        Dim div2 As Object = 0
        Dim div3 As Object = 0
        Dim div4 As Object = 0
        Dim div5 As Object = 0
        Dim div6 As Object = 0

        Dim iTotal As Integer = 0

        rs = cPConn.Execute("Select count(zdeptcode) as number from dbuser where zDeptCode='" & HttpContext.Current.Session("usercode") & "' group by zdeptcode ")
        If rs.RecordCount <> 0 Then
            iTotal = rs.Fields("number").Value
        End If


        rs = cPConn.Execute("Select count(cName) as number from KQQD where dQD='" & str1 & "' and cQDJD='上班签到' and cBZ='准时' and zDeptCode='" & HttpContext.Current.Session("usercode") & "' group by dQD")
        If rs.RecordCount <> 0 Then
            div1 = rs.Fields("number").Value
        End If

        rs = cPConn.Execute("Select count(cName) as number from KQQD where dQD='" & str1 & "' and cQDJD='上班签到' and cBZ='迟到' and zDeptCode='" & HttpContext.Current.Session("usercode") & "' group by dQD")
        If rs.RecordCount <> 0 Then
            div2 = rs.Fields("number").Value
        End If

        div3 = iTotal - div1 - div2

        rs = cPConn.Execute("Select count(cName) as number from KQQD where dQD='" & str1 & "' and cQDJD='下班签退' and cBZ='准时' and zDeptCode='" & HttpContext.Current.Session("usercode") & "' group by dQD")
        If rs.RecordCount <> 0 Then
            div4 = rs.Fields("number").Value
        End If

        rs = cPConn.Execute("Select count(cName) as number from KQQD where dQD='" & str1 & "' and cQDJD='下班签退' and cBZ='早退' and zDeptCode='" & HttpContext.Current.Session("usercode") & "' group by dQD")
        If rs.RecordCount <> 0 Then
            div5 = rs.Fields("number").Value
        End If

        div6 = iTotal - div4 - div5



        div1 = """" & div1 & "人" & ""","
        div2 = """" & div2 & "人" & ""","

        div3 = """" & div3 & "人" & ""","
        div4 = """" & div4 & "人" & ""","

        div5 = """" & div5 & "人" & ""","
        div6 = """" & div6 & "人" & """"



        Return "[" & div1 & div2 & div3 & div4 & div5 & div6 & "]"





    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function returnSTime(str1 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset


        rs = cPConn.Execute("Select * from KQDW where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
        If rs.RecordCount <> 0 Then

            Return rs.Fields("dQDTime").Value
        Else
            cPConn.Execute("insert into KQDW(zDeptCode,dQDTime,dQTTime)values('" & HttpContext.Current.Session("usercode") & "','09:00','18:00')")
            Return "失败"
        End If

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function returnXTime(str1 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset


        rs = cPConn.Execute("Select * from KQDW where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
        If rs.RecordCount <> 0 Then

            Return rs.Fields("dQTTime").Value
        Else
            cPConn.Execute("insert into KQDW(zDeptCode,dQDTime,dQTTime)values('" & HttpContext.Current.Session("usercode") & "','09:00','18:00')")

            Return "失败"
        End If

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function returnTime(str1 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset


        rs = cPConn.Execute("Select * from KQDW where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
        If rs.RecordCount <> 0 Then

            Return "[" & """" & rs.Fields("dQDTime").Value & """," & """" & rs.Fields("dQTTime").Value & """]"

        Else

            Return "失败"
        End If

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function saveSTime(str1 As String) As String
        'On Error Resume Next

        cPConn.Execute("update KQDW set dQDTime='" & str1 & "' where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")



        Return "保存成功"



    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function saveXTime(str1 As String) As String
        'On Error Resume Next

        cPConn.Execute("update KQDW set dQTTime='" & str1 & "' where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")



        Return "保存成功"



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function return_classname(str1 As String, str2 As String, str3 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset
        Dim cCode As String = ""
        Dim html As String = ""
        Dim delData As String = ""

        'str1 = Format(str1, "yyyy-MM-dd")
        If str3 = "上班" Then
            If str2 = "准时" Then

                rs = cPConn.Execute("Select * from KQQDView where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cBZ='准时' and cQDJD='上班签到' and dQD='" & str1 & "'")

                If rs.RecordCount <> 0 Then
                    For i = 1 To rs.RecordCount()
                        html = html & "<li><div class='item-content'><div class='item-media'></div><div class='item-media' style='width:1.7rem; height:1.7rem; border-radius:50%; overflow:hidden;'>" &
                            "<img src='" & rs.Fields("wxheadimgurl").Value & "' style='width: 1.8rem;'></div>" &
                             "<div class='item-inner'><div class='item-title' style='font-size: 14px;'>" & rs.Fields("cClassName").Value & "<div style='font-size: 13px; color: #999999'>" & rs.Fields("cName").Value & "</div>" &
                               "</div></div></div></li>"

                        rs.MoveNext()
                    Next

                Else
                    html = "<h4 style='text-align: center; color: #CCCCCC'>没有成员信息</h4>"
                End If

                Return html
            ElseIf str2 = "迟到" Then
                rs = cPConn.Execute("Select * from KQQDView where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cBZ='迟到' and cQDJD='上班签到' and dQD='" & str1 & "'")

                If rs.RecordCount <> 0 Then
                    For i = 1 To rs.RecordCount()
                        html = html & "<li><div class='item-content'><div class='item-media'></div><div class='item-media' style='width:1.7rem; height:1.7rem; border-radius:50%; overflow:hidden;'>" &
                            "<img src='" & rs.Fields("wxheadimgurl").Value & "' style='width: 1.8rem;'></div>" &
                             "<div class='item-inner'><div class='item-title' style='font-size: 14px;'>" & rs.Fields("cClassName").Value & "<div style='font-size: 13px; color: #999999'>" & rs.Fields("cName").Value & "</div>" &
                               "</div></div></div></li>"

                        rs.MoveNext()
                    Next

                Else
                    html = "<h4 style='text-align: center; color: #CCCCCC'>没有成员信息</h4>"
                End If
                Return html
            ElseIf str2 = "未签到" Then

                rs = cPConn.Execute("SELECT * FROM dbUserview WHERE (iphoneNumber NOT IN (SELECT cName FROM KQQDView where cQDJD='上班签到' and dQD='" & str1 & "')) And (zDeptCode = '" & HttpContext.Current.Session("usercode") & "') order by cClassname ")
                If rs.RecordCount <> 0 Then
                    For i = 1 To rs.RecordCount()
                        html = html & "<li><div class='item-content'><div class='item-media'></div><div class='item-media' style='width:1.7rem; height:1.7rem; border-radius:50%; overflow:hidden;'>" &
                            "<img src='" & rs.Fields("wxheadimgurl").Value & "' style='width: 1.8rem;'></div>" &
                             "<div class='item-inner'><div class='item-title' style='font-size: 14px;'>" & rs.Fields("cClassName").Value & "<div style='font-size: 13px; color: #999999'>" & rs.Fields("cName").Value & "</div>" &
                               "</div></div></div></li>"

                        rs.MoveNext()
                    Next
                Else
                    html = "<h4 style='text-align: center; color: #CCCCCC'>没有成员信息</h4>"
                End If
                Return html


            End If
        ElseIf str3 = "下班" Then
            If str2 = "准时" Then

                rs = cPConn.Execute("Select * from KQQDView where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cBZ='准时' and cQDJD='下班签退' and dQD='" & str1 & "'")

                If rs.RecordCount <> 0 Then
                    For i = 1 To rs.RecordCount()
                        html = html & "<li><div class='item-content'><div class='item-media'></div><div class='item-media' style='width:1.7rem; height:1.7rem; border-radius:50%; overflow:hidden;'>" &
                            "<img src='" & rs.Fields("wxheadimgurl").Value & "' style='width: 1.8rem;'></div>" &
                             "<div class='item-inner'><div class='item-title' style='font-size: 14px;'>" & rs.Fields("cClassName").Value & "<div style='font-size: 13px; color: #999999'>" & rs.Fields("cName").Value & "</div>" &
                               "</div></div></div></li>"

                        rs.MoveNext()
                    Next
                Else
                    html = "<h4 style='text-align: center; color: #CCCCCC'>没有成员信息</h4>"
                End If
                Return html
            ElseIf str2 = "早退" Then
                rs = cPConn.Execute("Select * from KQQDView where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cBZ='早退' and cQDJD='下班签退' and dQD='" & str1 & "'")

                If rs.RecordCount <> 0 Then
                    For i = 1 To rs.RecordCount()
                        html = html & "<li><div class='item-content'><div class='item-media'></div><div class='item-media' style='width:1.7rem; height:1.7rem; border-radius:50%; overflow:hidden;'>" &
                            "<img src='" & rs.Fields("wxheadimgurl").Value & "' style='width: 1.8rem;'></div>" &
                             "<div class='item-inner'><div class='item-title' style='font-size: 14px;'>" & rs.Fields("cClassName").Value & "<div style='font-size: 13px; color: #999999'>" & rs.Fields("cName").Value & "</div>" &
                               "</div></div></div></li>"

                        rs.MoveNext()
                    Next
                Else
                    html = "<h4 style='text-align: center; color: #CCCCCC'>没有成员信息</h4>"
                End If
                Return html
            ElseIf str2 = "未签退" Then

                rs = cPConn.Execute("SELECT * FROM dbUserview WHERE (iphoneNumber NOT IN (SELECT cName FROM KQQDView where cQDJD='下班签退' and dQD='" & str1 & "')) And (zDeptCode = '" & HttpContext.Current.Session("usercode") & "') order by cClassname")
                If rs.RecordCount <> 0 Then
                    For i = 1 To rs.RecordCount()
                        html = html & "<li><div class='item-content'><div class='item-media'></div><div class='item-media' style='width:1.7rem; height:1.7rem; border-radius:50%; overflow:hidden;'>" &
                            "<img src='" & rs.Fields("wxheadimgurl").Value & "' style='width: 1.8rem;'></div>" &
                             "<div class='item-inner'><div class='item-title' style='font-size: 14px;'>" & rs.Fields("cClassName").Value & "<div style='font-size: 13px; color: #999999'>" & rs.Fields("cName").Value & "</div>" &
                               "</div></div></div></li>"

                        rs.MoveNext()
                    Next
                Else
                    html = "<h4 style='text-align: center; color: #CCCCCC'>没有成员信息</h4>"
                End If
                Return html


            End If
        End If
        'rs = cPConn.Execute("Select * from dbuserview where cdeptjob='" & str1 & "'")

        'If rs.RecordCount <> 0 Then
        '    For i = 1 To rs.RecordCount()
        '        html = html & "<li><div class='item-content'><div class='item-media' style='width:2.1rem; height:2.1rem; border-radius:50%; overflow:hidden;'>" &
        '            "<img src='" & rs.Fields(" wxheadimgurl").Value & "' style='width: 2.2rem;'></div>" &
        '             "<div class='item-inner'><div class='item-title'>" & rs.Fields("cClassName").Value & "<div style='font-size: 14px; color: #999999'>" & rs.Fields("iPhoneNumber").Value & "</div>" &
        '               "</div></div></div></li>"

        '        rs.MoveNext()
        '    Next
        '    Return html
        'Else
        '    
        'End If

        Return "失败"


    End Function
End Class
