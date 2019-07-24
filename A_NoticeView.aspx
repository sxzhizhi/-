<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_NoticeView.aspx.vb" Inherits="A_NoticeView" %>

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
    <style type="text/css"></style>

</head>
<body>
    <form id ="Form" runat="server">
    <div></div>
    
       
    <div class="page-group">

    <%--查看通知内容--%>
    <div class="page" id='NoticeView'>
    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-no-cache="true" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">通知详情</h1>
<a class="button button-link button-nav pull-right" href="#" data-transition='slide-out' id="but_Del" runat="server">
      
    </a>
  </header>   
    <div class="content"  style="top: 20px">   
    <div class="list-block">

        <ul>
          <!-- Text inputs -->
          <li>
          <div class="item-content" style="display:none">
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
                <div id ="name" style="font-size: small; color: #999999" runat="server"></div>
                <div id ="date" style="font-size: small; color: #999999" runat="server"></div>
            </div>
          </div>
        </div>
      </li>
            <li id="viewuser" style="display:none">
        <div class="item-content">
          
          <div class="item-inner">
            <div class="item-input">
                <div id ="T_cJoinName1" style="font-size: small; color: #999999" runat="server"></div>
                
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
            <img id="imgPre1" src="" style="display: block; width: 50%; height: auto;"  runat="server" /> 
            </div>            
              
              </div>
            </div>
          </div>

</li>

    </ul>
  
    <div class="buttons-tab fixed-tab" data-offset="44">
    <a href="#tab1" class="tab-link active button" id="view5" runat="server">评论<div id="view6" runat="server"></div></a>
    <a href="#tab2" class="tab-link button" id="view3" runat="server">已看</a>
    <a href="#tab3" class="tab-link button" id="view4" runat="server">未看</a>
  </div>
  
      
      <div class="content-block" style="height: 90px">
    <div class="tabs">
      <div id="tab1" class="tab active">
        <div id="PL" class="content-block" runat="server">
         

        </div>
      </div>
      <div id="tab2" class="tab">
        <div class="content-block">

        <div style="font-size: 14px" id="view1" runat="server"></div>
         
        </div>
      </div>
      <div id="tab3" class="tab">
        <div class="content-block">
                  <div style="font-size: 14px" id="view2" runat="server"></div>

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
            <script type="text/javascript">
        function getcode() {
            function GetRequest() {
                var url = location.search; //获取url中"?"符后的字串    
                var theRequest = new Object();
                if (url.indexOf("?") != -1) {
                    var str = url.substr(1);
                    strs = str.split("&");
                    for (var i = 0; i < strs.length; i++) {
                        theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
                    }
                }
                return theRequest;
            }


            var Request = new Object();
            Request = GetRequest();
            var a = Request["UnitCode"];
            var b = Request["UnitEdit"];


            if (a != "") {

                document.getElementById("T_code").value = a;
            }
            

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

                    //返回查看情况
                    returnview();
                    //返回评论
                    returnPL();
                    //返回收件人
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
    
        
        </form> 
  </body>
</html>
