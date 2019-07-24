<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_SetPassword.aspx.vb" Inherits="A_SetPassword" %>

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


    <script>
        function Msg1() {
            $.toast("不能为空，请正确录入！");
            //layer.msg('不能为空，请正确录入！');
        }
        function Msg2() {
            $.toast("录入的旧密码不正确！");
            //layer.msg('录入的旧密码不正确！');
        }
        function Msg3() {
            $.toast("录入的两次新密码不一致！");
            //layer.msg('录入的两次新密码不一致！');
        }
        function SaveMsg() {
            $.toast("密码修改成功！");
            //layer.msg('密码修改成功！');
            }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div></div>
    
       
    <div class="page-group">

  <div class="page" id='SetPassword'>
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left external" href="A_Setting.aspx" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">修改密码</h1>
        <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Save" runat="server">
      保存
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
 
    
        
    


        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
<%--        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>--%>






</div> 
        


        </form> 
  </body>
</html>
