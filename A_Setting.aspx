<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Setting.aspx.vb" Inherits="A_Setting" %>

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
<div class="content">
  <div class="page" id='Setting'>
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">设置</h1>
       
  </header>  
      
       
      <br />
      

    <div class="list-block">
      <ul>
        <li><a href="#company">
            <div class="item-link list-button" style="text-align: left">团队管理<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span></div>
                          
            </a>
        </li>
        <li><a href="#SetPassword">
            <div class="item-link list-button" style="text-align: left">修改密码<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span></div>
                          
            </a>
        </li>
       <li><%--<a href="javascript:;" class="open-popup" data-popup=".popup-about">
            <div class="item-link list-button" style="text-align: left">关于<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span></div>
                          
            </a>--%>
           <a href="#about">
            <div class="item-link list-button" style="text-align: left">关于<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span></div>
                          
            </a>
        </li>

      </ul>
        </div>
     


  
 </div>
      </div>
 <div class="page" id='company'>

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">团队管理</h1>

  </header>  
    <div class="content">
     
     
      

<div class="content-block">

    <p class="buttons-row"><a href="#newcompany" class="button button-round">创建修改团队</a><a href="#joincompany" class="button button-round">加入已有团队</a></p>
  </div>


<%If Session("Popdom") = "1" %>
  <div class="list-block inset">
    <ul>
      <li><a href="#SH" class="item-link list-button">审核成员</a></li>

        <li><a href="A_GLCY.aspx" class="item-link list-button external">管理成员</a></li>

        <li><a href="#" class="item-link list-button" onclick="GL();">注销团队</a></li>
    </ul>
  </div>
<%else %>
  <div class="list-block inset">
    <ul>
      <li><a href="#" class="item-link list-button" id="ExitCompany">退出团队</a></li>
    </ul>
  </div>
<%end if %>
  
 </div>
      </div>

 <div class="page" id='newcompany'>
<div class="content">
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">创建修改团队</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SaveNew">
      保存
    </a>
  </header>   
      <br />
      
          
           <div class="list-block">
    <ul>
      <!-- Text inputs -->
        <li>
        <div class="item-content">
          
          <div class="item-inner">
            
            <div class="item-input">
              
              
                <input type="text" id="T_Name1" placeholder="请输入真实姓名" value ="<%= Session("name") %>"/>
            </div>
          </div>
        </div>
      </li>


      <li>
        <div class="item-content">
          
          <div class="item-inner">
            
            <div class="item-input">
              
              
                <input type="text" id="T_newcompany" placeholder="请输入团队名称" value ="<%= Session("username") %>"/>
            </div>
          </div>
        </div>
      </li>
        </ul> 
               </div> 
          <div class="content-block-title">注：为方便审核请输入真实信息!</div>


  
 </div>
      </div>


 <div class="page" id='joincompany'>

     <div class="content">
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">加入已有团队</h1>
    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SaveJoin">
      加入
    </a>
  </header>   
      <br />
      
                     <div class="list-block">
    <ul>
      <!-- Text inputs -->
        <li>
        <div class="item-content">
          
          <div class="item-inner">
            
            <div class="item-input">
              
              
                <input type="text" id="T_Name" placeholder="请输入真实姓名" value ="<%= Session("name") %>"/>
            </div>
          </div>
        </div>
      </li>
                <li>
        <div class="item-content">
          
          <div class="item-inner">
            
            <div class="item-input">
              
              
                <input type="text" id="T_joincompany1" placeholder="请输入团队名称" value ="<%= Session("username") %>"/>
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          
          <div class="item-inner">
            
            <div class="item-input">
              
              
                <input type="text" id="T_joincompany" placeholder="请输入团队ID" value ="<%= Session("usercode") %>"/>
            </div>
          </div>
        </div>
      </li>

        </ul>
        <ul>
              

        </ul> 
               </div> 
          <div class="content-block-title">注：为方便审核请输入真实信息!</div>


  
 </div>
      </div>


 <div class="page" id='SH'>
<div class="content">
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">审核成员</h1>
    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SH">
      审核
    </a>
  </header>   
      <br />
      
              <div class="list-block media-list">

            <%Dim rs As New ADODB.Recordset %>
            <%rs = cPConn.Execute("select * from [dbTZView] where cPhoneNumber='" & Session("iphone") & "' and bView='0' and cNR='申请加入' ") %>

              <%If rs.RecordCount <> 0 Then %>
                    <ul>
                <% For i = 1 To rs.RecordCount %>
              
                      <li>
                        <label class="label-checkbox item-content">
                          <input type="checkbox" name="checkbox" value ="<%= rs.Fields("cCode").Value  %>"/>
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title"><%= rs.Fields("cClassName").Value  %><%= rs.Fields("cjoinname").Value  %></div>
                              <div class="item-after" style="font-size: small"><%= format(rs.Fields("dDate").Value, "MM-dd")  %></div>
                            </div>
                            <div class="item-subtitle">申请加入团队</div>
                            
                          </div>
                        </label>
                      </li>
                       
                     <% rs.MoveNext  %>
                    <% Next %>

                    <% Else %>
                                  <br /><br />
          <h4 style="text-align: center; color: #999999">没有申请信息</h4>
                  <% End If %>
                  </ul>
                  </div>        
  
 </div>
      </div>

<div class="page" id='GLCY'>

 <header class="bar bar-nav">
    
    <h1 class="title">管理成员</h1>
        
        <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
          返回
        </a>
        
        <a class="button button-link button-nav pull-right" href="#" id="but_GLCY"  data-transition='slide-out'>
          删除
        </a>
  </header>  
 <div class="content" style="top: 20px" >
             


     <div class="list-block media-list">
        <ul>
      <!-- Text inputs -->
        <li>
        <div class="item-content">
          
          <div class="item-inner">
            
            <div class="item-input">
                    
                <input type="text" id="T_GroupName" placeholder="请输入群名称" value ="" maxlength="30" />
            </div>
          </div>
        </div>
      </li>
    </ul>


                 

             <ul><li class="list-group-title" style="font-size: 13px">全部成员</li> </ul>




            
            <%If Session("usercode")<>"" then %>
            <%rs = cPConn.Execute("select * from [dbUserView] where zDeptCode='" & Session("usercode") & "' and iPhoneNumber<>'" & Session("iphone") & "' order by cClassName ") %>

              <%If rs.RecordCount <> 0 Then %>
                    <ul>
<%--         <li>
                        <label class="label-checkbox item-content" onclick="checkall();">
                          <input type="checkbox" name="checkboxall" value ="" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title">全选</div>
                              <div class="item-after" style="font-size: small"></div>
                            </div>
                            
                            
                          </div>
                        </label>
                      </li>--%>





                <% For i = 1 To rs.RecordCount %>
              
                      <li>
                        <label class="label-checkbox item-content">
                          <input type="checkbox" name="checkbox" value ="<%= rs.Fields("cClassName").Value  %>" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title"><%= rs.Fields("cClassName").Value %></div>
                              <div class="item-after" style="font-size: small" id="b<%=i%>"><%= rs.Fields("iPhoneNumber").Value %></div>
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
                        <label class="label-checkbox item-content">
                          <input type="checkbox" name="checkbox" value ="<%= Session("iphone")  %>" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title"><%= Session("name") %></div>
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


<div class="page" id='SetPassword'>

<div class="content">
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">修改密码</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Save">
      保存
    </a>
  </header>   
      <br />
      

    <div class="list-block">

      <ul>
        <!-- Text inputs -->
        <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="Password1" runat="server" placeholder="原密码" TextMode="Password" MaxLength="16"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
                  <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="Password2" runat="server" placeholder="新密码" TextMode="Password" MaxLength="16"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
                  <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="Password3" runat="server" placeholder="确认密码" TextMode="Password" MaxLength="16"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
          </ul> 
        </div> 


  
 </div>
      </div>
        <div class="page" id='about'>

        <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">关于</h1>
       
  </header> 



    <div class="content-block">

        <br />
        <p style="text-align: center; font-size: 14px;">找对人 办对事</p>
        <p style="text-align: center">掌通办公</p>
        <p></p>
        <br /><br />
        <div style="text-align: center;">
            <img src="img/aw.jpg" style="width: 173px; height: 173px" /></div>
        <p style="text-align: center; font-size: 13px;">长按关注我们，获取更多功能!</p> 
        <br /><br />
        <p style="text-align: center; font-size: 13px;"> &copy; 2018 </p> 
    </div>
</div>




    <!-- About Popup -->
<div class="popup popup-about">
        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left close-popup" href="javascript:;" data-transition='slide-out'>
      关闭
    </a>
    <h1 class="title">关于</h1>
       
  </header> 



    <div class="content-block">

        <br />
        <p style="text-align: center; font-size: 14px;">找对人 办对事</p>
        <p style="text-align: center">掌通办公</p>
        <p></p>
        <br /><br />
        <div style="text-align: center;">
            <img src="img/aw.jpg" style="width: 150px; height: 150px" /></div>
        <p style="text-align: center; font-size: 13px;">长按关注我们</p> 
        <br /><br />
        <p style="text-align: center; font-size: 13px;"> &copy; 2018 </p> 
    </div>
</div>
        
        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
    <script type="text/javascript">
        $("#but_Save").click(function () {
            var ipassword1, ipassword2, ipassword3, ipasswordlength2, ipasswordlength3;

        
            ipassword1 = document.getElementById("Password1").value;
            ipassword2 = document.getElementById("Password2").value;
            ipassword3 = document.getElementById("Password3").value;
            ipasswordlength2 = ipassword2.length;
            ipasswordlength3 = ipassword3.length;

            if (ipassword1 == '') {
                $.toast("请输入原密码");
            }
            else if (ipassword2 == '') {
                $.toast("请输入新密码");
            }
            else if (ipassword3 == '') {
                $.toast("请输入确认密码");
            }
            else if (ipasswordlength2 < 6 || ipasswordlength3 < 6) {
                $.toast("密码必须6位以上");
            }
            else if (ipassword2 != ipassword3) {
                $.toast("两次输入的密码不一致");
            }

        else {
            modifypassword();
           
        }
        
      
            function modifypassword() {

            $(function () {
                var data = "{str1:'" + ipassword1 + "',str2:'" + ipassword2 + "',str3:'" + ipassword3 + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Setting.aspx/modifypassword", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d === "修改失败") {
                            $.toast("原密码错误");

                        } else if (data.d === "修改成功") {
                            
                            //self.location = 'A_App.aspx';
                            //window.location.href = 'A_App.aspx';
                            $.toast("修改成功");

                        }//if的尾括号
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
    $("#but_SaveNew").click(function () {
            var cnewcompany;
            var cName;
        
            cnewcompany = document.getElementById("T_newcompany").value;
            cName = document.getElementById("T_Name1").value;
            if(cName==''){
                $.toast("请输入真实姓名");
            }
            else if (cnewcompany == '') {

                $.toast("请输入团队名称");
            }
            

        else {
                newcompany();
           
        }
        
      
            function newcompany() {

            $(function () {
                var data = "{str1:'" + cnewcompany + "',str2:'" + cName + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Setting.aspx/newcompany", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d === "创建失败") {

                            $.toast("你不是创建者，不能修改");

                        } else if (data.d === "修改成功") {
                            
                            $.toast("修改成功");
                            $.router.back();
                        }
                        else if (data.d === "创建成功") {

                            $.toast("创建成功");
                            $.router.back();
                        
                        }
                        else if (data.d === "存在") {

                            $.toast("名称已存在，新重试！");


                        }//if的尾括号
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
            $("#but_SaveJoin").click(function () {
            var cjoincompany;
            var cName;
        
            cjoincompany = document.getElementById("T_joincompany").value;
            cjoincompany1 = document.getElementById("T_joincompany1").value;
            cName = document.getElementById("T_Name").value;

            var myDate = new Date();
            var wxData = {

                "template_id": "GCft9QKNdzWhb_rflC6ILiTbI84kmS7E3so-Dn_l2mM",
                "url": "http://my.aiwei.biz/aw/A_Login.aspx",

                "data": {
                    "first": {
                        "value": "申请加入通知",
                        "color": "#FF0000"
                    },
                    "keyword1": {
                        "value": "" + cName + "",
                        "color": "#173177"
                    },
                    "keyword2": {
                        "value": "" + myDate.toLocaleDateString() + " " + myDate.getHours() + ":" + myDate.getMinutes() + "",
                        "color": "#173177"
                    },
                    "remark": {
                        "value": "请您及时查阅处理！",
                        "color": "#173177"
                    }
                }
            }


            if (cName == '') {
                $.toast("请输入真实姓名");
            }
            else if (cjoincompany == '' && cjoincompany1 == '') {

                $.toast("请输入团队信息");
            }
            

            else if (cjoincompany1 != '') {

                joincompany1();
           
            }
            else if (cjoincompany != '') {

                joincompany();
            }
        






      
            function joincompany() {

            $(function () {
                var data = "{str1:'" + cjoincompany + "',str2:'" + cName + "',str3:'" + JSON.stringify(wxData) + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Setting.aspx/joincompany", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d === "已加入公司") {

                            $.toast("已加入，不能重复申请");

                        } else if (data.d === "公司ID不正确") {
                            
                            $.toast("团队ID不正确");
                        }
                        else if (data.d === "申请提交成功") {

                            $.toast("申请提交成功");
                            $.router.back();
                        }//if的尾括号
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
                return false; //禁用按钮的提交

            });

            };
            function joincompany1() {

                $(function () {
                    var data = "{str1:'" + cjoincompany1 + "',str2:'" + cName + "',str3:'" + JSON.stringify(wxData) + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Setting.aspx/joincompany1", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "已加入公司") {

                                $.toast("已加入，不能重复申请");

                            } else if (data.d === "公司ID不正确") {

                                $.toast("团队名称不正确");
                            }
                            else if (data.d === "申请提交成功") {

                                $.toast("申请提交成功");
                                $.router.back();
                            }//if的尾括号
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
            $("#but_SH").click(function () {
            var cCode; 
            var checkbox = document.getElementsByName("checkbox");

            var checked_counts = 0;


            var myDate = new Date();
            var wxData = {

                "template_id": "GLLYXzb9F_fTGaLrB4xxPpsbVuAXY8uUlYUkRLG4M6I",
                "url": "http://my.aiwei.biz/aw/A_Login.aspx",

                "data": {
                    "first": {
                        "value": "您好，您提交的实名加入已经完成！",
                        "color": "#FF0000"
                    },
                    "keyword1": {
                        "value": "实名申请加入",
                        "color": "#173177"
                    },
                    "keyword2": {
                        "value": "审核通过！",
                        "color": "#173177"
                    },
                    "keyword3": {
                        "value": "" + myDate.toLocaleDateString() + " " + myDate.getHours() + ":" + myDate.getMinutes() + "",
                        "color": "#173177"
                    },
                    "remark": {
                        "value": "感谢您的使用!",
                        "color": "#173177"
                    }
                }
            }



            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {     //被选中的checkbox
                    checked_counts++;
                    cCode = checkbox[i].value;
                    SH();
                    $.router.load('A_Setting.aspx')
                }
                if (checked_counts>0) {

                    $.toast("审核通过" + checked_counts + "条");
                    //self.location = 'A_Setting.aspx';
                }
                else{
                    $.toast("请选择");
                }              
                
            }

      
            function SH() {

            $(function () {
                var data = "{str1:'" + cCode + "',str2:'" + JSON.stringify(wxData) + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Setting.aspx/SH", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d === "更新成功") {

                            //$.toast("");

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
            $("#ExitCompany").click(function () {
                var cCode;
                cCode = document.getElementById("T_joincompany").value;
                $.confirm('确定退出?',
                  function () {
                      exitcompany();
                      
                  },
                  function () {
                     
                  }
                );
            
      
            function exitcompany() {

            $(function () {
                var data = "{str1:'" + cCode + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Setting.aspx/exitcompany", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            $.toast(data.d);
                            self.location = 'A_Setting.aspx';
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
            $("#but_GLCY").click(function () {
                var cCode='';
                var cName='';
                var bSelect = false;
                var checkbox = document.getElementsByName("checkbox");

                if (document.getElementById("T_GroupName").value == '') {

                    $.toast("请输入群名称");

                }

                else {


                    for (var i = 0; i < checkbox.length; i++) {
                        if (checkbox[i].checked === true) {
                            bSelect = true;
                            break;
                        }
                    }



                    if (bSelect == false) {
                        $.toast("请选择成员");
                    }
                    else {



                        for (var iii = 0; iii < checkbox.length; iii++) {
                            if (checkbox[iii].checked === true) {
                                cCode = cCode + checkbox[iii].value + ';';
                                cName = cName + document.getElementById('b' + (iii + 1)).innerText + ';';


                            }
                        }
                        //SaveGroup();
                        alert(cCode + cName);
                        //执行保存

                    }
                }







                function DelCY() {
                //var GroupName = document.getElementById("T_GroupName").value
                    var GroupName = '';
                $(function () {
                    var data = "{str1:'" + GroupName + "',str2:'" + cName + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Setting.aspx/DelCY", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "成功") {
                                //returnPL();
                                $.toast("删除成功");
                                self.location = 'A_Setting.aspx';
                                //$.router.load('A_Notice.aspx', true)

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
            function GL () {
                $.toast("暂无权限");
    }

</script>

<%--        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>--%>






</div> 
        


        </form> 
  </body>
</html>
