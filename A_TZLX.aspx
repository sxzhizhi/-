<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_TZLX.aspx.vb" Inherits="A_TZLX" %>

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

    

    <div class="page" id='TZLX'>
      
        <header class="bar bar-nav">
       <a class="button button-link button-nav pull-left external" href="A_Notice.aspx" data-transition='slide-out'>
          返回
        </a>
    <h1 class="title">编辑通知类型</h1>
        <a class="button button-link button-nav pull-right" href="#NewTZLX" data-transition='slide-out' id="A2" runat="server">
          新建
        </a>
  </header>  
<div class="content"  style="top: 20px" >
    
    <div class="list-block contacts-block">
    <div class="list-group">
      <ul id="TZLX1">
        <li class="list-group-title">通知类型列表</li>

            <% Dim rs As New ADODB.Recordset %>
          <%If Session("usercode") <> "" Then %>
            <%rs = cPConn.Execute("select * from [DicTZLX] where zDeptCode='" & Session("usercode") & "' order by cTZLXCode") %>

              <%If rs.RecordCount <> 0 Then %>
                   
                <% For i = 1 To rs.RecordCount %>

        <li><a href ="#ViewTZLX" onclick="View('<%=rs.Fields("cTZLXCode").Value%>','<%=rs.Fields("cTZLXName").Value%>');" >
          <div class="item-content">
            <div class="item-inner">
                      
              <div class="item-title"><%= rs.Fields("cTZLXName").Value  %><div style="font-size: 14px; color: #999999"></div></div>
            
            </div>
          </div>
            </a>
        </li>
                  <% rs.MoveNext  %>
                    <% Next %>
                  <% End If %>
          <%Else%>
          <li>

          <div class="item-content">
            <div class="item-inner">
              <div class="item-title">请先创建或加入公司<div style="font-size: 14px; color: #999999"></div></div>
            </div>
          </div>
        </li>



          <%End If  %>




          </ul> 
        </div> 
   
                </div>


          </div>
</div>
    
    <div class="page" id='NewTZLX'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">新建通知类型</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-no-cache="true" data-transition='slide-out' id="but_SaveTZLX">保存
                    </a>
                </header>

                <div class="content">

                    <div class="list-block">
                        <ul>
                            <!-- Text inputs -->
                            <li>
                                <div class="item-content">

                                    <div class="item-inner">

                                        <div class="item-input">


                                            <input type="text" id="T_TZLXName" placeholder="请输入通知类型" value="" />
                       
                                        </div>
                                    </div>
                                </div>
                            </li>



                        </ul>
                    </div>
                    <div class="content-block-title"></div>



                </div>
            </div>

        <div class="page" id='ViewTZLX'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">修改通知类型</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-no-cache="true" data-transition='slide-out' id="but_SaveTZLX1">保存
                    </a>
         <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Del" runat="server">
      删除
    </a>
                </header>

                <div class="content">

                    <div class="list-block">
                        <ul>
                            <!-- Text inputs -->
                           <li style="display:none">
                                <div class="item-content">

                                    <div class="item-inner">

                                        <div class="item-input" >


                                            <input type="text" id="T_TZLXCode" placeholder="" value="" />
                       
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="item-content">

                                    <div class="item-inner">

                                        <div class="item-input">


                                            <input type="text" id="T_TZLXName1" placeholder="请输入通知类型" value="" />
                       
                                        </div>
                                    </div>
                                </div>
                            </li>



                        </ul>
                    </div>
                    <div class="content-block-title"></div>



                </div>
            </div>

</div> 
        
    


        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
<%--        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>--%>

        <script type="text/javascript">
                $(document).on("pageInit", function (e, pageId, $page) {
                    if (pageId == "NewTZLX") {
                        document.getElementById("T_TZLXName").value = '';


                        //$.toast("设置页面");
                    
                    }
                    




       });
        </script>
        <script type="text/javascript">
            function View(code, name) {
                document.getElementById("T_TZLXCode").value = code;
                document.getElementById("T_TZLXName1").value = name;

                //$.toast("内容");
                //ViewRB();

            }
            </script>




        <script type="text/javascript">
            $("#but_SaveTZLX").click(function () {
                var cTZLXName;

                cTZLXName = document.getElementById("T_TZLXName").value;

                if (cTZLXName == '') {
                    $.toast("不能为空，请输入通知类型");
                }
                else {
                    saveTZLX();

                }


                function saveTZLX() {

                    $(function () {
                        var data = "{str1:'" + cTZLXName + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_TZLX.aspx/saveTZLX", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    //document.getElementById("T_SetName").innerText = cName;

                                    $.toast("保存成功");
                                    //$.router.back();
                                    //$.router.load("#TZLX",true);
                                    self.location = 'A_TZLX.aspx';
                                } //if的尾括号
                                else if (data.d === "已存在") {
                                    $.toast("通知类型已存在，请重新录入");
                                }
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
            $("#but_SaveTZLX1").click(function () {
                var cTZLXName;
                var cTZLXCode;
                cTZLXName = document.getElementById("T_TZLXName1").value;
                cTZLXCode = document.getElementById("T_TZLXCode").value;
                if (cTZLXName == '') {
                    $.toast("不能为空，请输入通知类型");
                }
                else {
                    saveTZLX1();

                }


                function saveTZLX1() {

                    $(function () {
                        var data = "{str1:'" + cTZLXCode + "',str2:'" + cTZLXName + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_TZLX.aspx/saveTZLX1", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    //document.getElementById("T_SetName").innerText = cName;




                                    $.toast("保存成功");
                                    //$.router.back();
                                    //$.router.load("#TZLX",true);
                                    self.location = 'A_TZLX.aspx';
                                } //if的尾括号

                                else if (data.d === "已存在") {
                                    $.toast("通知类型已存在，请重新录入");
                                }



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
                cCode = document.getElementById("T_TZLXCode").value;
      $.confirm('确定删除该通知类型吗?',
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
                  url: "A_TZLX.aspx/Del", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "删除成功") {

                          $.toast("删除成功");
                          self.location = 'A_TZLX.aspx';
                      }
                      else if (data.d === "已经删除") {
                          $.toast("已经删除");
                          self.location = 'A_TZLX.aspx';
                          //self.location = 'A_Addr.aspx';
                      
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
