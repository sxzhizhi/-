
Partial Class A_MySetting

    Inherits System.Web.UI.Page

    Private Sub A_MySetting_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim rs As New ADODB.Recordset

        Session("onelevel") = "3"



        'If Session("iphone") = "" Then Response.Redirect("A_login.aspx")

        rs = cPConn.Execute("Select * from dbuserview where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")

        If rs.RecordCount <> 0 Then
            T_SetName.InnerText = IIf(IsDBNull(rs.Fields("cClassName").Value), "", rs.Fields("cClassName").Value)
            T_sex.InnerText = IIf(IsDBNull(rs.Fields("cSex").Value), "", rs.Fields("cSex").Value)
            T_SetJob.InnerText = IIf(IsDBNull(rs.Fields("cJob").Value), "", rs.Fields("cJob").Value)
            T_Unit.InnerText = IIf(IsDBNull(rs.Fields("cUnitName").Value), "", rs.Fields("cUnitName").Value)
            T_SetEmail.InnerText = IIf(IsDBNull(rs.Fields("cEmail").Value), "", rs.Fields("cEmail").Value)
            JF.InnerText = "我的积分：" & rs.Fields("iJF").Value
        End If

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
    Public Shared Function savename(str1 As String) As String
        'On Error Resume Next

        cPConn.Execute("update dbuser set cClassName='" & str1 & "' where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")

        HttpContext.Current.Session("name") = str1

        Return "保存成功"



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function savesex(str1 As String) As String
        'On Error Resume Next

        cPConn.Execute("update dbuser set cSex='" & str1 & "' where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")



        Return "保存成功"



    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function savejob(str1 As String, str2 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset

        cPConn.Execute("update dbuser set cJob='" & str1 & "' where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")

        rs = cPConn.Execute("Select * from DicUnit where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cUnitName='" & str2 & "'")
        If rs.RecordCount <> 0 Then
            cPConn.Execute("update dbuser set cDeptJob='" & rs.Fields("cUnitCode").Value & "' where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")
        Else
            Return "部门不存在"
        End If

        Return "保存成功"



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function saveemail(str1 As String) As String
        'On Error Resume Next

        Dim reg As New Regex("\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}")

        If reg.IsMatch(str1) Then

            cPConn.Execute("update dbuser set cEmail='" & str1 & "' where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")

            'HttpContext.Current.Session("email") = str1

            Return "保存成功"

        Else

            Return "邮箱格式不正确"

        End If
        'cPConn.Execute("update dbuser set cEmail='" & str1 & "' where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")

        'HttpContext.Current.Session("email") = str1

        'Return "保存成功"

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function returnsex(str1 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset
        Dim cSex As String = ""
        rs = cPConn.Execute("Select * from dbuser where iPhoneNumber='" & HttpContext.Current.Session("iphone") & "'")

        If rs.RecordCount <> 0 Then
            If IsDBNull(rs.Fields("cSex").Value) Then
                cSex = ""
            Else
                cSex = rs.Fields("cSex").Value
            End If

            Return cSex

        Else
            Return "失败"
        End If


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ExitUser(str1 As String) As String
        'On Error Resume Next

        'Dim cookie As New HttpCookie("user_rqd")
        'Response.AppendCookie(cookie)
        'cookie.Expires = DateTime.Now.AddDays(-1)
        'Response.Redirect("A_Login.aspx")

        Return "成功"
    End Function
    Private Sub LinkButton1_Click(sender As Object, e As EventArgs) Handles LinkButton1.Click
        Dim cookie As New HttpCookie("user_rqd")
        Response.AppendCookie(cookie)
        cookie.Expires = DateTime.Now.AddDays(-1)

        Dim cookie2 As New HttpCookie("wxuser_rqd")
        Response.AppendCookie(cookie2)
        cookie2.Expires = DateTime.Now.AddDays(-1)

        Session("iphone") = ""
        Session("userid") = ""
        Session("openid") = ""
        Session("url") = ""
        Session("name") = ""
        Session("job") = ""
        Session("email") = ""
        '为1就是公司管理人员用户
        Session("Popdom") = ""
        '所属公司名称
        Session("username") = ""
        '所属公司编码
        Session("usercode") = ""


        Response.Redirect("A_Login1.aspx")
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function ReturnUnit(str1 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset
        str1 = ""
        rs = cPConn.Execute("Select * from DicUnit where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount
                'str1 = str1 & rs.Fields("cUnitName").Value & ","
                str1 += """" + rs.Fields("cUnitName").Value + ""","


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
    Public Shared Function iPhoneReg(str1 As String, str2 As String, str3 As String) As String
        On Error Resume Next

        Dim rs As New ADODB.Recordset
        Dim pass As String

        pass = DigestStrToHexStr(str3)

        If str1 = HttpContext.Current.Session("iphone") And str2 = HttpContext.Current.Session("iphoneCode") Then

            rs = cPConn.Execute("select * from dbuser where cname='" & str1 & "'")
            If rs.RecordCount = 0 Then

                '同时把cName和iphoneNumber全部更新成手机号
                cPConn.Execute("update dbuser set cname='" & str1 & "',cPass='" & pass & "',iphoneNumber='" & str1 & "' where wxname='" & HttpContext.Current.Session("openid") & "'")
                'cPConn.Execute("insert into dbuser (cName,iphonenumber,cpass) values('" & str1 & "','" & str1 & "','" & pass & "')")

                HttpContext.Current.Session("userid") = str1
                'HttpContext.Current.Session("iphone") = str1


            Else
                Return "已经注册"
            End If

            ''当前用户
            'HttpContext.Current.Session("userid") = str1
            'HttpContext.Current.Session("iphone") = str1


            Return "注册成功"
        Else
            Return "注册失败"
        End If



    End Function
End Class
