<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_Import.aspx.vb" Inherits="A_Import" %>

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

    <div class="page" id='import'>

        <header class="bar bar-nav">
    
    <h1 class="title">导入工资条</h1>
        
        <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
          返回
        </a>
        
        <a class="button button-link button-nav pull-right" href="#" id="but_ImportData"  data-transition='slide-out'>
          导入
        </a>
  </header>





        
 <div class="content" style="top: 20px" >

<div class="list-block">
  <div style="padding-right: 13px; padding-left: 13px; padding-top: 20px;">
    <input type="file"onchange="importf(this)" />
</div>


        <div id="demo"></div>


                    </div>

          </div>
</div>



</div> 
        
    

        <script src="js/xlsx.full.min.js"></script>
        <script src="js/SUI/zepto.js"></script>
        <script src="js/SUI/sm.js"></script>
        <script>
            /*
            FileReader共有4种读取方法：
            1.readAsArrayBuffer(file)：将文件读取为ArrayBuffer。
            2.readAsBinaryString(file)：将文件读取为二进制字符串
            3.readAsDataURL(file)：将文件读取为Data URL
            4.readAsText(file, [encoding])：将文件读取为文本，encoding缺省值为'UTF-8'
                         */
            var wb;//读取完成的数据
            var rABS = false; //是否将文件读取为二进制字符串

            function importf(obj) {//导入
                if (!obj.files) {
                    return;
                }
                var f = obj.files[0];
                var reader = new FileReader();
                reader.onload = function (e) {
                    var data = e.target.result;
                    if (rABS) {
                        wb = XLSX.read(btoa(fixdata(data)), {//手动转化
                            type: 'base64'
                        });
                    } else {
                        wb = XLSX.read(data, {
                            type: 'binary'
                        });
                    }
                    //wb.SheetNames[0]是获取Sheets中第一个Sheet的名字
                    //wb.Sheets[Sheet名]获取第一个Sheet的数据
                    document.getElementById("demo").innerHTML = JSON.stringify(XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]));
                    $.toast("数据载入，点击导入");


                };
                if (rABS) {
                    reader.readAsArrayBuffer(f);
                } else {
                    reader.readAsBinaryString(f);
                }
            }

            function fixdata(data) { //文件流转BinaryString
                var o = "",
                    l = 0,
                    w = 10240;
                for (; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
                o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
                return o;
            }
        </script>

        <script type="text/javascript">
            $("#but_GLCY").click(function () {
                var cCode='';
                var cName='';
                var bSelect = false;
                var checkbox = document.getElementsByName("checkbox");

                //if (document.getElementById("T_GroupName").value == '') {

                //    $.toast("请输名称");

                //}

                //else {


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

                        $.confirm('确定删除成员?',
                            function () {

                                //$.alert('You clicked Ok button');
                                for (var i = 0; i < checkbox.length; i++) {
                                    if (checkbox[i].checked === true) {
                                        cCode = cCode + checkbox[i].value + ';';
                                        cName = cName + document.getElementById('a' + (i + 1)).innerText + ';';


                                    }
                                }
                                //执行删除
                                DelCY();
                                //alert(cName);
                                

                            },

                        );


                    }
                //}

                function DelCY() {
                    //var GroupName = document.getElementById("T_GroupName").value
                    var GroupName = '';
                    $(function () {
                        var data = "{str1:'" + GroupName + "',str2:'" + cName + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_GLCY.aspx/DelCY", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d === "成功") {
                                    //returnPL();
                                    $.toast("删除成功");
                                    self.location = 'A_Setting.aspx';
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

        <script type="text/javascript">
            $("#but_ImportData").click(function () {
                var cData;
                cData = document.getElementById("demo").innerHTML;

                if (cData != '') {
                    //alert(cData);
                    ImportData();
                }
                else {
                    $.toast("没有数据");
                }


                function ImportData() {
                    //var GroupName = document.getElementById("T_GroupName").value
                    var cc = cData;
                    $(function () {
                        var data = "{str1:'" + cc + "'}";
                        $.ajax({
                            type: "Post", //要用post方式   
                            url: "A_Import.aspx/ImportData", //方法所在页面和方法名
                            contentType: "application/json; charset=utf-8",
                            data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != '') {
                                    alert(data.d);
                                    //$.toast("导入成功");
                                    //self.location = 'A_App.aspx';
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
