Imports Microsoft.VisualBasic.Compatibility

Public Module Main
    Private Declare Function GetComputerName Lib "kernel32" Alias "GetComputerNameA" (ByVal lpBuffer As String, ByRef nSize As Integer) As Integer

    Public cPConn As New ADODB.Connection
    Public mServer As String = ""
    Public mDataBase As String = ""
    Public mUser As String = ""
    Public mPassWord As String = ""
    Public mDomain As String
    Public mDataSort As String = 0       '数据库类型0_Sql数据库，1_Access数据库
    Public mTableOrder As String = ""    '数据表编号
    Public bMLink As Boolean = False          '主窗口是否能登录,数据库连接是否成功
    Public bMClassName As Boolean = False    '当前用户是否是子用户true是子用户，默认是false
    Public cPHostName As String '主机名称
    Public cPLogin As Boolean
    Public cPCurUser As String = ""

    Public Sub MainPro()
        cPHostName = GetHostName()
        If cPHostName = "Cancel" Then
            MsgBox("主机名称不能正确取得！请通知系统管理员...", MsgBoxStyle.Exclamation + MsgBoxStyle.OkOnly, "提示")
            Exit Sub
        End If
    End Sub
    '获取主机名称
    Public Function GetHostName() As Object
        Dim sBuff As New VB6.FixedLengthString(20)

        Dim iLen As Integer
        Dim OkSign As Integer
        iLen = 20
        OkSign = GetComputerName(sBuff.Value, iLen)

        If OkSign = 0 Then
            GetHostName = "Cancel"
        Else
            GetHostName = Trim(Mid(sBuff.Value, 1, InStr(1, sBuff.Value, Chr(0)) - 1))
        End If
    End Function
    'sKey，表示查哪个流水码
    'cFlag，R_读取流水码，W_写流水码
    '根据DicWaterCode中的cPerUnit字段值读写流水号（以YY,MM,DD即年月日）
    Public Function GetCode(ByVal sKey As String, ByRef cFlag As String, ByRef ipYear As Short, ByRef ipMonth As Short, ByRef ipDay As Short) As String
        On Error GoTo Err_Hand
        Dim rs As New ADODB.Recordset
        Dim sFldCode As String '读写字段
        Dim sPerCond As String '统计单元条件，根据DicWaterCode中cPerUnit值确定
        Dim sLocField As String '查询字段
        Dim sInsField As String '插入字段
        Dim bIfCond As Boolean 'if条件字符串
        Dim sSign As String '流水号单元标志，YY_MM_DD
        Dim sCode As String
        Dim sNo As String
        Dim sConnStr As String '连接字符串

        sPerCond = ""
        sLocField = ""
        sInsField = ""
        sConnStr = ""

        rs = cPConn.Execute("select * from dbDicWaterCode where ckey='" & sKey & "'")
        If rs.RecordCount = 0 Then
            Call InsertWaterCode(sKey)
            sSign = "DD"
            '        MsgBox "流水号字典表错误！", vbExclamation, "提示"
            '        GetCode = "err"
            '        rs.Close
            '        Exit Function
        Else
            sSign = rs.Fields("cperunit").Value
        End If
        rs.Close()

        '若单元标志不在"YYMMDD"中，由数据表约束
        Select Case sSign
            Case "YY"
                sPerCond = " iyear=" & ipYear & ""
                sLocField = "iyear"
                sInsField = "" & ipYear & ""
            Case "MM"
                sPerCond = " iyear=" & ipYear & " and imonth=" & ipMonth & ""
                sLocField = "iyear,imonth"
                sInsField = "" & ipYear & "," & ipMonth & ""
            Case "DD"
                sPerCond = "  iyear=" & ipYear & " and imonth=" & ipMonth & " and iday=" & ipDay & ""
                sLocField = "iyear,imonth,iday"
                sInsField = "" & ipYear & "," & ipMonth & "," & ipDay & ""
        End Select

        cFlag = UCase(cFlag)

        If cFlag <> "R" And cFlag <> "W" Then
            MsgBox("传递参数错误！", MsgBoxStyle.Exclamation, "提示")
            GetCode = "err"
            Exit Function
        End If
        sFldCode = IIf(cFlag = "R", "creadcode", "cwritecode")

        rs = cPConn.Execute("select " & sFldCode & ",iyear,imonth,iday,ilen,ckey,chead,ccompart from waterCodeView where ckey='" & sKey & "' and " & sPerCond)
        If rs.RecordCount <> 1 Then
            cPConn.Execute("insert into watercode (" & sLocField & ",ckey) select " & sInsField & ",ckey from dbDicWaterCode where ckey='" & sKey & "'")
            rs.Requery()
            If rs.RecordCount <> 1 Then
                MsgBox("参数传递错误或流水号表发生错误！", MsgBoxStyle.Exclamation, "提示")
                GetCode = "err"
                Exit Function
            End If
        End If






        Select Case sSign
            Case "YY"
                sConnStr = rs.Fields("iYear").Value
                bIfCond = rs.Fields("iYear").Value <> ipYear
            Case "MM"
                sConnStr = rs.Fields("iYear").Value & Strings.Right("00" & rs.Fields("iMonth").Value, 2)
                bIfCond = rs.Fields("iYear").Value <> ipYear And rs.Fields("iMonth").Value <> ipMonth
            Case "DD"
                sConnStr = rs.Fields("iYear").Value & Strings.Right("00" & rs.Fields("iMonth").Value, 2) & Strings.Right("00" & rs.Fields("iday").Value, 2)
                bIfCond = rs.Fields("iYear").Value <> ipYear And rs.Fields("iMonth").Value <> ipMonth And rs.Fields("iday").Value <> ipDay
        End Select

        '若日期<>dPCurDate，则置日期为dPCurDate,流水号为000001
        If bIfCond Then
            sNo = Right(New String("0", rs.Fields("iLen").Value) & "1", rs.Fields("iLen").Value)
            cPConn.Execute("update watercode set cwritecode='000000' where ckey='" & sKey & "' and " & sPerCond)
            rs.Requery()
        Else '否则，流水号加1
            sNo = Right(New String("0", rs.Fields("iLen").Value) & Trim(Str(Val(rs.Fields(0).Value) + 1)), rs.Fields("iLen").Value)
        End If

        sCode = rs.Fields("chead").Value & sConnStr & IIf(rs.Fields("ccompart").Value = "'", "-", rs.Fields("ccompart").Value) & sNo
        cPConn.Execute("update watercode set " & sFldCode & "='" & sNo & "' where ckey='" & sKey & "' and " & sPerCond)
        GetCode = sCode
        rs.Close()

        '若为读取写流水号，则恢复读流水号
        If cFlag = "W" Then cPConn.Execute("update watercode set creadcode=cwritecode where ckey='" & sKey & "' and " & sPerCond)

        Exit Function

Err_Hand:
        If cPConn.Errors.Count = 0 Then
            MsgBox("错 误 号：" & Err.Number & vbCrLf & "错误描述：" & Err.Description & vbCrLf & "错误来源：" & Err.Source & vbCrLf & "请通知系统管理员...", MsgBoxStyle.Exclamation, "提示")
            GetCode = "err"
            Exit Function
        End If

        Select Case cPConn.Errors(0).NativeError
            Case 2627
                Resume Next
            Case Else
                MsgBox("错 误 号：" & cPConn.Errors(0).NativeError & vbCr & vbLf & "错误信息：" & cPConn.Errors(0).Description & vbCr & vbLf & vbCr & vbLf & "请通知系统管理员！", MsgBoxStyle.Exclamation, "提示")
                GetCode = "err"
                Exit Function
        End Select

    End Function
    Public Function InsertWaterCode(ByRef sKey As String) As Object
        Dim cKey As String
        cKey = sKey

        InsertWaterCode = ""

        If cKey = "dbTableName" Then
            cPConn.Execute("insert into dbDicWaterCode(id,cKey,cKeyName,cHead,iLen,cCompart,cPerUnit,bSys)" & " values (1,'" & cKey & "','" & cKey & "表','TK',4,'-','DD',0)" & " ")
        ElseIf cKey = "dbTableFldName" Then
            cPConn.Execute("insert into dbDicWaterCode(id,cKey,cKeyName,cHead,iLen,cCompart,cPerUnit,bSys)" & " values (2,'" & cKey & "','" & cKey & "表','TL',4,'-','DD',0)" & " ")
        ElseIf cKey = "dbObjName" Then
            cPConn.Execute("insert into dbDicWaterCode(id,cKey,cKeyName,cHead,iLen,cCompart,cPerUnit,bSys)" & " values (0,'" & cKey & "','" & cKey & "表','TO',4,'-','DD',0)" & " ")
        Else
            cPConn.Execute("insert into dbDicWaterCode(id,cKey,cKeyName,cHead,iLen,cCompart,cPerUnit,bSys)" & " values (8,'" & cKey & "','" & cKey & "表','" & Left(UCase(cKey), 1) & Right(UCase(cKey), 1) & "',4,'-','DD',0)" & " ")
        End If


    End Function

    '获取服务器日期
    Public Function SrvDate() As Object
        Dim cmd As New ADODB.Command
        Dim Para1 As New ADODB.Parameter

        cmd.let_ActiveConnection(cPConn)
        cmd.CommandText = "GetDate"
        cmd.CommandType = ADODB.CommandTypeEnum.adCmdStoredProc

        Para1 = cmd.CreateParameter("cc", ADODB.DataTypeEnum.adDate, ADODB.ParameterDirectionEnum.adParamOutput, 20)
        cmd.Parameters.Append(Para1)

        cmd.Execute()

        SrvDate = Para1.Value
    End Function
    Private Const BITS_TO_A_BYTE = 8
    Private Const BYTES_TO_A_WORD = 4
    Private Const BITS_TO_A_WORD = 32

    Private m_lOnBits(30) As Object
    Private m_l2Power(30) As Object

    Private Function LShift(lValue As Object, iShiftBits As Object) As Object
        If iShiftBits = 0 Then
            LShift = lValue
            Exit Function
        ElseIf iShiftBits = 31 Then
            If lValue And 1 Then
                LShift = &H80000000
            Else
                LShift = 0
            End If
            Exit Function
        ElseIf iShiftBits < 0 Or iShiftBits > 31 Then
            Err.Raise(6)
        End If

        If (lValue And m_l2Power(31 - iShiftBits)) Then
            LShift = ((lValue And m_lOnBits(31 - (iShiftBits + 1))) * m_l2Power(iShiftBits)) Or &H80000000
        Else
            LShift = ((lValue And m_lOnBits(31 - iShiftBits)) * m_l2Power(iShiftBits))
        End If
    End Function

    Private Function RShift(lValue As Object, iShiftBits As Object) As Object
        If iShiftBits = 0 Then
            RShift = lValue
            Exit Function
        ElseIf iShiftBits = 31 Then
            If lValue And &H80000000 Then
                RShift = 1
            Else
                RShift = 0
            End If
            Exit Function
        ElseIf iShiftBits < 0 Or iShiftBits > 31 Then
            Err.Raise(6)
        End If

        RShift = (lValue And &H7FFFFFFE) \ m_l2Power(iShiftBits)

        If (lValue And &H80000000) Then
            RShift = (RShift Or (&H40000000 \ m_l2Power(iShiftBits - 1)))
        End If
    End Function

    Private Function RotateLeft(lValue As Object, iShiftBits As Object) As Object
        RotateLeft = LShift(lValue, iShiftBits) Or RShift(lValue, (32 - iShiftBits))
    End Function

    Private Function AddUnsigned(lX As Object, lY As Object) As Object
        Dim lX4 As Object
        Dim lY4 As Object
        Dim lX8 As Object
        Dim lY8 As Object
        Dim lResult As Object

        lX8 = lX And &H80000000
        lY8 = lY And &H80000000
        lX4 = lX And &H40000000
        lY4 = lY And &H40000000

        lResult = (lX And &H3FFFFFFF) + (lY And &H3FFFFFFF)

        If lX4 And lY4 Then
            lResult = lResult Xor &H80000000 Xor lX8 Xor lY8
        ElseIf lX4 Or lY4 Then
            If lResult And &H40000000 Then
                lResult = lResult Xor &HC0000000 Xor lX8 Xor lY8
            Else
                lResult = lResult Xor &H40000000 Xor lX8 Xor lY8
            End If
        Else
            lResult = lResult Xor lX8 Xor lY8
        End If

        AddUnsigned = lResult
    End Function

    Private Function md5_F(x As Object, y As Object, z As Object) As Object
        md5_F = (x And y) Or ((Not x) And z)
    End Function

    Private Function md5_G(x As Object, y As Object, z As Object) As Object
        md5_G = (x And z) Or (y And (Not z))
    End Function

    Private Function md5_H(x As Object, y As Object, z As Object) As Object
        md5_H = (x Xor y Xor z)
    End Function

    Private Function md5_I(x As Object, y As Object, z As Object) As Object
        md5_I = (y Xor (x Or (Not z)))
    End Function

    Private Sub md5_FF(a As Object, b As Object, c As Object, d As Object, x As Object, s As Object, ac As Object)
        a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_F(b, c, d), x), ac))
        a = RotateLeft(a, s)
        a = AddUnsigned(a, b)
    End Sub

    Private Sub md5_GG(a As Object, b As Object, c As Object, d As Object, x As Object, s As Object, ac As Object)
        a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_G(b, c, d), x), ac))
        a = RotateLeft(a, s)
        a = AddUnsigned(a, b)
    End Sub

    Private Sub md5_HH(a As Object, b As Object, c As Object, d As Object, x As Object, s As Object, ac As Object)
        a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_H(b, c, d), x), ac))
        a = RotateLeft(a, s)
        a = AddUnsigned(a, b)
    End Sub

    Private Sub md5_II(a As Object, b As Object, c As Object, d As Object, x As Object, s As Object, ac As Object)
        a = AddUnsigned(a, AddUnsigned(AddUnsigned(md5_I(b, c, d), x), ac))
        a = RotateLeft(a, s)
        a = AddUnsigned(a, b)
    End Sub

    Private Function ConvertToWordArray(sMessage As Object) As Object
        Dim lMessageLength As Object
        Dim lNumberOfWords As Object
        Dim lWordArray() As Object
        Dim lBytePosition As Object
        Dim lByteCount As Object
        Dim lWordCount As Object

        Const MODULUS_BITS = 512
        Const CONGRUENT_BITS = 448

        lMessageLength = Len(sMessage)

        lNumberOfWords = (((lMessageLength + ((MODULUS_BITS - CONGRUENT_BITS) \ BITS_TO_A_BYTE)) \ (MODULUS_BITS \ BITS_TO_A_BYTE)) + 1) * (MODULUS_BITS \ BITS_TO_A_WORD)
        ReDim lWordArray(lNumberOfWords - 1)

        lBytePosition = 0
        lByteCount = 0
        Do Until lByteCount >= lMessageLength
            lWordCount = lByteCount \ BYTES_TO_A_WORD
            lBytePosition = (lByteCount Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE
            lWordArray(lWordCount) = lWordArray(lWordCount) Or LShift(Asc(Mid(sMessage, lByteCount + 1, 1)), lBytePosition)
            lByteCount = lByteCount + 1
        Loop

        lWordCount = lByteCount \ BYTES_TO_A_WORD
        lBytePosition = (lByteCount Mod BYTES_TO_A_WORD) * BITS_TO_A_BYTE

        lWordArray(lWordCount) = lWordArray(lWordCount) Or LShift(&H80, lBytePosition)

        lWordArray(lNumberOfWords - 2) = LShift(lMessageLength, 3)
        lWordArray(lNumberOfWords - 1) = RShift(lMessageLength, 29)

        ConvertToWordArray = lWordArray
    End Function

    Private Function WordToHex(lValue As Object) As Object
        Dim lByte As Object
        Dim lCount As Object

        WordToHex = ""

        For lCount = 0 To 3
            lByte = RShift(lValue, lCount * BITS_TO_A_BYTE) And m_lOnBits(BITS_TO_A_BYTE - 1)
            WordToHex = WordToHex & Right("0" & Hex(lByte), 2)
        Next
    End Function


    Public Function MD5(sMessage As String, stype As Object) As Object
        m_lOnBits(0) = CLng(1)
        m_lOnBits(1) = CLng(3)
        m_lOnBits(2) = CLng(7)
        m_lOnBits(3) = CLng(15)
        m_lOnBits(4) = CLng(31)
        m_lOnBits(5) = CLng(63)
        m_lOnBits(6) = CLng(127)
        m_lOnBits(7) = CLng(255)
        m_lOnBits(8) = CLng(511)
        m_lOnBits(9) = CLng(1023)
        m_lOnBits(10) = CLng(2047)
        m_lOnBits(11) = CLng(4095)
        m_lOnBits(12) = CLng(8191)
        m_lOnBits(13) = CLng(16383)
        m_lOnBits(14) = CLng(32767)
        m_lOnBits(15) = CLng(65535)
        m_lOnBits(16) = CLng(131071)
        m_lOnBits(17) = CLng(262143)
        m_lOnBits(18) = CLng(524287)
        m_lOnBits(19) = CLng(1048575)
        m_lOnBits(20) = CLng(2097151)
        m_lOnBits(21) = CLng(4194303)
        m_lOnBits(22) = CLng(8388607)
        m_lOnBits(23) = CLng(16777215)
        m_lOnBits(24) = CLng(33554431)
        m_lOnBits(25) = CLng(67108863)
        m_lOnBits(26) = CLng(134217727)
        m_lOnBits(27) = CLng(268435455)
        m_lOnBits(28) = CLng(536870911)
        m_lOnBits(29) = CLng(1073741823)
        m_lOnBits(30) = CLng(2147483647)

        m_l2Power(0) = CLng(1)
        m_l2Power(1) = CLng(2)
        m_l2Power(2) = CLng(4)
        m_l2Power(3) = CLng(8)
        m_l2Power(4) = CLng(16)
        m_l2Power(5) = CLng(32)
        m_l2Power(6) = CLng(64)
        m_l2Power(7) = CLng(128)
        m_l2Power(8) = CLng(256)
        m_l2Power(9) = CLng(512)
        m_l2Power(10) = CLng(1024)
        m_l2Power(11) = CLng(2048)
        m_l2Power(12) = CLng(4096)
        m_l2Power(13) = CLng(8192)
        m_l2Power(14) = CLng(16384)
        m_l2Power(15) = CLng(32768)
        m_l2Power(16) = CLng(65536)
        m_l2Power(17) = CLng(131072)
        m_l2Power(18) = CLng(262144)
        m_l2Power(19) = CLng(524288)
        m_l2Power(20) = CLng(1048576)
        m_l2Power(21) = CLng(2097152)
        m_l2Power(22) = CLng(4194304)
        m_l2Power(23) = CLng(8388608)
        m_l2Power(24) = CLng(16777216)
        m_l2Power(25) = CLng(33554432)
        m_l2Power(26) = CLng(67108864)
        m_l2Power(27) = CLng(134217728)
        m_l2Power(28) = CLng(268435456)
        m_l2Power(29) = CLng(536870912)
        m_l2Power(30) = CLng(1073741824)


        Dim x As Object
        Dim k As Object
        Dim AA As Object
        Dim BB As Object
        Dim CC As Object
        Dim DD As Object
        Dim a As Object
        Dim b As Object
        Dim c As Object
        Dim d As Object

        Const S11 = 7
        Const S12 = 12
        Const S13 = 17
        Const S14 = 22
        Const S21 = 5
        Const S22 = 9
        Const S23 = 14
        Const S24 = 20
        Const S31 = 4
        Const S32 = 11
        Const S33 = 16
        Const S34 = 23
        Const S41 = 6
        Const S42 = 10
        Const S43 = 15
        Const S44 = 21

        x = ConvertToWordArray(sMessage)

        a = &H67452301
        b = &HEFCDAB89
        c = &H98BADCFE
        d = &H10325476

        For k = 0 To UBound(x) Step 16
            AA = a
            BB = b
            CC = c
            DD = d

            md5_FF(a, b, c, d, x(k + 0), S11, &HD76AA478)
            md5_FF(d, a, b, c, x(k + 1), S12, &HE8C7B756)
            md5_FF(c, d, a, b, x(k + 2), S13, &H242070DB)
            md5_FF(b, c, d, a, x(k + 3), S14, &HC1BDCEEE)
            md5_FF(a, b, c, d, x(k + 4), S11, &HF57C0FAF)
            md5_FF(d, a, b, c, x(k + 5), S12, &H4787C62A)
            md5_FF(c, d, a, b, x(k + 6), S13, &HA8304613)
            md5_FF(b, c, d, a, x(k + 7), S14, &HFD469501)
            md5_FF(a, b, c, d, x(k + 8), S11, &H698098D8)
            md5_FF(d, a, b, c, x(k + 9), S12, &H8B44F7AF)
            md5_FF(c, d, a, b, x(k + 10), S13, &HFFFF5BB1)
            md5_FF(b, c, d, a, x(k + 11), S14, &H895CD7BE)
            md5_FF(a, b, c, d, x(k + 12), S11, &H6B901122)
            md5_FF(d, a, b, c, x(k + 13), S12, &HFD987193)
            md5_FF(c, d, a, b, x(k + 14), S13, &HA679438E)
            md5_FF(b, c, d, a, x(k + 15), S14, &H49B40821)

            md5_GG(a, b, c, d, x(k + 1), S21, &HF61E2562)
            md5_GG(d, a, b, c, x(k + 6), S22, &HC040B340)
            md5_GG(c, d, a, b, x(k + 11), S23, &H265E5A51)
            md5_GG(b, c, d, a, x(k + 0), S24, &HE9B6C7AA)
            md5_GG(a, b, c, d, x(k + 5), S21, &HD62F105D)
            md5_GG(d, a, b, c, x(k + 10), S22, &H2441453)
            md5_GG(c, d, a, b, x(k + 15), S23, &HD8A1E681)
            md5_GG(b, c, d, a, x(k + 4), S24, &HE7D3FBC8)
            md5_GG(a, b, c, d, x(k + 9), S21, &H21E1CDE6)
            md5_GG(d, a, b, c, x(k + 14), S22, &HC33707D6)
            md5_GG(c, d, a, b, x(k + 3), S23, &HF4D50D87)
            md5_GG(b, c, d, a, x(k + 8), S24, &H455A14ED)
            md5_GG(a, b, c, d, x(k + 13), S21, &HA9E3E905)
            md5_GG(d, a, b, c, x(k + 2), S22, &HFCEFA3F8)
            md5_GG(c, d, a, b, x(k + 7), S23, &H676F02D9)
            md5_GG(b, c, d, a, x(k + 12), S24, &H8D2A4C8A)

            md5_HH(a, b, c, d, x(k + 5), S31, &HFFFA3942)
            md5_HH(d, a, b, c, x(k + 8), S32, &H8771F681)
            md5_HH(c, d, a, b, x(k + 11), S33, &H6D9D6122)
            md5_HH(b, c, d, a, x(k + 14), S34, &HFDE5380C)
            md5_HH(a, b, c, d, x(k + 1), S31, &HA4BEEA44)
            md5_HH(d, a, b, c, x(k + 4), S32, &H4BDECFA9)
            md5_HH(c, d, a, b, x(k + 7), S33, &HF6BB4B60)
            md5_HH(b, c, d, a, x(k + 10), S34, &HBEBFBC70)
            md5_HH(a, b, c, d, x(k + 13), S31, &H289B7EC6)
            md5_HH(d, a, b, c, x(k + 0), S32, &HEAA127FA)
            md5_HH(c, d, a, b, x(k + 3), S33, &HD4EF3085)
            md5_HH(b, c, d, a, x(k + 6), S34, &H4881D05)
            md5_HH(a, b, c, d, x(k + 9), S31, &HD9D4D039)
            md5_HH(d, a, b, c, x(k + 12), S32, &HE6DB99E5)
            md5_HH(c, d, a, b, x(k + 15), S33, &H1FA27CF8)
            md5_HH(b, c, d, a, x(k + 2), S34, &HC4AC5665)

            md5_II(a, b, c, d, x(k + 0), S41, &HF4292244)
            md5_II(d, a, b, c, x(k + 7), S42, &H432AFF97)
            md5_II(c, d, a, b, x(k + 14), S43, &HAB9423A7)
            md5_II(b, c, d, a, x(k + 5), S44, &HFC93A039)
            md5_II(a, b, c, d, x(k + 12), S41, &H655B59C3)
            md5_II(d, a, b, c, x(k + 3), S42, &H8F0CCC92)
            md5_II(c, d, a, b, x(k + 10), S43, &HFFEFF47D)
            md5_II(b, c, d, a, x(k + 1), S44, &H85845DD1)
            md5_II(a, b, c, d, x(k + 8), S41, &H6FA87E4F)
            md5_II(d, a, b, c, x(k + 15), S42, &HFE2CE6E0)
            md5_II(c, d, a, b, x(k + 6), S43, &HA3014314)
            md5_II(b, c, d, a, x(k + 13), S44, &H4E0811A1)
            md5_II(a, b, c, d, x(k + 4), S41, &HF7537E82)
            md5_II(d, a, b, c, x(k + 11), S42, &HBD3AF235)
            md5_II(c, d, a, b, x(k + 2), S43, &H2AD7D2BB)
            md5_II(b, c, d, a, x(k + 9), S44, &HEB86D391)

            a = AddUnsigned(a, AA)
            b = AddUnsigned(b, BB)
            c = AddUnsigned(c, CC)
            d = AddUnsigned(d, DD)
        Next

        If stype = 32 Then
            MD5 = LCase(WordToHex(a) & WordToHex(b) & WordToHex(c) & WordToHex(d))
        Else
            MD5 = LCase(WordToHex(b) & WordToHex(c))
        End If
    End Function





    Private Const OFFSET_4 As Double = 4294967296.0#
    Private Const MAXINT_4 As Double = 2147483647

    Private Const S11 As Short = 7
    Private Const S12 As Short = 12
    Private Const S13 As Short = 17
    Private Const S14 As Short = 22
    Private Const S21 As Short = 5
    Private Const S22 As Short = 9
    Private Const S23 As Short = 14
    Private Const S24 As Short = 20
    Private Const S31 As Short = 4
    Private Const S32 As Short = 11
    Private Const S33 As Short = 16
    Private Const S34 As Short = 23
    Private Const S41 As Short = 6
    Private Const S42 As Short = 10
    Private Const S43 As Short = 15
    Private Const S44 As Short = 21


    Private State(4) As Integer
    Private ByteCounter As Integer
    Private ByteBuffer(63) As Byte

    ReadOnly Property RegisterA() As String
        Get
            RegisterA = CStr(State(1))
        End Get
    End Property

    ReadOnly Property RegisterB() As String
        Get
            RegisterB = CStr(State(2))
        End Get
    End Property

    ReadOnly Property RegisterC() As String
        Get
            RegisterC = CStr(State(3))
        End Get
    End Property

    ReadOnly Property RegisterD() As String
        Get
            RegisterD = CStr(State(4))
        End Get
    End Property

    Public Function DigestFileToHexStr(ByRef FileName As String) As String
        FileOpen(1, FileName, OpenMode.Binary, OpenAccess.Read)
        MD5Init()
        Do While Not EOF(1)

            FileGet(1, ByteBuffer)
            If Loc(1) < LOF(1) Then
                ByteCounter = ByteCounter + 64
                MD5Transform(ByteBuffer)
            End If
        Loop
        ByteCounter = ByteCounter + (LOF(1) Mod 64)
        FileClose(1)
        MD5Final()
        DigestFileToHexStr = GetValues()
    End Function


    Public Function DigestStrToHexStr(ByRef SourceString As String) As String
        MD5Init()
        MD5Update(Len(SourceString), StringToArray(SourceString))
        MD5Final()
        DigestStrToHexStr = GetValues()
    End Function


    Private Function StringToArray(ByRef InString As String) As Byte()
        Dim I As Short
        Dim bytBuffer() As Byte
        ReDim bytBuffer(Len(InString))
        For I = 0 To Len(InString) - 1
            bytBuffer(I) = Asc(Mid(InString, I + 1, 1))
        Next I
        'StringToArray = VB6.CopyArray(bytBuffer)
        StringToArray = bytBuffer

    End Function

    Public Function GetValues() As String
        GetValues = LongToString(State(1)) & LongToString(State(2)) & LongToString(State(3)) & LongToString(State(4))
    End Function


    Private Function LongToString(ByRef Num As Integer) As String
        Dim a As Byte
        Dim b As Byte
        Dim c As Byte
        Dim d As Byte

        a = Num And &HFF
        If a < 16 Then
            LongToString = "0" & Hex(a)
        Else
            LongToString = Hex(a)
        End If

        b = (Num And &HFF00) \ 256
        If b < 16 Then
            LongToString = LongToString & "0" & Hex(b)
        Else
            LongToString = LongToString & Hex(b)
        End If

        c = (Num And &HFF0000) \ 65536
        If c < 16 Then
            LongToString = LongToString & "0" & Hex(c)
        Else
            LongToString = LongToString & Hex(c)
        End If

        If Num < 0 Then
            d = ((Num And &H7F000000) \ 16777216) Or &H80
        Else
            d = (Num And &HFF000000) \ 16777216
        End If

        If d < 16 Then
            LongToString = LongToString & "0" & Hex(d)
        Else
            LongToString = LongToString & Hex(d)
        End If

    End Function

    Public Sub MD5Init()
        ByteCounter = 0
        State(1) = UnsignedToLong(1732584193.0#)
        State(2) = UnsignedToLong(4023233417.0#)
        State(3) = UnsignedToLong(2562383102.0#)
        State(4) = UnsignedToLong(271733878.0#)
    End Sub

    '
    ' MD5 Final
    '
    Public Sub MD5Final()
        Dim dblBits As Double

        Dim padding(72) As Byte
        Dim lngBytesBuffered As Integer

        padding(0) = &H80

        dblBits = ByteCounter * 8

        ' Pad out
        lngBytesBuffered = ByteCounter Mod 64
        If lngBytesBuffered <= 56 Then
            MD5Update(56 - lngBytesBuffered, padding)
        Else
            MD5Update(120 - ByteCounter, padding)
        End If


        padding(0) = UnsignedToLong(dblBits) And &HFF
        padding(1) = UnsignedToLong(dblBits) \ 256 And &HFF
        padding(2) = UnsignedToLong(dblBits) \ 65536 And &HFF
        padding(3) = UnsignedToLong(dblBits) \ 16777216 And &HFF
        padding(4) = 0
        padding(5) = 0
        padding(6) = 0
        padding(7) = 0

        MD5Update(8, padding)
    End Sub

    '
    ' Break up input stream into 64 byte chunks
    '
    Public Sub MD5Update(ByRef InputLen As Integer, ByRef InputBuffer() As Byte)
        Dim II As Short
        Dim I As Short
        Dim J As Short
        Dim K As Short
        Dim lngBufferedBytes As Integer
        Dim lngBufferRemaining As Integer
        Dim lngRem As Integer

        lngBufferedBytes = ByteCounter Mod 64
        lngBufferRemaining = 64 - lngBufferedBytes
        ByteCounter = ByteCounter + InputLen
        ' Use up old buffer results first
        If InputLen >= lngBufferRemaining Then
            For II = 0 To lngBufferRemaining - 1
                ByteBuffer(lngBufferedBytes + II) = InputBuffer(II)
            Next II
            MD5Transform(ByteBuffer)

            lngRem = (InputLen) Mod 64
            ' The transfer is a multiple of 64 lets do some transformations
            For I = lngBufferRemaining To InputLen - II - lngRem Step 64
                For J = 0 To 63
                    ByteBuffer(J) = InputBuffer(I + J)
                Next J
                MD5Transform(ByteBuffer)
            Next I
            lngBufferedBytes = 0
        Else
            I = 0
        End If

        ' Buffer any remaining input
        For K = 0 To InputLen - I - 1
            ByteBuffer(lngBufferedBytes + K) = InputBuffer(I + K)
        Next K

    End Sub

    '
    ' MD5 Transform
    '
    Private Sub MD5Transform(ByRef Buffer() As Byte)
        Dim x(16) As Integer
        Dim a As Integer
        Dim b As Integer
        Dim c As Integer
        Dim d As Integer

        a = State(1)
        b = State(2)
        c = State(3)
        d = State(4)

        Decode(64, x, Buffer)

        ' Round 1
        FF(a, b, c, d, x(0), S11, -680876936)
        FF(d, a, b, c, x(1), S12, -389564586)
        FF(c, d, a, b, x(2), S13, 606105819)
        FF(b, c, d, a, x(3), S14, -1044525330)
        FF(a, b, c, d, x(4), S11, -176418897)
        FF(d, a, b, c, x(5), S12, 1200080426)
        FF(c, d, a, b, x(6), S13, -1473231341)
        FF(b, c, d, a, x(7), S14, -45705983)
        FF(a, b, c, d, x(8), S11, 1770035416)
        FF(d, a, b, c, x(9), S12, -1958414417)
        FF(c, d, a, b, x(10), S13, -42063)
        FF(b, c, d, a, x(11), S14, -1990404162)
        FF(a, b, c, d, x(12), S11, 1804603682)
        FF(d, a, b, c, x(13), S12, -40341101)
        FF(c, d, a, b, x(14), S13, -1502002290)
        FF(b, c, d, a, x(15), S14, 1236535329)

        ' Round 2
        GG(a, b, c, d, x(1), S21, -165796510)
        GG(d, a, b, c, x(6), S22, -1069501632)
        GG(c, d, a, b, x(11), S23, 643717713)
        GG(b, c, d, a, x(0), S24, -373897302)
        GG(a, b, c, d, x(5), S21, -701558691)
        GG(d, a, b, c, x(10), S22, 38016083)
        GG(c, d, a, b, x(15), S23, -660478335)
        GG(b, c, d, a, x(4), S24, -405537848)
        GG(a, b, c, d, x(9), S21, 568446438)
        GG(d, a, b, c, x(14), S22, -1019803690)
        GG(c, d, a, b, x(3), S23, -187363961)
        GG(b, c, d, a, x(8), S24, 1163531501)
        GG(a, b, c, d, x(13), S21, -1444681467)
        GG(d, a, b, c, x(2), S22, -51403784)
        GG(c, d, a, b, x(7), S23, 1735328473)
        GG(b, c, d, a, x(12), S24, -1926607734)

        ' Round 3
        HH(a, b, c, d, x(5), S31, -378558)
        HH(d, a, b, c, x(8), S32, -2022574463)
        HH(c, d, a, b, x(11), S33, 1839030562)
        HH(b, c, d, a, x(14), S34, -35309556)
        HH(a, b, c, d, x(1), S31, -1530992060)
        HH(d, a, b, c, x(4), S32, 1272893353)
        HH(c, d, a, b, x(7), S33, -155497632)
        HH(b, c, d, a, x(10), S34, -1094730640)
        HH(a, b, c, d, x(13), S31, 681279174)
        HH(d, a, b, c, x(0), S32, -358537222)
        HH(c, d, a, b, x(3), S33, -722521979)
        HH(b, c, d, a, x(6), S34, 76029189)
        HH(a, b, c, d, x(9), S31, -640364487)
        HH(d, a, b, c, x(12), S32, -421815835)
        HH(c, d, a, b, x(15), S33, 530742520)
        HH(b, c, d, a, x(2), S34, -995338651)

        ' Round 4
        II(a, b, c, d, x(0), S41, -198630844)
        II(d, a, b, c, x(7), S42, 1126891415)
        II(c, d, a, b, x(14), S43, -1416354905)
        II(b, c, d, a, x(5), S44, -57434055)
        II(a, b, c, d, x(12), S41, 1700485571)
        II(d, a, b, c, x(3), S42, -1894986606)
        II(c, d, a, b, x(10), S43, -1051523)
        II(b, c, d, a, x(1), S44, -2054922799)
        II(a, b, c, d, x(8), S41, 1873313359)
        II(d, a, b, c, x(15), S42, -30611744)
        II(c, d, a, b, x(6), S43, -1560198380)
        II(b, c, d, a, x(13), S44, 1309151649)
        II(a, b, c, d, x(4), S41, -145523070)
        II(d, a, b, c, x(11), S42, -1120210379)
        II(c, d, a, b, x(2), S43, 718787259)
        II(b, c, d, a, x(9), S44, -343485551)


        State(1) = LongOverflowAdd(State(1), a)
        State(2) = LongOverflowAdd(State(2), b)
        State(3) = LongOverflowAdd(State(3), c)
        State(4) = LongOverflowAdd(State(4), d)

        '  /* Zeroize sensitive information.
        '*/
        '  MD5_memset ((POINTER)x, 0, sizeof (x));

    End Sub

    Private Sub Decode(ByRef Length As Short, ByRef OutputBuffer() As Integer, ByRef InputBuffer() As Byte)
        Dim intDblIndex As Short
        Dim intByteIndex As Short
        Dim dblSum As Double

        intDblIndex = 0
        For intByteIndex = 0 To Length - 1 Step 4
            dblSum = InputBuffer(intByteIndex) + InputBuffer(intByteIndex + 1) * 256.0# + InputBuffer(intByteIndex + 2) * 65536.0# + InputBuffer(intByteIndex + 3) * 16777216.0#
            OutputBuffer(intDblIndex) = UnsignedToLong(dblSum)
            intDblIndex = intDblIndex + 1
        Next intByteIndex
    End Sub

    '
    ' FF, GG, HH, and II transformations for rounds 1, 2, 3, and 4.
    ' Rotation is separate from addition to prevent recomputation.
    '
    Private Function FF(ByRef a As Integer, ByRef b As Integer, ByRef c As Integer, ByRef d As Integer, ByRef x As Integer, ByRef s As Integer, ByRef ac As Integer) As Integer
        a = LongOverflowAdd4(a, (b And c) Or (Not (b) And d), x, ac)
        a = LongLeftRotate(a, s)
        a = LongOverflowAdd(a, b)
        Return FF
    End Function

    Private Function GG(ByRef a As Integer, ByRef b As Integer, ByRef c As Integer, ByRef d As Integer, ByRef x As Integer, ByRef s As Integer, ByRef ac As Integer) As Integer
        a = LongOverflowAdd4(a, (b And d) Or (c And Not (d)), x, ac)
        a = LongLeftRotate(a, s)
        a = LongOverflowAdd(a, b)
        Return GG
    End Function

    Private Function HH(ByRef a As Integer, ByRef b As Integer, ByRef c As Integer, ByRef d As Integer, ByRef x As Integer, ByRef s As Integer, ByRef ac As Integer) As Integer
        a = LongOverflowAdd4(a, b Xor c Xor d, x, ac)
        a = LongLeftRotate(a, s)
        a = LongOverflowAdd(a, b)
        Return HH
    End Function

    Private Function II(ByRef a As Integer, ByRef b As Integer, ByRef c As Integer, ByRef d As Integer, ByRef x As Integer, ByRef s As Integer, ByRef ac As Integer) As Integer
        a = LongOverflowAdd4(a, c Xor (b Or Not (d)), x, ac)
        a = LongLeftRotate(a, s)
        a = LongOverflowAdd(a, b)
        Return II
    End Function

    Function LongLeftRotate(ByRef value As Integer, ByRef bits As Integer) As Integer
        Dim lngSign As Integer
        Dim lngI As Integer
        bits = bits Mod 32
        If bits = 0 Then LongLeftRotate = value : Exit Function
        For lngI = 1 To bits
            lngSign = value And &HC0000000
            'value = CShort(value And &H3FFFFFFF) * 2
            value = (value And &H3FFFFFFF) * 2
            value = value Or ((lngSign < 0) And 1) Or (CBool(lngSign And &H40000000) And &H80000000)
        Next
        LongLeftRotate = value
    End Function

    Private Function LongOverflowAdd(ByRef Val1 As Integer, ByRef Val2 As Integer) As Integer
        Dim lngHighWord As Integer
        Dim lngLowWord As Integer
        Dim lngOverflow As Integer

        'lngLowWord = CShort(Val1 And &HFFFF) + CShort(Val2 And &HFFFF)
        lngLowWord = (Val1 And &HFFFF) + (Val2 And &HFFFF)
        lngOverflow = lngLowWord \ 65536
        lngHighWord = (((Val1 And &HFFFF0000) \ 65536) + ((Val2 And &HFFFF0000) \ 65536) + lngOverflow) And &HFFFF
        'LongOverflowAdd = UnsignedToLong((lngHighWord * 65536.0#) + CShort(lngLowWord And &HFFFF))
        LongOverflowAdd = UnsignedToLong((lngHighWord * 65536.0#) + (lngLowWord And &HFFFF))

    End Function

    Private Function LongOverflowAdd4(ByRef Val1 As Integer, ByRef Val2 As Integer, ByRef val3 As Integer, ByRef val4 As Integer) As Integer
        Dim lngHighWord As Integer
        Dim lngLowWord As Integer
        Dim lngOverflow As Integer

        'lngLowWord = CShort(CShort(CShort(Val1 And &HFFFF) + CShort(Val2 And &HFFFF)) + CShort(val3 And &HFFFF)) + CShort(val4 And &HFFFF)

        lngLowWord = (Val1 And &HFFFF) + (Val2 And &HFFFF) + (val3 And &HFFFF) + (val4 And &HFFFF)

        lngOverflow = lngLowWord \ 65536
        lngHighWord = (((Val1 And &HFFFF0000) \ 65536) + ((Val2 And &HFFFF0000) \ 65536) + ((val3 And &HFFFF0000) \ 65536) + ((val4 And &HFFFF0000) \ 65536) + lngOverflow) And &HFFFF
        'LongOverflowAdd4 = UnsignedToLong((lngHighWord * 65536.0#) + CShort(lngLowWord And &HFFFF))
        LongOverflowAdd4 = UnsignedToLong((lngHighWord * 65536.0#) + (lngLowWord And &HFFFF))

    End Function

    Private Function UnsignedToLong(ByRef value As Double) As Integer
        If value < 0 Or value >= OFFSET_4 Then Error (6)
        If value <= MAXINT_4 Then
            UnsignedToLong = value
        Else
            UnsignedToLong = value - OFFSET_4
        End If
    End Function

    Private Function LongToUnsigned(ByRef value As Integer) As Double
        If value < 0 Then
            LongToUnsigned = value + OFFSET_4
        Else
            LongToUnsigned = value
        End If
    End Function





End Module
