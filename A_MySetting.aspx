<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_MySetting.aspx.vb" Inherits="A_MySetting" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>掌通办公</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1" />
    <link rel="shortcut icon" href="/favicon.ico" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />

    <link href="css/sm.css" rel="stylesheet" />
    <link href="css/sm-extend.css" rel="stylesheet" />
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />

    <style type="text/css">

.msgs2{display:inline-block;width:104px;color:#fff;font-size:12px;border:1px solid #0697DA;text-align:center;height:30px;line-height:30px;background:#0697DA;cursor:pointer;}
form .msgs3{background:#E6E6E6;color:#818080;border:1px solid #CCCCCC;}

</style>


</head>
<body>
    <form id="form1" runat="server">
        <div></div>


        <div class="page-group">

            <div class="page" id='MySetting'>

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




   
                            <a class="tab-item external" href="A_Addr.aspx">
                               
                                <span class="icon icon-card"></span>
                                <span class="tab-label">通讯录</span>
                                    <%If Session("AddrNumber") <> 0 Then %>
                                    <span class="badge"><%=Session("AddrNumber") %></span>
                                    <% End if %>
                            </a>


                                <a class="tab-item external active" href="A_MySetting.aspx#MySetting">
                                 
                                    <span class="icon icon-me"></span>
                                    <span class="tab-label">我</span>
                                </a>
                </nav>

                <div class="content">

                    <div class="list-block media-list">
                        <ul>
                            <li>
                                <div class="item-content">
                                    <div class="item-media">
                                        <img src="<%= Session("url") %>" style='width: 2.2rem;'></div>
                                    <div class="item-inner">
                                        <div class="item-title-row">
                                            <div class="item-title"><%=Session("username") %></div>
                                        </div>
                                        <div class="item-subtitle">
                                            <div style="font-size: 12px; color: #999999;">团队ID:<%=IIf(Session("usercode") <> "", Session("usercode"), "你还没找到组织!") %></div>
                                            <div style="font-size: 12px; color: #999999;" id="JF"  runat="server"></div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                   

                        <ul>
                            <li>
                                <div class="item-link list-button" style="text-align: left">
                                    用户名<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                    <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"><%=IIf(Session("userid") <> "", Session("userid"), Session("iphone")) %></div>
                                </div>


                            </li>
                              <%If Left(Session("iphone"), 2) <> "US" %>  
                            <li>
                                <div class="item-link list-button" style="text-align: left">
                                    绑定手机<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                    <%If Left(Session("iphone"), 2) <> "US" %>
                                    <div class="pull-right" style="font-size: 14px; color: #009933; padding-right: 10px;">已认证</div>
                                    <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"><%=Session("userid") %></div>
                                    <%'微信用户手机认证时把当前微信用户cookies也改一下 %>
                                    
                                    <%End if %>
                                </div>
                                

                            </li>
                            <% Else %>

                            <li><a href="#register">
                                <div class="item-link list-button" style="text-align: left">
                                    绑定手机<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                    <%If Left(Session("iphone"), 2) <> "US"Then %>
                                    <div class="pull-right" style="font-size: 14px; color: #009933; padding-right: 10px;">已认证</div>
                                    <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;"><%=Session("userid") %></div>
                                    <%'微信用户手机认证时把当前微信用户cookies也改一下 %>
                                    
                                    <%End if %>
                                </div>
                                </a>

                            </li>
                            <% End if %>
                            <li>
                                <a href="#ModifyName">
                                    <div class="item-link list-button" style="text-align: left">
                                        姓名<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div id="cName" class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="T_SetName" runat="server"></div>
                                        </div>
                                    </div>
                                </a>


                            </li>


                            <li>
                                <a href="#Modifysex">
                                    <div class="item-link list-button" style="text-align: left">
                                        性别<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="T_sex" runat="server"></div>
                                        </div>
                                    </div>
                                </a>  


                            </li>
                            <li>
                                <a href="#ModifyJob">
                                    <div class="item-link list-button" style="text-align: left">
                                        部门职位<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="T_SetJob" runat="server"></div></div>
                                        <div class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="T_Unit" runat="server"></div>
                                            </div>
                                    
                                        </div>
                                    </a>
                                        </li>
                            <li>
                                <a href="#ModifyEmail">
                                    <div class="item-link list-button" style="text-align: left">
                                        邮箱<span class="icon icon-right pull-right" style="font-size: 14px; color: #999999"></span>
                                        <div id="cEmail" class="pull-right" style="font-size: 14px; color: #999999; padding-right: 10px;">
                                            <div id="T_SetEmail" runat="server"></div>
                                    </div>
                                        </div>
                                    </a>

                            </li>


                        </ul>




                    </div>


                    <div class="list-block">
                        <ul>
                            <li>
                                <asp:LinkButton ID="LinkButton1" runat="server"><div class="item-link list-button">注销登录</div></asp:LinkButton></li>
                                
                        </ul>
                    </div>

                </div>

            </div>

            <div class="page" id='ModifyName'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">修改姓名</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SaveName">保存
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


                                            <input type="text" id="T_Name" placeholder="请输入真实姓名" value="" />
                       
                                        </div>
                                    </div>
                                </div>
                            </li>



                        </ul>
                    </div>
                    <div class="content-block-title">注：为方便审核请输入真实信息!</div>



                </div>
            </div>

            <div class="page" id='Modifysex'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">修改姓别</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SaveSex">保存
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
                                            <select id="sex">
                                                <option>男</option>
                                                <option>女</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>


                            </li>



                        </ul>
                    </div>




                </div>
            </div>

            <div class="page" id='ModifyJob'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">修改部门职位</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SaveJob">保存
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


                                            <input type="text" id="T_Job" placeholder="请输入职位" value="<%= Session("job") %>" />
                                        </div>
                                    </div>
                                </div>
                            </li>

                         <li>
                                <div class="item-content">

                                    <div class="item-inner">

                                        <div class="item-input">

                                            <input type="text" id='picker_Unit' placeholder="请选择部门"/>
                                            

                                        </div>
                                    </div>
                                </div>
                            </li>

                        </ul>
                    </div>



                </div>
            </div>

            <div class="page" id='ModifyEmail'>
                <header class="bar bar-nav">
                    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>返回
                    </a>
                    <h1 class="title">修改邮箱</h1>
                    <a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_SaveEmail">保存
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


                                            <input type="text" id="T_Email" placeholder="请输入邮箱" value="<%= Session("email") %>" />
                                        </div>
                                    </div>
                                </div>
                            </li>



                        </ul>
                    </div>



                </div>
            </div>


            <%--注册 开始--%>
  <div class="page" id='register'>
  <header class="bar bar-nav">
          <a class="button button-link button-nav pull-left back">
      <span class="icon icon-left"></span>
      
    </a>
    <h1 class='title'>手机号绑定</h1>

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
                   <input id="Btn_PhoneReg" type="button" value="立即绑定" class="button button-fill" style="font-family: 黑体;font-size: 17px;height: 40px"  />

                </p>
                                  <div style="padding-right: 15px; font-size: 13px; color: #C0C0C0;">
        <div style="float:left">我已阅读并同意<a href="#reg" style="color: #333333">用户协议</a></div>
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




        </div>






        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
        <%--        <script src="js/SUI/sm-extend.js"></script>
        <script src="js/SUI/demos.js"></script>--%>

        <script type="text/javascript">
            $(document).on("pageInit", function (e, pageId, $page) {
                if (pageId == "MySetting") {
                    //var cName = '';

                    //returnsex();

                    //$.toast("设置页面");

                }
                else if (pageId == "Modifysex") {

                    document.getElementById("sex").value = document.getElementById("T_sex").innerText;;

                }
                else if (pageId == "ModifyName") {

                    document.getElementById("T_Name").value = document.getElementById("T_SetName").innerText;

                }
                else if (pageId == "ModifyJob") {
                    setunit();
                    document.getElementById("picker_Unit").value = document.getElementById("T_Unit").innerText;
                    document.getElementById("T_Job").value = document.getElementById("T_SetJob").innerText;

                }
                else if (pageId == "ModifyEmail") {

                    document.getElementById("T_Email").value = document.getElementById("T_SetEmail").innerText;

                }
                function returnsex() {

                    $(function () {
                        var data = "{str1:'" + cName + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_MySetting.aspx/returnsex", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "失败") {
                                    document.getElementById("T_sex").innerText = data.d;
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

                var unitname;
                function setunit() {
                    var data = "{str1:'" + unitname + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_MySetting.aspx/ReturnUnit", //方法所在页面和方法名
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
  <h1 class="title">选择部门</h1>\
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
            $("#but_SaveName").click(function () {
                var cName;

                cName = document.getElementById("T_Name").value;

                if (cName == '') {
                    $.toast("不能为空，请输入真实姓名");
                }
                else {
                    savename();

                }


                function savename() {

                    $(function () {
                        var data = "{str1:'" + cName + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_MySetting.aspx/savename", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    document.getElementById("T_SetName").innerText = cName;
                                    $.toast("保存成功");
                                    $.router.back();
                                    //$.router.load("#MySetting");
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
            $("#but_SaveSex").click(function () {
                var csex;
                csex = document.getElementById("sex").value;
                savesex();

                function savesex() {

                    $(function () {
                        var data = "{str1:'" + csex + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_MySetting.aspx/savesex", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    document.getElementById("T_sex").innerText = csex;

                                    $.toast("保存成功");
                                    $.router.back();
                                    
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
            $("#but_SaveJob").click(function () {
                var cJob;
                var cUnit;
                cJob = document.getElementById("T_Job").value;
                cUnit = document.getElementById("picker_Unit").value;

                

                if (cJob == '') {
                    $.toast("不能为空，请输入职位");
                }
                else {
                    savejob();

                }


                function savejob() {

                    $(function () {
                        var data = "{str1:'" + cJob + "',str2:'" + cUnit + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_MySetting.aspx/savejob", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    document.getElementById("T_Unit").innerText = cUnit;
                                    document.getElementById("T_SetJob").innerText = cJob;
                                    $.toast("保存成功");
                                    //$.MySetting.back();
                                    $.router.back();
                                    //self.location = 'A_MYSetting.aspx';
                                } //if的尾括号
                                else if (data.d === "部门不存在") {

                                    document.getElementById("T_SetJob").innerText = cJob;

                                    if (cUnit != '') {
                                    
                                    $.toast("部门不存在，管理员设置后再试！");
                                    
                                    };

                                    $.router.back();

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
            $("#but_SaveEmail").click(function () {
                var cEmail;

                cEmail = document.getElementById("T_Email").value;
                if (cEmail == '') {
                    $.toast("请输入邮箱");
                }
                else {
                    saveemail();

                }


                function saveemail() {

                    $(function () {
                        var data = "{str1:'" + cEmail + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_MySetting.aspx/saveemail", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "保存成功") {
                                    document.getElementById("T_SetEmail").innerText = cEmail;
                                    $.toast("保存成功");
                                    //$.MySetting.back();
                                    $.router.back();
                                    //self.location = 'A_MYSetting.aspx';
                                } //if的尾括号
                                 if (data.d === "邮箱格式不正确") {

                                    $.toast("邮箱格式不正确");
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
            function exitname() {

                $.confirm('确定要注销当前登录用户?',
                  function () {
                      //document.getElementById("Button1").click;
                      
                      //Exit();
                      //$.alert('You clicked Ok button');
                  },
                  function () {
                      //$.alert('You clicked Cancel button');
                  }
                );



                function Exit() {

                    $(function () {
                        var data = "{str1:'" + cName + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_MySetting.aspx/ExitUser", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "成功") {

                                    $.toast("注销成功");
                                    self.location = 'A_Login.aspx';
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


            };
        </script>

 <script type="text/javascript">
     var unitname;
     function setunit () {
         var data = "{str1:'" + unitname + "'}";
         $.ajax({
             type: "Post", //要用post方式   
             url: "A_MySetting.aspx/ReturnUnit", //方法所在页面和方法名
             contentType: "application/json; charset=utf-8",
             data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
             dataType: "json",
             success: function (data) {
                 if (data.d !=  "error") {
                     unitname = data.d;

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

     
     unitname = ['iPhone 4', 'iPhone 4S'];
     //unitname =[ 'iPhone 4', 'iPhone 4S', 'iPhone 5', 'iPhone 5S', 'iPhone 6', 'iPhone 6 Plus', 'iPad 2', 'iPad Retina', 'iPad Air', 'iPad mini', 'iPad mini 2', 'iPad mini 3'];

     $("#picker_Unit").picker({
         
  toolbarTemplate: '<header class="bar bar-nav">\
  <button class="button button-link pull-left"></button>\
  <button class="button button-link pull-right close-picker">确定</button>\
  <h1 class="title">选择部门</h1>\
  </header>',
  cols: [
    {
      textAlign: 'center',
      values: unitname
    }
  ]
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
                            url: "A_MySetting.aspx/iPhoneReg", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "注册失败") {
                                    $.toast("验证码错误");

                                }
                                else if (data.d === "已经注册") {
                                    $.toast("已绑定");
                                    //self.location = 'A_Login.aspx';
                                }
                                else if (data.d === "注册成功") {
                                    $.toast("绑定成功");
                                    self.location = 'A_Mysetting.aspx';
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
    </form>
</body>
</html>
