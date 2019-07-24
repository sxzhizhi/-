<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Power.aspx.vb" Inherits="A_Power" %>

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

  <div class="page" id='Power'>
    
      
      <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left external" href="A_Work.aspx" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">查看工作汇报权限</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Save" runat="server">
      
    </a>
  </header>   
      
      <div class="content"  style="top: 20px">
          <%Dim rs As New ADODB.Recordset %>
        <%If Session("usercode") <> "" Then %>
          <div class="content-block-title">设置每个人的查看范围</div>
          <div class="list-block">
               
                      <%rs = cPConn.Execute("select * from [dbuserView] where zDeptCode='" & Session("usercode") & "' order by cClassName") %>
                        <ul>
                        <%If rs.RecordCount <> 0 Then %>
                   
                            <% For i = 1 To rs.RecordCount %>
                                
                            




                               <li>
                                   <a href="#PowerName" onclick="view('<%= rs.Fields("iPhoneNumber").Value  %>');">
                                <div class="item-link list-button" style="text-align: left">
                                    <%= rs.Fields("cClassName").Value  %><span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                    <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"></div>
                                </div>

                                </a>
                            </li>


                            
                        <% rs.MoveNext  %>
                    <% Next %>
                  <% End If %>



                 </ul>
          </div>
              

                 <%Else%>


                 <%End If  %>

  </div>
 </div>


        <div class="page" id='PowerName'>

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">修改查看权限</h1>
    <a class="button button-link button-nav pull-right" data-transition='slide-out' id="" onclick="check();">
      确定
    </a>
  </header>   
      
      <div class="content"  style="top: 20px">
               <div class="item-input" style="display:none">
                  <asp:TextBox ID="T_Phone" runat="server"></asp:TextBox>
              </div>

              <div class="list-block media-list">
                  <ul>
                             <li>
                                 <a href ="#" onclick="SaveAll();">
                                <div class="item-link list-button" style="text-align: left">
                                    全部成员<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                    <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"></div>
                                </div>
                                 </a>

                            </li>
                             <li>
                                 <a href ="#" onclick="DelAll();">
                                <div class="item-link list-button" style="text-align: left">
                                    取消全部成员<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                    <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"></div>
                                </div>
                                 </a>

                            </li>



                     <li  style="display:none">
                        <label class="label-checkbox item-content">
                          <input type="checkbox" name="checkboxall" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title">全部成员</div>
                              <div class="item-after" style="font-size: small"></div>
                            </div>
                            
                            
                          </div>
                        </label>
                      </li>
                      
                  </ul>

                  <ul><li class="list-group-title" style="font-size: 13px">部门</li> </ul>
            <%rs = cPConn.Execute("select * from [DicUnit] where zDeptCode='" & Session("usercode") & "' order by cUnitCode ") %>

              <%If rs.RecordCount <> 0 Then %>
                   
                  <ul>
                <% For i = 1 To rs.RecordCount %>



                     <li>
                        <label class="label-checkbox item-content"  onclick="clearcheckall();" >
                          <input type="checkbox" name="checkboxunit" value ="<%= rs.Fields("cUnitCode").Value %>" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title"><%= rs.Fields("cUnitName").Value %></div>
                              <div class="item-after" style="font-size: small" id="b<%=i%>"></div>
                            </div>
                            
                            
                          </div>
                        </label>
                      </li>

                     <% rs.MoveNext  %>
                    <% Next %>
                  <% End If %>


                  </ul>
                  <ul><li class="list-group-title" style="font-size: 13px">联系人</li> </ul> 
            <%If Session("usercode")<>"" then %>
            <%rs = cPConn.Execute("select * from [dbUserView] where zDeptCode='" & Session("usercode") & "' and cDeptJob='' order by cClassName ") %>

              <%If rs.RecordCount <> 0 Then %>
                    <ul>
                <% For i = 1 To rs.RecordCount %>
              
                      <li>
                        <label class="label-checkbox item-content"  onclick="clearcheckall();">
                          <input type="checkbox" name="checkboxuser" value ="<%= rs.Fields("iPhoneNumber").Value  %>" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title"><%= rs.Fields("cClassName").Value %></div>
                              <div class="item-after" style="font-size: small" id="a<%=i%>"><%= rs.Fields("iPhoneNumber").Value %></div>
                            </div>
                            
                            
                          </div>
                        </label>
                      </li>
                       
                     <% rs.MoveNext  %>
                    <% Next %>
                  <% End If %>
                  </ul>

                  <%Else %>
                  <ul>
               
              
                      <li>
                        <label class="label-checkbox item-content" onclick="checklist();">
                          <input type="checkbox" name="checkbox" value ="<%= Session("iphone")  %>" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title"><%= Session("iphone") %></div>
                              <div class="item-after" style="font-size: small" id="a1"><%= Session("iphone") %></div>
                            </div>
                            
                            
                          </div>
                        </label>
                      </li>
                       
                    
                  </ul>
                  <%end if %>
                  </div>        
  
 </div>
      </div>








      </div>
 
            
        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
<%--        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>--%>

        <script type="text/javascript">
            $(document).on("pageInit", function (e, pageId, $page) {
                if (pageId == "PowerName") {
                    
                    var checkboxall = document.getElementsByName("checkboxall");
                    checkboxall[0].checked = false;
                    

                    //returnuser();


                }


                function returnuser() {

                    $(function () {
                        var data = "{str1:'" + cCode + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Notice.aspx/returnuser", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "失败") {
                                    document.getElementById("T_cJoinName1").innerText = '通知：' + data.d;
                                    //$.toast("保存成功");
                                    //$.MySetting.back();
                                    //self.location = 'A_MYSetting.aspx';
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
                    function check() {
                        var checkboxall = document.getElementsByName("checkboxall");
                        var checkboxunit = document.getElementsByName("checkboxunit");
                        var checkboxuser = document.getElementsByName("checkboxuser");

                        if (checkboxall[0].checked === true) {
                            var cAllName = document.getElementById("T_Phone").value;
                            SaveAll();
                            $.router.back();
                        }
                        else {
                            for (var i = 0; i < checkboxunit.length; i++) {

                                if (checkboxunit[i].checked == true) {

                                    SaveUnit(checkboxunit[i].value);

                                }
                            }
                            for (var i = 0; i < checkboxuser.length; i++) {

                                if (checkboxuser[i].checked == true) {

                                    SaveUser(checkboxuser[i].value);

                                }
                            }


                            //$.router.back();
                            $.toast("修改成功");
                            $.router.load("#Power");

                        }




                        //$.router.back();
                        //$.toast("成功");
                    };
                        

            function SaveAll() {

                $(function () {
                    var cAllName = document.getElementById("T_Phone").value;
                    var data = "{str1:'" + cAllName + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Power.aspx/SaveAll", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "保存成功") {
                                $.toast("修改成功");

                                $.router.back();
                                
                                //
                                //self.location = 'A_Notice.aspx';
                                //$.router.load('A_Notice.aspx', true)
                                //$.router.load("#NoticeList",true);
                            } //if的尾括号
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                    return false; //禁用按钮的提交

                });

            };
            function DelAll() {

                $(function () {
                    var cAllName = document.getElementById("T_Phone").value;
                    var data = "{str1:'" + cAllName + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Power.aspx/DelAll", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "保存成功") {
                                $.toast("修改成功");
                                $.router.back();

                                //$.toast("发布成功");
                                //self.location = 'A_Notice.aspx';
                                //$.router.load('A_Notice.aspx', true)
                                //$.router.load("#NoticeList",true);
                            } //if的尾括号
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                    return false; //禁用按钮的提交

                });

            };
            function SaveUnit(cUnit) {

                $(function () {
                    var cAllName = document.getElementById("T_Phone").value;
                    var data = "{str1:'" + cAllName + "',str2:'" + cUnit + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Power.aspx/SaveUnit", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "保存成功") {
                                //$.router.back();

                                //$.toast("发布成功");
                                //self.location = 'A_Notice.aspx';
                                //$.router.load('A_Notice.aspx', true)
                                //$.router.load("#NoticeList",true);
                            } //if的尾括号
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                    return false; //禁用按钮的提交

                });

            };

            function SaveUser(cUser) {

                $(function () {
                    var cAllName = document.getElementById("T_Phone").value;
                    var data = "{str1:'" + cAllName + "',str2:'" + cUser + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Power.aspx/SaveUser", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "保存成功") {
                                //$.router.back();

                                //$.toast("发布成功");
                                //self.location = 'A_Notice.aspx';
                                //$.router.load('A_Notice.aspx', true)
                                //$.router.load("#NoticeList",true);
                            } //if的尾括号
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                    return false; //禁用按钮的提交

                });

            };

            function clearcheckall() {
                var checkboxall = document.getElementsByName("checkboxall");
                checkboxall[0].checked = false;
            }


                                    </script>

        <script type="text/javascript">

            function view(cPhone) {

                
                document.getElementById("T_Phone").value = cPhone;


                

            }


           
            </script>




        </form> 
  </body>
</html>
