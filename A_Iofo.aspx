<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Iofo.aspx.vb" Inherits="A_Iofo" %>

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

  <div class="page page-current" id='iofo'>

 
      <nav class="bar bar-tab">

    <a class="tab-item external" href="A_App.aspx">
    <span class="icon icon-app"></span>
    <span class="tab-label">应用</span>
                         <%If Session("AppNumber") <> 0 Then %>
                        <span class="badge"><%=Session("AppNumber") %></span>
                        <% End if %>
  </a>
     <a class="tab-item external active" href="A_Iofo.aspx">
    <span class="icon icon-message"></span>
    <span class="tab-label">消息</span>
    <%If Session("IofoNumber") <> 0 Then %>
    <span class="badge"><%=Session("IofoNumber") %></span>
    <% End if %>
  </a>

 
      <a class="tab-item external" href="A_Addr.aspx">
  
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
    <a class="button button-link button-nav pull-left external" href="A_Setting.aspx" data-transition='slide-out'>
      
    </a>
    <h1 class="title">消息</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Save" runat="server">
      
    </a>
  </header>   
      
      
   <div class="content" style="top: 20px">

     
  <div class="list-block media-list">
    <ul><a href="#TZ" class="item-link">
      <li>
        <div class="item-content">
          <div class="item-media"></div>
            <div class="item-media"><img src="img/img/12.png" style='width: 2.2rem;'></div>
          <div class="item-inner">
            <div class="item-title-row">
              <div class="item-title">消息通知</div>
            </div>
            <div class="item-subtitle" style="color: #999999; font-size: 13px;">未完成的工作（<%=Session("IofoNumber") %>）</div>
          </div>
                
        </div>
      </li></a>
        </ul>
        <ul>
   <a href="#" class="item-link" onclick ="DY();">
      <li>
        <div class="item-content">
          <div class="item-media"></div>
            <div class="item-media"><img src="img/img/11.png" style='width: 2.2rem;'></div>
          <div class="item-inner">
            <div class="item-title-row">
              <div class="item-title">订阅信息</div>
            </div>
            <div class="item-subtitle"  style="color: #999999; font-size: 13px;">了解最新信息</div>
          </div>
                
        </div>
      </li></a>
    </ul>


  </div>








  
 </div>


  </div>  
      
    
  <div class="page " id='TZ'>




    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left external" href="A_Iofo.aspx" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">消息列表</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="A1" runat="server">
      
    </a>
  </header>   
      
      <div class="content"   style="top: 20px">
   

     
     
  <div class="list-block media-list">

               <%Dim rs As New ADODB.Recordset  %>
                <%rs = cPConn.Execute("select * from [dbTZListView] where cPhoneNumber='" & Session("iphone") & "' and zDeptCode='" & Session("usercode") & "' and bDel='0' order by dDate desc") %>

                  <%If rs.RecordCount <> 0 Then %>


    <ul>
         <% For i = 1 To rs.RecordCount %>
        <%If rs.Fields("bView").Value = "0" Then %>
      <li>
          <a href="#NoticeView" class="item-link item-content" onclick="View('<%=rs.Fields("cListCode").Value%>','<%=rs.Fields("cBT").Value%>','<%=rs.Fields("cNR").Value  %>','<%=rs.Fields("cJoinClassName").Value %>','<%=Format(rs.Fields("dDate").Value, "MM月dd日 HH:mm")%>','<%=rs.Fields("cBZ").Value %>','<%=rs.Fields("cURL").Value %>');" >
          <div style="padding-top: 1px; color: #666666; font-size: 35px; padding-right: 20px;"><i class="fa fa-volume-down"></i></div>
          <div class="item-inner">
            <div class="item-title-row">
              <div class="item-title" style="color: #666666"><%=rs.Fields("cBT").Value%></div>
            </div>
            <div class="item-subtitle" style="color: #CCCCCC; font-size: 13px"><%=Format(rs.Fields("dDate").Value, "MM-dd HH:mm")%></div>

          </div>
        </a>
      </li>




        <%Else %>
      <li>
          <a href="#NoticeView" class="item-link item-content" onclick="View('<%=rs.Fields("cListCode").Value%>','<%=rs.Fields("cBT").Value%>','<%=rs.Fields("cNR").Value  %>','<%=rs.Fields("cJoinClassName").Value %>','<%=Format(rs.Fields("dDate").Value, "MM月dd日 HH:mm") %>','<%=rs.Fields("cBZ").Value %>','<%=rs.Fields("cURL").Value %>');" >
          <div style="padding-top: 1px; color: #CCCCCC; font-size: 35px; padding-right: 20px;"><i class="fa fa-volume-down"></i></div>
          <div class="item-inner">
            <div class="item-title-row">
              <div class="item-title" style="color: #CCCCCC"><%=rs.Fields("cBT").Value%></div>
            </div>
            <div class="item-subtitle" style="color: #CCCCCC; font-size: 13px"><%=Format(rs.Fields("dDate").Value, "MM-dd HH:mm")%></div>

          </div>
        </a>
      </li>
        <% End If %>

               <% rs.MoveNext  %>
         <% Next %>

  </ul>
           <% Else %>
          <br /><br />
          <h4 style="text-align: center; color: #999999">没有新消息</h4>

          
 <% End If %>



  </div>


 </div>


  </div>  
    
    

        <div class="page" id='NoticeView'>


    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#TZ" data-no-cache="true" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">详情</h1>
<a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Del" runat="server">
      删除
    </a>
  </header>   

    <div class="content"  style="top: 20px">
  <div class="list-block">

        <ul>
          <!-- Text inputs -->
          <li style="display:none">
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_Code1" runat="server" placeholder="系统编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>

            <li>
        <div class="item-content">
          
          <div class="item-inner">
            <div class="item-input">
               <asp:TextBox ID="T_BT1" runat="server" placeholder="输入标题" MaxLength="40" Enabled="False" Font-Bold="True"></asp:TextBox>

            </div>
                  <div class="item-input" style="width: 70px">
                       <a class="pull-right" href="#" data-transition='slide-out' id="but_View" style="font-size: small;">显示/隐藏</a>

                   </div>
          </div>
        </div>
      </li>
            <li id="viewname" style="display:none">
        <div class="item-content">
          
          <div class="item-inner">
            <div class="item-input">
                <div id ="name" style="font-size: small; color: #999999"></div>
                <div id ="date" style="font-size: small; color: #999999"></div>
            </div>
          </div>
        </div>
      </li>
            <li id="viewuser" style="display:none">
        <div class="item-content">
          
          <div class="item-inner">
            <div class="item-input">
                <div id ="T_cJoinName1" style="font-size: small; color: #999999"></div>
                
            </div>
          </div>
        </div>
      </li>


        <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="T_NR1" runat="server" placeholder="输入内容..." TextMode="MultiLine" Height="100px" MaxLength="200" Enabled="False"></asp:TextBox>
                            <div align="center" style="padding-bottom: 10px">
            <img id="imgPre" src="" style="display: block; width: 50%; height: auto;" /> 
            </div> 
              </div>
            </div>
          </div>
        </li>
    </ul>
  
    <div class="buttons-tab">
    <a href="#tab1" class="tab-link active button" id="view5">评论</a>
    <a href="#tab2" class="tab-link button" id="view3">已看</a>
    <a href="#tab3" class="tab-link button" id="view4">未看</a>
  </div>
  
      
      <div class="content-block" style="height: 90px">
    <div class="tabs">
      <div id="tab1" class="tab active">
        <div id="PL" class="content-block">
         

        </div>
      </div>
      <div id="tab2" class="tab">
        <div class="content-block">

        <div style="font-size: 14px" id="view1"></div>
         
        </div>
      </div>
      <div id="tab3" class="tab">
        <div class="content-block">
                  <div style="font-size: 14px" id="view2"></div>

        </div>
      </div>
    </div>
  </div>

</div>

</div>



     <div class="bar bar-footer">



  <div class="searchbar row">
    <div class="search-input col-80">
      
      <input type="search" id='Reply' placeholder='添加评论...'/>
    </div>
     
    <a href ="#" class="button-fill button-primary col-20" style="padding-top: 4px;font-size: 14px" id="send">发送</a>

  </div>




</div>




     </div>

    
    </div>
 
    
        
 


        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
<%--        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>--%>
        <script>
  //打开自动初始化页面的功能
  //建议不要打开自动初始化，而是自己调用 $.init 方法完成初始化
  $.config = {
    autoInit: true
  }
</script>
        <script type="text/javascript">
            
                $(document).on("pageInit", function (e, pageId, $page) {
                    if (pageId == "NoticeView") {
                        var cCode = document.getElementById("T_Code1").value;
                        //$.showPreloader();
                        //setTimeout(function () {
                        //    $.hidePreloader();
                        //}, 500);
                       
                        //返回评论
                        returnview();
                        returnPL();
                        returnuser();
                       

                        //$.toast("设置页面");
                    
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
                    function returnview() {

                        $(function () {
                            var data = "{str1:'" + cCode + "'}";
                            $.ajax({
                                type: "Post", //要用post方式   
                                url: "A_Notice.aspx/returnview", //方法所在页面和方法名
                                contentType: "application/json; charset=utf-8",
                                data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                                dataType: "json",
                                success: function (data) {
                                    if (data.d != "失败") {
                                        var view;
                                        view = JSON.parse(data.d);
                                        document.getElementById("view1").innerText = view[0];
                                        document.getElementById("view2").innerText = view[1];
                                        document.getElementById("view3").innerText = '已看' + view[2];
                                        document.getElementById("view4").innerText = '未看' + view[3];
                                        document.getElementById("view5").innerText = '评论' + view[4];
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
                    function returnPL() {

                        $(function () {
                            var data = "{str1:'" + cCode + "'}";
                            $.ajax({
                                type: "Post", //要用post方式   
                                url: "A_Notice.aspx/returnPL", //方法所在页面和方法名
                                contentType: "application/json; charset=utf-8",
                                data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                                dataType: "json",
                                success: function (data) {
                                    if (data.d != "失败") {
                                        
                                        $("#PL").html(data.d);
                                        
                                      


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
            function View(cListCode, cBT, cNR, cName, cDate, cBZ, cURL) {
                document.getElementById("T_Code1").value = cListCode;
                document.getElementById("T_BT1").value = cBT;
                document.getElementById("T_NR1").value = cNR.replace('.', '\n');
                document.getElementById('name').innerText = cName + '（' + cDate + '）';
                document.getElementById("T_cJoinName1").innerText = cBZ;
                document.getElementById('imgPre').src = cURL;
                //document.getElementById('date').innerText = cDate;

                //$.toast("内容");
                ViewRB();






                function ViewRB() {

                var myDate = new Date();
                var wxData = {

                    "template_id": "vI8NQ0GS9nqh854QGrDN4O1eVrsqWfMkw5W9xdZLgsg",
                    "url": "http://my.aiwei.biz/aw/A_Iofo.aspx#TZ",

                    "data": {
                        "first": {
                            "value": "发起的通知已全部查看！",
                            "color": "#FF0000"
                        },
                        "keyword1": {
                            "value": "" + cBT + "",
                            "color": "#173177"
                        },
                        "keyword2": {
                            "value": "" + document.getElementById("T_cJoinName1").innerText + "",
                            "color": "#173177"
                        },
                        "keyword3": {
                            "value": "" + myDate.toLocaleDateString() + " " + myDate.getHours() + ":" + myDate.getMinutes() + "",
                            "color": "#173177"
                        },
                        "remark": {
                            "value": "您发送的通知，成员已全部查看！",
                            "color": "#173177"
                        }
                    }
                }







                    $(function () {
                        var data = "{str1:'" + cListCode + "',str2:'" + JSON.stringify(wxData) + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Notice.aspx/ViewTZ", //方法所在页面和方法名
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
                    function DY() {
                        $.toast("未开放，敬请期待！");
                    };

                    </script>

        <script type="text/javascript">
            $("#but_Del").click(function () 
            {
                var cCode;
                cCode = document.getElementById("T_Code1").value;
      $.confirm('确定删除该通知?',
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
                  url: "A_Notice.aspx/Del", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "删除成功") {

                          $.toast("删除成功");
                          //$.router.back();
                          self.location = 'A_Iofo.aspx';
                          //$.router.load('A_Notice.aspx', true)
                         
                      }
                      else if (data.d === "已经删除") {
                          $.toast("已经删除");
                          //$.router.back();
                          self.location = 'A_Iofo.aspx';
                          //$.router.load('#TZ')
                          
                      
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
            $("#send").click(function () {
                var cReply = document.getElementById("Reply").value;  
                
                if (cReply!=''){
                    SavePL();
                    
                    //var html;
                    //var cName = document.getElementById("T_Name").value;
                    //var myDate = new Date();
                    //var PLDate = myDate.toLocaleDateString() + " " + myDate.getHours() + ":" + myDate.getMinutes();
                    //html = '<div style="font-size: 13px"><div style="float: left; color: #173177;">' + cName + '</div><div style="float: right; color: #C0C0C0;">' + PLDate + '</div><div style="padding-top: 20px; padding-left: 1px; color: #333333; left: 0px;">' + cReply + '</div></div><hr style ="color: #CCCCCC" />';                  
                    //$("#PL").before(html);
                    //$("#PL").html(html);
                    document.getElementById("Reply").value = '';



                }


                  });
            function returnPL() {
                var cCode = document.getElementById("T_Code1").value;
                $(function () {
                    var data = "{str1:'" + cCode + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Notice.aspx/returnPL", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "失败") {

                                $("#PL").html(data.d);




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
                function SavePL() {
                    
                    var cReply = document.getElementById("Reply").value;
                    var cCode = document.getElementById("T_Code1").value;
                    
                        
                    $(function () {
                        var data = "{str1:'" + cCode + "',str2:'" + cReply + "',str3:''}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Notice.aspx/SavePL", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "成功") {
                                    returnPL();
                                    //$.toast("成功");
                                    //self.location = 'A_Notice.aspx';
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


</script>

        <script type="text/javascript">
            //显示或隐藏（通知人和收件人）
            $("#but_View").click(function () {

                if ($("#viewname").css("display") == 'none') {//如果是隐藏的
                    $("#viewname").css("display", "block");//display属性设置为block（显示）
                    $("#viewuser").css("display", "block")
                } else {
                    $("#viewname").css("display", "none");
                    $("#viewuser").css("display", "none");
                }





           })

        </script>


        <script type="text/javascript">
            function DelList(cCode)
            {

      $.confirm('确定删除?',
        function () {
            Del();
            var box = document.getElementById(cCode);
            box.parentNode.removeChild(box);
            //document.body.removeChild(document.document.getElementById(cCode));
            //returnPL();

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
                  url: "A_Notice.aspx/DelList", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "删除成功") {

                          //$.toast("删除成功");
                          //self.location = 'A_Notice.aspx';
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


            function returnPL() {
                var cCode = document.getElementById("T_Code1").value;
                $(function () {
                    var data = "{str1:'" + cCode + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Notice.aspx/returnPL", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "失败") {

                                $("#PL").html(data.d);




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
</script>

        


        </form> 
  </body>
</html>
