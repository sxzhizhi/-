<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Group.aspx.vb" Inherits="A_Group" %>

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

    <div class="page" id='Addr'>

        <header class="bar bar-nav">
    
    <h1 class="title">创建群</h1>
        
        <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
          返回
        </a>
        
        <a class="button button-link button-nav pull-right" href="#" id="but_SaveGroup"  data-transition='slide-out'>
          保存
        </a>
  </header>  
    





 <div class="content" style="top: 20px" >
             


     <div class="list-block media-list">
    
    <ul>
      <!-- Text inputs -->
        <li>
        <div class="item-content">
          
          <div class="item-inner">
            
            <div class="item-input">
                    
                <input type="text" id="T_GroupName" placeholder="请输入群名称" value ="" maxlength="30" />
            </div>
          </div>
        </div>
      </li>
    </ul>

                 

             <ul><li class="list-group-title" style="font-size: 13px">全部成员</li> </ul>




            <%Dim rs As New ADODB.Recordset  %>
            <%If Session("usercode")<>"" then %>
            <%rs = cPConn.Execute("select * from [dbUserView] where zDeptCode='" & Session("usercode") & "' order by cClassName ") %>

              <%If rs.RecordCount <> 0 Then %>
                    <ul>
<%--         <li>
                        <label class="label-checkbox item-content" onclick="checkall();">
                          <input type="checkbox" name="checkboxall" value ="" />
                          <div class="item-media"><i class="icon icon-form-checkbox"></i></div>
                          <div class="item-inner">
                            <div class="item-title-row">
                              <div class="item-title">全选</div>
                              <div class="item-after" style="font-size: small"></div>
                            </div>
                            
                            
                          </div>
                        </label>
                      </li>--%>





                <% For i = 1 To rs.RecordCount %>
              
                      <li>
                        <label class="label-checkbox item-content">
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
                        <label class="label-checkbox item-content">
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



</div> 
        
    


        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>


        <script type="text/javascript">
            $("#but_SaveGroup").click(function () {
                var cCode='';
                var cName='';
                var bSelect = false;
                var checkbox = document.getElementsByName("checkbox");

                if (document.getElementById("T_GroupName").value == '') {

                    $.toast("请输入群名称");

                }

                else {


                    for (var i = 0; i < checkbox.length; i++) {
                        if (checkbox[i].checked === true) {
                            bSelect = true;
                            break;
                        }
                    }



                    if (bSelect == false) {
                        $.toast("请选择成员");
                    }
                    else {



                        for (var i = 0; i < checkbox.length; i++) {
                            if (checkbox[i].checked === true) {
                                cCode = cCode + checkbox[i].value + ';';
                                cName = cName + document.getElementById('a' + (i + 1)).innerText + ';';


                            }
                        }
                        SaveGroup();
                        //alert(cCode+cName);
                        //执行保存

                    }
                }



                function SaveGroup() {
                    var GroupName = document.getElementById("T_GroupName").value

                $(function () {
                    var data = "{str1:'" + GroupName + "',str2:'" + cName + "'}";
                    $.ajax({
                        type: "Post", //要用post方式   
                        url: "A_Group.aspx/SaveGroup", //方法所在页面和方法名
                        contentType: "application/json; charset=utf-8",
                        data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d === "保存成功") {
                                //returnPL();
                                $.toast("保存成功");
                                self.location = 'A_Addr.aspx';
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


            })

            

            </script>


        </form> 
  </body>
</html>
