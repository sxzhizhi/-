
Partial Class A_Import1


    Inherits System.Web.UI.Page

    Private Sub A_Group_Load(sender As Object, e As EventArgs) Handles Me.Load

        'If Session("iphone") = "" Then Response.Redirect("A_login.aspx")

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveGroup(str1 As String, str2 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        Dim cGroupName As String = Replace(str1, "'", "")
        Dim cName() As String = Split(str2, ";")


        Dim sBillCode As String = ""
        Dim sBillCode1 As String = ""




        sBillCode = GetCode("GK", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("insert into dbGroup(cCode,zDeptCode,cPhoneNumber,cGroupName)values('" & sBillCode & "','" & HttpContext.Current.Session("usercode") & "','" & HttpContext.Current.Session("iphone") & "','" & cGroupName & "')")

        For i = 0 To UBound(cName) - 1
            sBillCode1 = GetCode("GL", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

            cPConn.Execute("insert into dbGroupList(cCode,cListCode,cPhoneNumber)values('" & sBillCode & "','" & sBillCode1 & "','" & cName(i) & "')")

        Next

        Return "保存成功"

    End Function
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

            cPConn.Execute("update dbuser set zDeptCode='' where iPhoneNumber='" & cName(i) & "' and zDeptCode='" & HttpContext.Current.Session("usercode") & "'")


        Next

        Return "成功"

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ImportData(str1 As Object) As String
        On Error GoTo errhand

        Dim rs As New ADODB.Recordset

        'Dim cGroupName As String = Replace(str1, "'", "")
        'Dim cName() As String = Split(str2, ";")

        'Dim cData As String
        Dim JSON As Newtonsoft.Json.JsonConvert
        Dim aajson = JSON.DeserializeObject(str1)
        Dim cItem As String = ""
        Dim cM1, cM2, cM3, cM4, cM5, cM6, cM7, cM8, cM9, cM10 As String
        Dim cM11, cM12, cM13, cM14, cM15, cM16, cM17, cM18, cM19, cM20 As String
        Dim cM21, cM22, cM23, cM24, cM25, cM26, cM27, cM28, cM29, cM30 As String
        Dim cM31, cM32, cM33, cM34 As String
        Dim iCount As Integer

        iCount = aajson.Count()

        'Dim bb As Object
        'bb = aajson.Item(1).First.Value


        For i = 0 To iCount - 1
            cM1 = aajson(i).Item("团队编码").ToString
            cM2 = aajson(i).Item("月份").ToString
            cM3 = aajson(i).Item("手机号").ToString
            cM4 = aajson(i).Item("人员编号").ToString
            cM5 = aajson(i).Item("姓名").ToString
            cM6 = aajson(i).Item("岗位/学历工资").ToString
            cM7 = aajson(i).Item("薪级工资").ToString
            cM8 = aajson(i).Item("试用期工资").ToString
            cM9 = aajson(i).Item("保留津贴").ToString
            cM10 = aajson(i).Item("取得资证").ToString
            cM11 = aajson(i).Item("职务补助").ToString
            cM12 = aajson(i).Item("岗位补助").ToString
            cM13 = aajson(i).Item("出勤奖").ToString
            cM14 = aajson(i).Item("车补").ToString
            cM15 = aajson(i).Item("电话补").ToString
            cM16 = aajson(i).Item("证龄补贴").ToString
            cM17 = aajson(i).Item("节假日补助").ToString
            cM18 = aajson(i).Item("未休假补助").ToString
            cM19 = aajson(i).Item("伙食补助").ToString
            cM20 = aajson(i).Item("值班补助").ToString
            cM21 = aajson(i).Item("绩效工资").ToString
            cM22 = aajson(i).Item("平均奖").ToString
            cM23 = aajson(i).Item("其他补发").ToString
            cM24 = aajson(i).Item("其他扣发").ToString
            cM25 = aajson(i).Item("备注").ToString
            cM26 = aajson(i).Item("应发工资").ToString
            cM27 = aajson(i).Item("扣公积金").ToString
            cM28 = aajson(i).Item("扣医疗保险").ToString
            cM29 = aajson(i).Item("扣失业保险").ToString
            cM30 = aajson(i).Item("扣职业年金").ToString
            cM31 = aajson(i).Item("扣养老保险").ToString
            cM32 = aajson(i).Item("实发工资").ToString
            cM33 = aajson(i).Item("扣个税").ToString
            cM34 = aajson(i).Item("税后实发工资").ToString
            If cM1 <> HttpContext.Current.Session("usercode") Then
                Return "工资条模板错误，请核对‘团队编号’！"
                Exit Function
            Else
                cPConn.Execute("insert into money1(zDeptCode,cMonth,cPhoneNumber,cCode,cName,iM1,iM2,iM3,iM4,iM5,iM6,iM7,iM8,iM9,iM10,iM11,iM12,iM13,iM14,iM15,iM16,iM17,iM18,iM19,iM20,iM21,iM22,iM23,iM24,iM25,iM26,iM27,iM28,iM29)values " &
                               "('" & cM1 & "','" & cM2 & "','" & cM3 & "','" & cM4 & "','" & cM5 & "'," &
                               "" & cM6 & "," & cM7 & "," & cM8 & "," & cM9 & "," & cM10 & "," &
                                "" & cM11 & "," & cM12 & "," & cM13 & "," & cM14 & "," & cM15 & "," &
                                "" & cM16 & "," & cM17 & "," & cM18 & "," & cM19 & "," & cM20 & "," &
                                "" & cM21 & "," & cM22 & "," & cM23 & "," & cM24 & "," & cM25 & "," &
                               "" & cM26 & "," & cM27 & "," & cM28 & "," & cM29 & "," & cM30 & "," &
                                "" & cM31 & "," & cM32 & "," & cM33 & "," & cM34 & ")")


            End If


        Next

        Return "导入成功"
        'If cM1 <> "" Then

        '    Return cM1 & cM2 & cM3 & cM4 & cM5
        'Else
        '    Return ""
        'End If

        'json中获取指定数据下面是（access_token）
        'cData = JSON.eval("JSON=" & strReturn & ";JSON.access_token;")

        'cData = JSON.eval("JSON=" & cImportData & ";JSON.团队编号;")

        'If cData <> Nothing Then
        '    '返加成功
        '    'cPConn.Execute("update WXToken set AccessToken='" & cToken & "'")
        '    Return "成功"
        'Else
        '    '返加失败
        '    Return "失败"
        'End If
        'JSON = Nothing

errhand:
        If Err.Number <> 0 Then
            Select Case Err.Number
                Case Else
                    'MsgBox(Err.Number & vbLf &
                    '       Err.Description, vbInformation, "提示")
                    Return Err.Description & "导入失败！"
                    Exit Function
            End Select
        End If

    End Function
End Class
