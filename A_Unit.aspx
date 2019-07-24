<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Unit.aspx.vb" Inherits="A_Unit" %>

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

    

    <div class="page" id='Unit'>
      
        <header class="bar bar-nav">
       <a class="button button-link button-nav pull-left external" href="A_Addr.aspx" data-transition='slide-out'>
          返回
        </a>
    <h1 class="title">编辑部门</h1>
        <a class="button button-link button-nav pull-right" href="#NewUnit" data-transition='slide-out' id="A2" runat="server">
          新建
        </a>
  </header>  
<div class="content"  style="top: 20px" >
    
    <div class="list-block contacts-block">
    <div class="list-group">
      <ul id="unit">
        <li class="list-group-title">部门列表</li>

            <% Dim rs As New ADODB.Recordset %>
          <%If Session("usercode") <> "" Then %>
            <%rs = cPConn.Execute("select * from [DicUnit] where zDeptCode='" & Session("usercode") & "' order by cUnitCode") %>

              <%If rs.RecordCount <> 0 Then %>
                   
                <% For i = 1 To rs.RecordCount %>

        <li><a href ="#ViewUnit" onclick="View('<%=rs.Fields("cUnitCode").Value%>','<%=rs.Fields("cUnitName").Value%>');" >
          <div class="item-content">
            <div class="item-inner">
                      
              <div class="item-title"><%= rs.Fields("cUnitName").Value  %><div style="font-size: 14px; color: #999999"></div></div>
            
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
    
    <div class="page" id='NewUnit'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">新建部门</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-no-cache="true" data-transition='slide-out' id="but_SaveUnit">保存
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


                                            <input type="text" id="T_UnitName" placeholder="请输入部门" value="" />
                       
                                        </div>
                                    </div>
                                </div>
                            </li>



                        </ul>
                    </div>
                    <div class="content-block-title"></div>



                </div>
            </div>

        <div class="page" id='ViewUnit'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">修改部门</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-no-cache="true" data-transition='slide-out' id="but_SaveUnit1">保存
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


                                            <input type="text" id="T_UnitCode" placeholder="" value="" />
                       
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="item-content">

                                    <div class="item-inner">

                                        <div class="item-input">


                                            <input type="text" id="T_UnitName1" placeholder="请输入部门" value="" />
                       
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
                    if (pageId == "NewUnit") {
                        document.getElementById("T_UnitName").value = '';


                        //$.toast("设置页面");
                    
                    }
                    




       });
        </script>
        <script type="text/javascript">
            function View(code, name) {
                document.getElementById("T_UnitCode").value = code;
                document.getElementById("T_UnitName1").value = name;

                //$.toast("内容");
                //ViewRB();

            }
            </script>




        <script type="text/javascript">
            $("#but_SaveUnit").click(function () {
                var cUnitName;

                cUnitName = document.getElementById("T_UnitName").value;

                if (cUnitName == '') {
                    $.toast("不能为空，请输入部门名称");
                }
                else {
                    saveunit();

                }


                function saveunit() {

                    $(function () {
                        var data = "{str1:'" + cUnitName + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Unit.aspx/saveunit", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    //document.getElementById("T_SetName").innerText = cName;

                                    $.toast("保存成功");
                                    //$.router.back();
                                    //$.router.load("#Unit",true);
                                    self.location = 'A_Unit.aspx';
                                } //if的尾括号
                                else if (data.d === "已存在") {
                                    $.toast("部门名称已存在，请重新录入");
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
            $("#but_SaveUnit1").click(function () {
                var cUnitName;
                var cUnitCode;
                cUnitName = document.getElementById("T_UnitName1").value;
                cUnitCode = document.getElementById("T_UnitCode").value;
                if (cUnitName == '') {
                    $.toast("不能为空，请输入部门名称");
                }
                else {
                    saveunit1();

                }


                function saveunit1() {

                    $(function () {
                        var data = "{str1:'" + cUnitCode + "',str2:'" + cUnitName + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Unit.aspx/saveunit1", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    //document.getElementById("T_SetName").innerText = cName;




                                    $.toast("保存成功");
                                    //$.router.back();
                                    //$.router.load("#Unit",true);
                                    self.location = 'A_Unit.aspx';
                                } //if的尾括号

                                else if (data.d === "已存在") {
                                    $.toast("部门名称已存在，请重新录入");
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
                cCode = document.getElementById("T_UnitCode").value;
      $.confirm('确定删除该部门吗?',
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
                  url: "A_Unit.aspx/Del", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "删除成功") {

                          $.toast("删除成功");
                          self.location = 'A_Unit.aspx';
                      }
                      else if (data.d === "已经删除") {
                          $.toast("已经删除");
                          self.location = 'A_Unit.aspx';
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
