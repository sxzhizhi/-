<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="css/bootstrap-fileinput.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
    <div class="page-header">
            <form>
            <div class="form-group" id="uploadForm" enctype='multipart/form-data'>
                <div class="h4">图片预览</div>
                <div class="fileinput fileinput-new" data-provides="fileinput"  id="exampleInputUpload">
                    <div class="fileinput-new thumbnail" style="width: 200px;height: auto;max-height:150px;">
                        <img id='picImg' style="width: 100%;height: auto;max-height: 140px;" src="img/noimage.png" alt="" />
                    </div>
                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                    <div>
                        <span class="btn btn-primary btn-file">
                            <span class="fileinput-new">选择文件</span>
                            <span class="fileinput-exists">更换</span>
                            <%--<input type="file" name="pic1" id="picID" accept="image/gif,image/jpeg,image/x-png">--%>
                            <input type="file"  id="file1" style="/* visibility: hidden */" capture="camera" accept="image/*,video/*" name="file" value="" />

                        </span>
                        <a href="javascript:;" class="btn btn-warning fileinput-exists" data-dismiss="fileinput">移除</a>
                    </div>
                </div>
            </div>
            <%--<button type="button" id="uploadSubmit" class="btn btn-info">提交</button>--%>
                <input type="button" value="上传" />
        </form>
        </div>
        </div>
    <script src="js/jquery-2.1.1.js"></script>
    <script src="js/ajaxfileupload.js"></script>
    <script src="js/bootstrap-fileinput.js"></script>
    <script type="text/javascript">
        $(function () {
            $(":button").click(function () {
                ajaxFileUpload();
            })
        })
        function ajaxFileUpload() {
            $.ajaxFileUpload
            (
                {
                    url: 'Default2.aspx', //用于文件上传的服务器端请求地址
                    secureuri: false, //是否需要安全协议，一般设置为false
                    fileElementId: 'file1', //文件上传域的ID
                    dataType: 'json', //返回值类型 一般设置为json
                    success: function (data, status)  //服务器成功响应处理函数
                    {
                        //$("#img1").attr("src", data.imgurl);
                        if (typeof (data.error) != 'undefined') {
                            if (data.error != '') {
                                alert(data.error);
                            } else {
                                alert(data.msg);
                            }
                        }
                    },
                    error: function (data, status, e)//服务器响应失败处理函数
                    {
                        alert(e);
                    }
                }
            )
            return false;
        }
    </script>



</body>
</html>
