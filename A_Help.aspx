<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Help.aspx.vb" Inherits="A_Help" %>

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
    <form id="form1" runat="server">
    
    
       
    <div class="page-group">
        <div class="page  page-current" id='HelpList1'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">解答</h1>
         
          <a class="button button-link button-nav pull-right" href="#joinname" data-transition='slide-out' id="A1" runat="server">
          求助报修
        </a>
        
      </header>   
<div class="content">
    <div style="padding: 10px 12px 0px 12px;">
        <div class="row">
        <div class="col-50">
        <a href="#HelpList3" onclick="" class="button button-light" id="Del"><i class="fa fa-pencil-square-o"></i> 我的回答</a>   
            </div>
                <div class="col-50">
        <a href="#HelpList2" onclick="" class="button button-light" id="Del1"><i class="fa fa-question"></i> 我的求助</a>   
            </div>
            </div>
      </div> 
    <%Dim rs, re As New ADODB.Recordset  %>
                    <%rs = cPConn.Execute("select * from [dbQKListView] where cPhoneNumber='" & Session("iphone") & "' and zDeptCode='" & Session("usercode") & "' and bDel='0' and bView<>'1' order by dDate desc") %>

                  <%If rs.RecordCount <> 0 Then %>

                     <% For i = 1 To rs.RecordCount %>

<div class="card facebook-card" id="<%=rs.Fields("cCode").Value%>">
    <a href ="#HelpList1-1" onclick="returnHelp('<%=rs.Fields("cCode").Value%>','<%=rs.Fields("cBT").Value%>','<%=rs.Fields("cNR").Value%>','2','<%=rs.Fields("cListCode").Value%>','<%=rs.Fields("cURL").Value%>');" >
    <div class="card-content">
              <div class="facebook-avatar" style="padding-top: 10px; padding-left: 10px">
          <div style="width:0.9rem; height:0.9rem; border-radius:50%; overflow:hidden;">
          <img src="<%= rs.Fields("wxheadimgurl").Value  %>" style='width: 0.9rem;'></div></div>
      <div class="facebook-name" style="padding-top: 10px; font-size: 13px; color: #999999;">来自你可能感兴趣的问题</div>
                                <div class="card-content-inner">
                          
                          <div style="font-family: 黑体; font-size: 15px;"><%=rs.Fields("cBT").Value%></div>
                            
                        </div>
    </div></a>
    <div class="card-footer no-border">
        <%re = cPConn.Execute("Select count(cListCode) as number from dbQKListView where cCode='" & rs.Fields("cCode").Value & "' and cPL='' group by cCode") %>

                        <div style="color: #666666; font-size: 13px" id="GZ1"><%=re.Fields("number").Value %>人关注</div>
                        <div class="row">
      <div class="col-50"><a href="#" onclick="HL('<%=rs.Fields("cCode").Value%>');"  style="font-size: 14px" class="button button-dark">忽略</a></div>
      <div class="col-50"><a href="#HD" onclick="HD('<%=rs.Fields("cBT").Value%>','<%=rs.Fields("cListCode").Value%>');"  style="font-size: 14px; color: #0894EC;" class="button">回答</a></div>
    </div>
                        
    </div>
  </div>



                     <% rs.MoveNext  %>
                    <% Next %>
                    <%End if %>



    </div>
  
     </div>

        <div class="page" id='HelpList1-1'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#HelpList1" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">问题详情</h1>
         
          <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Del" runat="server" style="display:none">
          删除
        </a>
         <a class="button button-link button-nav pull-right" href="#HD" data-transition='slide-out' id="but_HD" runat="server" style="display:none"> 
          
        </a>
         <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_HL" runat="server" style="display:none">
          
        </a>
      </header>   
<div class="content">
                      


<div class="card facebook-card">

    <div class="card-content">

      
                                <div class="card-content-inner">
                          
                          <div style="font-family: 黑体; font-size: 16px;" id="BT"></div>
                            <div style="color: #999999; font-size: 13px" id="NR"></div>
                                                  <div align="center" style="padding-bottom: 10px">
            <img id="imgPre2" src="" style="display: block; width: 50%; height: auto;" /> 
            </div>
                        </div>
    </div>
    <div class="card-footer no-border">
                        <div style="color: #666666; font-size: 13px" id="GZ">关注</div>
                        <div class="row">
      
      <div class="col-100"><a href="#HD" id="but_HD1" style="font-size: 14px; color: #0894EC;" class="button">添加回答</a></div>
                           
    </div>
                        
    </div>

  </div>
    <div class="list-group-title" style="font-size: 13px; color: #808080; padding-left: 15px;" id="HDNumber">0个回答</div>
    
    <div id="HDList">





        </div>
    
 

              <div class="list-block" style="display:none">

        <ul>
          <!-- Text inputs -->
          <li>
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
              
              <div class="item-input" >
                  <asp:TextBox ID="T_CodeList1" runat="server" placeholder="系统编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
            </ul>
              </div>

    </div>
  
     </div>

        <div class="page" id='HelpList1-2'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#HelpList1-1" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">解答详情</h1>
         
          <a class="button button-link button-nav pull-right" href="#joinname" data-transition='slide-out' id="A5" runat="server">
          
        </a>
        
      </header>   
<div class="content">
                      


<div class="card facebook-card">

    <div class="card-content">

      
                                <div class="card-content-inner">
                          
                          <div style="font-family: 黑体; font-size: 16px;">中中中加右右历啡中右可加中百右右右右！？</div>
                            <div style="color: #999999; font-size: 13px; padding-right: 10px; text-align: right;">查看全部回答 ></div>
                        </div>
    </div>


  </div>
   
    <div class="card facebook-card">
    
    <div class="card-content">
              <div class="facebook-avatar" style="padding-top: 10px; padding-left: 10px">
          <div style="width:0.9rem; height:0.9rem; border-radius:50%; overflow:hidden;">
          <img src="" style='width: 0.9rem;'></div></div>
      <div class="facebook-name" style="padding-top: 10px; font-size: 13px; color: #999999;">来自你</div>
                                <div class="card-content-inner">
                          <div style="color: #333333; font-size: 13px;">中中中加右右历啡中右可加中百右右右右！？</div>
                          <div style="color: #999999; font-size: 13px; text-align: right; padding-right: 10px;">发布于22:34</div>
                            
                        </div>
    </div>
    
  </div>



    </div>
  
     </div>

        

        <div class="page" id='HelpList2'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#HelpList1" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">求助解答</h1>
         
          <a class="button button-link button-nav pull-right" href="#joinname" data-transition='slide-out' id="A2" runat="server">
          
        </a>
        
      </header>   
        <div class="content pull-to-refresh-content" data-ptr-distance="55">
                            <!-- 默认的下拉刷新层 -->
            <div class="pull-to-refresh-layer">
                <div class="preloader"></div>
                <div class="pull-to-refresh-arrow"></div>
            </div>

               <div class="row" style="padding: 10px 12px 0px 12px;">
              <div class="col-100"><a href="#joinname"  style="font-size: 14px;color: #0894EC;" class="button"><i class="fa fa-pencil-square-o"></i> 求助报修</a></div>
              <%--<div class="col-50"><a href="#HelpList1"  style="font-size: 14px;" class="button button button-dark"><i class="fa fa-stack-exchange"></i> 回答</a></div>--%>
            </div>



                <div class="card-container">
 
            
          
                            <%rs = cPConn.Execute("select * from [dbQKView] where cJoinName='" & Session("iphone") & "' and zDeptCode='" & Session("usercode") & "' and bView<>'1' order by dDate desc") %>

                          <%If rs.RecordCount <> 0 Then %>

                             <% For i = 1 To rs.RecordCount %>

        <div class="card">

            <a href ="#HelpList1-1" onclick="returnHelp('<%=rs.Fields("cCode").Value%>','<%=rs.Fields("cBT").Value%>','<%=rs.Fields("cNR").Value%>','1','','<%=rs.Fields("cURL").Value%>');" >
                <div class="card-content">

                                        <div class="card-content-inner">
                          
                                  <div style="font-family: 黑体; font-size: 15px;"><%=rs.Fields("cBT").Value%></div>
                                    <div style="color: #333333; font-size: 13px"><%=rs.Fields("cNR").Value%></div>

                                            <%re = cPConn.Execute("Select count(cListCode) as number from dbQKListView where cCode='" & rs.Fields("cCode").Value & "' and cPL<>'' group by cCode") %>
                                            <%Dim iNumber As Integer = 0  %>
                                            <%If re.RecordCount <> 0 Then %>
                                                <%iNumber = re.Fields("number").Value %>
                                            <%End If  %>
                                            <div style="color: #999999; font-size: 13px"><%=Format(rs.Fields("dDate").Value, "MM-dd HH:mm")%><div style="float: right;padding-right: 5px; padding-left: 5px;" onclick="")><%=iNumber %>个回答</div></div>
                        
                                        </div>
            </div></a>

          </div>



                             <% rs.MoveNext  %>
                            <% Next %>
                            <%End if %>

</div>

            </div>
  
     </div>

        



        
                <%--选择--%>
        <div class="page" id='joinname'>

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back"  href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">选择邀请</h1>
    <a class="button button-link button-nav pull-right" data-transition='slide-out' id="#Help" onclick="checkall();">
      确定
    </a>
  </header>   
      
      <div class="content"  style="top: 20px">
              <div class="list-block media-list">
                  
                                        
                  <ul><li class="list-group-title" style="font-size: 13px">全部</li> </ul>                    
                      <ul>
                     <li>
                        <label class="label-checkbox item-content" onclick ="">
                          <input type="checkbox" name="checkboxall" value ="" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title">所有人</div>
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





                  

                  <ul><li class="list-group-title" style="font-size: 13px">好友</li> </ul> 
            <%rs = cPConn.Execute("select * from [dbfriendview] where cPhoneNumber='" & Session("iphone") & "' order by cClassName") %>

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

                  
                  </div>        
  
 </div>
      </div>
        <%--内容--%>
    <div class="page" id='Help'>

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">求助报修</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Save">
      提交
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
            <li>
        <div class="item-content">
          
          <div class="item-inner">
            <a href="#joinname" class="button button-fill button-success" style="font-size: 14px">邀请</a>
            <div class="item-input">
            
               <asp:TextBox ID="T_cJoinName" runat="server" placeholder="" Enabled="False" style="font-size: 14px">所有人</asp:TextBox>
                
               
            </div>
          </div>
        </div>
      </li>

            <li>
        <div class="item-content">
          
          <div class="item-inner">
            <div class="item-input">
               <asp:TextBox ID="T_BT" runat="server" placeholder="请输入标题" MaxLength="50"></asp:TextBox>
            </div>
          </div>
        </div>
      </li>




        <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="T_NR" runat="server" placeholder="请输入问题描述（选填）" TextMode="MultiLine" Height="120px" MaxLength="200"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
            <li>
            <div class="item-content" >
          
          <div class="item-inner">
            <div class="item-title label">是否匿名身份</div>
            <div class="item-input">
              <label class="label-switch">
                <input type="checkbox"  name="checkboxKNM" >
                <div class="checkbox"></div>
              </label>
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
        <a href="#" class="button button-light" id="Delete" style="display: none;">清除</a>
      </div>      
<img id="imgPre" src="" style="padding: 10px; display: block; width: 100%; height: auto;" /> 
</div>
</div>
      </div>

<div class="page" id='HelpList3'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#HelpList1" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">我的回答</h1>
         
          <a class="button button-link button-nav pull-right" href="#joinname" data-transition='slide-out' id="A3" runat="server">
          
        </a>
        
      </header>   
<div class="content">

    
                    <%rs = cPConn.Execute("select * from [dbQKListView] where cPhoneNumber='" & Session("iphone") & "' and zDeptCode='" & Session("usercode") & "' and bDel='0' and bView='1'  order by dDate desc") %>

                  <%If rs.RecordCount <> 0 Then %>

                     <% For i = 1 To rs.RecordCount %>

<div class="card">
    <a href ="#HelpList1-1" onclick="returnHelp('<%=rs.Fields("cCode").Value%>','<%=rs.Fields("cBT").Value%>','<%=rs.Fields("cNR").Value%>','3','<%=rs.Fields("cListCode").Value%>','<%=rs.Fields("cURL").Value%>');" >
    <div class="card-content">

                                <div class="card-content-inner">
                          
                          <div style="font-family: 黑体; font-size: 15px;"><%=rs.Fields("cBT").Value%></div>
                            <div style="color: #333333; font-size: 13px"><%=rs.Fields("cNR").Value%></div>
                                    <div style="color: #999999; font-size: 13px;"><%=Format(rs.Fields("dDate").Value, "MM-dd HH:mm") %></div>
                        </div>
    </div>
        </a>

  </div>



                     <% rs.MoveNext  %>
                    <% Next %>
                    <%End if %>



    </div>
  
     </div>

    <div class="page" id='HelpList3-1'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-transition='slide-out'>
          
        </a>
        <h1 class="title">问题</h1>
         
        
      </header>   
<div class="content">
                      


<div class="card facebook-card">
    
    <div class="card-content">

      
                                <div class="card-content-inner">
                          
                          <div style="font-family: 黑体; font-size: 16px;">中中中加右右历啡中右可加中百右右右右！？</div>
                            <div style="color: #999999; font-size: 13px">学样中右右破口大骂中历</div>
                        </div>
    </div>
    <div class="card-footer no-border">
                        <div style="color: #666666; font-size: 13px">21 关注</div>
                        <div class="row">
      
      <div class="col-100"><a href="#"  style="font-size: 14px; color: #0894EC;" class="button">我的回答</a></div>
    </div>
                        
    </div>

  </div>
    <div class="list-group-title" style="font-size: 13px; color: #808080; padding-left: 15px;">11个回答</div>
    <div class="card facebook-card">
    <a href ="#HelpList1-2" onclick="" >
    <div class="card-content">
              <div class="facebook-avatar" style="padding-top: 10px; padding-left: 10px">
          <div style="width:0.9rem; height:0.9rem; border-radius:50%; overflow:hidden;">
          <img src="" style='width: 0.9rem;'></div></div>
      <div class="facebook-name" style="padding-top: 10px; font-size: 13px; color: #999999;">来自你</div>
                                <div class="card-content-inner">
                          <div style="color: #333333; font-size: 13px;">中中中加右右历啡中右可加中百右右右右！？</div>
                          <div style="color: #999999; font-size: 13px">日期</div>
                            
                        </div>
    </div>
    </a>
  </div>



    </div>
  
     </div>


        <div class="page" id='HD'>

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title" id="WT"></h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_TJ">
      提交
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
                  <asp:TextBox ID="T_ListCode" runat="server" placeholder="系统编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
          <li style="display:none">
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="TextBox2" runat="server" placeholder="当前用户"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
        <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="T_HD" runat="server" placeholder="写回答..." TextMode="MultiLine" Height="173px" MaxLength="200"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
            <li>
            <div class="item-content">
          
          <div class="item-inner">
            <div class="item-title label">是否匿名身份</div>
            <div class="item-input">
              <label class="label-switch">
                <input type="checkbox"  name="checkboxNM" >
                <div class="checkbox"></div>
              </label>
            </div>
          </div>
        </div>

        </li>
    </ul>



  </div>



</div>
      </div>
        



         </div>    
        
    

        
        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
        <script src="js/lrz.all.bundle.js"></script>
        <script src="js/canvas-to-blob.min.js"></script>
        <script src="js/SUI/demos.js"></script>
<%--        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>--%>
            <script type="text/javascript">



                    // 添加'refresh'监听器
                $(document).on('HelpList2', '.pull-to-refresh-content', function (e) {
                    // 模拟2s的加载过程
                    setTimeout(function() {
                        var cardNumber = $(e.target).find('.card').length + 1;
                        var cardHTML = '<div class="card">' +
                                          '<div class="card-header">card'+cardNumber+'</div>' +
                                          '<div class="card-content">' +
                                            '<div class="card-content-inner">' +
                                                '这里是第' + cardNumber + '个card，下拉刷新会出现第' + (cardNumber + 1) + '个card。' +
                                            '</div>' +
                                          '</div>' +
                                      '</div>';

                        //$(e.target).find('.card-container').prepend(cardHTML);
                        //$.router.load("#HelpList1");
                        self.location = 'A_Help.aspx';
                        // 加载完毕需要重置
                        $.pullToRefreshDone('.pull-to-refresh-content');
                    }, 2000);
                });

</script>



                  <script type="text/javascript">
              $(document).on("pageInit", function (e, pageId, $page) {
                  if (pageId == "HelpList1-1") {
                      var cCode = document.getElementById("T_Code1").value;
                      returnHDNumber(cCode);

                  }
                  

                  function returnHDNumber(cCode) {

                      $(function () {
                          var data = "{str1:'" + cCode + "'}";
                          $.ajax({
                              type: "Post", //要用post方式   
                              url: "A_Help.aspx/returnHDNumber", //方法所在页面和方法名
                              contentType: "application/json; charset=utf-8",
                              data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                              dataType: "json",
                              success: function (data) {
                                  if (data.d != "失败") {
                                      document.getElementById("HDNumber").innerText = data.d + '个回答';


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

              })
        </script>


        <script type="text/javascript">
            function HD(cBT,cListCode) {

                if (cBT.length >= 13) {
                    cBT = cBT.substring(0, 12) + '...';
                }


                document.getElementById("WT").innerText = cBT;
                document.getElementById("T_ListCode").value = cListCode;
            }

        </script>
        <script type="text/javascript">
            function HL(cCode) {

                var box = document.getElementById(cCode);
                box.parentNode.removeChild(box);

                $(function () {
                    var data = "{str1:'" + cCode + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Help.aspx/HL", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "失败") {
                                
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


            }

        </script>
        <script type="text/javascript">
            function returnHelp(cCode, cBT, cNR, cSign, cCodeList,cURL) {

                document.getElementById("BT").innerText = cBT;
                document.getElementById("NR").innerText = cNR;
                document.getElementById("T_Code1").value = cCode;

                document.getElementById("T_CodeList1").value = cCodeList;


                document.getElementById('imgPre2').src = cURL;
                returnHD(cCode,cSign);
                returnGZ(cCode);
                returnHDNumber(cCode);


            }
            function returnGZ(cCode) {

                $(function () {
                    var data = "{str1:'" + cCode + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Help.aspx/returnGZ", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "失败") {
                                document.getElementById("GZ").innerText = data.d + '人关注';
                                

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
            function returnHDNumber(cCode) {

                $(function () {
                    var data = "{str1:'" + cCode + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Help.aspx/returnHDNumber", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "失败") {
                                document.getElementById("HDNumber").innerText = data.d + '个回答';


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
            function returnHD(cCode,cSign) {

                $(function () {
                    var data = "{str1:'" + cCode + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Help.aspx/returnHD", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "失败") {
                                if (cSign=='1'){
                                    $("#but_Del").css("display", "block");
                                    $("#but_HD").css("display", "none");
                                    $("#but_HL").css("display", "none");

                                    //if (data.d === '') {
                                    //    $("#but_Del").css("display", "block");
                                    //}
                                    //else {
                                    //    $("#but_Del").css("display", "none");
                                    //}



                                }
                                else if(cSign=='2'){
                                    $("#but_HD").css("display", "block");
                                    $("#but_Del").css("display", "none");
                                    $("#but_HL").css("display", "none");
                                }
                                else if (cSign == '3') {
                                    $("#but_HL").css("display", "block");
                                    $("#but_Del").css("display", "none");
                                    $("#but_HD").css("display", "none");
                                }

                                 $("#HDList").html(data.d);

                                

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

            function checkall() {
                var cCode = '';
                var cName = '';
                var cUnitCode = '';
                var cUnitName = '';
                var bAll = true;
                var checkbox = document.getElementsByName("checkbox");
                //var checkboxunit = document.getElementsByName("checkboxunit");
                var checkboxall = document.getElementsByName("checkboxall");

                if (checkboxall[0].checked === true) {

                    document.getElementById("T_cJoinName").value = '所有人';
                    document.getElementById("T_Group").value = ''
                    $.router.load("#Help");

                }
                else {


                

                for (var i = 0; i < checkbox.length; i++) {
                    if (checkbox[i].checked === true) {
                        
                        bAll = false;
                        break;
                    }
                }
                //for (var i = 0; i < checkboxunit.length; i++) {
                //    if (checkboxunit[i].checked === true) {

                //        bAll = false;
                //        break;
                //    }
                //}


                if (bAll) {
                    $.toast("请选择邀请人");
                }
                else {

                    //for (var i = 0; i < checkboxunit.length; i++) {
                    //    if (checkboxunit[i].checked === true) {
                    //        cUnitCode = cUnitCode + checkboxunit[i].value + ';';
                    //        cUnitName = cUnitName + document.getElementById('b' + (i + 1)).innerText + ';';


                    //    }
                    //}

                    for (var i = 0; i < checkbox.length; i++) {
                        if (checkbox[i].checked === true) {
                            cCode = cCode + checkbox[i].value + ';';
                            cName = cName + document.getElementById('a' + (i + 1)).innerText + ';';


                        }
                    }





                    //$.toast(cCode);
                    document.getElementById("T_cJoinName").value = cCode;
                    //document.getElementById("T_Group").value = ''
                    $.router.load("#Help");
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
                    $.router.load("#Help");
                    
                }
                else{
                    $.toast("请选择邀请群");
                
                }
            }




            </script>
        <script type="text/javascript">
            $("#but_Save").click(function () {
            var cBT,cNR,cName,cUnit,cUserName,cGroup,cGroupName;
            var checkbox = document.getElementsByName("checkbox");
            //var checkboxunit = document.getElementsByName("checkboxunit");
            //var checkgroup = document.getElementsByName("checkgroup");

            cBT = document.getElementById("T_BT").value;
            cNR = document.getElementById("T_NR").value;

            cUserName = document.getElementById("T_Name").value;

            cName = '';
            cUnit = '';

            var checkboxKNM = document.getElementsByName("checkboxKNM");
            var iNM;

            if (checkboxKNM[0].checked === true) {
                iNM = '1'
            }
            else {
                iNM = '0'
            }

            var myDate = new Date();
            var wxData = {

                "template_id": "4yvXUiizVN9M7p6uD3tnT99rRdf5n3bgD-M8cjKM1lQ",
                "url": "http://my.aiwei.biz/aw/A_Iofo.aspx#TZ",

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
                        "value": "" + myDate.toLocaleDateString() + " " + myDate.getHours() + ":" + myDate.getMinutes() + "",
                        "color": "#173177"
                    },
                    "remark": {
                        "value": "请您及时查阅处理！",
                        "color": "#173177"
                    }
                }
            }







            if (cBT == '') {

                $.toast("请输入标题");
            }
            //else if (cNR == '') {
            //    $.toast("请输入内容");
            //}
            else if(cBT.length<5){
                $.toast("问题描述太少");
            }
            else if (cNR.length>280)
                $.toast("描述超限");
            else {

                //for (var i = 0; i < checkboxunit.length; i++) {
                //    if (checkboxunit[i].checked === true) {

                //        cUnit = cUnit + document.getElementById('b' + (i + 1)).innerText + ';';


                //    }
                //}

                for (var i = 0; i < checkbox.length; i++) {
                    if (checkbox[i].checked === true) {
                        
                        cName = cName + document.getElementById('a' + (i + 1)).innerText + ';';


                    }
                }


                //for (var i = 0; i < checkgroup.length; i++) {
                //    if (checkgroup[i].checked === true) {

                //        cGroup = document.getElementById('c' + (i + 1)).innerText + ';';
                //        cGroupName = checkgroup[i].value;

                //    }
                //}


                if (document.getElementById("T_cJoinName").value == '所有人') {
                    //如果是向所有人发送的时候调用
			$("#but_Save").css("display", "none");
                    SaveAll();
                   
                }
                
                else {
                    //不是向所有人发送的时候调用
			$("#but_Save").css("display", "none");
                    Save();

                }
           
            }


      
            function Save() {
                $(function () {
                    var cUser;
                    cUser = document.getElementById("T_cJoinName").value;

                    var data = "{str1:'" + cBT + "',str2:'" + cNR + "',str3:'" + cName + "',str4:'" + cUser + "',str5:'" + JSON.stringify(wxData) + "',str6:'" + iNM + "'}";
                $.ajax({
                    type: "Post", //要用post方式   
                    url: "A_Help.aspx/Save", //方法所在页面和方法名
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
                                    self.location = 'A_Help.aspx';
                                }, 3000)

                            }
                            else {
                                $.toast("发布成功");
                                self.location = 'A_Help.aspx';
                            }




                            //$.toast("发布成功");
                            //self.location = 'A_Help.aspx';
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

            function SaveAll() {

                $(function () {
                    var data = "{str1:'" + cBT + "',str2:'" + cNR + "',str3:'" + JSON.stringify(wxData) + "',str4:'" + iNM + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Help.aspx/SaveAll", //方法所在页面和方法名
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
                                        self.location = 'A_Help.aspx';
                                    }, 3000)

                                }
                                else {
                                    $.toast("发布成功");
                                    self.location = 'A_Help.aspx';
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
            
    })
            
</script>
                <script type="text/javascript">
                    $("#but_TJ").click(function () {
                        var cListCode,cHD;
                        cListCode = document.getElementById("T_ListCode").value;
                        cHD = document.getElementById("T_HD").value;
                        var checkboxNM = document.getElementsByName("checkboxNM");
                        var iNM;
                        if (checkboxNM[0].checked === true) {
                            iNM='1'
                        }
                        else {
                            iNM='0'
                        }


                        if (cHD == '') {

                            $.toast("请写入回答！");

                        }


                        else {
                            TJ();
                        }



                        function TJ() {

                            $(function () {
                                var data = "{str1:'" + cListCode + "',str2:'" + cHD + "',str3:'" + iNM + "'}";
                                $.ajax({
                                    type: "Post", //要用post方式   
                                    url: "A_Help.aspx/TJ", //方法所在页面和方法名
                                    contentType: "application/json; charset=utf-8",
                                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                                    dataType: "json",
                                    success: function (data) {
                                        if (data.d != "失败") {
                                            
                                            $.toast("提交成功，积分+3");
                                            //self.location = 'A_Help.aspx';
                                            //$.router.back();
                                            //var div = document.createElement('div'); // 新增元素
                                            //div.innerHTML = '<div class="card facebook-card" id="a"><a href ="#" onclick=""><div class="card-content">' +
                                            //'<div Class="facebook-avatar" style="padding-top: 10px; padding-left: 10px">' +
                                            //'<div style = "width:0.9rem; height:0.9rem; border-radius:50%; overflow:hidden;">' +
                                            //'<img src="" style="width: 0.9rem;"></div></div>' +
                                            //'<div Class="facebook-name" style="padding-top: 10px; font-size: 13px; color: #999999;"></div>' +
                                            //'<div Class="card-content-inner">' +
                                            //'<div style = "color: #333333; font-size: 13px;" ></div>' +
                                            //'<div style="color: #999999; font-size: 13px;"></div></div>' +
                                            //'</div></a></div>'

                                            //var diva = document.getElementById('HDList'); // 获取id为a的元素
                                            //diva.parentNode.insertBefore(div, diva); // 在这个元素前面增加上去
                                            //diva.parentNode.appendChild(div);
                                            //$.router.load('A_Notice.aspx', true)
                                            $("#HDList").html(data.d);
                                            $.router.back();

                                            //$.router.load("#NoticeList");
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
            $("#but_Del").click(function () 
            {
                var cCode;
                cCode = document.getElementById("T_Code1").value;
                  $.confirm('确定删除该问题?',
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
                  url: "A_Help.aspx/Del", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "删除成功") {

                          $.toast("删除成功");
                          self.location = 'A_Help.aspx';
                          //$.router.load('A_Notice.aspx', true)
                         
                      }
                      else if (data.d === "已经删除") {
                          $.toast("已经删除");
                          self.location = 'A_Help.aspx';
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
            $("#but_HD").click(function () 
            {
                var cBT = document.getElementById("BT").innerText;
                if (cBT.length >= 13) {
                    cBT = cBT.substring(0, 12) + '...';
                }
                document.getElementById("WT").innerText = cBT;
                document.getElementById("T_ListCode").value = document.getElementById("T_CodeList1").value;

                document.getElementById("T_HD").value = '';
            });
            $("#but_HD1").click(function () {

                var cBT = document.getElementById("BT").innerText;
                if (cBT.length >= 13) {
                    cBT = cBT.substring(0, 12) + '...';
                }

                document.getElementById("WT").innerText = cBT;
                document.getElementById("T_ListCode").value = document.getElementById("T_CodeList1").value;

                document.getElementById("T_HD").value = '';
            });



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
                  url: "A_Help.aspx/DelList", //方法所在页面和方法名
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
    $("#Delete").css("display", "block");

    if ($("#Delete").css("display") === "block") {
        var reader = new FileReader();
        reader.readAsDataURL($('#imgOne')[0].files[0]);
        reader.onload = function (evt) {
            document.getElementById('imgPre').src = evt.target.result;
        }
    }


}
else if(targetId == "imgPre1"){
    $("#Delete1").css("display", "block");

    if ($("#Delete1").css("display") === "block") {
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
            $("#Delete").click(function () {
                document.getElementById('imgOne').value = "";
                document.getElementById('imgPre').src = "";

                $("#Delete").css("display", "none");
            })
        })
        $(function () {
            $("#Delete1").click(function () {
                document.getElementById('imgOne1').value = "";
                document.getElementById('imgPre1').src = "";

                $("#Delete1").css("display", "none");
            })
        })


        function Upload() {

            if (document.getElementById('imgOne').value != '') {              

                lrz($('#imgOne')[0].files[0], { width: 500 })
               
                .then(function (rst) {

                    var xhr = new XMLHttpRequest();
                    xhr.open("POST", "A_Upload1.aspx");
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
                        xhr.open("POST", "A_Upload1.aspx");
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





        </form> 
  </body>
</html>
