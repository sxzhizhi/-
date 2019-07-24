
Partial Class A_App


    Inherits System.Web.UI.Page

    Private Sub A_App_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Session("onelevel") = "1"

        'If Session("iphone") = "" Then Response.Redirect("A_login.aspx")

        Dim rs As New ADODB.Recordset

        '当用户需要与微信同步时，执行下面代码
        'rs = cPConn.Execute("Select binit from dbUserview where iPhoneNumber='" & Session("iphone") & "'")

        'If rs.Fields("binit").Value = False Then

        '    Dim appid As String = "wxd19bd0389e56e567"
        '    Dim redirect_uri As String = "http%3a%2f%2fmy.aiwei.biz%2faw"
        '    Dim url As String = String.Format("https://open.weixin.qq.com/connect/oauth2/authorize?appid={0}&redirect_uri={1}&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect", appid, redirect_uri)
        '    Response.Redirect(url)

        'End If
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

        'Page.ClientScript.RegisterStartupScript(Page.GetType(), "", "<script>alert('" & Session("iphone") & "！')</script>")

        'Session("WXUser") = True

        If Session("WXUser") = True Then
            Dim cookie2 As New HttpCookie("wxuser_rqd")
            cookie2.Values.Add("wxuname_rqd", HttpUtility.UrlEncode(Session("iphone")))
            'cookie2.Values.Add("wxopenid_rqd", HttpUtility.UrlEncode(Session("openid")))
            'cookie.Values.Add("pwd_rqd", HttpUtility.UrlEncode(password.Text))
            Response.AppendCookie(cookie2)
            cookie2.Expires = DateTime.Now.AddDays(500)
            Session("WXUser") = False
        End If
        Session("NoticeCode") = ""
        Session("QKCode") = ""

        Me.T_Name.Text = Session("name")
        Me.T_Name1.Text = Session("name")

        cPConn.Execute("insert into WaterLog(cUser,cAction,cRemark)values('" & Session("iphone") & "','用户登录','" & Session("name") & "')")


    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function ReturnUnit(str1 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset
        str1 = ""
        rs = cPConn.Execute("Select * from Money where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cPhoneNumber='" & HttpContext.Current.Session("iphone") & "' order by cMonth desc")
        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount
                'str1 = str1 & rs.Fields("cUnitName").Value & ","
                str1 += """" + rs.Fields("cMonth").Value + ""","


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
    Public Shared Function ReturnUnit1(str1 As String) As String
        'On Error Resume Next
        Dim rs As New ADODB.Recordset
        str1 = ""
        rs = cPConn.Execute("Select * from Money1 where zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cPhoneNumber='" & HttpContext.Current.Session("iphone") & "' order by cMonth desc")
        If rs.RecordCount <> 0 Then
            For i = 1 To rs.RecordCount
                'str1 = str1 & rs.Fields("cUnitName").Value & ","
                str1 += """" + rs.Fields("cMonth").Value + ""","


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
    Public Shared Function ViewList(str1 As String) As String
        'On Error Resume Next
        Dim iM1 As Object = 0

        Dim rs As New ADODB.Recordset
        Dim aa As New A_App

        rs = cPConn.Execute("Select * from Money where cMonth='" & str1 & "' and zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cPhoneNumber='" & HttpContext.Current.Session("iphone") & "' ")
        If rs.RecordCount <> 0 Then
            'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")
            'aa.T_Month.Text = rs.Fields("cNR").Value
            'aa.T_Month.Value = rs.Fields("").Value
            iM1 = """" & rs.Fields("iM1").Value & """," & """" & rs.Fields("iM2").Value & """," & """" & rs.Fields("iM3").Value & """," & """" & rs.Fields("iM4").Value & """," _
                 & """" & rs.Fields("iM5").Value & """," & """" & rs.Fields("iM6").Value & """," & """" & rs.Fields("iM7").Value & """," & """" & rs.Fields("iM8").Value & """," _
                 & """" & rs.Fields("iM9").Value & """," & """" & rs.Fields("iM10").Value & """," & """" & rs.Fields("iM11").Value & """," & """" & rs.Fields("iM12").Value & """," _
                 & """" & rs.Fields("iM13").Value & """," & """" & rs.Fields("iM14").Value & """," & """" & rs.Fields("iM15").Value & """," & """" & rs.Fields("iM16").Value & """," _
                 & """" & rs.Fields("iM17").Value & """," & """" & rs.Fields("iM18").Value & """," & """" & rs.Fields("iM19").Value & """," & """" & rs.Fields("iM20").Value & """," _
                 & """" & rs.Fields("iM21").Value & """," & """" & rs.Fields("iM22").Value & """," & """" & rs.Fields("iM23").Value & """," & """" & rs.Fields("iM24").Value & """," _
                 & """" & rs.Fields("iM25").Value & """," & """" & rs.Fields("iM26").Value & """," & """" & rs.Fields("iM27").Value & """"

            'iM1 = iM1 & """" & rs.Fields("iM2").Value & """"

            Return "[" & iM1 & "]"
        Else
            Return "error"
        End If


    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ViewList1(str1 As String) As String
        'On Error Resume Next
        Dim iM1 As Object = 0

        Dim rs As New ADODB.Recordset
        Dim aa As New A_App

        rs = cPConn.Execute("Select * from Money1 where cMonth='" & str1 & "' and zDeptCode='" & HttpContext.Current.Session("usercode") & "' and cPhoneNumber='" & HttpContext.Current.Session("iphone") & "' ")
        If rs.RecordCount <> 0 Then
            'aa.RBdate.Value = Format(rs.Fields("dDate").Value, "yyyy-MM-dd")
            'aa.T_Month.Text = rs.Fields("cNR").Value
            'aa.T_Month.Value = rs.Fields("").Value
            iM1 = """" & rs.Fields("iM1").Value & """," & """" & rs.Fields("iM2").Value & """," & """" & rs.Fields("iM3").Value & """," & """" & rs.Fields("iM4").Value & """," _
                 & """" & rs.Fields("iM5").Value & """," & """" & rs.Fields("iM6").Value & """," & """" & rs.Fields("iM7").Value & """," & """" & rs.Fields("iM8").Value & """," _
                 & """" & rs.Fields("iM9").Value & """," & """" & rs.Fields("iM10").Value & """," & """" & rs.Fields("iM11").Value & """," & """" & rs.Fields("iM12").Value & """," _
                 & """" & rs.Fields("iM13").Value & """," & """" & rs.Fields("iM14").Value & """," & """" & rs.Fields("iM15").Value & """," & """" & rs.Fields("iM16").Value & """," _
                 & """" & rs.Fields("iM17").Value & """," & """" & rs.Fields("iM18").Value & """," & """" & rs.Fields("iM19").Value & """," & """" & rs.Fields("iM20").Value & """," _
                 & """" & rs.Fields("iM21").Value & """," & """" & rs.Fields("iM22").Value & """," & """" & rs.Fields("iM23").Value & """," & """" & rs.Fields("iM24").Value & """," _
                 & """" & rs.Fields("iM25").Value & """," & """" & rs.Fields("iM26").Value & """," & """" & rs.Fields("iM27").Value & """," & """" & rs.Fields("iM28").Value & """," _
                 & """" & rs.Fields("iM29").Value & """"
            'iM1 = iM1 & """" & rs.Fields("iM2").Value & """"

            Return "[" & iM1 & "]"
        Else
            Return "error"
        End If


    End Function
End Class
