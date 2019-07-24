
//60秒刷新仪表计数器
function fuu() {
   // $(function () {

        $.ajax({
            type: "Post", //要用post方式   
            url: "Main.aspx/getData", //方法所在页面和方法名
            contentType: "application/json; charset=utf-8",
            data: "{}", //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
            dataType: "json",
            success: function (data) {

                function f1() {
                    var iData1 = (parseFloat(JSON.parse(data.d)[0]) / 100).toFixed(4);
                    var $topLoader1 = $("#topLoader1").percentageLoader({
                        width: 150, height: 150, controllable: false, progress: iData1, onProgressUpdate: function (val) {
                            $topLoader1.setValue(Math.round(val * 100.0));
                        }
                    });
                    var topLoaderRunning = false;
                   // $("#animateButton1").click(function () {

                        if (topLoaderRunning) {
                            return;
                        }
                        topLoaderRunning = true;
                        $topLoader1.setProgress(0);
                        //              $topLoader1.setValue('0');
                        var kb = 0;
                        var totalKb = iData1;

                        var animateFunc = function () {
                            kb += 0.01;
                            $topLoader1.setProgress(kb);

                            //                  $topLoader1.setValue(kb.toString() + '');

                            if (kb < totalKb) {
                                setTimeout(animateFunc, 25);
                            } else {
                                $topLoader1.setProgress(totalKb);
                                topLoaderRunning = false;
                            }
                        }

                        setTimeout(animateFunc, 25);

                   // });

                };
                
                

                function f2() {
                    var iData2 = (parseFloat(JSON.parse(data.d)[1]) / 100).toFixed(4);
                    var $topLoader2 = $("#topLoader2").percentageLoader2({
                        width: 150, height: 150, controllable: false, progress: iData2, onProgressUpdate: function (val) {
                            $topLoader2.setValue(Math.round(val * 100.0));
                        }
                    });
                    var topLoaderRunning = false;
                   // $("#animateButton1").click(function () {
                        if (topLoaderRunning) {
                            return;
                        }
                        topLoaderRunning = true;
                        $topLoader2.setProgress(0);
                        //                  $topLoader.setValue('0');
                        var kb = 0;
                        var totalKb = iData2;

                        function animateFunc() {
                            kb += 0.01;
                            $topLoader2.setProgress(kb);
                            //                      $topLoader.setValue(kb.toString() + '');

                            if (kb < totalKb) {
                                setTimeout(animateFunc, 25);

                            } else {
                                $topLoader2.setProgress(totalKb);
                                topLoaderRunning = false;
                            }
                        }

                        setTimeout(animateFunc, 25);

                  //  });
                };
                
               
                
                function f3() {
                    var iData3 = (parseFloat(JSON.parse(data.d)[2]) / 2000).toFixed(4);
                    var $topLoader3 = $("#topLoader3").percentageLoader3({
                        width: 150, height: 150, controllable: false, progress: iData3, onProgressUpdate: function (val) {
                            $topLoader3.setValue(Math.round(val * 2000.0));
                        }
                    });
                    var topLoaderRunning = false;
                   // $("#animateButton1").click(function () {
                        if (topLoaderRunning) {
                            return;
                        }
                        topLoaderRunning = true;
                        $topLoader3.setProgress(0);
                        //                  $topLoader.setValue('0');
                        var kb = 0;
                        var totalKb = iData3;

                        var animateFunc = function () {
                            kb += 0.01;
                            $topLoader3.setProgress(kb);
                            //                      $topLoader.setValue(kb.toString() + '');

                            if (kb < totalKb) {
                                setTimeout(animateFunc, 25);

                            } else {
                                $topLoader3.setProgress(totalKb);
                                topLoaderRunning = false;
                            }
                        }

                        setTimeout(animateFunc, 25);

                 //   });
                };
                
                

                function f4() {
                    var iData4 = (parseFloat(JSON.parse(data.d)[3]) / 200).toFixed(4);
                    var $topLoader4 = $("#topLoader4").percentageLoader4({
                        width: 150, height: 150, controllable: false, progress: iData4, onProgressUpdate: function (val) {
                            $topLoader4.setValue(Math.round(val * 200.0));
                        }
                    });
                    var topLoaderRunning = false;
                   // $("#animateButton1").click(function () {
                        if (topLoaderRunning) {
                            return;
                        }
                        topLoaderRunning = true;
                        $topLoader4.setProgress(0);
                        //                  $topLoader.setValue('0');
                        var kb = 0;
                        var totalKb = iData4;

                        var animateFunc = function () {
                            kb += 0.01;
                            $topLoader4.setProgress(kb);
                            //                      $topLoader.setValue(kb.toString() + '');

                            if (kb < totalKb) {
                                setTimeout(animateFunc, 25);

                            } else {
                                $topLoader4.setProgress(totalKb);
                                topLoaderRunning = false;
                            }
                        }

                        setTimeout(animateFunc, 25);

                //    });
                };
                
               

                function f5() {
                    iData5 = (parseFloat(JSON.parse(data.d)[4]) / 100).toFixed(4);
                    var $topLoader5 = $("#topLoader5").percentageLoader5({
                        width: 150, height: 150, controllable: false, progress: iData5, onProgressUpdate: function (val) {
                            $topLoader5.setValue(Math.round(val * 100.0));
                        }
                    });
                    var topLoaderRunning = false;
                  //  $("#animateButton1").click(function () {
                        if (topLoaderRunning) {
                            return;
                        }
                        topLoaderRunning = true;
                        $topLoader5.setProgress(0);
                        //              $topLoader1.setValue('0');
                        var kb = 0;
                        var totalKb = iData5;

                        var animateFunc = function () {
                            kb += 0.01;
                            $topLoader5.setProgress(kb);

                            //                  $topLoader1.setValue(kb.toString() + '');

                            if (kb < totalKb) {
                                setTimeout(animateFunc, 25);
                            } else {
                                $topLoader5.setProgress(totalKb);
                                topLoaderRunning = false;
                            }
                        }

                        setTimeout(animateFunc, 25);

                //    });
                };
                
                

                function f6() {
                    var iData6 = (parseFloat(JSON.parse(data.d)[5]) / 100).toFixed(4);
                    var $topLoader6 = $("#topLoader6").percentageLoader6({
                        width: 150, height: 150, controllable: false, progress: iData6, onProgressUpdate: function (val) {
                            $topLoader6.setValue(Math.round(val * 100.0));
                        }
                    });
                    var topLoaderRunning = false;
                  //  $("#animateButton1").click(function () {
                        if (topLoaderRunning) {
                            return;
                        }
                        topLoaderRunning = true;
                        $topLoader6.setProgress(0);
                        //              $topLoader1.setValue('0');
                        var kb = 0;
                        var totalKb = iData6;

                        var animateFunc = function () {
                            kb += 0.01;
                            $topLoader6.setProgress(kb);

                            //                  $topLoader1.setValue(kb.toString() + '');

                            if (kb < totalKb) {
                                setTimeout(animateFunc, 25);
                            } else {
                                $topLoader6.setProgress(totalKb);
                                topLoaderRunning = false;
                            }
                        }

                        setTimeout(animateFunc, 25);

                //    });
                };
               
                $("#topLoader1").text("");
                $("#topLoader2").text("");
                $("#topLoader3").text("");
                $("#topLoader4").text("");
                $("#topLoader5").text("");
                $("#topLoader6").text("");
                f1(); f2(); f3(); f4(); f5(); f6();
               
            },
            error: function (err) {
                alert(err);
            }
        });//Ajax尾括号
        return false; //禁用按钮的提交

   // });//侦听尾括号
};//fuu()尾括号
setInterval(fuu, 60000);
setTimeout(fuu, 0);


      //60秒循环刷新统计图
      function fu() {
                  var dData10;

                  //自动载入数据
                  //$(function () {

                      $.ajax({
                          type: "Post", //要用post方式   
                          url: "Main.aspx/getData10", //方法所在页面和方法名   
                          contentType: "application/json; charset=utf-8",
                          data: "{}", //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                          dataType: "json",
                          success: function (data) {
                              if (data.d === "无数据") {

                                  alert("该地块暂无数据!");
                              } else {

                                  dData10 = JSON.parse(data.d);

                                  $('#container').highcharts({
                                      chart: {
                                      },
                                      title: {
                                          text: '数据曲线'
                                      },

                                      //x轴
                                      xAxis: {
                                          categories: [dData10[9], dData10[8], dData10[7], dData10[6], dData10[5], dData10[4], dData10[3], dData10[2], dData10[1], dData10[0]]
                                      },
                                      tooltip: {
                                          formatter: function () {
                                              var s;
                                              if (this.point.name) { // the pie chart                   
                                                  s = '' +
                                                      this.point.name + ': ' + this.y + ' fruits';
                                              } else {
                                                  s = '' +
                                                      this.x + ': ' + this.y;
                                              }
                                              return s;
                                          }
                                      },
                                      labels: {
                                          items: [{
                                              html: '',
                                              style: {
                                                  left: '40px',
                                                  top: '8px',
                                                  color: 'black'
                                              }
                                          }]
                                      },

                                      series: [{


                                          type: 'spline',
                                          name: '空气湿度',
                                          data: [parseFloat(dData10[19]), parseFloat(dData10[18]), parseFloat(dData10[17]), parseFloat(dData10[16]), parseFloat(dData10[15]), parseFloat(dData10[14]), parseFloat(dData10[13]), parseFloat(dData10[12]), parseFloat(dData10[11]), parseFloat(dData10[10])],
                                          marker: {
                                              lineWidth: 2,
                                              lineColor: Highcharts.getOptions().colors[1],
                                              fillColor: 'white'
                                          }
                                      },
                                      {
                                          type: 'spline',
                                          name: '空气温度',
                                          data: [parseFloat(dData10[29]), parseFloat(dData10[28]), parseFloat(dData10[27]), parseFloat(dData10[26]), parseFloat(dData10[25]), parseFloat(dData10[24]), parseFloat(dData10[23]), parseFloat(dData10[22]), parseFloat(dData10[21]), parseFloat(dData10[20])],
                                          marker: {
                                              lineWidth: 2,
                                              lineColor: Highcharts.getOptions().colors[0],
                                              fillColor: 'white'
                                          }
                                      },
                                      {
                                          type: 'column',
                                          name: 'CO2浓度(Reduce 100 times)',
                                          data: [parseFloat(dData10[39]) / 100, parseFloat(dData10[38]) / 100, parseFloat(dData10[37]) / 100, parseFloat(dData10[36]) / 100, parseFloat(dData10[35]) / 100, parseFloat(dData10[34]) / 100, parseFloat(dData10[33]) / 100, parseFloat(dData10[32]) / 100, parseFloat(dData10[31]) / 100, parseFloat(dData10[30]) / 100]
                                      },

                                      {
                                          type: 'column',
                                          name: '光照强度',
                                          data: [parseFloat(dData10[49]), parseFloat(dData10[48]), parseFloat(dData10[47]), parseFloat(dData10[46]), parseFloat(dData10[45]), parseFloat(dData10[44]), parseFloat(dData10[43]), parseFloat(dData10[42]), parseFloat(dData10[41]), parseFloat(dData10[40])]
                                      },
                                       {
                                           type: 'spline',
                                           name: '土壤温度',
                                           data: [parseFloat(dData10[59]), parseFloat(dData10[58]), parseFloat(dData10[57]), parseFloat(dData10[56]), parseFloat(dData10[55]), parseFloat(dData10[54]), parseFloat(dData10[53]), parseFloat(dData10[52]), parseFloat(dData10[51]), parseFloat(dData10[50])],
                                           marker: {
                                               lineWidth: 2,
                                               lineColor: Highcharts.getOptions().colors[7],
                                               fillColor: 'white'
                                           }
                                       }, {
                                           type: 'spline',
                                           name: '土壤湿度',
                                           data: [parseFloat(dData10[69]), parseFloat(dData10[68]), parseFloat(dData10[67]), parseFloat(dData10[66]), parseFloat(dData10[65]), parseFloat(dData10[64]), parseFloat(dData10[63]), parseFloat(dData10[62]), parseFloat(dData10[61]), parseFloat(dData10[60])],
                                           marker: {
                                               lineWidth: 2,
                                               lineColor: Highcharts.getOptions().colors[3],
                                               fillColor: 'white'
                                           }
                                       },

                                      ]
                                  });

                              }//if的尾括号
                              
                          },
                          error: function (err) {
                              alert(err);
                          }
                      });
                      return false; //禁用按钮的提交
                 // });
               

              }
        setInterval(fu, 60000);
        setTimeout(fu, 0);



      //固定时间查询
      $(function () {
          var dData10;
          $("#chaxun").click(function () {
              var data = "{str:'" + $("#shijian").val() + "'}";
              $.ajax({
                  type: "Post", //要用post方式   
                  url: "Main.aspx/dingshiData", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "该时段没有数据!") {
                          alert(data.d)
                      } else if (data.d === "请选择日期!") {
                          alert(data.d)
                      }else {

                          dData10  = JSON.parse(data.d);

                          $('#container').highcharts({
                              chart: {
                              },
                              title: {
                                  text: '数据监控'
                              },

                              //x轴
                              xAxis: {
                                  categories: [dData10[9], dData10[8], dData10[7], dData10[6], dData10[5], dData10[4], dData10[3], dData10[2], dData10[1], dData10[0]]
                              },
                              tooltip: {
                                  formatter: function () {
                                      var s;
                                      if (this.point.name) { // the pie chart                   
                                          s = '' +
                                              this.point.name + ': ' + this.y + ' fruits';
                                      } else {
                                          s = '' +
                                              this.x + ': ' + this.y;
                                      }
                                      return s;
                                  }
                              },
                              labels: {
                                  items: [{
                                      html: '',
                                      style: {
                                          left: '40px',
                                          top: '8px',
                                          color: 'black'
                                      }
                                  }]
                              },

                              series: [{


                                  type: 'spline',
                                  name: '空气湿度',
                                  data: [parseFloat(dData10[19]), parseFloat(dData10[18]), parseFloat(dData10[17]), parseFloat(dData10[16]), parseFloat(dData10[15]), parseFloat(dData10[14]), parseFloat(dData10[13]), parseFloat(dData10[12]), parseFloat(dData10[11]), parseFloat(dData10[10])],
                                  marker: {
                                      lineWidth: 2,
                                      lineColor: Highcharts.getOptions().colors[1],
                                      fillColor: 'white'
                                  }
                              },
                              {
                                  type: 'spline',
                                  name: '空气温度',
                                  data: [parseFloat(dData10[29]), parseFloat(dData10[28]), parseFloat(dData10[27]), parseFloat(dData10[26]), parseFloat(dData10[25]), parseFloat(dData10[24]), parseFloat(dData10[23]), parseFloat(dData10[22]), parseFloat(dData10[21]), parseFloat(dData10[20])],
                                  marker: {
                                      lineWidth: 2,
                                      lineColor: Highcharts.getOptions().colors[0],
                                      fillColor: 'white'
                                  }
                              },
                              {
                                  type: 'column',
                                  name: 'CO2浓度(Reduce 100 times)',
                                  data: [parseFloat(dData10[39]) / 100, parseFloat(dData10[38]) / 100, parseFloat(dData10[37]) / 100, parseFloat(dData10[36]) / 100, parseFloat(dData10[35]) / 100, parseFloat(dData10[34]) / 100, parseFloat(dData10[33]) / 100, parseFloat(dData10[32]) / 100, parseFloat(dData10[31]) / 100, parseFloat(dData10[30]) / 100]
                              },

                              {
                                  type: 'column',
                                  name: '光照强度',
                                  data: [parseFloat(dData10[49]), parseFloat(dData10[48]) , parseFloat(dData10[47]), parseFloat(dData10[46]) , parseFloat(dData10[45]), parseFloat(dData10[44]), parseFloat(dData10[43]), parseFloat(dData10[42]) , parseFloat(dData10[41]), parseFloat(dData10[40])]
                              },
                               {
                                   type: 'spline',
                                   name: '土壤温度',
                                   data: [parseFloat(dData10[59]), parseFloat(dData10[58]), parseFloat(dData10[57]), parseFloat(dData10[56]), parseFloat(dData10[55]), parseFloat(dData10[54]), parseFloat(dData10[53]), parseFloat(dData10[52]), parseFloat(dData10[51]), parseFloat(dData10[50])],
                                   marker: {
                                       lineWidth: 2,
                                       lineColor: Highcharts.getOptions().colors[7],
                                       fillColor: 'white'
                                   }
                               }, {
                                   type: 'spline',
                                   name: '土壤湿度',
                                   data: [parseFloat(dData10[69]), parseFloat(dData10[68]), parseFloat(dData10[67]), parseFloat(dData10[66]), parseFloat(dData10[65]), parseFloat(dData10[64]), parseFloat(dData10[63]), parseFloat(dData10[62]), parseFloat(dData10[61]), parseFloat(dData10[60])],
                                   marker: {
                                       lineWidth: 2,
                                       lineColor: Highcharts.getOptions().colors[3],
                                       fillColor: 'white'
                                   }
                               },

                              ]
                          });
                      }//if的尾括号
                  },
                  error: function (err) {
                      alert(err);
                  }
              });
              return false; //禁用按钮的提交

          });

      });



      //时间控件载入时显示当前时间
      $(function () {
          var d = new Date();
          var shijian = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate() + " " + d.getHours() + "时";
          $("#shijian").val(shijian);
      });


      //查询
      $(function () {
          var dEye;
          $("#chaxun").click(function () {
              var data = "{str:'" + $("#shijian").val() + "'}";
              $.ajax({
                  type: "Post", //要用post方式   
                  url: "Key_TJ.aspx/EyeData", //方法所在页面和方法名
                  contentType: "application/json; charset=utf-8",
                  data: data, //方法传参的写法一定要对，str为形参的名字,str2为第二个形参的名字, data: "{'str1':'参数值1','str2':'参数值2'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d === "该时段没有数据!") {
                          alert(data.d)
                      } else if (data.d === "请选择日期!") {
                          alert(data.d)
                      } else {

                          dEye = JSON.parse(data.d);

                          $('#container').highcharts({
                              chart: {
                              },
                              title: {
                                  text: '数据监控'
                              },

                              //x轴
                              xAxis: {
                                  categories: [dData10[9], dData10[8], dData10[7], dData10[6], dData10[5], dData10[4], dData10[3], dData10[2], dData10[1], dData10[0]]
                              },
                              tooltip: {
                                  formatter: function () {
                                      var s;
                                      if (this.point.name) { // the pie chart                   
                                          s = '' +
                                              this.point.name + ': ' + this.y + ' fruits';
                                      } else {
                                          s = '' +
                                              this.x + ': ' + this.y;
                                      }
                                      return s;
                                  }
                              },
                              labels: {
                                  items: [{
                                      html: '',
                                      style: {
                                          left: '40px',
                                          top: '8px',
                                          color: 'black'
                                      }
                                  }]
                              },

                              series: [{


                                  type: 'spline',
                                  name: '空气湿度',
                                  data: [parseFloat(dData10[19]), parseFloat(dData10[18]), parseFloat(dData10[17]), parseFloat(dData10[16]), parseFloat(dData10[15]), parseFloat(dData10[14]), parseFloat(dData10[13]), parseFloat(dData10[12]), parseFloat(dData10[11]), parseFloat(dData10[10])],
                                  marker: {
                                      lineWidth: 2,
                                      lineColor: Highcharts.getOptions().colors[1],
                                      fillColor: 'white'
                                  }
                              },
                              {
                                  type: 'spline',
                                  name: '空气温度',
                                  data: [parseFloat(dData10[29]), parseFloat(dData10[28]), parseFloat(dData10[27]), parseFloat(dData10[26]), parseFloat(dData10[25]), parseFloat(dData10[24]), parseFloat(dData10[23]), parseFloat(dData10[22]), parseFloat(dData10[21]), parseFloat(dData10[20])],
                                  marker: {
                                      lineWidth: 2,
                                      lineColor: Highcharts.getOptions().colors[0],
                                      fillColor: 'white'
                                  }
                              },
                              {
                                  type: 'column',
                                  name: 'CO2浓度(Reduce 100 times)',
                                  data: [parseFloat(dData10[39]) / 100, parseFloat(dData10[38]) / 100, parseFloat(dData10[37]) / 100, parseFloat(dData10[36]) / 100, parseFloat(dData10[35]) / 100, parseFloat(dData10[34]) / 100, parseFloat(dData10[33]) / 100, parseFloat(dData10[32]) / 100, parseFloat(dData10[31]) / 100, parseFloat(dData10[30]) / 100]
                              },

                              {
                                  type: 'column',
                                  name: '光照强度',
                                  data: [parseFloat(dData10[49]), parseFloat(dData10[48]), parseFloat(dData10[47]), parseFloat(dData10[46]), parseFloat(dData10[45]), parseFloat(dData10[44]), parseFloat(dData10[43]), parseFloat(dData10[42]), parseFloat(dData10[41]), parseFloat(dData10[40])]
                              },
                               {
                                   type: 'spline',
                                   name: '土壤温度',
                                   data: [parseFloat(dData10[59]), parseFloat(dData10[58]), parseFloat(dData10[57]), parseFloat(dData10[56]), parseFloat(dData10[55]), parseFloat(dData10[54]), parseFloat(dData10[53]), parseFloat(dData10[52]), parseFloat(dData10[51]), parseFloat(dData10[50])],
                                   marker: {
                                       lineWidth: 2,
                                       lineColor: Highcharts.getOptions().colors[7],
                                       fillColor: 'white'
                                   }
                               }, {
                                   type: 'spline',
                                   name: '土壤湿度',
                                   data: [parseFloat(dData10[69]), parseFloat(dData10[68]), parseFloat(dData10[67]), parseFloat(dData10[66]), parseFloat(dData10[65]), parseFloat(dData10[64]), parseFloat(dData10[63]), parseFloat(dData10[62]), parseFloat(dData10[61]), parseFloat(dData10[60])],
                                   marker: {
                                       lineWidth: 2,
                                       lineColor: Highcharts.getOptions().colors[3],
                                       fillColor: 'white'
                                   }
                               },

                              ]
                          });
                      }//if的尾括号
                  },
                  error: function (err) {
                      alert(err);
                  }
              });
              return false; //禁用按钮的提交

          });

      });