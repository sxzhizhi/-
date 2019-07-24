<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Money.aspx.vb" Inherits="A_Money" %>

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
    
    <link href="css/bootstrap-fileinput.css" rel="stylesheet" />
    <style type="text/css">


.msgs6{display:inline-block;width:104px;color:#C0C0C0;font-size:12px;border:0px solid #0697DA;text-align:center;height:30px;line-height:30px;cursor:pointer;}

.sp-upload{position:relative; display:inline-block; min-height:33px;overflow:hidden;vertical-align:middle; cursor:pointer;}

.sp-upload-img{position:absolute; right:0; top:0; font-size:100px; opacity:0; filter:alpha(opacity=0);cursor:pointer; width:100%;height:100%;}
        .sp-upload-photo {
            float: left;
            outline: none;
            width: 100%;
            height:auto;
            background: url('z_add.png') center center no-repeat #fff;
            border-radius: 3px;
            cursor: pointer;
        }

</style>

</head>
<body>
    <form enctype="multipart/form-data" id ="postForm" runat="server" method="post">
    <div></div>
    
       
    <div class="page-group">
        <%--主界面，工资条--%>
        <div class="page" id='Money'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">工资条</h1>
        <%If Session("Popdom") = "1"Then %>
        <a class="button button-link button-nav pull-right external" href="A_Import.aspx" data-transition='slide-out'>
          导入
        </a>
        <% End if %>
          
        
      </header>   

<div class="content"  style="top: 20px">
              

<% If Session("usercode") <> "" %>   
    <div class="list-block">


                                        <ul>
                            <!-- Text inputs -->
                            <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">当前用户：</div>
                                        <div class="item-input">

                                            <asp:TextBox ID="T_Name" runat="server" placeholder="当前用户" Enabled="False"></asp:TextBox>
                                            <%--<input type="text" id="T_Job" placeholder="请输入职位" value="<%= Session("job") %>" />--%>
                                        </div>
                                    </div>
                                </div>
                            </li>

                               

                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">月份：</div>
                                        <div class="item-input">

                                            <input type="text" id='picker_Unit' placeholder="请选择" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                  
                                
                       


                </ul>
        <div style="padding-right: 13px; padding-left: 13px; padding-top: 20px;">
                     
                        <a href="#Money" class="button button-fill" style="color: #FFFFFF; background-color: #4CD964;" ><i class="fa fa-search"></i> 查询</a>
                     
                    </div>
                    </div>

                        <% Else %>

                                <br /><br />
                                 <h4 style="text-align: center; color: #999999">你还没找到组织!</h4>

                               <% End if %>








        </div>



       
    </div>
         
        <div class="page" id='NoticeList1'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">通知</h1>
        <%If Session("Popdom") = "1" Then %>
        <a class="button button-link button-nav pull-right external" href="A_TZLX.aspx" data-transition='slide-out' runat="server">
          类型
        </a>
        <% End if %>
          <a class="button button-link button-nav pull-right" href="#MYNoticeList" data-transition='slide-out' id="A3" runat="server">
          已发
        </a>
        
      </header>   

<div class="content">
              


                  <div style="padding-right: 13px; padding-left: 13px;">
                     
                        <p><a href="#joinname" class="button button-fill" style="color: #FFFFFF; background-color: #4CD964;" ><i class="fa fa-pencil"></i> 发通知</a></p> 
                     
            </div>
              
                 <%Dim rs As New ADODB.Recordset  %>
                <%rs = cPConn.Execute("select  * from [dbTZListView] where cPhoneNumber='" & Session("iphone") & "' and zDeptCode='" & Session("usercode") & "' and bDel='0' order by dDate desc") %>

                  <%If rs.RecordCount <> 0 Then %>
               <div class="content-block-title" >收到的通知</div>
                  <div class="list list-block media-list" >
      <ul>
          <% For i = 1 To rs.RecordCount %>
        <li>


          <a href="#NoticeView" class="item-link item-content" onclick="View('<%=rs.Fields("cListCode").Value%>','<%=rs.Fields("cBT").Value%>','<%=rs.Fields("cNR").Value  %>','<%=rs.Fields("cJoinClassName").Value %>','<%=Format(rs.Fields("dDate").Value, "MM月dd日 HH:mm")%>','<%=rs.Fields("cBZ").Value %>','<%=rs.Fields("cURL").Value %>');" >
             <div class="item-media"></div>
            <div class="item-media" style="width:2rem; height:2rem; border-radius:50%; overflow:hidden;"><img src="<%= rs.Fields("wxheadimgurl").Value  %>" style='width: 2rem;'></div>

              <div class="item-inner">

              <div class="item-title-row">
                <div class="item-title"><%=rs.Fields("cBT").Value%>
                    <%If rs.Fields("bView").Value = 0 Then %>
                    <span style="color: #FF3300; font-size: 11px;">New</span>
                    <% End if %>
                </div>
                <div class="item-after"><%=Format(rs.Fields("dDate").Value, "MM-dd")%></div>
              </div>
              
              <div class="item-text"><%=rs.Fields("cBT").Value = rs.Fields("cNR").Value%></div>
            </div>
          </a>
        </li>
       <% rs.MoveNext  %>
         <% Next %>

           <% Else %>
          <br /><br />
          <h4 style="text-align: center; color: #999999">没有通知</h4>

           <% End If %>



          </ul>
        </div>



       
    </div>


  
     </div>

    </div>



        
    

        
        
        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
<%--        <script src="js/lrz.all.bundle.js"></script>
        <script src="js/canvas-to-blob.min.js"></script>--%>

        <script type="text/javascript">
            $(document).on("pageInit", function (e, pageId, $page) {
                if (pageId == "Money") {
                    setunit();
                    //var cName = '';

                    //returnsex();

                    //$.toast("设置页面");

                }
                
                else if (pageId == "Money1") {
                    setunit();
                    //document.getElementById("picker_Unit").value = document.getElementById("T_Unit").innerText;
                    

                }
                
              

                var unitname;
                function setunit() {
                    var data = "{str1:'" + unitname + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Money.aspx/ReturnUnit", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "error") {
                                unitname = JSON.parse(data.d);
                                setaa();

                                //$("#picker_Unit").picker("setValue", ["2012", "12", "12"]);
                                //$.toast("注销成功");
                                //self.location = 'A_Login.aspx';
                                //$.router.load('A_Notice.aspx', true)

                            }



                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                    return false; //禁用按钮的提交

                    function setaa() {

                        $("#picker_Unit").picker({

                            toolbarTemplate: '<header class="bar bar-nav">\
  <button class="button button-link pull-left"></button>\
  <button class="button button-link pull-right close-picker">确定</button>\
  <h1 class="title">选择月份</h1>\
  </header>',
                            cols: [
                                {
                                    textAlign: 'center',
                                    values: unitname
                                }
                            ]
                        });
                    };

                };


            });

        </script>


        </form> 
  </body>
</html>
