
Partial Class A_SBKQ


    Inherits System.Web.UI.Page
    <System.Web.Services.WebMethod()>
    Public Shared Function KQ(str1 As String) As String
        'On Error Resume Next

        Dim rs As New ADODB.Recordset

        Dim sBillCode As String = ""

        Dim dTime As String = ""
        Dim cBZ As String = ""
        rs = cPConn.Execute("Select * from KQDW where zDeptCode='" & HttpContext.Current.Session("usercode") & "'")
        If rs.RecordCount <> 0 Then
            dTime = Format(rs.Fields("dQDTime").Value, "HH:mm")
            If dTime < Format(SrvDate(), "HH:mm") Then
                cBZ = "迟到"
            Else
                cBZ = "准时"
            End If

        End If



        sBillCode = GetCode("SQ", "W", Year(Now.Date), Month(Now.Date), Day(Now.Date))

        cPConn.Execute("insert into KQQD(cCode,cName,dQDTime,cQDJD,cQDWD,dQD,dQTTime,cBZ,zDeptCode)values('" & sBillCode & "','" & HttpContext.Current.Session("iphone") & "','" & SrvDate() & "','上班签到','" & str1 & "','" & Format(SrvDate(), "yyyy-MM-dd") & "','" & dTime & "','" & cBZ & "','" & HttpContext.Current.Session("usercode") & "')")


        Return "成功"

    End Function
End Class
