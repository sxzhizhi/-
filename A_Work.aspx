<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Work.aspx.vb" Inherits="A_Work" %>

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

  
    <%--我的日工作汇报列表--%>
    <div class="page" id='work'>
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">工作汇报</h1>
        <a class="button button-link button-nav pull-right" href="#WorkList" data-transition='slide-out' id="A1" runat="server">
      查看
    </a>
        <a class="button button-link button-nav pull-right external" href="A_WorkExport.aspx" data-transition='slide-out' id="A3" runat="server">
      导出
    </a>
      <%If Session("Popdom") = "1" %>
     <a class="button button-link button-nav pull-right external" href="A_Power.aspx" data-transition='slide-out' id="A2" runat="server">
      权限
    </a>

        <% End if %>
  </header>
          
<div class="content"> 
    <div style="padding-right: 13px; padding-left: 13px;">
        <%If Session("usercode") <> "" %>
        <p><a href="#day" class="button button-fill" style="color: #FFFFFF; background-color: #4CD964;"><i class="fa fa-edit"></i> 写汇报</a></p> 
         
        <% End if %>
        </div>
       <%Dim rs As New ADODB.Recordset %>
            <%rs = cPConn.Execute("select * from [RBView] where iPhoneNumber='" & Session("iphone") & "' order by dRBDate desc") %>

              <%If rs.RecordCount <> 0 Then %>
                    
                <% For i = 1 To rs.RecordCount %>
    
      <div class="card">
      <div style="background-color :aliceblue;font-size:14px;" valign="bottom" class="card-header color-white no-border"><%=Session("name") %><div class="color-gray" style="font-size: x-small">发表于: <%= Format(rs.Fields("dRBDate").Value, "yyyy-MM-dd HH:mm")%></div>
</div>
      <a href ="#dayView" onclick="View('<%=rs.Fields("cCode").Value%>','<%=Format(rs.Fields("dDate").Value, "yyyy-MM-dd")%>','<%=rs.Fields("cNR").Value  %>');" >
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

             <%else %>
          <br /><br />
          <h4 style="text-align: center; color: #999999">没有工作汇报</h4>
                  <% End If %>


   
    </div>            
</div>
    
    <%--新建日工作汇报--%>
    <div class="page" id='day'>
<div class="content">
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">日报</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Save" runat="server">
      保存
    </a>
  </header>   
    <br />
  <div class="list-block">

        <ul>
          <!-- Text inputs -->
          <li style="display:none">
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_code" runat="server" placeholder="系统编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>


          <li>
            <div class="item-content">
              <div class="item-inner">
                <div class="item-title label">日期</div>
                <div class="item-input">
                  <input type="text" placeholder="选择日期" id='date' data-toggle='date' value ="<%=Format(Now(), "yyyy-MM-dd") %>"/>
                </div>
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
                  <asp:TextBox ID="t_NR" runat="server" placeholder="输入日报内容" TextMode="MultiLine" Height="230px" MaxLength="150"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
    </ul>
  </div>

</div>
      </div>
    
    <%--工作汇报详情--%>
    <div class="page" id='dayView'>
     <div class="content">
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">工作汇报详情</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Save1" runat="server">
      保存
    </a>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Del" runat="server">
      删除
    </a>
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
                <div class="item-title label">日期</div>
                <div class="item-input">
                  <input type="text" placeholder="选择日期" id='RBdate'  data-toggle='date'  runat="server"/>
                    
                </div>
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
                  <asp:TextBox ID="T_RBNR" runat="server" placeholder="输入日报内容" TextMode="MultiLine" Height="230px" MaxLength="150"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
    </ul>
  </div>

</div>
      
        </div>
    
    <%--可以查看的工作汇报列表--%>
    <div class="page" id='WorkList'>


    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left" href="#work" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">可以查看的工作汇报</h1>
        
  </header>
          
    
<div class="content"  style="top: 20px"> 
            
            <%rs = cPConn.Execute("select dDate,count(iPhoneNumber) as number from [PowerView] where zDeptCode='" & Session("usercode") & "' and iphone='" & Session("iphone") & "' group by dDate order by dDate desc") %>

              <%If rs.RecordCount <> 0 Then %>
  <div class="list-block">

      <ul>                   
                <% For i = 1 To rs.RecordCount %>
    
       
          <li><a href="A_WorkView.aspx" onclick ="ViewList('<%=Format(rs.Fields("dDate").Value, "yyyy-MM-dd")%>');" class="external">
            <div class="item-link list-button" style="text-align: left" >日报（<%=Format(rs.Fields("dDate").Value, "MM月dd日") & " " & Format$(rs.Fields("dDate").Value, "ddd")%>）<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"><%=rs.Fields("number").Value%>份</div></div>
                         </a>  
            
        </li>


          

                     <% rs.MoveNext  %>
                    <% Next %>

           <% else %>
          <br /><br />
          <h4 style="text-align: center; color: #999999">没有工作汇报</h4>

                  <% End If %>

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
            function View(code,dDate,cNR) {
                document.getElementById("T_RBCode").value = code;
                document.getElementById("RBdate").value = dDate;
                document.getElementById("T_RBNR").value = cNR;
                //$.toast("内容");
                //ViewRB();

                function ViewRB() {

                    $(function () {
                        var data = "{str1:'" + cCode + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Work.aspx/ViewRB", //方法所在页面和方法名
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
        <script type="text/javascript">

            function ViewList(dDate) {

                var aa = dDate;
                SetRBDate();
                //$.router.load('A_WorkView.aspx')

                function SetRBDate() {
                    $(function () {
                        var data = "{str1:'" + aa + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Work.aspx/SetRBDate", //方法所在页面和方法名
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


           
            </script>
        </form> 
  </body>
</html>
