<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_App.aspx.vb" Inherits="A_App" %>

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

  <div class="page" id='App'>

      <nav class="bar bar-tab">

    <a class="tab-item external active" href="A_App.aspx">
    <span class="icon icon-app"></span>
    <span class="tab-label">应用</span>
    <%If Session("AppNumber") <> 0 Then %>
    <span class="badge"><%=Session("AppNumber") %></span>
    <% End If %>
  </a>
     <a class="tab-item external" href="A_Iofo.aspx">
    <span class="icon icon-message"></span>
    <span class="tab-label">消息</span>
    <%If Session("IofoNumber") <> 0 Then %>
    <span class="badge"><%=Session("IofoNumber") %></span>
    <% End If %>
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


      <div class="content" style="background-color: #FFFFFF">


 <header class="bar bar-nav">

    <h1 class="title">应用</h1>
  </header>
        <div class="content-padded grid-demo">

      <h5>工作</h5>
      <div class="row no-gutter" style="text-align: center">
        <div class="col-25" ><a href="A_QD.aspx" class="external"><div style="padding-top: 1px; color: #FF5050; font-size: xx-large;"><i class="fa fa-map-marker"></i></div><div style="font-size: small;color: #000000;">定位</div> </a></div>
        <div class="col-25" ><a href="A_Notice.aspx" class="external"><div style="padding-top: 1px; color: #FFCC00; font-size: xx-large;"><i class="fa fa-volume-up"></i></div><div style="font-size: small;color: #000000;">通知</div></a> </div>
        <div class="col-25" ><a href="A_Work.aspx" class="external"><div style="padding-top: 1px; color: #33CC33; font-size: xx-large;"><i class="fa fa-pencil-square"></i></div><div style="font-size: small; color: #000000;">工作汇报</div></a> </div>
        <div class="col-25" ><a href="A_Help.aspx" class="external"><div style="padding-top: 1px; color: #F8AC59; font-size: xx-large;"><i class="fa fa-question-circle"></i></div><div style="font-size: small; color: #000000;">求助报修</div></a> </div>

          <br /><br /><br /><br />
         <div class="col-25" >
             <%If Session("usercode") = "DT201900002" %>
             <a href="#Money1">
             <%else %>
             <a href="#Money">
             <%end if%>
             

             <div style="padding-top: 1px; color: #9656CF; font-size: xx-large;"><i class="fa fa-jpy"></i></div><div style="font-size: small; color: #000000;">工资条</div></a> </div>

   
          <div class="col-25" ><a href="A_Setting.aspx" class="external"><div style="padding-top: 1px; color: #808080; font-size: xx-large;"><i class="fa fa-cog"></i></div><div style="font-size: small; color: #000000;">设置</div></a> </div>

          
      </div>
      </div> 

          </div>
      
 
    
        
    


        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
<%--        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>--%>




</div>

<div class="page" id='Money'>


            <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#App" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">选择月份</h1>
        
        <%If Session("Popdom") = "1"Then %>
        <a class="button button-link button-nav pull-right external" href="A_Import.aspx" data-transition='slide-out' runat="server">
          导入管理
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
                     
                        <a href="#MoneyList" onclick="View();" class="button button-fill" style="color: #FFFFFF; background-color: #4CD964;" ><i class="fa fa-search"></i> 查询</a>
                        
                         
                    </div>
                    </div>

                        <% Else %>

                                <br /><br />
                                 <h4 style="text-align: center; color: #999999">你还没找到组织!</h4>

                               <% End if %>








        </div>








    </div>


<div class="page" id='MoneyList'>


            <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#Money" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">工资条</h1>
        
          
        
      </header>   

<div class="content"  style="top: 20px">
              

<% If Session("usercode") <> ""Then %>   
    <div class="list-block">


                                        <ul>
                            <!-- Text inputs -->


                               

                                <li>


                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">月份：</div>
                                        <div class="item-input">

                                            <input type="text" id='T_Month' placeholder="请选择" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>


                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">岗位工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM1' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">薪级工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM2' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">特教补：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM3' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">教护补：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM4' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                            
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">教护龄：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM5' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">保留津贴：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM6' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">卫生费：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM7' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">防疫津贴：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM8' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">基础性绩效工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM9' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">奖励性绩效工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM10' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">房补：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM11' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">公积金：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM12' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                            
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">独生补：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM13' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">其他补发：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM14' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">应发工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM15' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣公积金单位：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM16' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣公积金个人：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM17' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣医疗保险：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM18' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣失业保险：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM19' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣劳保金：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM20' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                            
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣工会会费：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM21' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">职业年金：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM22' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">个人养老保险：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM23' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">个税扣款：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM24' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
 <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">其他扣款：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM25' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣款合计：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM26' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">实发工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iM27' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                </ul>

                    </div>

                        <% Else %>

                                <br /><br />
                                 <h4 style="text-align: center; color: #999999">你还没找到组织!</h4>

                               <% End if %>








        </div>








    </div>

        
<div class="page" id='Money1'>


            <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#App" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">选择月份</h1>
        
        <%If Session("Popdom") = "1"Then %>
        <a class="button button-link button-nav pull-right external" href="A_Import1.aspx" data-transition='slide-out' runat="server">
          导入管理
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

                                            <asp:TextBox ID="T_Name1" runat="server" placeholder="当前用户" Enabled="False"></asp:TextBox>
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

                                            <input type="text" id='picker_Unit1' placeholder="请选择" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                  
                                
                       


                </ul>
        <div style="padding-right: 13px; padding-left: 13px; padding-top: 20px;">
                     
                        <a href="#MoneyList1" onclick="View1();" class="button button-fill" style="color: #FFFFFF; background-color: #4CD964;" ><i class="fa fa-search"></i> 查询</a>
                        
                         
                    </div>
                    </div>

                        <% Else %>

                                <br /><br />
                                 <h4 style="text-align: center; color: #999999">你还没找到组织!</h4>

                               <% End if %>








        </div>








    </div>


<div class="page" id='MoneyList1'>


            <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left back" href="#Money1" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">工资条</h1>
        
          
        
      </header>   

<div class="content"  style="top: 20px">
              

<% If Session("usercode") <> ""Then %>   
    <div class="list-block">


                                        <ul>
                            <!-- Text inputs -->


                               

                                <li>


                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">月份：</div>
                                        <div class="item-input">

                                            <input type="text" id='T_Month1' placeholder="请选择" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>


                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">岗位/学历工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN1' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">薪级工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN2' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">试用期工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN3' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">保留津贴：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN4' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                            
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">取得资证：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN5' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">职务补助：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN6' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">岗位补助：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN7' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">出勤奖：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN8' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">车补：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN9' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">电话补：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN10' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">证龄补贴：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN11' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">节假日补助：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN12' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                            
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">未休假补助：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN13' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">伙食补助：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN14' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">值班补助：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN15' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">绩效工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN16' placeholder="" disabled="disabled" runat="server" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">平均奖：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN17' placeholder="" disabled="disabled" runat="server" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">其他补发：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN18' placeholder="" disabled="disabled" runat="server" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">其他扣发：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN19' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">备注：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN20' placeholder="" disabled="disabled" runat="server"  />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                            
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">应发工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN21' placeholder="" disabled="disabled" runat="server"  />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣公积金：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN22' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣医疗保险：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN23' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣失业保险：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN24' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
 <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣职业年金：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN25' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣养老保险：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN26' placeholder="" disabled="disabled" runat="server" style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>                         
                       <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">实发工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN27' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                                                  <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">扣个税：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN28' placeholder="" disabled="disabled" runat="server"  style="color: #FF0000" />
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                                                                  <li>
                                <div class="item-content">

                                    <div class="item-inner">
                                        <div class="item-title label">税后实发工资：</div>
                                        <div class="item-input">

                                            <input type="text" id='iN29' placeholder="" disabled="disabled" runat="server"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>
                </ul>

                    </div>

                        <% Else %>

                                <br /><br />
                                 <h4 style="text-align: center; color: #999999">你还没找到组织!</h4>

                               <% End if %>








        </div>








    </div>



</div> 
        
        <script type="text/javascript">
            $(document).on("pageInit", function (e, pageId, $page) {
                if (pageId == "Money") {
                    setunit();
                    //var cName = '';

                    //returnsex();

                    //$.toast("设置页面");

                }
                
                else if (pageId == "Money1") {
                    setunit1();
                    //document.getElementById("picker_Unit").value = document.getElementById("T_Unit").innerText;
                    

                }
                
              

                var unitname;
                function setunit() {
                    var data = "{str1:'" + unitname + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_App.aspx/ReturnUnit", //方法所在页面和方法名
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

                function setunit1() {
                    var data = "{str1:'" + unitname + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_App.aspx/ReturnUnit1", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "error") {
                                unitname = JSON.parse(data.d);
                                setaa1();

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

                    function setaa1() {

                        $("#picker_Unit1").picker({

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
        <script type="text/javascript">
            function View() {

                document.getElementById("T_Month").value = document.getElementById("picker_Unit").value;

                tMonth = document.getElementById("T_Month").value;
                
                if (tMonth == '') {
                    //self.location = 'A_App.aspx#Money';
                    //$.router.back()
                    $.toast("请选择月份");

                }
                else {

                    ViewList();

                }

                //document.getElementById("RBdate").value = dDate;
                //document.getElementById("T_RBNR").value = cNR;
                //$.toast("内容");
                //ViewRB();

                function ViewList() {

                    $(function () {
                        var data = "{str1:'" + tMonth + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_App.aspx/ViewList", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "error") {

                                    var view;
                                    view = JSON.parse(data.d);
                                    document.getElementById("iM1").value = view[0];
                                    document.getElementById("iM2").value = view[1];
                                    document.getElementById("iM3").value = view[2];
                                    document.getElementById("iM4").value = view[3];
                                    document.getElementById("iM5").value = view[4];
                                    document.getElementById("iM6").value = view[5];
                                    document.getElementById("iM7").value = view[6];
                                    document.getElementById("iM8").value = view[7];
                                    document.getElementById("iM9").value = view[8];
                                    document.getElementById("iM10").value = view[9];
                                    document.getElementById("iM11").value = view[10];
                                    document.getElementById("iM12").value = view[11];
                                    document.getElementById("iM13").value = view[12];
                                    document.getElementById("iM14").value = view[13];
                                    document.getElementById("iM15").value = view[14];
                                    document.getElementById("iM16").value = view[15];
                                    document.getElementById("iM17").value = view[16];
                                    document.getElementById("iM18").value = view[17];
                                    document.getElementById("iM19").value = view[18];
                                    document.getElementById("iM20").value = view[19];
                                    document.getElementById("iM21").value = view[20];
                                    document.getElementById("iM22").value = view[21];
                                    document.getElementById("iM23").value = view[22];
                                    document.getElementById("iM24").value = view[23];
                                    document.getElementById("iM25").value = view[24];
                                    document.getElementById("iM26").value = view[25];
                                    document.getElementById("iM27").value = view[26];
                                    


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

        <script type="text/javascript">
            function View1() {

                document.getElementById("T_Month1").value = document.getElementById("picker_Unit1").value;

                tMonth = document.getElementById("T_Month1").value;

                if (tMonth == '') {
                    //self.location = 'A_App.aspx#Money';
                    //$.router.back()
                    $.toast("请选择月份");

                }
                else {

                    ViewList1();

                }

                //document.getElementById("RBdate").value = dDate;
                //document.getElementById("T_RBNR").value = cNR;
                //$.toast("内容");
                //ViewRB();

                function ViewList1() {

                    $(function () {
                        var data = "{str1:'" + tMonth + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_App.aspx/ViewList1", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "error") {

                                    var view;
                                    view = JSON.parse(data.d);
                                    document.getElementById("iN1").value = view[0];
                                    document.getElementById("iN2").value = view[1];
                                    document.getElementById("iN3").value = view[2];
                                    document.getElementById("iN4").value = view[3];
                                    document.getElementById("iN5").value = view[4];
                                    document.getElementById("iN6").value = view[5];
                                    document.getElementById("iN7").value = view[6];
                                    document.getElementById("iN8").value = view[7];
                                    document.getElementById("iN9").value = view[8];
                                    document.getElementById("iN10").value = view[9];
                                    document.getElementById("iN11").value = view[10];
                                    document.getElementById("iN12").value = view[11];
                                    document.getElementById("iN13").value = view[12];
                                    document.getElementById("iN14").value = view[13];
                                    document.getElementById("iN15").value = view[14];
                                    document.getElementById("iN16").value = view[15];
                                    document.getElementById("iN17").value = view[16];
                                    document.getElementById("iN18").value = view[17];
                                    document.getElementById("iN19").value = view[18];
                                    document.getElementById("iN20").value = view[19];
                                    document.getElementById("iN21").value = view[20];
                                    document.getElementById("iN22").value = view[21];
                                    document.getElementById("iN23").value = view[22];
                                    document.getElementById("iN24").value = view[23];
                                    document.getElementById("iN25").value = view[24];
                                    document.getElementById("iN26").value = view[25];
                                    document.getElementById("iN27").value = view[26];
                                    document.getElementById("iN28").value = view[27];
                                    document.getElementById("iN29").value = view[28];


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
