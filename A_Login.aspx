<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Login.aspx.vb" Inherits="A_Login" %>

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
form{margin:200px auto;width:500px;}
label{font-size:14px;color:#555;line-height:40px;margin-right:10px;}
input{width:212px;height:38px;border-style:none;padding:0 4px;border:1px solid #C8C8C8;margin-right:10px;outline:none;}
.msgs{display:inline-block;width:104px;color:#fff;font-size:12px;border:1px solid #0697DA;text-align:center;height:30px;line-height:30px;background:#0697DA;cursor:pointer;}
form .msgs1{background:#E6E6E6;color:#818080;border:1px solid #CCCCCC;}
.msgs2{display:inline-block;width:104px;color:#fff;font-size:12px;border:1px solid #0697DA;text-align:center;height:30px;line-height:30px;background:#0697DA;cursor:pointer;}
form .msgs3{background:#E6E6E6;color:#818080;border:1px solid #CCCCCC;}
.msgs4{display:inline-block;width:104px;color:#fff;font-size:12px;border:1px solid #0697DA;text-align:center;height:30px;line-height:30px;background:#0697DA;cursor:pointer;}
form .msgs5{background:#E6E6E6;color:#818080;border:1px solid #CCCCCC;}

.msgs6{display:inline-block;width:104px;color:#C0C0C0;font-size:12px;border:0px solid #0697DA;text-align:center;height:30px;line-height:30px;cursor:pointer;}
</style>


</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <div class="page-group">

<%--用户名登录 开始--%>
  <div class="page" id='login'>
    <div class="content">
          <header class="bar bar-nav">
    
    <h1 class='title'>帐号登录</h1>
      
  </header>


        <br/>


<div class="content-block-title" style="text-align: right;font-size: 13px;">找对人 做对事</div>
  <div class="list-block" style="padding-right: 15px; padding-left: 15px">
    <ul>
      <!-- Text inputs -->
      <li>
        <div class="item-content">
          <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-user"></i></div> </div>
          <div class="item-inner">
            <div class="item-input" >

              <asp:TextBox ID="email" runat="server" placeholder="用户名/手机号" style="font-size: 15px"></asp:TextBox>
            </div>
          </div>
        </div>
      </li>
      <li>
        <div class="item-content">
          <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-lock"></i></div></div>
          <div class="item-inner">
            <div class="item-input">

              <asp:TextBox ID="password" runat="server" placeholder="密码" type="password"  style="font-size: 15px" MaxLength="16"></asp:TextBox>
            
            
            </div><a href="#modify" class ="msgs6">找回密码</a>
          </div>
        </div>
      </li>
      
    </ul>
      
                <div style="font-size: 14px; text-align: center; padding-top: 13px; ">
            <asp:Label ID="Label1" runat="server" Text="请输入用户名"  Visible="False" ForeColor="#FF6666"></asp:Label>
            <asp:Label ID="Label2" runat="server" Text="请输入密码" Visible="False" ForeColor="#FF6666"></asp:Label>
            <asp:Label ID="Label3" runat="server" Text="帐号或密码错误，请重新输入" Visible="False" ForeColor="#FF6666"></asp:Label>
            </div>
                <p>
                    <asp:Button ID="Btn_Login" runat="server" Text="登 录"  CssClass ="button button-fill"  style="font-size: 17px;font-family: 黑体;" Height="40px" />
                </p>
                
  
  <div  style="padding-right: 15px; font-size: 13px;">
        
<a href="#phone" style="float:left">短信快捷登录</a><a href="#register" style="float:right">注册</a>
      </div>

  </div>
 

<br /><br /><br /><br />
        
        <div style="text-align: center">
            <div style="text-align: center; font-size: 12px; color: #C0C0C0;">—————— 其它登录方式 ——————</div>
            <br />
        <a href ="#" onclick ="WXLogin2();"><img src="img/img/wxLogin.png" style='width: 2.2rem;'></a>
<div style="text-align: center; font-size: 13px;">微信</div> </div>
        <div id="Login"></div>

</div>
</div>
<%--用户名登录 结束--%>

<%--手机号登录 开始--%>
  <div class="page" id='phone'>
      
  <div class="content">  

     <header class="bar bar-nav">
    
    <h1 class='title'>短信快捷登录</h1>
      
  </header>


        <br/>

<div class="content-block-title" style="text-align: right;font-size: 13px;">找对人 做对事</div>



            <div class="list-block" style="padding-right: 15px; padding-left: 15px">
      <ul>
                  <li>
          <div class="item-content">
              <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-tty"></i></div></div>
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="T_PhoneLog" runat="server" placeholder="手机号" MaxLength="11" style="font-size: 15px" TextMode="Number"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
          <li>
          <div class="item-content">
              <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-code"></i></div></div>
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="T_PhoneCode" runat="server" placeholder="验证码" MaxLength="6" style="font-size: 15px" TextMode="Number"></asp:TextBox>
              
              </div><span class="msgs">获取验证码</span>
            </div>
          </div>
        </li>
                  
          </ul> 
            <div style="font-size: 14px; text-align: center; padding-top: 13px; ">
            <asp:Label ID="Label4" runat="server" Text=""  Visible="False" ForeColor="#FF6666"></asp:Label>
            </div>
                <p>
                    <input id="Btn_PhoneLog" type="button" value="登 录" class="button button-fill disabled" style="font-family: 黑体;font-size: 17px;height: 40px"  />
                    
                </p>

                  <div style="padding-right: 15px; font-size: 13px;">
        <a href="#login" style="float:left" class="back">帐号登录</a><a href="#register" style="float:right">注册</a>
      </div>
                
        
        
      
        </div>

<br /><br /><br /><br />
        
        <div style="text-align: center">
            <div style="text-align: center; font-size: 12px; color: #C0C0C0;">—————— 其它登录方式 ——————</div>
            <br />
        <a href ="#" onclick ="WXLogin2();"><img src="img/img/wxLogin.png" style='width: 2.2rem;'></a>
<div style="text-align: center; font-size: 13px;">微信</div> </div>



</div>



</div>
<%--手机号登录 结束--%>

<%--注册 开始--%>
  <div class="page" id='register'>
  <header class="bar bar-nav">
          <a class="button button-link button-nav pull-left back">
      <span class="icon icon-left"></span>
      
    </a>
    <h1 class='title'>手机号注册</h1>

  </header>



  <div class="content">  

            <div class="list-block"  style="padding-right: 15px; padding-left: 15px">
      <ul>
          
                   <li>
          <div class="item-content">
              <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-tty"></i></div></div>
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="T_PhoneReg" runat="server" placeholder="手机号" MaxLength="11" style="font-size: 15px" TextMode="Number"></asp:TextBox>
              </div>
            </div>
          </div>
        </li>
          <li>
          <div class="item-content">
              <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-code"></i></div></div>
            <div class="item-inner">
              
              <div class="item-input">
                  <asp:TextBox ID="T_PhoneRegCode" runat="server" placeholder="验证码" MaxLength="6" style="font-size: 15px" TextMode="Number"></asp:TextBox>
              
              </div><span class="msgs2">获取验证码</span>
            </div>
          </div>
        </li>
          <li>
        <div class="item-content">
          <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-lock"></i></div></div>
          <div class="item-inner">
            <div class="item-input">

              <asp:TextBox ID="T_PhoneRegPass" runat="server" placeholder="设置密码（6—16个字符）" type="password"  style="font-size: 15px" MaxLength="16"></asp:TextBox>
            
            
            </div>
          </div>
        </div> 
          </li>
          </ul>
          <div style="font-size: 14px; text-align: center; padding-top: 13px; ">
            <asp:Label ID="Label5" runat="server" Text=""  Visible="False" ForeColor="#FF6666"></asp:Label>
            </div>
                <p>
                   <input id="Btn_PhoneReg" type="button" value="立即注册" class="button button-fill" style="font-family: 黑体;font-size: 17px;height: 40px"  />

                </p>
                                  <div style="padding-right: 15px; font-size: 13px; color: #C0C0C0;">
        <div style="float:left">我已阅读并同意<a href="#reg" style="color: #333333">用户注册协议</a></div>
      </div>
                 
        </div>


  
            

</div>



</div>
<%--注册 结束--%>

<%--注册 开始--%>
  <div class="page" id='reg'>
  <header class="bar bar-nav">
          <a class="button button-link button-nav pull-left back">
      <span class="icon icon-left"></span>
      
    </a>
    <h1 class='title'>用户注册协议</h1>

  </header>



  <div class="content">  

      <div style="padding-right: 15px; padding-left: 15px; font-size: 13px;">

<p>一、本站（APP）服务条款的确认和接纳</p>

本站（APP）的各项电子服务的所有权和运作权归本站（APP）。本站（APP）提供的服务将完全按照其发布的服务条款和操作规则严格执行。用户同意所有服务条款并完成注册程序时，本协议在用户与本站（APP）间成立并发生法律效力，同时用户成为本站（APP）正式用户。用户确认：本协议条款是处理双方权利义务的约定，除非违反国家强制性法律，否则始终有效。在下订单的同时，您也同时承认了您拥有购买这些产品的权利能力和行为能力，并且将您对您在订单中提供的所有信息的真实性负责。

<p>二、服务介绍</p>

本站（APP）运用自己的操作系统通过国际互联网络为用户提供网络服务。同时，用户必须：

(1)自行配备上网的所需设备，包括个人电脑、手机或其它必备上网装置。

(2)自行负担个人上网所支付的与此服务有关的电话费用、网络费用。 基于本站（APP）所提供的网络服务的重要性，用户应同意
(1)提供详尽、准确的个人资料。
(2)不断更新注册资料，符合及时、详尽、准确的要求。

本站（APP）保证不公开用户的真实姓名、地址、电子邮箱和联系电话等用户信息， 除以下情况外：
(1)用户授权本站（APP）透露这些信息。
(2)相应的法律及程序要求本站（APP）提供用户的个人资料。

<p>三、服务条款的修改</p>

本站（APP）将可能不定期的修改本用户协议的有关条款，一旦条款及服务内容产生变动，本站（APP）将会在重要页面上提示修改内容。

<p>四、用户隐私制度</p>

尊重用户个人隐私是本站（APP）的一项基本政策。所以，作为对以上第二条注册资料分析的补充，本站（APP）一定不会在未经合法用户授权时公开、编辑或透露其注册资料及保存在本站（APP）中的非公开内容。

<p>五、用户的帐号，密码和安全性</p>

用户一旦注册成功，成为本站（APP）的合法用户，将得到一个密码和用户名。您可随时根据指示改变您的密码。用户需谨慎合理的保存、使用用户名和密码。在账号使用过程中，为了保障您的账号安全基于不同的终端以及您的使用习惯，我们可能采取不同的验证措施识别您的身份。用户不应将其账号、密码转让、出售或出借予他人使用，若用户授权他人使用账户，应对被授权人在该账户下发生所有行为负全部责任。用户若发现任何非法使用用户帐号或存在安全漏洞的情况，请立即通知本站（APP）和向公安机关报案。

<p>六、对用户信息的存储和限制</p>

如果用户违背了国家法律法规规定或本协议约定，本站（APP）有视具体情形中止或终止对其提供网络服务的权利。

<p>七、用户管理</p>

本协议依据国家相关法律法规规章制定，用户同意严格遵守以下条款：
(1)从中国境内向外传输技术性资料时必须符合中国有关法规。
(2) 不利用本站（APP）从事非法活动。
(3)不干扰或混乱网络服务。
(4)遵守所有使用网络服务的网络协议、规定、程序和惯例。

用户须承诺不传输任何违法犯罪的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、伤害性的、庸俗的，淫秽的、不文明的等信息资料；不传输损害国家社会公共利益和涉及国家安全的信息资料；不传输教唆他人从事本条所述行为的信息资料。

未经许可而非法进入其它电脑系统是禁止的。

若用户的行为不符合以上提到的服务条款，本站（APP）将作出独立判断立即取消用户服务帐号。用户需对自己在网上的行为承担法律责任。用户若在本站（APP）上散布和传播反动、色情或其它违反国家法律的信息，本站（APP）的系统记录有可能作为用户违反法律的证据。

<p>八、通告</p>

所有发给用户的通告都可通过重要页面的公告或系统消息或电子邮件或常规的信件或短信方式传送。用户协议条款的修改、服务变更、或其它重要事件的通告都会以此形式进行。

<p>九、网络服务内容的所有权</p>

本站（APP）定义的网络服务内容包括：文字、软件、声音、图片、录象、图表、广告中的全部内容；电子邮件的全部内容；本站（APP）为用户提供的其它信息。所有这些内容受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在本站（APP）和广告商授权下才能使用这些内容，而不能擅自复制、再造这些内容、或创造与内容有关的派生产品。本站（APP）所有的文章版权归原文作者和本站（APP）共同所有，任何人需要转载本站（APP）的内容，必须征得原文作者和本站（APP）授权。

<p>十、责任限制</p>

如因不可抗力或其它本站（APP）无法控制的原因使本站（APP）系统崩溃或无法正常使用导致无法完成或丢失有关的信息、记录等本站（APP）会尽可能合理地协助处理善后事宜，并尽最大努力使客户免受损失。

<p>十一、法律管辖和适用</p>

本协议的订立、执行和解释及争议的解决均应适用中国法律。

如发生本站（APP）服务条款与中国法律相抵触时，则这些条款将完全按法律规定重新解释，而其它有效条款继续有效。

如双方就本协议内容或其执行发生任何争议，双方应尽力友好协商解决；协商不成时，任何一方均可向人民法院提起诉讼。</div>      


  
            

</div>



</div>
<%--注册 结束--%>

<%--忘记密码 开始--%>
  <div class="page" id='modify'>
      <header class="bar bar-nav">
              <a class="button button-link button-nav pull-left back">
          <span class="icon icon-left"></span>
      
        </a>
        <h1 class='title'>找回密码</h1>

      </header>



      <div class="content">  

                <div class="list-block"  style="padding-right: 15px; padding-left: 15px">
          <ul>
                       <li>
              <div class="item-content">
                  <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-tty"></i></div></div>
                <div class="item-inner">
              
                  <div class="item-input">
                      <asp:TextBox ID="T_PhoneModify" runat="server" placeholder="手机号" MaxLength="11" style="font-size: 15px" TextMode="Number"></asp:TextBox>
                  </div>
                </div>
              </div>
            </li>
              <li>
              <div class="item-content">
                  <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-code"></i></div></div>
                <div class="item-inner">
              
                  <div class="item-input">
                      <asp:TextBox ID="T_PhoneModifyCode" runat="server" placeholder="验证码" MaxLength="6" style="font-size: 15px" TextMode="Number"></asp:TextBox>
              
                  </div><span class="msgs4">获取验证码</span>
                </div>
              </div>
            </li>
              <li>
            <div class="item-content">
              <div class="item-media"><div style="color: #C0C0C0;"><i class="fa fa-lock"></i></div></div>
              <div class="item-inner">
                <div class="item-input">

                  <asp:TextBox ID="T_PhoneModifyPass" runat="server" placeholder="新密码（6—16位字符）" type="password"  style="font-size: 15px" MaxLength="16"></asp:TextBox>
            
            
                </div>
              </div>
            </div> 
              </li>
              </ul>
              <div style="font-size: 14px; text-align: center; padding-top: 13px; ">
                <asp:Label ID="Label6" runat="server" Text=""  Visible="False" ForeColor="#FF6666"></asp:Label>
                </div>
                    <p>
                       <input id="Btn_PhoneModify" type="button" value="保存并登录" class="button button-fill" style="font-family: 黑体;font-size: 17px;height: 40px"  />

                    </p>
                
                 
            </div>


  
            

    </div>



    </div>
<%--忘记密码 结束--%>
  
    </div>


        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>


        <script type="text/javascript">
       //弹出框
       function Msg1() {
           $.toast("请输入用户名");
       }
       function Msg2() {
           $.toast("请输入密码");
       }
       function Msg3() {
           $.toast("帐号或密码错误，请重新输入");
       }
    </script>
        <script type="text/javascript">
        $(function  () {
	        //获取短信验证码
            var validCode = true;
    
	        $(".msgs").click(function () {
	            var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
	            var iphone;
	            iphone = document.getElementById("T_PhoneLog").value;
	            if (iphone == '') {
	                $.toast("请输入手机号");
	            }
            
	            else if (!myreg.test(iphone)) {
	                $.toast("请输入有效手机号");
	       	            }
	            else {
       
	                var time = 60;
	                var code = $(this);
	                if (validCode) {
	                    validCode = false;
                
	                    sendsms();

	                    code.addClass("msgs1");

	                    var t = setInterval(function () {
	                        time--;
	                        code.html(time + "秒");
	                        if (time == 0) {
	                            clearInterval(t);
	                            code.html("重新获取");
	                            validCode = true;
	                            code.removeClass("msgs1");

	                        }
	                    }, 1000)
	                }


	            }

	        })
        })


            function sendsms () {
                var iphone;
                iphone = document.getElementById("T_PhoneLog").value;

                $(function () { 
                    var data = "{str:'" + iphone + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Login.aspx/SendSms", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "发送失败") {
                                $.toast("发送失败");
                    
                            } else if (data.d === "发送成功") {
                                $.toast("验证码已发送，请注意查收");

                                $("#Btn_PhoneLog").removeClass("disabled");
                        
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
            $("#Btn_PhoneLog").click(function () {
                var iphone;
                var iphonecode;
                iphone = document.getElementById("T_PhoneLog").value;
                iphonecode = document.getElementById("T_PhoneCode").value;
                var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
                if (iphone == '') {
                    $.toast("请输入手机号");
                }
                else if (!myreg.test(iphone)) {
                    $.toast("请输入有效手机号");
                }
                else if (iphonecode == '') {
                    $.toast("请输入验证码");
                }
                else {
                    iphonelog();
           
                }
        
      
                function iphonelog() {

                    $(function () {
                        var data = "{str1:'" + iphone + "',str2:'" + iphonecode + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Login.aspx/iPhoneLog", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "登录失败") {
                                    $.toast("验证码错误");

                                } else if (data.d === "登录成功") {
                            
                                    self.location = 'A_App.aspx';
                                    //window.location.href = 'A_App.aspx';
                                    $.toast("登录成功");

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
        $(function  () {
	        //获取短信验证码
            var validCode = true;
    
	        $(".msgs2").click(function () {
	            var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
	            var iphone;
	            iphone = document.getElementById("T_PhoneReg").value;
	            if (iphone == '') {
	                $.toast("请输入手机号");
	            }
            
	            else if (!myreg.test(iphone)) {
	                $.toast("请输入有效手机号");
	       	            }
	            else {
       
	                var time = 60;
	                var code = $(this);
	                if (validCode) {
	                    validCode = false;
                
	                    sendsms1();

	                    code.addClass("msgs3");

	                    var t = setInterval(function () {
	                        time--;
	                        code.html(time + "秒");
	                        if (time == 0) {
	                            clearInterval(t);
	                            code.html("重新获取");
	                            validCode = true;
	                            code.removeClass("msgs3");

	                        }
	                    }, 1000)
	                }


	            }

	        })
        })


            function sendsms1 () {
                var iphone;
                iphone = document.getElementById("T_PhoneReg").value;

                $(function () { 
                    var data = "{str:'" + iphone + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Login.aspx/SendSms", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "发送失败") {
                                $.toast("发送失败");
                    
                            } else if (data.d === "发送成功") {
                                $.toast("验证码已发送，请注意查收");

                        
                        
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
            $("#Btn_PhoneReg").click(function () {
        
                var iphone;
                var iphonecode;
                var iphonepass;
                var iphonepasslength;
        
                iphone = document.getElementById("T_PhoneReg").value;
                iphonecode = document.getElementById("T_PhoneRegCode").value;
                iphonepass = document.getElementById("T_PhoneRegPass").value;
                iphonepasslength = iphonepass.length;

                var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
               if (iphone == '') {
                    $.toast("请输入手机号");
                }
                else if (!myreg.test(iphone)) {
                    $.toast("请输入有效手机号");
                }
                else if (iphonecode == '') {
                    $.toast("请输入验证码");
                }
                else if (iphonepass=='') {
                    $.toast("请设置密码");
                }

                else if (iphonepasslength < 6) {
                    $.toast("密码必须6位以上");
                }
                else {
                    iphonereg();
           
                }
        
      
                function iphonereg() {

                    $(function () {
                        var data = "{str1:'" + iphone + "',str2:'" + iphonecode + "',str3:'" + iphonepass + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Login.aspx/iPhoneReg", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "注册失败") {
                                    $.toast("验证码错误");

                                }
                                else if (data.d === "已经注册") {
                                    $.toast("已经注册，请直接登录");
                                    //self.location = 'A_Login.aspx';
                                }
                                else if (data.d === "注册成功") {
                                    $.toast("注册成功");
                                    self.location = 'A_App.aspx';
                                    //window.location.href = 'A_App.aspx';
                            

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
$(function  () {
	//获取短信验证码
    var validCode = true;
    
	$(".msgs4").click(function () {
	    var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
	    var iphone;
	    iphone = document.getElementById("T_PhoneModify").value;
	    if (iphone == '') {
	        $.toast("请输入手机号");
	    }
            
	    else if (!myreg.test(iphone)) {
	        $.toast("请输入有效手机号");
	       	    }
	    else {
       
	        var time = 60;
	        var code = $(this);
	        if (validCode) {
	            validCode = false;
                
	            sendsms2();

	            code.addClass("msgs5");

	            var t = setInterval(function () {
	                time--;
	                code.html(time + "秒");
	                if (time == 0) {
	                    clearInterval(t);
	                    code.html("重新获取");
	                    validCode = true;
	                    code.removeClass("msgs5");

	                }
	            }, 1000)
	        }


	    }

	})
})


    function sendsms2 () {
        var iphone;
        iphone = document.getElementById("T_PhoneModify").value;

        $(function () { 
            var data = "{str:'" + iphone + "'}";
            $.ajax({
                type: "Post", //要用post方式   
                url: "A_Login.aspx/SendSms", //方法所在页面和方法名
                contentType: "application/json; charset=utf-8",
                data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                dataType: "json",
                success: function (data) {
                    if (data.d === "发送失败") {
                        $.toast("发送失败");
                    
                    } else if (data.d === "发送成功") {
                        $.toast("验证码已发送，请注意查收");

                        
                        
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
            $("#Btn_PhoneModify").click(function () {
                var iphone;
                var iphonecode;
                var iphonepass;
                var iphonepasslength;
                iphone = document.getElementById("T_PhoneModify").value;
                iphonecode = document.getElementById("T_PhoneModifyCode").value;
                iphonepass = document.getElementById("T_PhoneModifyPass").value;
                iphonepasslength = iphonepass.length;

                var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
                if (iphone == '') {
                    $.toast("请输入手机号");
                }
                else if (!myreg.test(iphone)) {
                    $.toast("请输入有效手机号");
                }
                else if (iphonecode == '') {
                    $.toast("请输入验证码");
                }
                else if (iphonepass=='') {
                    $.toast("请设置密码");
                }

                else if (iphonepasslength < 6) {
                    $.toast("密码必须6位以上");
                }
                else {
                    iphonemodify();
           
                }
        
      
                function iphonemodify() {

                    $(function () {
                        var data = "{str1:'" + iphone + "',str2:'" + iphonecode + "',str3:'" + iphonepass + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Login.aspx/iPhoneModify", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "修改失败") {
                                    $.toast("验证码错误");

                                }
                        
                                else if (data.d === "修改成功") {
                                    $.toast("登录成功");
                                    self.location = 'A_App.aspx';
                                    //window.location.href = 'A_App.aspx';
                            

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
                    function WXLogin1() {


                        //sleep(3000);

                        //WXLogin2();

                        var a1;
                        var jsonObj = { "name": "傅红雪", "age": "24", "profession": "刺客" };
                        var eValue = eval('jsonObj.' + 'age');
                        //alert(eValue);

                        var n;
                        

                        function sleep(numberMillis) {
                            //now = new date();
                            var now = new Date();
                            
                            //debugger
                            var exitTime = now.getTime() + numberMillis;
                            while (true) {
                                var now = new Date();
                                
                                //alert(exitTime);
                                //alert(now.getTime());
                                if (now.getTime() > exitTime){
                                    //debugger
                                    alert('时间到');

                                    return;
                                }
                            }
                        }



                    }
                </script>
         <script type="text/javascript">
                    function WXLogin2() {

                        $appid = 'wxd19bd0389e56e567';
                        $redirect_uri = 'http%3a%2f%2fmy.aiwei.biz%2faw';
                        $url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' + $appid + '&redirect_uri=' + $redirect_uri + '&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect';
                        //$url = 'https://www.baidu.com?code=123456';
                        self.location = $url;

                    }
                </script>
        <script type="text/javascript">
            function WXLogin() {
                var openid;

                    $appid = 'wxd19bd0389e56e567';
                    $redirect_uri = 'http%3a%2f%2fmy.aiwei.biz%2faw';
                    $url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=' + $appid + '&redirect_uri=' + $redirect_uri + '&response_type=code&scope=snsapi_base&state=STATE#wechat_redirect';

                    self.location = $url;
                    
                    
                    function GetRequest() {
                        
                        //var url = location.search; //获取url中"?"符后的字串    
                        //window.location.href("http://www.mozilla.org");
                        var url = window.location.href
                        //var url = $url;
                        var theRequest = new Object();
                        if (url.indexOf("?") != -1) {
                            var str = url.substr(url.indexOf("?") + 1);

                            strs = str.split("&");
                            for (var i = 0; i < strs.length; i++) {
                                theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
                            }
                        }
                        return theRequest;
                    }

                    var Request = new Object();

                    while (typeof code == "undefined") {
                        
                        Request = GetRequest();
                        var code = Request["code"];

                    }

                    alert(code);
                    //getopenid();

                function getopenid() {
                        //alert(code)
                        $(function (){
      
                            var data = "{str1:'" + code + "'}";
                            $.ajax({
                                type: "Post", //要用post方式   
                                url: "A_Login.aspx/GetOpenid", //方法所在页面和方法名
                                contentType: "application/json; charset=utf-8",
                                data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                                dataType: "json",
                                success: function (data) {
                                    if (data.d != "失败") {

                                        var jsonObj = JSON.parse(data.d)
                                        var eValue = eval('jsonObj.' + 'openid');
                                        openid = eValue;

                                        self.location = 'A_App.aspx';

                                        getWX();
                                        
                                        //alert(eValue);
                                    }

                                },
                                error: function (err) {
                                    alert(err);
                                }
                            });
                            return false; //禁用按钮的提交
                        });
                    }
                

                function getWX() {

                    $(function () {
                        var data = "{str1:'" + openid + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Login.aspx/GetWX", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "成功") {
                                    //alert('登录成功');

                                    //self.location = 'A_App.aspx';
                                    
                                    //$.router.load('A_Notice.aspx', true)
                                }
                                else if (data.d === "失败") {
                                    //$.toast("已经删除");
                                    //$.router.back();
                                    self.location = 'A_Login.aspx';
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

          }
       </script>

        





</div> 
        


 </form> 


  </body>
</html>
