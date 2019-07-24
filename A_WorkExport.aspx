<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_WorkExport.aspx.vb" Inherits="A_WorkExport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>掌通办公</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
    <link rel="shortcut icon" href="img/img/favicon.ico"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>

    <link href="css/sm.css" rel="stylesheet" />
    <link href="css/sm-extend.css" rel="stylesheet" />
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
    <style type="text/css" style="font-weight: bold">
  body {
    font-family: arial;
        background:#fff;
  }

  table {
    border: 1px solid #ccc;
    width: 95%;
    margin:0;
    padding:0;
    border-collapse: collapse;
    border-spacing: 0;
    margin: 0 auto;
  }

  table tr {
    border: 1px solid #ddd;
    padding: 5px;
  }

  table th, table td {
    padding: 10px;
    text-align: center;
  }

  table th {
    text-transform: uppercase;
    font-size: 14px;
    letter-spacing: 1px;
  }

  @media screen and (max-width: 600px) {

    table {
      border: 0;
    }

    table thead {
      display: none;

    }

    table tr {
      margin-bottom: 10px;
      display: block;
      border-bottom: 0px solid #ddd;
    }

    table td {
      display: block;
      text-align: right;
      font-size: 13px;
      border-bottom: 0px dotted #ccc;
      text-align:left;
    }

    table td:last-child {
      border-bottom: 0;
    }

    table td:before {
      content: attr(data-label);
      float: left;
      text-transform: uppercase;
      font-weight: bold;
    }
  }

.note{max-width: 95%; margin: 0 auto;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div></div>
    
       
    <div class="page-group">

  
    <%--我的日工作汇报列表--%>
    <div class="page" id='work'>
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left external" href="A_Work.aspx" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">工作汇报导出</h1>
        
     
  </header>
          
<div class="content"> 
    <div style="padding-right: 13px; padding-left: 13px;">
        <%If Session("usercode") <> "" %>
        
        <p><a onclick="btn_export()" class="button button-fill" style="color: #FFFFFF; background-color: #4CD964;">导出</a></p> 
        
        
        <% End if %>
        </div>
       <%Dim rs As New ADODB.Recordset %>
            <%rs = cPConn.Execute("select * from [RBView] where iPhoneNumber='" & Session("iphone") & "' order by dRBDate desc") %>


    
                <table id="table1" border="1" cellspacing="0" cellpadding="0" >
        <thead style="font-weight: bold">
            <tr>
                
                <td style="width:20%">时间</td>
                
                <td>内容</td>
            </tr>
        </thead>
        <%If rs.RecordCount <> 0 Then %>
                    
                <% For i = 1 To rs.RecordCount %>
        <tbody>
            <tr>
                
                <td data-label="时间:"><%=Format(rs.Fields("dDate").Value, "MM月dd日") & " " & Format$(rs.Fields("dDate").Value, "ddd")%></td>
                
                <td data-label="内容:" style="vertical-align:top; text-align: left;"><%=rs.Fields("cNR").Value  %></td>
            </tr>
            
        </tbody>
   
    
                     <% rs.MoveNext  %>
                    <% Next %>
    <% End If %>
 </table>



    </div>            
</div>
    </div>
 
    
        
    

        <script src="js/xlsx.full.min.js"></script>
        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>     
        <script>
            function btn_export() {
                var table1 = document.querySelector("#table1");
                var sheet = XLSX.utils.table_to_sheet(table1);//将一个table对象转换成一个sheet对象
                openDownloadDialog(sheet2blob(sheet), '工作汇报.xlsx');
            }
            // 将一个sheet转成最终的excel文件的blob对象，然后利用URL.createObjectURL下载
            function sheet2blob(sheet, sheetName) {
                sheetName = sheetName || 'sheet1';
                var workbook = {
                    SheetNames: [sheetName],
                    Sheets: {}
                };
                workbook.Sheets[sheetName] = sheet; // 生成excel的配置项

                var wopts = {
                    bookType: 'xlsx', // 要生成的文件类型
                    bookSST: false, // 是否生成Shared String Table，官方解释是，如果开启生成速度会下降，但在低版本IOS设备上有更好的兼容性
                    type: 'binary'
                };
                var wbout = XLSX.write(workbook, wopts);
                var blob = new Blob([s2ab(wbout)], {
                    type: "application/octet-stream"
                }); // 字符串转ArrayBuffer
                function s2ab(s) {
                    var buf = new ArrayBuffer(s.length);
                    var view = new Uint8Array(buf);
                    for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
                    return buf;
                }
                return blob;
            }

            function openDownloadDialog(url, saveName) {
                if (typeof url == 'object' && url instanceof Blob) {
                    url = URL.createObjectURL(url); // 创建blob地址
                }
                var aLink = document.createElement('a');
                aLink.href = url;
                aLink.download = saveName || ''; // HTML5新增的属性，指定保存文件名，可以不要后缀，注意，file:///模式下不会生效
                var event;
                if (window.MouseEvent) event = new MouseEvent('click');
                else {
                    event = document.createEvent('MouseEvents');
                    event.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                }
                aLink.dispatchEvent(event);
            }





</script>


        </form> 
  </body>
</html>
