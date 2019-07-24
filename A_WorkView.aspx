<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_WorkView.aspx.vb" Inherits="A_WorkView" %>

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

</head>
<body>
    <form id="form1" runat="server">
    <div></div>
    
       
    <div class="page-group">

  
        
      
    
               
        
        <div class="page" id='workview'>
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">工作汇报（<%=Session("dRBDate")%>）</h1>
        
  </header>
          
<div class="content"> 
        <%If Session("usercode") <> "" Then %>
       <%Dim rs As New ADODB.Recordset  %>

            <%rs = cPConn.Execute("select * from [PowerView] where CONVERT(varchar(100), dDate, 23)='" & Session("dRBDate") & "' and zDeptCode='" & Session("usercode") & "' and iphone='" & Session("iphone") & "' order by dRBDate desc") %>

              <%If rs.RecordCount <> 0 Then %>
                    
                <% For i = 1 To rs.RecordCount %>
    
      <div class="card">
      <div style="background-color :aliceblue;font-size:14px;" valign="bottom" class="card-header color-white no-border"><%=rs.Fields("cClassName").Value %><div class="color-gray" style="font-size: x-small">发表于: <%= Format(rs.Fields("dRBDate").Value, "yyyy-MM-dd HH:mm")%></div></div>
      <a href ="#" onclick="View('<%=rs.Fields("cCode").Value%>','<%=Format(rs.Fields("dRBDate").Value, "MM-dd HH:mm")%>','<%=rs.Fields("cNR").Value  %>','<%=rs.Fields("cClassName").Value  %>','日报（<%=Format(rs.Fields("dDate").Value, "MM月dd日") & " " & Format$(rs.Fields("dDate").Value, "ddd")%>）');" >
       <div class="card-content">
        <div class="card-content-inner">
          
            <%=rs.Fields("cNR").Value  %>
        </div>
      </div></a>
            <div class="card-footer no-border">
                <span></span>
                <span></span>
              <span>日报（<%=Format(rs.Fields("dDate").Value, "MM月dd日") & " " & Format$(rs.Fields("dDate").Value, "ddd")%>）</span>

            </div>
    </div>





                     <% rs.MoveNext  %>
                    <% Next %>
                  <% End If %>

                 <%else %>
          <br /><br />
          <h4 style="text-align: center; color: #999999">没有工作汇报</h4>

     <% End If %>
   
    </div>            
</div>
    
    



    
    
    <div class="page" id='dayView'>

<div class="content">
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">工作汇报详情</h1>
        
  </header>   
    <br />
  <div class="list-block">

        <ul>
          <!-- Text inputs -->
          <li style="display:none">
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_RBCode" runat="server" placeholder="系统编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
                  <li>
        <div class="item-content">
          
          <div class="item-inner">
            <div class="item-title-row">
              <div class="item-title" id="cName">
            </div>
            <div class="item-subtitle"><div style="font-size: 12px; color: #999999;" id='RBdate'>
                                       </div></div>
          </div> <div class="pull-right" style="font-size: 13px; color: #999999; padding-right: 10px;" id="dDate"></div>
        </div>
            </div> 
      </li>


            </ul> 
    <br />
     
      <ul>
        <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="T_RBNR" runat="server" placeholder="输入日报内容" TextMode="MultiLine" Height="230px" MaxLength="150" Enabled="False"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
    </ul>
  </div>

</div>
      </div>
    
    
    </div>
 
    
        
    


        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>     

                <script type="text/javascript">
                $(document).on("pageInit", function (e, pageId, $page) {
                    if (pageId == "MySetting") {
                        var cName = '';

                        //returnsex();

                        //$.toast("设置页面");

                    }
                    else if (pageId == "Modifysex") {

                        //document.getElementById("sex").value = '男';

                    }
             
       });
        </script>





        <script type="text/javascript">
            $("#but_Save").click(function () {
            var dDate,cNR;

        
            dDate = document.getElementById("date").value;
            cNR = document.getElementById("t_NR").value;

            if (dDate == '') {

                $.toast("请选择日期");
            }
            else if (cNR == '') {
                $.toast("请输入汇报内容");
            }

        else {
                Save();
           
        }
        
      
            function Save() {

            $(function () {
                var data = "{str1:'" + dDate + "',str2:'" + cNR + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Work.aspx/Save", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d === "保存成功") {

                            $.toast("保存成功");
                            self.location = 'A_Work.aspx';
                        } //if的尾括号
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
                return false; //禁用按钮的提交

            });

        };
    })

</script>
        <script type="text/javascript">

            function ViewList(dDate) {

                var aa = dDate;
                SetRBDate();


                function SetRBDate() {
                    $(function () {
                        var data = "{str1:'" + aa + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_WorkView.aspx/SetRBDate", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {

                            },
                            error: function (err) {
                                alert(err);
                            }
                        });
                        return false; //禁用按钮的提交

                    });

                }

            }


            function View(code,dDate,cNR,cName,date) {
                document.getElementById("T_RBCode").value = code;
                document.getElementById("RBdate").innerText = dDate;
                document.getElementById("cName").innerText = cName;
                document.getElementById("dDate").innerText = date;
                document.getElementById("T_RBNR").value = cNR;
                $.router.load("#dayView");
                //$.toast("内容");
                //ViewRB();

                function ViewRB() {

                    $(function () {
                        var data = "{str1:'" + cCode + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_WorkView.aspx/ViewRB", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                
                            },
                            error: function (err) {
                                alert(err);
                            }
                        });
                        return false; //禁用按钮的提交

                    });

                };



            }
            </script>

            
        <script type="text/javascript">
            $("#but_Save1").click(function () {
                var dDate, cNR, cCode;

                cCode = document.getElementById("T_RBCode").value;
                dDate = document.getElementById("RBdate").value;
                cNR = document.getElementById("T_RBNR").value;
                 if (dDate == '') {

                $.toast("请选择日期");
            }
            else if (cNR == '') {
                $.toast("请输入汇报内容");
            }

        else {
                
                Save1();
        }
        

      
            function Save1() {

            $(function () {
                var data = "{str1:'" + dDate + "',str2:'" + cNR + "',str3:'" + cCode + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Work.aspx/Save1", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d === "保存成功") {

                            $.toast("保存成功");
                            self.location = 'A_Work.aspx';
                        } //if的尾括号
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
                return false; //禁用按钮的提交

            });

        };
    })

</script>

        <script type="text/javascript">
            $("#but_Del").click(function () 
            {
                var cCode;
                cCode = document.getElementById("T_RBCode").value;
      $.confirm('确定删除该汇报?',
        function () {
            Del();
          //$.alert('You clicked Ok button');
        },
        function () {
          //$.alert('You clicked Cancel button');
        }
      );



      function Del() {

          $(function () {
              var data = "{str1:'" + cCode + "'}";
              $.ajax({
                  type: "Post", //要用post方式   
                  url: "A_Work.aspx/Del", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "删除成功") {

                          $.toast("删除成功");
                          self.location = 'A_Work.aspx';
                      }
                      else if (data.d === "已经删除") {
                          $.toast("已经删除");
                          self.location = 'A_Work.aspx';
                      
                      } //if的尾括号
                  },
                  error: function (err) {
                      alert(err);
                  }
              });
              return false; //禁用按钮的提交

          });

      };


  });
</script>

        </form> 
  </body>
</html>
