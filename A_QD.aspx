[-<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_QD.aspx.vb" Inherits="A_QD" %>

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

<div class="page-group">

        <div class="page page-current" id='QD'>
      <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left external" href="A_App.aspx">
          返回
        </a>
        <h1 class="title">今日考勤</h1>
                  <%If Session("Popdom") = "1"Then %>
        <a class="button button-link button-nav pull-right" href="#SetQD" data-transition='slide-out' runat="server">
          管理
        </a>
         <a class="button button-link button-nav pull-right" href="#QDTJList" data-transition='slide-out' runat="server">
          统计
        </a>
        <% End if %>


      </header>

     <div class="content" style="top: 20px">

         <div class="list-block media-list">
        <ul>
          <li style="height: 90px; background-color: #B4C2DE;">
            <div class="item-content">
              <div class="item-media"></div>
                <div class="item-media"></div>
              <div class="item-inner">
                <div class="item-title-row">
                  <div class="item-title" style="font-size: 25px"><% if Weekday(Now) = 1 Then%>
                                                                         <% = "星期天"%>
                                                                        <%ElseIf Weekday(Now) = 2 Then %>
                                                                         <% = "星期一"%>
                                                                         <%ElseIf Weekday(Now) = 3 Then%>
                                                                         <% = "星期二"%>
                                                                        <%ElseIf Weekday(Now) = 4 Then %>
                                                                         <% = "星期三"%>
                                                                        <%ElseIf Weekday(Now) = 5 Then %>
                                                                         <% = "星期四"%>
                                                                         <%ElseIf Weekday(Now) = 6  then%>
                                                                         <% = "星期五"%>
                                                                        <%ElseIf Weekday(Now) = 7 Then %>
                                                                         <% = "星期六"%>
                                                                      <%End If%>


                      </div>
                </div>
                <div class="item-subtitle" style="color: #808080; font-size: 17px;"><%=Format(Now(), "yyyy年MM月dd日") %></div>
              </div>
                
            </div>
          </li>
            </ul>
        



        <ul>
          <li>
            <div class="item-content">
              <div class="item-media"></div>
                <div class="item-media"><img src="img/img/1.png" style='width: 2.2rem;'></div>
              <div class="item-inner">
                <div class="item-title-row">
                  <div class="item-title">上班</div>
                </div>
                <div class="item-subtitle" style="color: #999999; font-size: 13px;" id="SBTime" runat="server"></div>
              </div>
                    <div style="padding-right: 20px; font-size: 14px; width: 110px;" id="SB" runat="server"><a href="A_SBKQ.aspx" class="button button-big button-fill button-success external" style="font-size: 14px">签到</a></div>
            </div>      
             <div id="SBAddr" runat="server" style="color: #999999; text-align: center; font-size: 11px; padding-right: 20px; padding-left: 20px; padding-bottom: 10px;"></div>

          </li>
            </ul>
            <ul>
   
          <li>
            <div class="item-content">
              <div class="item-media"></div>
                <div class="item-media"><img src="img/img/2.png" style='width: 2.2rem;'></div>
              <div class="item-inner">
                <div class="item-title-row">
                  <div class="item-title">下班</div>
                </div>
                <div class="item-subtitle"  style="color: #999999; font-size: 13px;" id="XBTime" runat="server"></div>
              </div>
                    <div style="padding-right: 20px; font-size: 14px; width: 110px;" id="XB" runat="server"><a href="A_XBKQ.aspx" class="button button-big button-fill button-success external" style="font-size: 14px">签退</a></div>
            </div>
         <div id="XBAddr" runat="server" style="color: #999999; text-align: center; font-size: 11px; padding-right: 20px; padding-left: 20px; padding-bottom: 10px;"></div>

          </li>
        </ul>


      </div>


                            <div class="list-block">
                            <ul>
                                <li>
                                    <a href ="#QDList"><div class="item-link list-button">我的考勤历史</div></a>

                                </li>
                                
                            </ul>
                        </div>




       </div>





    </div>
        
        <div class="page" id='SetQD'>


            <header class="bar bar-nav">
            <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
              返回
            </a>
            <h1 class="title">编辑考勤</h1>
                    
          </header>
          <div class="content"  style="top: 20px"> 
              <div class="list-block">

                        <ul>

                            <li>
                                <a href="#ModifySTime">
                                    <div class="item-link list-button" style="text-align: left">
                                        上班时间<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div id="cName" class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="T_STime" runat="server"></div>
                                        </div>
                                    </div>
                                </a>


                            </li>


                            <li>
                                <a href="#ModifyXTime">
                                    <div class="item-link list-button" style="text-align: left">
                                        下班时间<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="T_XTime" runat="server"></div>
                                        </div>
                                    </div>
                                </a>  


                            </li>



                        </ul>




                    </div>
   
    </div>
    
            
        </div>

    <div class="page" id='ModifySTime'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">修改上班时间</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SaveSTime">保存
                    </a>
                </header>

                <div class="content">

                    <div class="list-block">
                        <ul>


                         <li>
                                <div class="item-content">

                                    <div class="item-inner">

                                        <div class="item-input">

                                            <input type="text" id='picker_STime' placeholder="请选择时间"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                        </ul>
                    </div>



                </div>
            </div>

    <div class="page" id='ModifyXTime'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">修改下班时间</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SaveXTime">保存
                    </a>
                </header>

                <div class="content">

                    <div class="list-block">
                        <ul>


                         <li>
                                <div class="item-content">

                                    <div class="item-inner">

                                        <div class="item-input">

                                            <input type="text" id='picker_XTime' placeholder="请选择时间"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                        </ul>
                    </div>



                </div>
            </div>


        <div class="page" id='QDList'>


            <header class="bar bar-nav">
            <a class="button button-link button-nav pull-left back" href="#QD" data-transition='slide-out'>
              返回
            </a>
            <h1 class="title">我的考勤历史</h1>
        
          </header>
          <div class="content"  style="top: 20px"> 
            <%Dim rs As New ADODB.Recordset  %>
            <%rs = cPConn.Execute("select top 30 dQD,count(cName) as number from [KQQD] where cName='" & Session("iphone") & "' group by dQD order by dQD desc") %>

              <%If rs.RecordCount <> 0 Then %>
  <div class="list-block">

      <ul>                   
                <% For i = 1 To rs.RecordCount %>
    
       
          <li><a href="#QDView" onclick ="QDView('<%=Format(rs.Fields("dQD").Value, "yyyy-MM-dd") %>','<%=Format$(rs.Fields("dQD").Value, "ddd") %>')" >
            <div class="item-link list-button" style="text-align: left" >（<%=Format(rs.Fields("dQD").Value, "yyyy-MM-dd") & " " & Format$(rs.Fields("dQD").Value, "ddd")%>）<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"><%=rs.Fields("number").Value%>次</div></div>
                         </a>  
            
        </li>


          

                     <% rs.MoveNext  %>
                    <% Next %>

           <% else %>
          <br /><br />
          <h4 style="text-align: center; color: #999999">没有考勤记录</h4>

          <% End If %>

</ul> 
            </div> 
   
    </div>
    
            
        </div>


<div class="page" id='QDView'>
      <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#">
          返回
        </a>
        <h1 class="title">考勤详情</h1>
        
      </header>

     <div class="content" style="top: 20px">

         <div class="list-block media-list">
        <ul>
          <li style="height: 90px; background-color: #B4C2DE;">
            <div class="item-content">
              <div class="item-media"></div>
                <div class="item-media"></div>
              <div class="item-inner">
                <div class="item-title-row">
                  <div class="item-title" style="font-size: 25px" id="week">
                      </div>
                </div>
                <div class="item-subtitle" style="color: #808080; font-size: 17px;" id="date"></div>
              </div>
                
            </div>
          </li>
            </ul>
        



        <ul>
          <li>
            <div class="item-content">
              <div class="item-media"></div>
                <div class="item-media"><img src="img/img/1.png" style='width: 2.2rem;'></div>
              <div class="item-inner">
                <div class="item-title-row">
                  <div class="item-title">上班</div>
                </div>
                <div class="item-subtitle" style="color: #999999; font-size: 13px;" id="SBTime1" ></div>
              </div>
                    <div style="padding-right: 20px; font-size: 14px; width: 110px;" id="SBBZ" runat="server">签到</div>
            </div>      
             <div id="SB1" runat="server" style="color: #999999; text-align: center; font-size: 11px; padding-right: 20px; padding-left: 20px; padding-bottom: 10px;"></div>

          </li>
            </ul>
            <ul>
   
          <li>
            <div class="item-content">
              <div class="item-media"></div>
                <div class="item-media"><img src="img/img/2.png" style='width: 2.2rem;'></div>
              <div class="item-inner">
                <div class="item-title-row">
                  <div class="item-title">下班</div>
                </div>
                <div class="item-subtitle"  style="color: #999999; font-size: 13px;" id="XBTime1"></div>
              </div>
                    <div style="padding-right: 20px; font-size: 14px; width: 110px;" id="XBBZ" runat="server">签退</div>
            </div>
         <div id="XB1" runat="server" style="color: #999999; text-align: center; font-size: 11px; padding-right: 20px; padding-left: 20px; padding-bottom: 10px;"></div>

          </li>
        </ul>


      </div>







       </div>





    </div>

    <div class="page" id='QDTJList'>


            <header class="bar bar-nav">
            <a class="button button-link button-nav pull-left back" href="#QD" data-transition='slide-out'>
              返回
            </a>
            <h1 class="title">考勤统计</h1>

          <button class="button button-link button-nav pull-right back" type="button" onclick="method('tableExcel')">
              导出
                </button>
          </header>
          <div class="content"  style="top: 20px"> 
            
            <%rs = cPConn.Execute("select top 30 dQD,count(cName) as number from [KQQD] where zDeptCode='" & Session("usercode") & "' group by dQD order by dQD desc") %>

              <%If rs.RecordCount <> 0 Then %>
  <div class="list-block">

      <ul>                   
                <% For i = 1 To rs.RecordCount %>
    
       
          <li><a href="#QDTJListView"   onclick ="QDTJView('<%=Format(rs.Fields("dQD").Value, "yyyy-MM-dd") %>','<%=Format$(rs.Fields("dQD").Value, "ddd") %>')" >
            <div class="item-link list-button" style="text-align: left" >（<%=Format(rs.Fields("dQD").Value, "yyyy-MM-dd") & " " & Format$(rs.Fields("dQD").Value, "ddd")%>）<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"><%=rs.Fields("number").Value%>次</div></div>
                         </a>  
            
        </li>


          

                     <% rs.MoveNext  %>
                    <% Next %>

           <% Else %>
          <br /><br />
          <h4 style="text-align: center; color: #999999">没有考勤记录</h4>

          <% End If %>

</ul> 
            </div> 
   
    </div>
    
            
        </div>

            <div class="page" id='QDTJListView'>


            <header class="bar bar-nav">
            <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
              返回
            </a>
            <h1 class="title">考勤详情</h1>
                    
          </header>
          <div class="content"  style="top: 20px"> 
              <div class="list-block">

                        <ul>
            <li style="height: 40px; background-color: #B4C2DE;">
            <div class="item-content">
              
              <div class="item-inner">
                <div class="item-title-row">
                <div class="item-subtitle" style="color: #808080; font-size: 17px;" id="TJDate"></div>
                </div>
                <div id="TJWeek" style="color: #808080; font-size: 17px;"></div>
              </div>
                
            </div>
          </li>
            </ul>
                  <div style="font-size: 12px; padding-left: 15px; padding-top: 5px; padding-bottom: 5px;">上班</div>
                  <ul>
                            
                            <li>
                                
                                <a href="#TJView" onclick="classname('准时','上班');">
                                    <div class="item-link list-button" style="text-align: left">
                                        准时<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="Div1" runat="server"></div>
                                        </div>
                                    </div>
                                </a>


                            </li>


                            <li>
                                <a href="#TJView" onclick="classname('迟到','上班');">
                                    <div class="item-link list-button" style="text-align: left">
                                        迟到<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="Div2" runat="server"></div>
                                        </div>
                                    </div>
                                </a>  


                            </li>
                               <li>
                                <a href="#TJView" onclick="classname('未签到','上班');">
                                    <div class="item-link list-button" style="text-align: left">
                                        未签到<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="Div3" runat="server"></div>
                                        </div>
                                    </div>
                                </a>  


                            </li>


                        </ul>
                  <div style="font-size: 12px; padding-top: 5px; padding-bottom: 5px; padding-left: 15px;">下班</div>
                  <ul>
                            
                            <li>
                                
                                <a href="#TJView" onclick="classname('准时','下班');">
                                    <div class="item-link list-button" style="text-align: left">
                                        准时<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="Div4" runat="server"></div>
                                        </div>
                                    </div>
                                </a>


                            </li>


                            <li>
                                <a href="#TJView" onclick="classname('早退','下班');">
                                    <div class="item-link list-button" style="text-align: left">
                                        早退<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="Div5" runat="server"></div>
                                        </div>
                                    </div>
                                </a>  


                            </li>
                               <li>
                                <a href="#TJView" onclick="classname('未签退','下班');">
                                    <div class="item-link list-button" style="text-align: left">
                                        未签退<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="Div6" runat="server"></div>
                                        </div>
                                    </div>
                                </a>  


                            </li>


                        </ul>



                    </div>
   
    </div>
    
            
        </div>

    <div class="page" id='TJView'>

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">考勤详情</h1>

  </header>   
      
      <div class="content"  style="top: 20px">






          <div class="list-block media-list">
             <ul><li class="list-group-title" style="font-size: 13px" id="BZ"></li> </ul>
            <ul>
              <div id="classname" runat="server"></div>
          </ul>
          </div>
                  
  
 </div>
      </div>






</div>

        
        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>

        <script type="text/javascript">
            $(document).on("pageInit", function (e, pageId, $page) {
                if (pageId == "SetQD") {

                    returnTime();



                }

                else if (pageId == "QD") {
                    returnTime();
                }
            else if (pageId == "ModifySTime") {

                    var STime = '';
                    function sup(n) { return (n < 10) ? '0' + n : n; }
                    returnSTime();
                    function returnSTime() {

                        $(function () {
                            var data = "{str1:'" + STime + "'}";
                            $.ajax({
                                type: "Post", //要用post方式   
                                url: "A_QD.aspx/returnSTime", //方法所在页面和方法名
                                contentType: "application/json; charset=utf-8",
                                data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                                dataType: "json",
                                success: function (data) {
                                    if (data.d != "失败") {
                                        STime = new Date(data.d);

                                        

                                        document.getElementById("picker_STime").value = sup(STime.getHours()) + ':' + sup(STime.getMinutes());
                                        var a = document.getElementById("picker_STime").value;


                                    } //if的尾括号
                                },
                                error: function (err) {
                                    alert(err);
                                }
                            });
                            return false; //禁用按钮的提交

                        });

                    };
                    

                //$("#picker_STime").picker("setValue", ["09", ":", "00"]);

                    $("#picker_STime").picker({
                        value: ['09', ':', '00'],
                        
                        toolbarTemplate: '<header class="bar bar-nav">\
  <button class="button button-link pull-right close-picker">确定</button>\
  <h1 class="title">请选择时间</h1>\
  </header>',
                        cols: [
                          {
                              textAlign: 'center',
                              values: ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23']
                              //如果你希望显示文案和实际值不同，可以在这里加一个displayValues: [.....]
                          },
                                                    {
                             
                                                        textAlign: 'center',
                                                        values: [':']
                                                    },
                          {
                             
                              textAlign: 'center',
                              values: ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10',
                                         '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
                              '21', '22', '23', '24', '25', '26', '27', '28', '29', '30',
                               '31', '32', '33', '34', '35', '36', '37', '38', '39', '40',
                               '41', '42', '43', '44', '45', '46', '47', '48', '49', '50',
                               '51', '52', '53', '54', '55', '56', '57', '58', '59' ]
                          }
                        ]
                    });

                }
                else if (pageId == "ModifyXTime") {

                    var XTime = '';

                    returnXTime();
                    function returnXTime() {

                        $(function () {
                            var data = "{str1:'" + XTime + "'}";
                            $.ajax({
                                type: "Post", //要用post方式   
                                url: "A_QD.aspx/returnXTime", //方法所在页面和方法名
                                contentType: "application/json; charset=utf-8",
                                data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                                dataType: "json",
                                success: function (data) {
                                    if (data.d != "失败") {
                                        XTime = new Date(data.d);

                                        function sup(n) { return (n < 10) ? '0' + n : n; }

                                        document.getElementById("picker_XTime").value = sup(XTime.getHours()) + ':' + sup(XTime.getMinutes());


                                    } //if的尾括号
                                },
                                error: function (err) {
                                    alert(err);
                                }
                            });
                            return false; //禁用按钮的提交

                        });

                    };


                    $("#picker_XTime").picker({

                        value: ['18', ':', '00'],
                        toolbarTemplate: '<header class="bar bar-nav">\
  <button class="button button-link pull-right close-picker">确定</button>\
  <h1 class="title">请选择时间</h1>\
  </header>',
                        cols: [
                          {
                              textAlign: 'center',
                              values: ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23']
                              //如果你希望显示文案和实际值不同，可以在这里加一个displayValues: [.....]
                          },
                                                    {

                                                        textAlign: 'center',
                                                        values: [':']
                                                    },
                          {

                              textAlign: 'center',
                              values: ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10',
                                         '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
                              '21', '22', '23', '24', '25', '26', '27', '28', '29', '30',
                               '31', '32', '33', '34', '35', '36', '37', '38', '39', '40',
                               '41', '42', '43', '44', '45', '46', '47', '48', '49', '50',
                               '51', '52', '53', '54', '55', '56', '57', '58', '59']
                          }
                        ]
                    });

                }
                

                });
            function returnTime() {
                var cTime = '';
                
                    $(function () {
                        var data = "{str1:'" + cTime + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_QD.aspx/returnTime", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "失败") {
                                    var view;
                                    view = JSON.parse(data.d);

                                    function sup(n) { return (n < 10) ? '0' + n : n; }

                                    cTime = new Date(view[0]);
                                    document.getElementById("T_STime").innerText = sup(cTime.getHours()) + ':' + sup(cTime.getMinutes());
                                    document.getElementById("SBTime").innerText = sup(cTime.getHours()) + ':' + sup(cTime.getMinutes());

                                    cTime = new Date(view[1]);
                                    document.getElementById("T_XTime").innerText = sup(cTime.getHours()) + ':' + sup(cTime.getMinutes());
                                    document.getElementById("XBTime").innerText = sup(cTime.getHours()) + ':' + sup(cTime.getMinutes());

                                } //if的尾括号
                            },
                            error: function (err) {
                                alert(err);
                            }
                        });
                        return false; //禁用按钮的提交

                    });

               

            }
        </script>
            <script type="text/javascript">
                $("#but_SaveSTime").click(function () {
                    var STime = document.getElementById("picker_STime").value;

                    if (STime == '') {
                    $.toast("不能为空，请选择时间");
                }
                else {
                        saveSTime();

                }


                    function saveSTime() {

                    $(function () {
                        var data = "{str1:'" + STime + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_QD.aspx/saveSTime", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    document.getElementById("T_STime").innerText = STime;
                                    $.toast("保存成功");
                                    $.router.back();

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
                $("#but_SaveXTime").click(function () {
                    var XTime = document.getElementById("picker_XTime").value;

                    if (XTime == '') {
                        $.toast("不能为空，请选择时间");
                    }
                    else {
                        saveXTime();

                    }


                    function saveXTime() {

                        $(function () {
                            var data = "{str1:'" + XTime + "'}";
                            $.ajax({
                                type: "Post", //要用post方式   
                                url: "A_QD.aspx/saveXTime", //方法所在页面和方法名
                                contentType: "application/json; charset=utf-8",
                                data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                                dataType: "json",
                                success: function (data) {
                                    if (data.d === "保存成功") {
                                        document.getElementById("T_XTime").innerText = XTime;
                                        $.toast("保存成功");
                                        $.router.back();

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

            function QDView(dDate,week) {

                var aa = dDate;
                var bb = week;

                document.getElementById("week").innerText = bb;
                document.getElementById("date").innerText = aa;
                SetDate();
               

                function SetDate() {
                    $(function () {
                        var data = "{str1:'" + aa + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_QD.aspx/SetQD", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                var view;
                                view = JSON.parse(data.d);
                                document.getElementById("SB1").innerText = view[0];
                                document.getElementById("XB1").innerText = view[1];
                                document.getElementById("SBTime1").innerText = view[2];
                                document.getElementById("SBBZ").innerText = view[4];
                                document.getElementById("XBTime1").innerText = view[3];
                                document.getElementById("XBBZ").innerText = view[5];

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
        <script type="text/javascript">

            function QDTJView(dDate,week) {

                var aa = dDate;
                var bb = week;

                
                //document.getElementById("TJDate").innerText = aa + " （" + bb + "）";
                document.getElementById("TJDate").innerText = aa;
                document.getElementById("TJWeek").innerText = bb;
                TJKQ();
               

                function TJKQ() {
                    $(function () {
                        var data = "{str1:'" + aa + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_QD.aspx/TJKQ", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                var view;
                                view = JSON.parse(data.d);
                                document.getElementById("Div1").innerText = view[0];
                                document.getElementById("Div2").innerText = view[1];
                                document.getElementById("Div3").innerText = view[2];
                                document.getElementById("Div4").innerText = view[3];
                                document.getElementById("Div5").innerText = view[4];
                                document.getElementById("Div6").innerText = view[5];

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
         <script>
             function classname(cBZ, cSign) {

                 var cTime = document.getElementById("TJDate").innerText;
                 document.getElementById("BZ").innerText = cBZ;
                $(function () {
                    var data = "{str1:'" + cTime + "',str2:'" + cBZ + "',str3:'" + cSign + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_QD.aspx/return_classname", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "失败") {
                                
                                $("#classname").html(data.d);
                                //$.toast("发布成功");
                                //self.location = 'A_Notice.aspx';
                                //$.router.load('A_Notice.aspx', true)
                                //$.router.load("#NoticeList",true);
                            } //if的尾括号
                        },
                        error: function (err) {
                            //alert(err);
                        }
                    });
                    return false; //禁用按钮的提交

                });

            };


        </script>

            <script language="JavaScript" type="text/javascript">  

            function method(tableid) {

                var curTbl = document.getElementById(tableid);
                var oXL = new ActiveXObject("Excel.Application");
                var oWB = oXL.Workbooks.Add();
                var oSheet = oWB.ActiveSheet;
                var Lenr = curTbl.rows.length;
                for (i = 0; i < Lenr; i++) {
                    var Lenc = curTbl.rows(i).cells.length;
                    for (j = 0; j < Lenc; j++) {
                        oSheet.Cells(i + 1, j + 1).value = curTbl.rows(i).cells(j).innerText;

                    }

                }
                oXL.Visible = true;
            }
            </script>
    <div id="myDiv">  
<table id="tableExcel" width="100%" border="1" cellspacing="0" cellpadding="0">  
    <tr>  
        <td colspan="5" align="center">html 表格导出道Excel</td>  
    </tr>  
    <tr>  
        <td>列标题1</td>  
        <td>列标题2</td>  
        <td>类标题3</td>  
        <td>列标题4</td>  
        <td>列标题5</td>  
    </tr>  
    <tr>  
        <td>aaa</td>  
        <td>bbb</td>  
        <td>ccc</td>  
        <td>ddd</td>  
        <td>eee</td>  
    </tr>  
    <tr>  
        <td>AAA</td>  
        <td>BBB</td>  
        <td>CCC</td>  
        <td>DDD</td>  
        <td>EEE</td>  
    </tr>  
    <tr>  
        <td>FFF</td>  
        <td>GGG</td>  
        <td>HHH</td>  
        <td>III</td>  
        <td>JJJ</td>  
    </tr>  
</table>  
</div>  

  </body>
</html>
