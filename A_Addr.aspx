<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Addr.aspx.vb" Inherits="A_Addr" %>

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

    <div class="page" id='Addr'>

      <nav class="bar bar-tab">

    <a class="tab-item external" href="A_App.aspx">
    <span class="icon icon-app"></span>
    <span class="tab-label">应用</span>
                         <%If Session("AppNumber") <> 0 Then %>
                        <span class="badge"><%=Session("AppNumber") %></span>
                        <% End if %>
  </a>
     <a class="tab-item external" href="A_Iofo.aspx">
    <span class="icon icon-message"></span>
    <span class="tab-label">消息</span>
    <%If Session("IofoNumber") <> 0 Then %>
    <span class="badge"><%=Session("IofoNumber") %></span>
    <% End if %>
  </a>

 
      <a class="tab-item external active" href="A_Addr.aspx">
  
    <span class="icon icon-card"></span>
    <span class="tab-label">通讯录</span>
    <%If Session("AddrNumber") <> 0 Then %>
    <span class="badge"><%=Session("AddrNumber") %></span>
    <% End if %>
  </a>


      <a class="tab-item external" href="A_MySetting.aspx#MySetting">

    <span class="icon icon-me"></span>
    <span class="tab-label">我</span>
  </a>
</nav>
 
        <header class="bar bar-nav">
                <a class="button button-link button-nav pull-left" href="#joinfriend" data-transition='slide-out'>
          加友
        </a>
    <h1 class="title">通讯录</h1>
        <%If Session("Popdom") = "1"Then %>
        <a class="button button-link button-nav pull-right external" href="A_Unit.aspx" data-transition='slide-out' runat="server">
          部门
        </a>
        <% End if %>
        <a class="button button-link button-nav pull-right external" href="A_Group.aspx" data-transition='slide-out' runat="server">
          建群
        </a>
  </header>  
    
        <div class="content" style="top: 20px" >



     <div class="list-block media-list">
    <ul><a href="#Group" class="item-link">
      <li>
        <div class="item-content">
          <div class="item-media"></div>
            <div class="item-media"><img src="img/img/13.png" style='width: 2.2rem;'></div>
          <div class="item-inner">
            <div class="item-title-row">
              <div class="item-title">组群</div>
            </div>
            <div class="item-subtitle" style="color: #999999; font-size: 13px;">自定义群，向群成员发通知。</div>
          </div>
                
        </div>
      </li></a>
        </ul>

    <div class="list-group">
      <ul>
        <li class="list-group-title" >通讯录</li>

            <%Dim rs As New ADODB.Recordset %>
          <%If Session("usercode")<>"" then %>
            <%rs = cPConn.Execute("select * from [dbuserView] where zDeptCode='" & Session("usercode") & "' order by cClassName") %>

              <%If rs.RecordCount <> 0 Then %>
                   
                <% For i = 1 To rs.RecordCount %>

        <li>
          <div class="item-content">
              <div class="item-media"></div>
            <div class="item-media" style="width:2.1rem; height:2.1rem; border-radius:50%; overflow:hidden;"><img src="<%= rs.Fields("wxheadimgurl").Value  %>" style='width: 2.2rem;'></div>
            <div class="item-inner">
              <div class="item-title">
                  <%If rs.Fields("cadmin").Value = "1" %>
                  <%= rs.Fields("cClassName").Value & "(管理员)"  %>
                  <%Else %>
                  <%= rs.Fields("cClassName").Value  %>
                  <%End if %>
                  <div style="font-size: 14px; color: #999999"><%=rs.Fields("iPhoneNumber").Value %></div>
              </div>
            </div>
          </div>
        </li>
                  <% rs.MoveNext  %>
                    <% Next %>
                  <% End If %>
          <%Else%>
          <li>

          <div class="item-content">
            <div class="item-media"></div>
            <div class="item-media" style="width:2.1rem; height:2.1rem; border-radius:50%; overflow:hidden;"><img src="<%= Session("url")  %>" style='width: 2.2rem;'></div>

            <div class="item-inner">
              <div class="item-title"><%=Session("name") %><div style="font-size: 14px; color: #999999"><%=Session("iphone") %></div></div>
            </div>
          </div>
        </li>



          <%End If  %>



   
            <%rs = cPConn.Execute("select * from [dbfriendview] where cPhoneNumber='" & Session("iphone") & "' order by cClassName") %>

              <%If rs.RecordCount <> 0 Then %>
                   
                  <li class="list-group-title" >好友</li>

           
                    <li>


                <% For i = 1 To rs.RecordCount %>

        
          <div class="item-content">
              <div class="item-media"></div>
            <div class="item-media" style="width:2.1rem; height:2.1rem; border-radius:50%; overflow:hidden;"><img src="<%= rs.Fields("wxheadimgurl").Value  %>" style='width: 2.2rem;'></div>
            <div class="item-inner">
              <div class="item-title">

                  <%= rs.Fields("cClassName").Value  %>
                  
                  <div style="font-size: 14px; color: #999999"><%=rs.Fields("iPhoneNumber").Value %></div>
              </div>
            </div>
          </div>
        
                  <% rs.MoveNext  %>
                    <% Next %>



                    </li>
                  <% End If %>




          </ul> 



        </div> 
    
    
    </div>


          </div>
</div>


    <div class="page" id='Group'>

 
        <header class="bar bar-nav">
    
    <h1 class="title">群列表</h1>
        
        <a class="button button-link button-nav pull-left back" href="#Addr" data-transition='slide-out'>
        返回
        </a>
        
        <a class="button button-link button-nav pull-right external" href="A_Group.aspx" data-transition='slide-out' runat="server">
          建群
        </a>
  </header>  
    

 <div class="content" style="top: 20px" >



     <div class="list-block media-list">
    

    <div class="list-group">
      
        <li class="list-group-title">群列表</li>

            
          
            <%rs = cPConn.Execute("select * from [dbGroupView] where zDeptCode='" & Session("usercode") & "' and cPhoneNumber='" & Session("iphone") & "' order by cClassName") %>

              <%If rs.RecordCount <> 0 Then %>
                   
                <% For i = 1 To rs.RecordCount %>

        <ul>
       <a href="#GroupView" class="item-link" onclick="GroupView('<%= rs.Fields("cCode").Value  %>')">
      <li>
        <div class="item-content">
          <div class="item-media"></div>
            
          <div class="item-inner">
            <div class="item-title-row">
              <div class="item-title"><%=rs.Fields("cGroupName").Value %></div>
            </div>
            <div class="item-subtitle" style="color: #999999; font-size: 13px;"></div>
          </div>
                
        </div>
      </li></a>
        </ul>

                  <% rs.MoveNext  %>
                    <% Next %>

        <%else %>
        <h4 style="text-align: center; color: #999999">没有群</h4>

                  <% End If %>
       </div> 
    
    
    </div>


          </div>
</div>

    <div class="page" id='GroupView'>

        <header class="bar bar-nav">
    
    <h1 class="title">群成员列表</h1>
        
        <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out' runat="server">
          返回
        </a>
        
        <a class="button button-link button-nav pull-right" href="#" onclick="DelList();" data-transition='slide-out' runat="server">
          解散群
        </a>
  </header>  
    

 <div class="content" style="top: 20px" >



     <div class="list-block media-list">

               <!-- Text inputs -->
        
        <div class="item-content" style="display:none">
          
          <div class="item-inner">
            
            <div class="item-input">
              
              
                <input type="text" id="T_GroupCode" placeholder="" value =""/>
            </div>
          </div>
        </div>
      


  
    <div class="list-group">
      <ul>
        <li class="list-group-title">群成员列表</li>
</ul>
        <div id="ListName">

     

            </div>
        </div> 
    
    
    </div>


          </div>
</div>

        <div class="page" id='joinfriend'>

     <div class="content">
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">添加朋友</h1>
    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SaveJoin">
      发送
    </a>
  </header>   
      <br />
      
    <div class="list-block">
        <div class="content-block-title">添加朋友</div>
    <ul>
      <!-- Text inputs -->
        <li>
        <div class="item-content">
          
          <div class="item-inner">
            
            <div class="item-input">
              
              
                <input type="text" id="T_Name" placeholder="用户名/手机号" value =""/>
            </div>
          </div>
        </div>
      </li>
                <li>
        <div class="item-content" style="display :none">
          
          <div class="item-inner">
            
            <div class="item-input">
              
              
                <input type="text" id="T_MyName" placeholder="" value ="<%=Session("name") %>"/>
            </div>
          </div>
        </div>
      </li>

        </ul>

               </div> 
          
            <%rs = cPConn.Execute("select * from [dbTZView] where cPhoneNumber='" & Session("iphone") & "' and bView='0' and cBT='请求加你为好友' ") %>


              <%If rs.RecordCount <> 0 Then %>

      <div class="list-block media-list">

            <div class="content-block-title">新的朋友</div>

                    <ul>
                <% For i = 1 To rs.RecordCount %>
              
                      <li>
                        <label class="label-checkbox item-content">
                          <input type="checkbox" name="checkbox" value ="<%= rs.Fields("cCode").Value  %>"/>
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title"><%= rs.Fields("cClassName").Value  %></div>
                              <div class="item-after" style="font-size: small"><%= format(rs.Fields("dDate").Value, "MM-dd")  %></div>
                            </div>
                            <div class="item-subtitle">请求加你为好友</div>
                            
                          </div>
                        </label>
                      </li>
                       
                     <% rs.MoveNext  %>
                    <% Next %>
                  </ul>
                  </div>
                    

         <div class="content-block">
    <div class="row">
      
      <a href="#" class="button button-big button-fill button-success" onclick="accept();">接受</a>
    </div>
  </div>


                  <% End If %>

                   



  
 </div>
      </div>





</div> 
        
    


        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
        <script type="text/javascript">
            function GroupView(cCode) {

                document.getElementById("T_GroupCode").value = cCode;
                returnlist();

            }

            function returnlist() {
                var code = document.getElementById("T_GroupCode").value;

                $(function () {
                    var data = "{str1:'" + code + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Addr.aspx/returnlist", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "失败") {
                                //document.getElementById("ListName").innerText = data.d;
                                $("#ListName").html(data.d);
                                //$.toast("保存成功");
                                //$.MySetting.back();
                                //$.router.back();
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




             </script>



        <script type="text/javascript">
            function DelList()
            {

      $.confirm('确定解散本群?',
        function () {
            Del();
            //var box = document.getElementById(cCode);
            //box.parentNode.removeChild(box);
            //document.body.removeChild(document.document.getElementById(cCode));


          //$.alert('You clicked Ok button');
        },
        function () {
          //$.alert('You clicked Cancel button');
        }
      );



      function Del() {
          var code = document.getElementById("T_GroupCode").value;
          $(function () {
              var data = "{str1:'" + code + "'}";
              $.ajax({
                  type: "Post", //要用post方式   
                  url: "A_Addr.aspx/DelList", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "删除成功") {

                          //$.toast("删除成功");
                          self.location = 'A_Addr.aspx';
                          //$.router.load('A_Notice.aspx', true)
                         
                      }//if的尾括号
                  },
                  error: function (err) {
                      alert(err);
                  }
              });
              return false; //禁用按钮的提交

          });

      };


            };

</script>

        <script type="text/javascript">
            function DelListName(cCode)
            {

      $.confirm('确定移除?',
        function () {
            Del();
            var box = document.getElementById(cCode);
            box.parentNode.removeChild(box);
            document.body.removeChild(document.document.getElementById(cCode));


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
                  url: "A_Addr.aspx/DelListName", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "删除成功") {

                          //$.toast("删除成功");
                          //self.location = 'A_Addr.aspx';
                          //$.router.load('A_Notice.aspx', true)
                         
                      }//if的尾括号
                  },
                  error: function (err) {
                      alert(err);
                  }
              });
              return false; //禁用按钮的提交

          });

      };


            };

</script>
        <script type="text/javascript">
            $("#but_SaveJoin").click(function () {
            
            var cName;
            var cMyName;
            cName = document.getElementById("T_Name").value;
            cMyName = document.getElementById("T_MyName").value;

            var myDate = new Date();
            var wxData = {

                "template_id": "GCft9QKNdzWhb_rflC6ILiTbI84kmS7E3so-Dn_l2mM",
                "url": "http://my.aiwei.biz/aw/A_Addr.aspx",

                "data": {
                    "first": {
                        "value": "添加好友通知",
                        "color": "#FF0000"
                    },
                    "keyword1": {
                        "value": "" + cMyName + "",
                        "color": "#173177"
                    },
                    "keyword2": {
                        "value": "" + myDate.toLocaleDateString() + " " + myDate.getHours() + ":" + myDate.getMinutes() + "",
                        "color": "#173177"
                    },
                    "remark": {
                        "value": "对方请求添加你为朋友，请在通讯录中操作！",
                        "color": "#173177"
                    }
                }
            }


            if (cName == '') {
                $.toast("请输入用户名或手机号！");
            }
            else {

                joinfriend();

            }
        
      
            function joinfriend() {

            $(function () {
                var data = "{str1:'" + cName + "',str2:'" + JSON.stringify(wxData) + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Addr.aspx/joinfriend", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d === "不存在") {

                            $.toast("添加的好友不存在！");

                        }
                        else if (data.d === '存在') {
                            $.toast("已经在好友列表！");
                        }
                        else if (data.d === "成功") {

                            $.toast("发送成功，等待对方通过！");
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
            function accept() {
            var cCode; 
            var checkbox = document.getElementsByName("checkbox");

            var checked_counts = 0;

            for (var i = 0; i < checkbox.length; i++) {
                if (checkbox[i].checked) {     //被选中的checkbox
                    checked_counts++;
                    cCode = checkbox[i].value;
                    SH();
                    //$.router.load('A_Setting.aspx')
                }
                if (checked_counts>0) {

                    $.toast("添加成功");
                    self.location = 'A_Addr.aspx';
                }
                else{
                    $.toast("请选择");
                }              
                
            }

      
            function SH() {

            $(function () {
                var data = "{str1:'" + cCode + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Addr.aspx/SH", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d === "成功") {
                            self.location = 'A_Addr.aspx';
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
    }

</script>


        </form> 
  </body>
</html>
