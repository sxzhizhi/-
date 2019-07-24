<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_HelpView.aspx.vb" Inherits="A_HelpView" %>

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
        

        <div class="page" id='HelpList1-1'>


        <header class="bar bar-nav">
        <a class="button button-link button-nav pull-left external" href="A_App.aspx" data-transition='slide-out'>
          返回
        </a>
        <h1 class="title">问题详情</h1>
         

        
      </header>   
<div class="content">
                      


<div class="card facebook-card">

    <div class="card-content">

      
                                <div class="card-content-inner">
                          
                          <div style="font-family: 黑体; font-size: 16px;" id="BT" runat="server"></div>
                            <div style="color: #999999; font-size: 13px" id="NR" runat="server"></div>
                                                  <div align="center" style="padding-bottom: 10px">
            <img id="imgPre2" src="" style="display: block; width: 50%; height: auto;" runat="server" /> 
            </div>
                        </div>
    </div>
    <div class="card-footer no-border">
                        <div style="color: #666666; font-size: 13px" id="GZ" runat="server">关注</div>
                        <div class="row">
      
      <div class="col-100"><a href="#HD" id="but_HD" style="font-size: 14px; color: #0894EC;" class="button">添加回答</a></div>
                           
    </div>
                        
    </div>

  </div>
    <div class="list-group-title" style="font-size: 13px; color: #808080; padding-left: 15px;" id="HDNumber" runat="server">0个回答</div>
    
    <div id="HDList" runat="server">





        </div>
    
 

              <div class="list-block" style="display:none">

        <ul>
          <!-- Text inputs -->
          <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_Code" runat="server" placeholder="系统编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
                      <li>
          <div class="item-content">
            <div class="item-inner">
              
              <div class="item-input" >
                  <asp:TextBox ID="T_CodeList" runat="server" placeholder="系统编码"></asp:TextBox>
              </div>
            </div>
          </div>
          </li>
            </ul>
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
                  <asp:TextBox ID="T_Code1" runat="server" placeholder="系统编码"></asp:TextBox>
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
                  <asp:TextBox ID="T_HD" runat="server" placeholder="写回答..." TextMode="MultiLine" Height="173px" MaxLength="100"></asp:TextBox>
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
<%--        <script src="js/lrz.all.bundle.js"></script>
        <script src="js/canvas-to-blob.min.js"></script>--%>
          <script type="text/javascript">
              $(document).on("pageInit", function (e, pageId, $page) {
                  if (pageId == "HelpList1-1") {
                      var cCode =  document.getElementById("T_Code").value;
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
                    $("#but_TJ").click(function () {
                        var cListCode,cHD;
                        cListCode = document.getElementById("T_Code1").value;
                        cHD = document.getElementById("T_HD").value;

                        var checkboxNM = document.getElementsByName("checkboxNM");
                        var iNM;
                        if (checkboxNM[0].checked === true) {
                            iNM = '1'
                        }
                        else {
                            iNM = '0'
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
                                    url: "A_HelpView.aspx/TJ", //方法所在页面和方法名
                                    contentType: "application/json; charset=utf-8",
                                    data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                                    dataType: "json",
                                    success: function (data) {
                                        if (data.d != "失败") {

                                            $.toast("提交成功，积分+3");
                                            //self.location = 'A_Help.aspx';
                                            
                                            //var div = document.createElement('div'); // 新增元素
                                            //div.innerHTML = '<div class="card facebook-card" id="a"><a href ="#" onclick=""><div class="card-content"><div style = "width:0.9rem; height:0.9rem; border-radius:50%; overflow:hidden;">' +
                                            //'<img src="" style="width: 0.9rem;"></div></div>' +
                                            //'<div Class="facebook-name" style="padding-top: 10px; font-size: 13px; color: #999999;"></div>' +
                                            //'<div Class="card-content-inner">' +
                                            //'<div style = "color: #333333; font-size: 13px;" ></div>' +
                                            //'<div style="color: #999999; font-size: 13px;"></div></div>' +
                                            //'</div></a></div>'

                                            //var diva = document.getElementById('HDList'); // 获取id为a的元素
                                            //diva.parentNode.insertBefore(div, diva); // 在这个元素前面增加上去
                                            //diva.parentNode.appendChild(div);
                                            $("#HDList").html(data.d);
                                            $.router.back();

                                            //$.router.load('A_Notice.aspx', true)
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
            $("#but_HD").click(function () 
            {
                var cBT = document.getElementById("BT").innerText;
                if (cBT.length >= 13) {
                    cBT = cBT.substring(0, 12) + '...';
                }
                document.getElementById("WT").innerText = cBT;
                //document.getElementById("T_Code1").value = document.getElementById("T_Code").value;

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





        </form> 
  </body>
</html>
