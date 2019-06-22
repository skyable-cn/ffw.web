<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/head.jsp"%>
<html class="x-admin-sm">
  
  <head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.1</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/xadmin/css/font.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/xadmin/css/xadmin.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/xadmin/js/jquery.min.3.2.1.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/xadmin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/xadmin/js/xadmin.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/xadmin/js/cookie.js"></script>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
      <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
      <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
     #fileTable{
     	min-width:550px;
     }
     #fileTable tr td{
     	  padding:10px;
     }
     #fileTable tr{
     	  border:1px #dddddd solid;
     }
     
     #fileTable2{
     	min-width:550px;
     }
     #fileTable2 tr td{
     	  padding:10px;
     }
     #fileTable2 tr{
     	  border:1px #dddddd solid;
     }
    </style>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/static/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/static/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/static/ueditor/lang/zh-cn/zh-cn.js"></script>
  </head>
  
  <body>
  	    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">产品管理</a>
        <a href="">产品维护</a>
        <a>
          <cite>新增产品</cite></a>
      </span>
    </div>
    <div class="x-body">
    <div class="layui-row" style="margin-bottom:10px;">
<div class="layui-col-md3"><button id="btn1" class="layui-btn layui-btn-fluid" style="width:calc(100% - 10px);">第一步：基础信息<font style="float:right;">></font></button></div>
<div class="layui-col-md3"><button id="btn2" class="layui-btn layui-btn-fluid layui-btn-primary" style="width:calc(100% - 10px);">第二步：价格设置<font style="float:right;">></font></button></div>
<div class="layui-col-md3"><button id="btn3" class="layui-btn layui-btn-fluid layui-btn-primary" style="width:calc(100% - 10px);">第三步：购买须知<font style="float:right;">></font></button></div>
<div class="layui-col-md3"><button id="btn4" class="layui-btn layui-btn-fluid layui-btn-primary" style="width:calc(100% - 10px);">第四步：运营设置<font style="float:right;">></font></button></div>
</div>
        <form enctype="multipart/form-data"  class="layui-form" method="post" action="<%=request.getContextPath()%>/goods/save" onsubmit="return checkContent()">
          
          <div class="layui-form-item step4" style="display:none;">
              <label class="layui-form-label"><span class="x-red">*</span>关联小程序</label>
              <div class="layui-input-inline" style="height:50px;">
                <input value="1" type="checkbox" name="WXFLAG" lay-skin="primary" title="微信" lay-filter="filter" checked="checked"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>微信</span><i class="layui-icon layui-icon-ok"></i></div>
                <input value="1" type="checkbox" name="DYFLAG" lay-skin="primary" title="抖音" lay-filter="filter" checked="checked"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>抖音</span><i class="layui-icon layui-icon-ok"></i></div>
              </div>
          </div>
          
          <div class="layui-form-item step1" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username8" name="GOODSNAME" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item step1" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品图片
              </label>
              <div class="layui-input-inline">
                  	<table id="fileTable">
                  		<tr><td><input id="file0" type="file" name="file0" lt="0" onchange="showImg(this)" accept="image/*"/></td><td><img alt="产品图片" title="点击删除" width="150px" id="image0" onclick="deleteImg(this)" style="display:none;cursor:pointer;"/></td><td></td></tr>
                  	</table>
              </div>
          </div>
          <div class="layui-form-item step1" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品介绍
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc3" name="GOODSDESC" class="layui-textarea"></textarea>
              </div>
          </div>
          <!-- <div class="layui-form-item step3" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>购买须知
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc4" name="BUYNOTICE" class="layui-textarea"></textarea>
              </div>
          </div>
           -->
          <div class="layui-form-item step3" style="display:none;">
          <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>购买须知
              </label>
              <div class="layui-input-inline" style="width:calc(100% - 200px);max-width:800px;">
          		  <input type="hidden" id="BUYNOTICE" name="BUYNOTICE"/>
                  <script id="editor" type="text/plain" style="width:100%;min-height:300px;">购买须知</script>
          	</div>
          </div>
          <div class="layui-form-item step3" style="display:none;">
          <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品详情
              </label>
              <div class="layui-input-inline" style="width:calc(100% - 200px);max-width:800px;">
          		  <input type="hidden" id="GOODSDETIAL" name="GOODSDETIAL"/>
                  <script id="editor2" type="text/plain" style="width:100%;min-height:300px;">产品详情</script>
          	</div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品售卖价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username9" name="SELLMONEY" lay-verify="sellingprice"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品原始价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username10" name="ORIGINALMONEY" lay-verify="originalproduct"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品结算价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username11" name="BALANCEMONEY" lay-verify="ettlementsprice"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  普通用户返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username112" name="MEMBERBACKMONEY"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                 会员用户返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username113" name="VIPBACKMONEY" lay-verify="userReturnPrice"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  本级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username12" name="BACKMONEY0" lay-verify="distributionPrice"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  一级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username13" name="BACKMONEY1" lay-verify="oneDistribution"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  二级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username14" name="BACKMONEY2" lay-verify="twoDistribution"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>售卖开始时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="开始日" name="STARTTIME" id="start" lay-key="1" autocomplete="off" lay-verify="beginningDate">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>售卖结束时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="结束日" name="ENDTIME" id="end" lay-key="2" autocomplete="off" lay-verify="endDate">
              </div>
          </div>
           <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>核销开始时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="开始日" name="USESTARTTIME" id="ustart" lay-key="3" autocomplete="off" lay-verify="xhstartDate">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>核销结束时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="结束日" name="USEENDTIME" id="uend" lay-key="4" autocomplete="off" lay-verify="xhendDate">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  库存
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username15" name="STORE" lay-verify="stock1"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
            <div class="layui-form-item step4" style="display:none;">
                <label for="L_username" class="layui-form-label">
                    虚拟已售
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="L_username155" name="VIRTUALSELLED" value="0"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>提供人员
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username151" name="PROVIDE" lay-verify="providers"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div id="shopDiv" class="layui-form-item step1" style="display:none;">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户
              </label>
              <div class="layui-input-inline">
                  <input type="button" class="layui-btn layui-btn-normal" onclick="business()" id="shanghu"  value="商户选择"></input>
                  <%--<select id="shipping1" name="SHOP_ID" class="valid">
                      <c:forEach var="shop" items="${shopData}">
                          <option value="${shop.SHOP_ID}">${shop.SHOPNAME}</option>
                      </c:forEach>
                  </select>--%>

                  <%--<div style="display:none">
                      <select id="shipping1" name="SHOP_ID" class="valid">
                          <c:forEach var="shop" items="${shopData}">
                            <option value="${shop.SHOP_ID}">${shop.SHOPNAME}</option>
                          </c:forEach>
                      </select>
                  </div>--%>
                  <div style="display:none;position: absolute;background: #FFFFFF;z-index: 999;border: solid 1px #CCCCCC;" id="carlist">
                      <c:forEach var="shop" items="${shopData}">
                          <input type="radio" name="SHOP_ID" value="${shop.SHOP_ID}" title="${shop.SHOPNAME}" lay-verify="myrepostr"></input>
                      </c:forEach>
                      <button type="button" class="layui-btn layui-btn-sm" onclick="selected()">确定</button>
                      <button type="button" class="layui-btn layui-btn-sm layui-btn-danger" onclick="passselected()">取消</button>
                  </div>
              </div>

          </div>
          <div class="layui-form-item step1" style="display:none;">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>分销海报
              </label>
              <div class="layui-input-inline">
                  <table id="fileTable2">
                  		<tr><td><input id="file-1" type="file" name="file-1" lt="-1" onchange="showImg2(this)" accept="image/*"/></td><td><img alt="海报图片"  width="150px" id="image-1" style="display:none;cursor:pointer;"/></td><td></td></tr>
                  	</table>
              </div>
          </div>
          <div class="layui-form-item step1" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>分享描述
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc5" name="SHAREDESC" class="layui-textarea"></textarea>
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>状态
              </label>
              <div class="layui-input-inline">
                  <select id="shipping" name="STATE" class="valid">
                    <option value="1">启用</option>
                    <option value="0">暂停</option>
                    <option value="2">售空</option>
                  </select>
              </div>
          </div>
          <div class="layui-form-item step1" style="display:none;">
              <button class="layui-btn" style="float:right;" onclick="showStep('2')" type="button">下一步</button>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <button class="layui-btn" style="float:right;" onclick="showStep('3')" type="button">下一步</button><button class="layui-btn" style="float:right;margin-right:20px;" onclick="showStep('1')" type="button">上一步</button>
          </div>
          <div class="layui-form-item step3" style="display:none;">
              <button class="layui-btn" style="float:right;" onclick="showStep('4')" type="button">下一步</button><button class="layui-btn" style="float:right;margin-right:20px;" onclick="showStep('2')" type="button">上一步</button>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <button class="layui-btn" style="float:right;margin-right:20px;" onclick="showStep('3')" type="button">上一步</button>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_repass" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="" type="submit">
                  增加
              </button>
          </div>
      </form>
    </div>
    <%@ include file="../common/foot.jsp"%>
    
    <script type="text/javascript">
    
    	var ue = UE.getEditor('editor');
    	
    	var ue2 = UE.getEditor('editor2');
    
    </script>
    
    <script>

        var obj = document.getElementsByName("SHOP_ID");
        function selected(){
            for(var i=0; i<obj.length; i ++){
                if(obj[i].checked){
                    var ss= document.getElementById("#shanghu");
                    $("#shanghu").val(obj[i].title)
                }
            }
            $("#carlist").hide();
        }

        function passselected(){
            $("#carlist").hide();
        }


        layui.use(['form','layer'], function(){
            $ = layui.jquery;
          var form = layui.form
          ,layer = layui.layer;
        
          //自定义验证规则
          form.verify({
            nikename: function(value){
              if(value.length < 1){
                return '产品名称至少得1个字符啊';
              }
            },sellingprice: function(value){
                  if(value.length < 1){
                      return '正确输入产品售卖价格';
                  }
                  var re = /^[0-9]+.?[0-9]*/;//判断字符串是否为数字//判断正整数/[1−9]+[0−9]∗]∗/
                  if (!re.test(value)) {
                      return '正确输入产品售卖价格';
                  }
              }
              ,originalproduct: function(value){
                  if(value.length < 1){
                      return '正确输入产品原始价格';
                  }
                  var re = /^[0-9]+.?[0-9]*/;//判断字符串是否为数字//判断正整数/[1−9]+[0−9]∗]∗/
                  if (!re.test(value)) {
                      return '正确输入产品原始价格';
                  }
              }
              ,ettlementsprice: function(value){
                  if(value.length < 1){
                      return '正确输入产品结算价格';
                  }
                  var re = /^[0-9]+.?[0-9]*/;//判断字符串是否为数字//判断正整数/[1−9]+[0−9]∗]∗/
                  if (!re.test(value)) {
                      return '正确输入产品结算价格';
                  }
              },providers: function(value){
                  if(value.length < 1){
                      return '正确输入提供人员啊';
                  }
              },beginningDate: function(value){
                  if(value.length < 1){
                      return '售卖开始时间忘记输入啦！';
                  }
              },endDate: function(value){
                  if(value.length < 1){
                      return '售卖结束时间忘记输入啦！';
                  }
              },xhstartDate: function(value){
                  if(value.length < 1){
                      return '核销开始时间忘记输入啦！';
                  }
              },xhendDate: function(value){
                  if(value.length < 1){
                      return '核销结束时间忘记输入啦！';
                  }
              },myrepostr: function(value){
                  if(value.length < 1){
                      return '商户选择忘记输入啦！';
                  }
              }
          });
          
        });
        
        layui.use('laydate', function(){
            var laydate = layui.laydate;
            
            //执行一个laydate实例
            laydate.render({
              elem: '#start' //指定元素
            	  ,type: 'datetime'
            });

            //执行一个laydate实例
            laydate.render({
              elem: '#end' //指定元素
            	  ,type: 'datetime'
            });
            
          //执行一个laydate实例
            laydate.render({
              elem: '#ustart' //指定元素
            	  ,type: 'datetime'
            });

            //执行一个laydate实例
            laydate.render({
              elem: '#uend' //指定元素
            	  ,type: 'datetime'
            });
          });
        
        var counter = 1;

        function showImg(obj){
        	var imageSrc = window.URL?window.URL.createObjectURL(obj.files[0]):obj.value;
        	$("#image"+$(obj).attr("lt"))[0].src=imageSrc;
        	$("#image"+$(obj).attr("lt")).css("display","");
        	$("#file"+$(obj).attr("lt")).css("display","none");
        	$("#file"+$(obj).attr("lt")).parent().append("文件名称:"+obj.files[0].name+"</br>文件大小:"+(obj.files[0].size/1024/1024).toFixed(3)+" / M");
        	
        	$("#fileTable").append('<tr><td><input id="file'+counter+'"  type="file" name="file'+counter+'" lt="'+counter+'" onchange="showImg(this)" accept="image/*"/></td><td><img alt="产品图片" title="点击删除" width="150px" id="image'+counter+'" onclick="deleteImg(this)"  style="display:none;cursor:pointer;"/></td><td></td></tr>');
        	counter++;
        }
        
        function deleteImg(obj){
        	$(obj.parentNode.parentNode).remove();
        }
        
        function showImg2(obj){
        	var imageSrc = window.URL?window.URL.createObjectURL(obj.files[0]):obj.value;
        	$("#image"+$(obj).attr("lt"))[0].src=imageSrc;
        	$("#image"+$(obj).attr("lt")).css("display","");
        }
        
        $(".step1").css("display","")
        
        function showStep(id){
        	$(".layui-form-item").css("display","none");
        	$(".step"+id).css("display","");
        	
        	$(".layui-btn-fluid").addClass("layui-btn-primary");
        	$("#btn"+id).removeClass("layui-btn-primary");
        }
        
        function checkContent(){
        	$("#BUYNOTICE").val(UE.getEditor('editor').getContent());
        	$("#GOODSDETIAL").val(UE.getEditor('editor2').getContent());
        	return true;
        }

        function business(){
            var o = $("#carlist");
            if(o.css("display")=="none"){
                o.show();
            }else{
                o.hide();
            }
        }
        /* function business(){
             var obj = document.getElementById("shipping1").options;
             var rs=[];
             for ( var i = 0; i <obj.length; i++){
                 rs[i]=obj[i].text;
             }
             layer.confirm('纳尼？', {
               //  btn: ['按钮一', '按钮二', '按钮三'] //可以无限个按钮
                 btn: rs //可以无限个按钮
                 ,btn3: function(index, layero){
                     //按钮【按钮三】的回调
                     alert(index);
                     layer.close(index)
                 }
             }, function(index, layero){
                 //按钮【按钮一】的回调
                 alert(index);
                 layer.close(index)
             }, function(index){
                 //按钮【按钮二】的回调
                 alert(index);
                 layer.close(index)
             });

         }*/

    </script>
  </body>

</html>