<%@ Page Language="VB" AutoEventWireup="false" CodeFile="A_XBKQ.aspx.vb" Inherits="A_XBKQ" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>考勤定位</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.4&key=49b5dd8d67a0b679b689a79907dd378e"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    </head> 
<body>

           
    <div class="page-group">

  <div class="page" id='KQ'>

      

    <header class="bar bar-nav">
    <a class="button button-link button-nav pull-left back" href="#" data-transition='slide-out'>
      返回
    </a>
    <h1 class="title">签到</h1>
       


  </header>  
<div class="content">


<div id='container'></div>
<div id="tip"></div>

    </div>
      </div>
        </div>


 <script src="js/jquery-2.1.1.js"></script>
<script type="text/javascript">
/***************************************
由于Chrome、IOS10等已不再支持非安全域的浏览器定位请求，为保证定位成功率和精度，请尽快升级您的站点到HTTPS。
***************************************/
    var map, geolocation;
    var addr;
    //加载地图，调用浏览器定位服务
    map = new AMap.Map('container', {
        resizeEnable: true
    });
    map.plugin('AMap.Geolocation', function() {
        geolocation = new AMap.Geolocation({
            enableHighAccuracy: true,//是否使用高精度定位，默认:true
            timeout: 10000,          //超过10秒后停止定位，默认：无穷大
            buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
            zoomToAccuracy: true,      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
            buttonPosition:'RB'
        });
        map.addControl(geolocation);
        geolocation.getCurrentPosition();
        AMap.event.addListener(geolocation, 'complete', onComplete);//返回定位信息

        AMap.event.addListener(geolocation, 'error', onError);      //返回定位出错信息
        
        
    });
    //解析定位结果
    function onComplete(data) {
        var str=['定位成功'];
        str.push('经度：' + data.position.getLng());
        str.push('纬度：' + data.position.getLat());
        if(data.accuracy){
             str.push('精度：' + data.accuracy + ' 米');
        }//如为IP精确定位结果则没有精度信息
        str.push('是否经过偏移：' + (data.isConverted ? '是' : '否'));
        document.getElementById('tip').innerHTML = str.join('<br>');

        addr = data.formattedAddress;

        
        
        KQ();


    }
    //解析定位错误信息
    function onError(data) {
        document.getElementById('tip').innerHTML = '定位失败';
    }

    function KQ() {


            
            var data = "{str1:'" + addr + "'}";
              $.ajax({
                  type: "Post", //要用post方式   
                  url: "A_XBKQ.aspx/KQ", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "成功") {

                          alert('签退成功!\n'+ addr);
                          //$.toast("签退成功");
                          self.location = 'A_QD.aspx';
                         
                      }
                      else if (data.d === "失败") {

                          
                      
                      } //if的尾括号
                  },
                  error: function (err) {
                      alert(err);
                  }
              });
              return false; //禁用按钮的提交



      };
</script>

</body>
</html>