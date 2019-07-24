<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Notice.aspx.vb" Inherits="A_Notice" %>

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
        <%--主界面，收到的通知--%>
        <div class="page" id='NoticeList'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">通知</h1>
        <%If Session("Popdom") = "1"Then %>
        <a class="button button-link button-nav pull-right external" href="A_TZLX.aspx" data-transition='slide-out' runat="server">
          类型
        </a>
        <% End if %>
          <a class="button button-link button-nav pull-right" href="#MYNoticeList" data-transition='slide-out' id="A1" runat="server">
          已发
        </a>
        
      </header>   

<div class="content">
              


                  <div style="padding-right: 13px; padding-left: 13px;">
                     
                        <p><a href="#joinname" class="button button-fill" style="color: #FFFFFF; background-color: #4CD964;" ><i class="fa fa-pencil"></i> 发通知</a></p> 
                     
            </div>
              
                <%Dim rs As New ADODB.Recordset  %>
                <%rs = cPConn.Execute("select  * from [dbTZListView] where cPhoneNumber='" & Session("iphone") & "' and zDeptCode='" & Session("usercode") & "' and bDel='0' and ddate > DATEADD(month, -3, getDate()) order by dDate desc") %>

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
              
              <div class="item-text"><%=rs.Fields("cNR").Value%></div>
            </div>
          </a>
        </li>
       <% rs.MoveNext  %>
         <% Next %>

           <div style="padding-right: 13px; padding-left: 13px;">
                     
                        <%--<p><a href="#NoticeList1" class="button button-fill" style="color: #FFFFFF; background-color: #4CD964;" ><i class="fa fa-pencil"></i> 全部通知</a></p>--%> 
               <p><a href="#NoticeList1" class="button button-success">全部通知</a></p>
                     
            </div>
          <p style="padding-bottom: 10px"></p>


           <% Else %>
          <br /><br />
          <h4 style="text-align: center; color: #999999">没有通知</h4>

           <% End If %>



          </ul>
        </div>



       
    </div>


  
     </div>
         
        <div class="page" id='NoticeList1'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">通知</h1>
        <%If Session("Popdom") = "1"Then %>
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
              
              <div class="item-text"><%=rs.Fields("cNR").Value%></div>
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


        <%--选择通知成员--%>
        <div class="page" id='joinname'>

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#NoticeList" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">选择通知成员</h1>
    <a class="button button-link button-nav pull-right" data-transition='slide-out' id="" onclick="checkall();">
      确定
    </a>
  </header>   
      
      <div class="content"  style="top: 20px">
              <div class="list-block media-list">
                  
                                    <ul>

                               <li>
                                 <a href ="#GroupName">
                                <div class="item-link list-button" style="text-align: left">
                                    我的群<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                    <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"></div>
                                </div>
                                 </a>

                            </li>    
                      </ul>    
                  <ul><li class="list-group-title" style="font-size: 13px">全部成员</li> </ul>                    
                      <ul>
                     <li>
                        <label class="label-checkbox item-content" onclick ="">
                          <input type="checkbox" name="checkboxall" value ="" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title">全部成员</div>
                              <div class="item-after" style="font-size: small"></div>
                            </div>
                            
                            
                          </div>
                        </label>
                      </li>
                      
                      <li style="display :none">
                                 <a href ="#" onclick="checkboxall();">
                                <div class="item-link list-button" style="text-align: left">
                                    全部成员<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                    <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"></div>
                                </div>
                                 </a>

                            </li>


                      

                  </ul>



               
            <%rs = cPConn.Execute("select * from [DicUnit] where zDeptCode='" & Session("usercode") & "' order by cUnitCode ") %>

              <%If rs.RecordCount <> 0 Then %>
                   <ul><li class="list-group-title" style="font-size: 13px">部门</li> </ul>
                  <ul>
                <% For i = 1 To rs.RecordCount %>



                     <li>
                        <label class="label-checkbox item-content"  onclick="checklist();" >
                          <input type="checkbox" name="checkboxunit" value ="<%= rs.Fields("cUnitName").Value %>" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title"><%= rs.Fields("cUnitName").Value %></div><div id="bb<%=i%>" style="font-size: 12px"></div>
                              <div class="item-after" style="font-size: small; color: #FFFFFF;" id="b<%=i%>"><%= rs.Fields("cUnitCode").Value %><a href="#joinname1" onclick="classname('<%=rs.Fields("cUnitCode").Value %>','<%=i%>');" class="button">...</a></div>
                                <div id="bbb<%=i%>" style="display :none"></div>
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
            <%rs = cPConn.Execute("select * from [dbUserView] where zDeptCode='" & Session("usercode") & "' and cDeptJob=''  order by cClassName ") %>

              <%If rs.RecordCount <> 0 Then %>
                    <ul>
                <% For i = 1 To rs.RecordCount %>
              
                      <li>
                        <label class="label-checkbox item-content" onclick="checklist();">
                          <input type="checkbox" name="checkbox" value ="<%= rs.Fields("cClassName").Value  %>" />
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

        <%--选择通知部门成员--%>
        <div class="page" id='joinname1'>

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#joinname" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">选择通知成员</h1>

  </header>   
      
      <div class="content"  style="top: 20px">
              <div class="list-block" style="display:none">
            
        <ul>
          <!-- Text inputs -->
          <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_id" runat="server" placeholder=""></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
            </ul>
                  </div>





          <div class="list-block media-list">
                       <ul><li class="list-group-title" style="font-size: 13px">成员</li> </ul> 
            <ul>
              <div id="classname" runat="server"></div>
          </ul>
          </div>
                  
  
 </div>
      </div>

        <%--选择群成员--%>
        <div class="page" id='GroupName'>

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#NoticeList" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">选择群</h1>
    <a class="button button-link button-nav pull-right" data-transition='slide-out' id="" onclick="checkgroup();">
      确定
    </a>
  </header>   
      
      <div class="content"  style="top: 20px">
              
          <div class="list-block media-list">
                       <ul><li class="list-group-title" style="font-size: 13px">我的群</li> </ul> 
            
            <%rs = cPConn.Execute("select * from [dbGroupView] where zDeptCode='" & Session("usercode") & "' and cPhoneNumber='" & Session("iphone") & "'  order by cClassName ") %>

              <%If rs.RecordCount <> 0 Then %>
                    <ul>
                <% For i = 1 To rs.RecordCount %>
              
                      <li>
                        <label class="label-checkbox item-content" onclick="">
                          <input type="radio" name="checkgroup" value ="<%= rs.Fields("cGroupName").Value  %>" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title"><%= rs.Fields("cGroupName").Value %></div>
                              <div class="item-after" style="font-size: small; color: #FFFFFF;" id="c<%=i%>"><%= rs.Fields("cCode").Value %></div>
                            </div>
                            
                            
                          </div>
                        </label>
                      </li>
                       
                     <% rs.MoveNext  %>
                    <% Next %>
                  <% End If %>
                  </ul>
          
          </div>
                  
  
 </div>
      </div>

        <%--编辑通知内容--%>
        <div class="page" id='Notice'>
<div class="content">
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#NoticeList" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">编辑通知</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Save" runat="server">
      发送
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
          <li style="display:none">
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_Name" runat="server" placeholder="当前用户"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
           <li style="display:none">
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_UnitCode" runat="server" placeholder="部门编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
                     <li style="display:none">
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_Group" runat="server" placeholder="群标志"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
         <li style="display:none">
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_UserCode" runat="server" placeholder="成员编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
         <li style="display:none">
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_CalssCode" runat="server" placeholder="部门成员编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
            <li>
        <div class="item-content">
          <div class="item-media">发送至：</div>
          <div class="item-inner">
            <div class="item-input">
                <a href ="#joinname"><asp:TextBox ID="T_cJoinName" runat="server" placeholder="" Enabled="False"></asp:TextBox></a>

               
            </div>
          </div>
        </div>
      </li>
            <li>
        <div class="item-content">
          <div class="item-media">通知类型：</div>
          <div class="item-inner">
            <div class="item-input">
               <asp:TextBox ID="T_BT" runat="server" placeholder="输入标题" MaxLength="40"></asp:TextBox>
            </div>
          </div>
        </div>
      </li>




        <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="T_NR" runat="server" placeholder="输入内容..." TextMode="MultiLine" Height="150px" MaxLength="200"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
     </ul>
     
      <div class="sp-page-box" style=" padding-left: 10px; padding-top: 10px;">                         
                        <div class="sp-page-column span6">
                            
                            <div class="sp-page-column span5">
                                <span class="sp-upload">
                                    <img class="sp-upload-photo" data-url="" alt="" style="width: 85px; height: 25px;" />

                                    
                                    <%--<input class="sp-upload-img" type="file" id="imgOne" style="/* visibility: hidden */" capture="camera" accept="image/*,video/*" name="imgOne" value="图片" onchange="preImg(this.id,'imgPre');" />--%>
                                    <input class="sp-upload-img" id="imgOne" type="file" name="imgOne" value="图片" onchange="preImg(this.id,'imgPre');"/>
                                </span>
                            </div>
                        </div>
                    </div>





      <div style="padding: 0px 10px 0px 10px; width: 100%;">
          <a href="#" class="button button-light" id="test" style="display: none;">测试</a>

          
</div>
      <div style="padding: 0px 10px 0px 10px;">
        <a href="#" class="button button-light" id="Del" style="display: none;">清除</a>
      </div>      
<img id="imgPre" src="" style="padding: 10px; display: block; width: 100%; height: auto;" /> 


  
  </div>

        
    </div>

      </div>

        <%--查看通知内容，（个人）删除通知--%>
        <div class="page" id='NoticeView'>
    
         
  <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#NoticeList" data-no-cache="true" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">通知详情</h1>
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
                  <asp:TextBox ID="T_NR1" runat="server" placeholder="输入内容..." TextMode="MultiLine"  MaxLength="200" Enabled="False"></asp:TextBox>
              
              <div align="center" style="padding-bottom: 10px">
            <img id="imgPre2" src="" style="display: block; width: 50%; height: auto;" /> 
            </div>            
              
              </div>
            </div>
          </div>

</li>

    </ul>
  
    <div class="buttons-tab fixed-tab" data-offset="44">
    <a href="#tab1" class="tab-link active button" id="view5">评论<div id="view6"></div></a>
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

        <%--个人发送的通知列表--%>
        <div class="page" id='MYNoticeList'>
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#NoticeList" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">我发的通知</h1>
     <a class="button button-link button-nav pull-right" href="#joinname" data-transition='slide-out' id="A2" runat="server">
      新建
    </a>
  </header>
          
<div class="content"> 

            
            <%rs = cPConn.Execute("select * from [dbTZView] where cJoinName='" & Session("iphone") & "' and cPhoneNumber='' order by dDate desc") %>

              <%If rs.RecordCount <> 0 Then %>


              <% For i = 1 To rs.RecordCount %>
        
            <%Dim re As New ADODB.Recordset  %>
            <%Dim cJoinName As String = "" %>
            <%re = cPConn.Execute("Select top 1 * from dbTZListView where cCode='" & rs.Fields("cCode").Value & "'") %>
            <%If re.RecordCount <> 0 Then %>
            <% For j = 1 To re.RecordCount %>
                <% cJoinName = IIf(IsDBNull(re.Fields("cBZ").Value), "", re.Fields("cBZ").Value)  %>
                <% re.MoveNext  %>
            <%Next %>
            <%End if %>




                  <div class="card">
        
          <a href ="#NoticeEdit" onclick="EditNotice('<%=rs.Fields("cCode").Value%>','<%=rs.Fields("cBT").Value%>','<%=rs.Fields("cNR").Value %>','<%=cJoinName  %>','<%=rs.Fields("cURL").Value  %>');">
                  <div class="card-content">
        
          <div class="list-block media-list">
            <ul>
              <li class="item-content">
              
                <div class="item-inner">
                  <div class="item-title-row">
                    <div class="item-title" style="color: #000000;font-size:14px;"><%=rs.Fields("cBT").Value  %></div><div style="font-size: small; color: #C0C0C0;"><%=Format(rs.Fields("dDate").Value, "MM-dd HH:mm")  %></div>
                  </div>
                  <div class="item-subtitle" style="font-size:14px;"><%=rs.Fields("cNR").Value  %></div>
                </div>
              </li>
            </ul>
          </div>
        </div></a>
        <div class="card-footer">
            
            <%re = cPConn.Execute("select cCode,count(cCode) as number from [dbTZListView] where cCode='" & rs.Fields("cCode").Value & "' and cPL<>'' group by cCode") %>
            <%If re.RecordCount <> 0 Then %>
            <span style="font-size: small; color: #C0C0C0;">回复 <%=re.Fields("number").Value  %></span>
            <%else %>
            <span style="font-size: small; color: #C0C0C0;">回复 0</span>
            <% End If %>



            <%re = cPConn.Execute("select cCode,count(cCode) as number from [dbTZListView] where cCode='" & rs.Fields("cCode").Value & "' and bView='1' group by cCode") %>
            <%If re.RecordCount <> 0 Then %>
            <span style="font-size: small; color: #C0C0C0;">已看 <%=re.Fields("number").Value  %></span>
            <%else %>
            <span style="font-size: small; color: #C0C0C0;">已看 0</span>
            <% End If %>
            <%re = cPConn.Execute("select cCode,count(cCode) as number from [dbTZListView] where cCode='" & rs.Fields("cCode").Value & "' and bView='0' and cPL='' group by cCode") %>
            <%If re.RecordCount <> 0 Then %>
            <span style="font-size: small; color: #C0C0C0;">未看 <%=re.Fields("number").Value  %></span><div class="col-50"><a href="#" onclick="SendTX('<%=rs.Fields("cCode").Value%>','<%=rs.Fields("cBT").Value  %>','<%=Session("name") %>');" style="font-size: 13px; color: #0894EC;" class="button">提醒</a></div>
            <% Else %>
            <span style="font-size: small; color: #C0C0C0;">未看 0</span>
            <% End If %>
        
      
      
        </div>
      </div>


       <% rs.MoveNext  %>
         <% Next %>

           <% else %>
          <br /><br />
          <h4 style="text-align: center; color: #999999">没有通知</h4>

       <% End If %>

        </div>


    </div>            

        <%--编辑通知，删除和重新编辑后发送通知--%>
        <div class="page" id='NoticeEdit'>
    
        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#MYNoticeList" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">编辑通知</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Save2" runat="server">
          重新发送
        </a>
                    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Del2" runat="server">
          删除
        </a>

      </header> 
       <div class="content"   style="top: 20px">   
    
      <div class="list-block">

            <ul>
              <!-- Text inputs -->
              <li style="display:none">
              <div class="item-content">
                <div class="item-inner">
              
                  <div class="item-input" >
                      <asp:TextBox ID="T_Code2" runat="server" placeholder="系统编码"></asp:TextBox>
                  </div>
                </div>
              </div>
              </li>
                <li>
            <div class="item-content">
              <div class="item-media">发送至：</div>
              <div class="item-inner">
                <div class="item-input">
                    <a href ="#"><asp:TextBox ID="T_cJoinName2" runat="server" placeholder="" Enabled="False"></asp:TextBox></a>

               
                </div>
              </div>
            </div>
          </li>
                <li>
            <div class="item-content">
              <div class="item-media">标题：</div>
              <div class="item-inner">
                <div class="item-input">
                   <asp:TextBox ID="T_BT2" runat="server" placeholder="输入标题" MaxLength="40"></asp:TextBox>
                </div>
              </div>
            </div>
          </li>




            <li>
              <div class="item-content">
                <div class="item-inner">
              
                  <div class="item-input">
                      <asp:TextBox ID="T_NR2" runat="server" placeholder="输入内容..." TextMode="MultiLine" Height="150px" MaxLength="200"></asp:TextBox>
                  </div>
                </div>
              </div>
            </li>
        </ul>

                <div class="sp-page-box" style=" padding-left: 10px; padding-top: 10px;">                         
                        <div class="sp-page-column span6">
                            
                            <div class="sp-page-column span5">
                                <span class="sp-upload">
                                    <img class="sp-upload-photo" data-url="" alt="" style="width: 85px; height: 25px;" />

                                    
                    <%--<input class="sp-upload-img" type="file" id="imgOne1" style="/* visibility: hidden */" capture="camera" accept="image/*,video/*" name="imgOne" value="图片" onchange="preImg(this.id,'imgPre1');" />--%>
                    <input class="sp-upload-img" id="imgOne1" type="file" name="imgOne1" value="图片" onchange="preImg(this.id,'imgPre1');"/>

                                </span>
                            </div>
                        </div>
                    </div>





                <div style="padding: 0px 10px 0px 10px; width: 100%;">
<%--<input class="button button-light" type="file" id="imgOne1" style="/* visibility: hidden */" capture="camera" accept="image/*,video/*" name="imgOne" value="图片" onchange="preImg(this.id,'imgPre1');" />--%>
<%--<input type="file" id="imgOne" runat="server" name="imgOne" value="图片" onchange="preImg(this.id,'imgPre');" />--%>
          
</div>
      <div style="padding: 0px 10px 0px 10px;">
        <a href="#" class="button button-light" id="Del1" style="display: none;">清除</a>
          
      </div>      
<img id="imgPre1" src="" style="padding: 10px; display: block; width: 100%; height: auto;" /> 


      </div>

    </div>
          </div>

    
         </div>    
        
    

        
        
        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
        <script src="js/lrz.all.bundle.js"></script>
        <script src="js/canvas-to-blob.min.js"></script>
        
        <script type="text/javascript">
            $(document).on("pageInit", function (e, pageId, $page) {
                if (pageId == "NoticeView") {
                    var cCode = document.getElementById("T_Code1").value;

                    //$.showPreloader();
                    //setTimeout(function () {
                    //    $.hidePreloader();
                    //}, 500);

                    //返回查看情况
                    returnview();
                    //返回评论
                    returnPL();
                    //返回收件人
                    returnuser();
                       
                    //$.toast("设置页面");
                }
                else if (pageId == "Notice") {
                    
                    var TZLXname;
                    setTZLX();
                function setTZLX() {
                    var data = "{str1:'" + TZLXname + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Notice.aspx/ReturnTZLX", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "error") {
                                TZLXname = JSON.parse(data.d);
                                setaa();
                            }



                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                    return false; //禁用按钮的提交

                    function setaa() {
     
                        $("#T_BT").picker({

                            toolbarTemplate: '<header class="bar bar-nav">\
  <button class="button button-link pull-left"></button>\
  <button class="button button-link pull-right close-picker">确定</button>\
  <h1 class="title">选择通知类型</h1>\
  </header>',
                            cols: [
                              {
                                  textAlign: 'center',
                                  values: TZLXname
                              }
                            ]
                        });
                    };

                };
                }
                else if (pageId == "joinname") {

                    var checkboxclass = document.getElementsByName("checkboxclass");
                    var cClassCode = '';
                    var cClassName = '';

                    for (var i = 0; i < checkboxclass.length; i++) {
                        if (checkboxclass[i].checked === true) {
                            cClassCode = cClassCode + checkboxclass[i].value + ';';
                            cClassName = cClassName + document.getElementById('d' + (i + 1)).innerText + ';';
                        }
                    }

                    if (cClassName != '') {
                        var i;
                        i = document.getElementById("T_id").value;

                        document.getElementById('bb' + i).innerText = cClassCode;
                        document.getElementById('bbb' + i).innerText = cClassName;

                    }
                    else {
                        var i;
                        i = document.getElementById("T_id").value;
                        if (i != '') {
                        document.getElementById('bb' + i).innerText = '';
                        document.getElementById('bbb' + i).innerText = '';                            
                        }

                    }

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
/** 
* 从 file 域获取 本地图片 url 
*/ 
function getFileUrl(sourceId) { 
var url; 
if (navigator.userAgent.indexOf("MSIE")>=1) { // IE 
    url = document.getElementById(sourceId).value;
} else if(navigator.userAgent.indexOf("Firefox")>0) { // Firefox 
url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
} else if(navigator.userAgent.indexOf("Chrome")>0) { // Chrome 
url = window.URL.createObjectURL(document.getElementById(sourceId).files.item(0)); 
} 
return url; 
} 

/** 
* 将本地图片 显示到浏览器上 
*/ 
function preImg(sourceId, targetId) { 
var url = getFileUrl(sourceId); 
var imgPre = document.getElementById(targetId); 
imgPre.src = url;



if (targetId == "imgPre") {
    $("#Del").css("display", "block");

    if ($("#Del").css("display") === "block") {
        var reader = new FileReader();
        reader.readAsDataURL($('#imgOne')[0].files[0]);
        reader.onload = function (evt) {
            document.getElementById('imgPre').src = evt.target.result;
        }
    }


}
else if(targetId == "imgPre1"){
    $("#Del1").css("display", "block");

    if ($("#Del1").css("display") === "block") {
        var reader = new FileReader();
        reader.readAsDataURL($('#imgOne1')[0].files[0]);
        reader.onload = function (evt) {
            document.getElementById('imgPre1').src = evt.target.result;
        }
    }


}


} 
</script>
        <script type="text/javascript">
        $(function () {
            $("#test").click(function () {
                Upload();
            })
        })
        </script>
        <script type="text/javascript">
        $(function () {
            $("#Del").click(function () {
                document.getElementById('imgOne').value = "";
                document.getElementById('imgPre').src = "";

                $("#Del").css("display", "none");
            })
        })
        $(function () {
            $("#Del1").click(function () {
                document.getElementById('imgOne1').value = "";
                document.getElementById('imgPre1').src = "";

                $("#Del1").css("display", "none");
            })
        })


        function Upload() {

            if (document.getElementById('imgOne').value != '') {              

                lrz($('#imgOne')[0].files[0], { width: 500 })
               
                .then(function (rst) {

                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "A_Upload.aspx");
                    // 添加参数
                    rst.formData.append('fileLen', rst.fileLen);
                    //rst.formData.append('xxx', '我是其他参数');

                    // 触发上传
                    xhr.send(rst.formData);

                    return rst;
                });
            }
        }


        function Upload1() {

            if (document.getElementById('imgOne1').value != '') {

                

                    lrz($('#imgOne1')[0].files[0], { width: 500 })

                    .then(function (rst) {

                        var xhr = new XMLHttpRequest();
                        xhr.open("POST", "A_Upload.aspx");
                        // 添加参数
                        rst.formData.append('fileLen', rst.fileLen);
                        //rst.formData.append('xxx', '我是其他参数');

                        // 触发上传
                        xhr.send(rst.formData);

                        return rst;
                    });
 
                
                //var reader = new FileReader();
                //reader.readAsDataURL($('#imgOne1')[0].files[0]);
                //reader.onload = function (evt) {
                //    document.getElementById('imgPre1').src = evt.target.result;
                //}
                    //test1();
                    //var xhr = new XMLHttpRequest();
                    //var formData = new FormData();
                    //formData.append('file', $('#imgOne1')[0].files[0]);

                    //xhr.open("POST", "A_Upload.aspx");

                    //xhr.onreadystatechange = function () {
                    //    if (xhr.readyState == 4 && xhr.status == 200) {

                    //        alert('上传成功')

                    //    }
                    //}

                    //xhr.send(formData);

                }
            };

</script>
        

        <script type="text/javascript">
            //下拉刷新页面
            $(document).on("pageInit", "#NoticeList", function (e, id, page) {
                var $content = $(page).find(".card").on('refresh', function (e) {
                    // 模拟2s的加载过程
                    setTimeout(function () {
                        var cardHTML = '<div class="card">' +
                          '<div class="card-header">标题</div>' +
                          '<div class="card-content">' +
                          '<div class="card-content-inner">内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容' +
                          '</div>' +
                          '</div>' +
                          '</div>';

                        $content.find('.card-container').prepend(cardHTML);
                        // $(window).scrollTop(0);
                        // 加载完毕需要重置
                        $.pullToRefreshDone($content);
                    }, 2000);
                });
            });

              </script>
        <script type="text/javascript">
            function checkboxall() {
                var checkbox = document.getElementsByName("checkbox");
                var checkboxall = document.getElementsByName("checkboxall");
                document.getElementById("T_cJoinName").value = '全部成员';
                $.router.load("#Notice");

                //if (checkboxall[0].checked==true) {
                //    for (var i = 0; i < checkbox.length; i++) {
                //        checkbox[i].checked = true;

                //        $.router.load("#Notice");
                //    }
                    
                //}
                //else {
                //    for (var i = 0; i < checkbox.length; i++) {
                //        checkbox[i].checked = false;

                //    }
                    
                //}

            }
            function checklist() {
                var checkboxall = document.getElementsByName("checkboxall");
                checkboxall[0].checked = false;
            }

            function checkclassname() {
                var checkboxclass = document.getElementsByName("checkboxclass");
                var cClassCode='';
                var cClassName='';
                

                for (var i = 0; i < checkboxclass.length; i++) {
                    if (checkboxclass[i].checked === true) {
                        cClassCode = cClassCode + checkboxclass[i].value + ';';
                        cClassName = cClassName + document.getElementById('d' + (i + 1)).innerText + ';';




                    }
                }
                document.getElementById("T_CalssCode").value = cClassName;

            }

            function checkall() {
                var cCode = '';
                var cName = '';
                var cUnitCode = '';
                var cUnitName = '';
                var bAll = true;
                var checkbox = document.getElementsByName("checkbox");
                var checkboxunit = document.getElementsByName("checkboxunit");
                var checkboxall = document.getElementsByName("checkboxall");

                if (checkboxall[0].checked === true) {

                    document.getElementById("T_cJoinName").value = '全部成员';
                    document.getElementById("T_Group").value = ''
                    $.router.load("#Notice");

                }
                else {


                

                for (var i = 0; i < checkbox.length; i++) {
                    if (checkbox[i].checked === true) {
                        
                        bAll = false;
                        break;
                    }
                }
                for (var i = 0; i < checkboxunit.length; i++) {
                    if (checkboxunit[i].checked === true || document.getElementById('bb' + (i + 1)).innerText!='') {

                        bAll = false;
                        break;
                    }
                }


                if (bAll) {
                    $.toast("请选择成员");
                }
                else {

                    for (var i = 0; i < checkboxunit.length; i++) {
                        if (checkboxunit[i].checked === true) {
                            cUnitCode = cUnitCode + checkboxunit[i].value + ';';
                            cUnitName = cUnitName + document.getElementById('b' + (i + 1)).innerText + ';';


                        }
                        else {
                            if (document.getElementById('bb' + (i + 1)).innerText!='') {
                                cUnitCode = cUnitCode + document.getElementById('bb' + (i + 1)).innerText;
                            }
                            if (document.getElementById('bbb' + (i + 1)).innerText != '') {
                                cUnitName = cUnitName + document.getElementById('bbb' + (i + 1)).innerText;
                            }

                            

                        }
                    }

                    for (var i = 0; i < checkbox.length; i++) {
                        if (checkbox[i].checked === true) {
                            cCode = cCode + checkbox[i].value + ';';
                            cName = cName + document.getElementById('a' + (i + 1)).innerText + ';';


                        }
                    }





                    //$.toast(cCode);
                    document.getElementById("T_cJoinName").value = cUnitCode + cCode;
                    document.getElementById("T_Group").value = ''
                    $.router.load("#Notice");
                }
                    }
            }

            function checkgroup() {
                var cCode = '';


                var checkgroup = document.getElementsByName("checkgroup");
                
                for (var i = 0; i < checkgroup.length; i++) {
                    if (checkgroup[i].checked === true) {
                        cCode = checkgroup[i].value;
                        break;
                    }
                }

                if (cCode != '') {

                    document.getElementById("T_cJoinName").value = cCode;
                    document.getElementById("T_Group").value = '群';
                    $.router.load("#Notice");
                    
                }
                else{
                    $.toast("请选择群");
                
                }
            }




            </script>
        <script type="text/javascript">
            $("#but_Save").click(function () {
            var cBT,cNR,cName,cUnit,cUserName,cGroup,cGroupName;
            var checkbox = document.getElementsByName("checkbox");
            var checkboxunit = document.getElementsByName("checkboxunit");
            var checkgroup = document.getElementsByName("checkgroup");

            cBT = document.getElementById("T_BT").value;
            cNR = document.getElementById("T_NR").value;

            cUserName = document.getElementById("T_Name").value;

            cName = '';
            cUnit = '';
            

            var myDate = new Date();
            var wxData = {
               
                "data": {
                    "first": {
                        "value": "通知提醒",
                        "color": "#FF0000"
                    },
                    "keyword1": {
                        "value": "" + cBT + "",
                        "color": "#173177"
                    },
                    "keyword2": {
                        "value": "" + cUserName + "",
                        "color": "#173177"
                    },
                    "keyword3": {
                        "value": "" + myDate.toLocaleDateString() + " " + myDate.getHours() + ":" + myDate.getMinutes()  + "",
                        "color": "#173177"
                    },
                    "remark": {
                        "value": "点击详情，系统自动反馈通知人已收到并查看通知！",
                        "color": "#FF0000"
                    }
                }
            }







            if (cBT == '') {

                $.toast("请输入标题");
            }
            else if (cNR == '') {
                $.toast("请输入内容");
            }

            else {

                for (var i = 0; i < checkboxunit.length; i++) {
                    if (checkboxunit[i].checked === true) {

                        cUnit = cUnit + document.getElementById('b' + (i + 1)).innerText.substring(0,15) + ';';


                    }
                }

                for (var i = 0; i < checkbox.length; i++) {
                    if (checkbox[i].checked === true) {
                        
                        cName = cName + document.getElementById('a' + (i + 1)).innerText + ';';
                        
                        
                    }
                    else{
                        if (document.getElementById('bbb' + (i + 1)).innerText != ''){
                        cName = cName + document.getElementById('bbb' + (i + 1)).innerText;
                        }
                    }
                }


                for (var i = 0; i < checkgroup.length; i++) {
                    if (checkgroup[i].checked === true) {

                        cGroup = document.getElementById('c' + (i + 1)).innerText + ';';
                        cGroupName = checkgroup[i].value;

                    }
                }


                if (document.getElementById("T_cJoinName").value == '全部成员') {
                    //如果不是向全部成员发送的时候调用
                    
                    SaveAll();
                    
                }
                else if (document.getElementById("T_Group").value == '群') {
                    //向群发送的时候调用
                    
                    SaveGroup();
                    
                }
                else {
                    //向全体成员发送的时候调用
                    
                    Save();
                    
                }
           
            }


      
            function Save() {
                $(function () {
                    var cUser;
                    cUser = document.getElementById("T_cJoinName").value;

                    var data = "{str1:'" + cBT + "',str2:'" + cNR + "',str3:'" + cName + "',str4:'" + cUnit + "',str5:'" + cUser + "',str6:'" + JSON.stringify(wxData) + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Notice.aspx/Save", //方法所在页面和方法名
                    contentType: "application/json; charset=utf-8",
                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d === "保存成功") {
                            //$.toast("发布成功");
                            //self.location = 'A_Notice.aspx';

                            if (document.getElementById('imgOne').value != '') {
                                Upload();
                                $.showIndicator();
                                setTimeout(function () {
                                    $.hideIndicator();
                                    $.toast("发布成功");
                                    self.location = 'A_Notice.aspx';
                                }, 3000)

                            }
                            else {
                                $.toast("发布成功");
                                self.location = 'A_Notice.aspx';
                            }
                        } //if的尾括号
                    },
                    error: function (err) {
                        //alert(err);
                    }
                });
                return false; //禁用按钮的提交

            });

            };

            function SaveAll() {

                $(function () {
                    var data = "{str1:'" + cBT + "',str2:'" + cNR + "',str3:'" + JSON.stringify(wxData) + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Notice.aspx/SaveAll", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "保存成功") {

                                if (document.getElementById('imgOne').value != '') {
                                    Upload();
                                    $.showIndicator();
                                    setTimeout(function () {
                                        $.hideIndicator();
                                        $.toast("发布成功");
                                        self.location = 'A_Notice.aspx';
                                    }, 3000)

                                }
                                else {
                                    $.toast("发布成功");
                                    self.location = 'A_Notice.aspx';
                                }
                            } //if的尾括号
                        },
                        error: function (err) {
                            //alert(err);
                        }
                    });
                    return false; //禁用按钮的提交

                });

            };
            function SaveGroup() {

                $(function () {
                    var data = "{str1:'" + cBT + "',str2:'" + cNR + "',str3:'" + cGroup + "',str4:'" + cGroupName + "',str5:'" + JSON.stringify(wxData) + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Notice.aspx/SaveGroup", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "保存成功") {
                                //$.toast("发布成功");
                                //self.location = 'A_Notice.aspx';

                                if (document.getElementById('imgOne').value != '') {
                                    Upload();
                                $.showIndicator();
                                setTimeout(function () {
                                    
                                    $.hideIndicator();
                                    $.toast("发布成功");
                                    self.location = 'A_Notice.aspx';
                                }, 3000)

                                }
                                else {
                                    $.toast("发布成功");
                                    self.location = 'A_Notice.aspx';
                                }

                                



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
    })
            
</script>
        <script type="text/javascript">
            function View(cListCode,cBT,cNR,cName,cDate,cBZ,cURL) {
                document.getElementById("T_Code1").value = cListCode;
                document.getElementById("T_BT1").value = cBT;
                document.getElementById("T_NR1").value = cNR.replace('.', '\n');
                document.getElementById('name').innerText = cName + '（' + cDate + '）';
                document.getElementById("T_cJoinName1").innerText = cBZ;
                document.getElementById('imgPre2').src =  cURL;
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
                    function SendTX(cCode, cBT, cName) {

                    $(function () {
                        var data = "{str1:'" + cCode + "',str2:'" + cBT + "',str3:'" + cName + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Notice.aspx/SendTX", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                
                                if (data.d === "成功") {

                                    $.toast("发送成功");
                                   

                                }//if的尾括号



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
                          self.location = 'A_Notice.aspx';
                          //$.router.load('A_Notice.aspx', true)
                         
                      }
                      else if (data.d === "已经删除") {
                          $.toast("已经删除");
                          self.location = 'A_Notice.aspx';
                          //$.router.load('A_Notice.aspx', true)
                          
                      
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
          function EditNotice(cCode, cBT, cNR, cName,cURL) {
              
              document.getElementById("T_Code2").value = cCode;
              document.getElementById("T_BT2").value = cBT;
              document.getElementById("T_NR2").value = cNR.replace('.', '\n');
              document.getElementById('T_cJoinName2').value = cName;
              document.getElementById('imgPre1').src = cURL;
              if (cURL != '') {
                  $("#Del1").css("display", "block");
              }
              //$.toast("内容");
              //ViewNotice();

              function ViewNotice() {

                  $(function () {
                      var data = "{str1:'" + cListCode + "'}";
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
            $("#but_Save2").click(function () {
                var cCode,cBT, cNR, cName;
                
                cCode = document.getElementById("T_Code2").value;
                cBT = document.getElementById("T_BT2").value;
                cNR = document.getElementById("T_NR2").value;
                cName = '';

                if (cBT == '') {

                    $.toast("请输入标题");
                }
                else if (cNR == '') {
                    $.toast("请输入内容");
                }

                else {
                    
                    Save();

                }


                function Save() {
                    //判断是否有图片
                    if ($("#Del1").css("display") == "block") {
                        bImg = 'block';
                    }
                    else {
                        bImg = '';
                    }
                    //var bImg = JSON.stringify(document.getElementById('imgPre1').src);

                    $(function () {
                        var data = "{str1:'" + cBT + "',str2:'" + cNR + "',str3:'" + cCode + "',str4:'" + bImg + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Notice.aspx/Save2", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    if ($("#Del1").css("display") == "block") {
                                        Upload1();
                                        $.showIndicator();
                                        setTimeout(function () {
                                            $.hideIndicator();
                                            $.toast("修改成功");
                                            self.location = 'A_Notice.aspx';
                                        }, 3000)

                                    }
                                    else {
                                        $.toast("修改成功");
                                        self.location = 'A_Notice.aspx';
                                    }




                                    //$.toast("修改成功");
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
            })

</script>
        <script type="text/javascript">
            $("#but_Del2").click(function () {
                var cCode;
                cCode = document.getElementById("T_Code2").value;
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
                            url: "A_Notice.aspx/Del2", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "删除成功") {

                                    $.toast("删除成功");
                                    self.location = 'A_Notice.aspx';
                                    //$.router.load('A_Notice.aspx', true)

                                }
                                else if (data.d === "已经删除") {
                                    $.toast("已经删除");
                                    self.location = 'A_Notice.aspx';
                                    //$.router.load('A_Notice.aspx', true)


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

         <script>
             function classname(deptcode,id) {

                $(function () {
                    var data = "{str1:'" + deptcode + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Notice.aspx/return_classname", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "失败") {
                                document.getElementById("T_id").value = id;
                                $("#classname").html(data.d);
                                //$.toast("发布成功");
                                //self.location = 'A_Notice.aspx';
                                //$.router.load('A_Notice.aspx', true)
                                //$.router.load("#NoticeList",true);
                            }
                            else {
                                document.getElementById("T_id").value = '';
                                $("#classname").html('');
                            }

                            //if的尾括号
                        },
                        error: function (err) {
                            //alert(err);
                        }
                    });
                    return false; //禁用按钮的提交

                });

            };


        </script>
        <script>
            function Upload4() {
                var eleFile = document.querySelector('#imgOne');

                // 压缩图片需要的一些元素和对象
                var reader = new FileReader();
                var url = document.getElementById('imgOne').value;
                var img = document.getElementById('imgPre');
                
                //img = document.getElementById('imgPre');
                // 选择的文件对象
                var file = null;

                // 缩放图片需要的canvas
                var canvas = document.createElement('canvas');
                var context = canvas.getContext('2d');

                // base64地址图片加载完毕后
                //img.onload = function () {
                    // 图片原始尺寸
                    var originWidth = this.width;
                    var originHeight = this.height;
                    // 最大尺寸限制
                    var maxWidth = 400, maxHeight = 400;
                    // 目标尺寸
                    var targetWidth = originWidth, targetHeight = originHeight;
                    // 图片尺寸超过400x400的限制
                    if (originWidth > maxWidth || originHeight > maxHeight) {
                        if (originWidth / originHeight > maxWidth / maxHeight) {
                            // 更宽，按照宽度限定尺寸
                            targetWidth = maxWidth;
                            targetHeight = Math.round(maxWidth * (originHeight / originWidth));
                        } else {
                            targetHeight = maxHeight;
                            targetWidth = Math.round(maxHeight * (originWidth / originHeight));
                        }
                    }

                    // canvas对图片进行缩放
                    canvas.width = 400;
                    canvas.height = 400;

                    targetWidth = 400;
                    targetHeight = 400;
                    // 清除画布
                    context.clearRect(0, 0, targetWidth, targetHeight);
                // 图片压缩
                    
                    context.drawImage(img, 0, 0, targetWidth, targetHeight);
                    // canvas转为blob并上传
                    canvas.toBlob(function (blob) {
                        // 图片ajax上传
                        var xhr = new XMLHttpRequest();
                        // 文件上传成功
                        xhr.onreadystatechange = function () {
                            if (xhr.status == 200) {
                                // xhr.responseText就是返回的数据
                            }
                        };
                        // 开始上传
                        xhr.open("POST", 'A_Upload.aspx', true);
                        xhr.send(blob);
                    }, file.type || 'image/png');
                //};

                //// 文件base64化，以便获知图片原始尺寸
                //reader.onload = function (e) {
                //    img.src = e.target.result;
                //};
                //eleFile.addEventListener('change', function (event) {
                //    file = event.target.files[0];
                //    // 选择的文件是图片
                //    if (file.type.indexOf("image") == 0) {
                //        reader.readAsDataURL(file);
                //    }
                //});
            }
            </script>
        </form> 
  </body>
</html>
