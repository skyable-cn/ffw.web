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
          <cite>编辑产品</cite></a>
      </span>
    </div>
    <div class="x-body">
        <div class="layui-row" style="margin-bottom:10px;">
<div class="layui-col-md3"><button id="btn1" class="layui-btn layui-btn-fluid" style="width:calc(100% - 10px);">第一步：基础信息<font style="float:right;">></font></button></div>
<div class="layui-col-md3"><button id="btn2" class="layui-btn layui-btn-fluid layui-btn-primary" style="width:calc(100% - 10px);">第二步：价格设置<font style="float:right;">></font></button></div>
<div class="layui-col-md3"><button id="btn3" class="layui-btn layui-btn-fluid layui-btn-primary" style="width:calc(100% - 10px);">第三步：购买须知<font style="float:right;">></font></button></div>
<div class="layui-col-md3"><button id="btn4" class="layui-btn layui-btn-fluid layui-btn-primary" style="width:calc(100% - 10px);">第四步：运营设置<font style="float:right;">></font></button></div>
</div>
        <form enctype="multipart/form-data" class="layui-form" method="post" action="<%=request.getContextPath()%>/goods/edit" onsubmit="return checkContent()">
          <input type="hidden" name="GOODS_ID" value="${pd.GOODS_ID}"/>
          <input type="hidden" name="HBFILE_ID" value="${fileData.FILE_ID}"/>
          
          <div class="layui-form-item step4" style="display:none;">
              <label class="layui-form-label"><span class="x-red">*</span>关联小程序</label>
              <div class="layui-input-inline" style="height:50px;">
                <input value="1" type="checkbox" name="WXFLAG" lay-skin="primary" title="微信" lay-filter="filter"  <c:if test="${pd.WXFLAG eq 1}">checked="checked"</c:if>><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>微信</span><i class="layui-icon layui-icon-ok"></i></div>
                <input value="1" type="checkbox" name="DYFLAG" lay-skin="primary" title="抖音" lay-filter="filter"  <c:if test="${pd.DYFLAG eq 1}">checked="checked"</c:if>><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>抖音</span><i class="layui-icon layui-icon-ok"></i></div>
              </div>
          </div>
          
          <div class="layui-form-item step1" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username8" name="GOODSNAME" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.GOODSNAME}">
              </div>
          </div>
          <div class="layui-form-item step1" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品图片
              </label>
              <div class="layui-input-inline">
                  	<table id="fileTable">
                  		<c:forEach var="var" items="${fileDataList}">
                  			<tr><td>文件名称:${var.FILENAME}</br>文件大小:${var.FILESIZE} / M</td><td><img src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" alt="产品图片" title="点击删除" width="150px" lt="${var.FILE_ID}" onclick="deleteImg2(this)" style="cursor:pointer;" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}';"/></td><td></td></tr>
                  		</c:forEach>
                  		<tr><td><input id="file0" type="file" name="file0" lt="0" onchange="showImg(this)" accept="image/*"/></td><td><img alt="产品图片" title="点击删除" width="150px" id="image0" onclick="deleteImg(this)" style="display:none;cursor:pointer;"/></td><td></td></tr>
                  	</table>
              </div>
          </div>
          <div class="layui-form-item step1" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>标题
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc3" name="GOODSDESC" class="layui-textarea">${pd.GOODSDESC}</textarea>
              </div>
          </div>
          <!-- 
          <div class="layui-form-item">
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
          		  <input type="hidden" id="BUYNOTICE" name="BUYNOTICE" value='${pd.BUYNOTICE}'/>
                  <script id="editor" type="text/plain" style="width:100%;min-height:300px;">${pd.BUYNOTICE}</script>
          	  </div>
          </div>
          <div class="layui-form-item step3" style="display:none;">
          <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品详情
              </label>
              <div class="layui-input-inline" style="width:calc(100% - 200px);max-width:800px;">
          		  <input type="hidden" id="GOODSDETIAL" name="GOODSDETIAL" value='${pd.GOODSDETIAL}'/>
                  <script id="editor2" type="text/plain" style="width:100%;min-height:300px;">${pd.GOODSDETIAL}</script>
          	</div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品售卖价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username9" name="SELLMONEY" lay-verify="sellingprice"
                  autocomplete="off" class="layui-input" value="${pd.SELLMONEY}">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品原始价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username10" name="ORIGINALMONEY" lay-verify="originalproduct"
                  autocomplete="off" class="layui-input" value="${pd.ORIGINALMONEY}">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品结算价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username11" name="BALANCEMONEY" lay-verify="ettlementsprice"
                  autocomplete="off" class="layui-input" value="${pd.BALANCEMONEY}">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  普通用户返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username112" name="MEMBERBACKMONEY"
                  autocomplete="off" class="layui-input" value="${pd.MEMBERBACKMONEY}">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  会员用户返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username113" name="VIPBACKMONEY"
                  autocomplete="off" class="layui-input" value="${pd.VIPBACKMONEY}">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                 本级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username12" name="BACKMONEY0"
                  autocomplete="off" class="layui-input" value="${pd.BACKMONEY0}">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  一级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username13" name="BACKMONEY1"
                  autocomplete="off" class="layui-input" value="${pd.BACKMONEY1}">
              </div>
          </div>
          <div class="layui-form-item step2" style="display:none;">
              <label for="L_username" class="layui-form-label">
                 二级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username14" name="BACKMONEY2"
                  autocomplete="off" class="layui-input" value="${pd.BACKMONEY2}">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  	售卖开始时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="开始日" name="STARTTIME" id="start" lay-key="1" lay-verify="beginningDate" value="${pd.STARTTIME}">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>售卖结束时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="结束日" name="ENDTIME" id="end" lay-key="2" lay-verify="endDate" value="${pd.ENDTIME}">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>核销开始时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="开始日" name="USESTARTTIME" id="ustart" lay-key="3" lay-verify="xhstartDate" value="${pd.USESTARTTIME}">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  	核销结束时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="结束日" name="USEENDTIME" id="uend" lay-key="4" lay-verify="xhendDate" value="${pd.USEENDTIME}">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  库存
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username15" name="STORE"
                  autocomplete="off" class="layui-input" value="${pd.STORE}">
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
                <label for="L_username" class="layui-form-label">
                    虚拟已售
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="L_username155" name="VIRTUALSELLED" value="${pd.VIRTUALSELLED}"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
           <div class="layui-form-item step4" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>提供人员
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username151" name="PROVIDE" lay-verify="providers"
                  autocomplete="off" class="layui-input" value="${pd.PROVIDE}">
              </div>
          </div>
          <div id="shopDiv" class="layui-form-item step1" style="display:none;">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户
              </label>
              <div class="layui-input-inline">
              <input type="hidden" id="SHOP_ID_HIDDEN" name="SHOP_ID" value="${pd.SHOP_ID}"/>
              <input type="text" id="L_username777"
                  autocomplete="off" class="layui-input" onclick="showShop();" value="${pd.SHOPNAME}">
              	<!-- 
                  <select id="shipping" name="SHOP_ID" class="valid" disabled="disabled">
                    <c:forEach var="shop" items="${shopData}">
                    	<option value="${shop.SHOP_ID}" <c:if test="${shop.SHOP_ID eq pd.SHOP_ID}">selected="selected"</c:if>>${shop.SHOPNAME}</option>
                    </c:forEach>
                  </select>
                 -->
              </div>
          </div>
          <div class="layui-form-item step1" style="display:none;">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>分销海报
              </label>
              <div class="layui-input-inline">
                  <table id="fileTable2">
                  		<tr><td><input id="file-1" type="file" name="file-1" lt="-1" onchange="showImg2(this)" accept="image/*"/></td><td><img src="<%=request.getContextPath()%>/file/image?FILENAME=${fileData.FILEPATH}" alt="海报图片"  width="150px" id="image-1" style="cursor:pointer;"/></td><td></td></tr>
                  	</table>
              </div>
          </div>
          <div class="layui-form-item step1" style="display:none;">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>分享描述
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc5" name="SHAREDESC" class="layui-textarea">${pd.SHAREDESC}</textarea>
              </div>
          </div>
          <div class="layui-form-item step4" style="display:none;">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>状态
              </label>
              <div class="layui-input-inline">
                  <select id="shipping" name="STATE" class="valid">
                    <option value="1" <c:if test="${pd.STATE eq 1}">selected="selected"</c:if>>启用</option>
                    <option value="0" <c:if test="${pd.STATE eq 0}">selected="selected"</c:if>>暂停</option>
                    <option value="2" <c:if test="${pd.STATE eq 2}">selected="selected"</c:if>>售空</option>
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
                  编辑
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
        layui.use(['form','layer'], function(){
            $ = layui.jquery;
          var form = layui.form
          ,layer = layui.layer;
        
          //自定义验证规则
          form.verify({
            nikename: function(value){
              if(value.length < 1){
                return '昵称至少得1个字符啊';
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
        
        function deleteImg2(obj){
        	var FILE_ID = $(obj).attr("lt");
        	$.ajax({
        		type: "POST",
        		url: '<%=request.getContextPath()%>/goods/image/delete',
            	data:{"FILE_ID":FILE_ID},
        		dataType:'json',
        		cache: false,
        		success: function(data){
        			$(obj.parentNode.parentNode).remove();
        		},
        		error:function(){
        		
        		}
        	});
        	
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
        
        var shopIDS = "${pd.SHOP_ID}";
        var shopNAMES = "${pd.SHOPNAME}";
        
        function showShop(){
        	var shopids = shopIDS.split(",");
        	var tbody = "<tbody id = 'shopTbody'>";
        	<c:forEach var="m" items="${shopData}">
        		var checkflag= "";
        		if(shopids.indexOf("${m.SHOP_ID}") >= 0){
        			checkflag = "checked='checked'";
        		}
            		tbody+="<tr id='${m.SHOP_ID}' ln='${m.SHOPNAME}'><td><img src='<%=request.getContextPath()%>/file/image?FILENAME=${m.FILEPATH}' width='50'/>'</td><td>${m.SHOPNAME}</td><td><input type='radio' name='shopsel' style='width:30px;' value='${m.SHOP_ID}' ln='${m.SHOPNAME}' "+checkflag+"/></td></tr>";
            </c:forEach>
           tbody+="</tbody>";
        	var table = "<table class='layui-table'>";
        	table+=tbody;
        	table += "</table>";
        	layer.open({
        	  title:'选择产品商户',
        	  area: ['600px', '400px'],
        	  content: '<div><input type="text" id="searchShop" name="autocomplete="off" class="layui-input" onblur="searchShop()" placeholder="请输入商户名称"/></div><div>'+table+'</div>'
        	  ,btn: ['确认', '取消']
        	  ,yes: function(index, layero){
        		 shopIDS = "";
        		 shopNAMES = "";
        	    $("#shopTbody").find("input[type='radio']").each(function(){
        	    	if($(this).is(':checked')){
        	    		shopIDS+=$(this).val()+',';
        	    		shopNAMES+=$(this).attr("ln")+',';
        	    	}
        	    });
        	    
        	    if(shopIDS.length > 0){
        	    	shopIDS = shopIDS.substr(0,shopIDS.length-1);
        	    	shopNAMES = shopNAMES.substr(0,shopNAMES.length-1).replace(/,/g,"  ,  ");
        	    }
        	    
        		$("#SHOP_ID_HIDDEN").val(shopIDS);
        	    
        	    $("#L_username777").val(shopNAMES);
        	    layer.close(index);
        	  }
        	  ,btn2: function(index, layero){
        	    //按钮【按钮二】的回调
        	    
        	    //return false 开启该代码可禁止点击该按钮关闭
        	  }
        	  ,cancel: function(){ 
        	    //右上角关闭回调
        	    
        	    //return false 开启该代码可禁止点击该按钮关闭
        	  }
        	});
        }
        
        function searchShop(){
        	var searchShop = $("#searchShop").val();
        	if(!searchShop){
        		$("#shopTbody").find("tr").each(function(){
    				$(this).css("display","");
    		    });
        		return;
        	}
        	if(searchShop){
    	    	$("#shopTbody").find("tr").each(function(){
    		    	if($(this).attr("ln").indexOf(searchShop) == -1 ){
    		    		$(this).css("display","none");
    		    	}else{
    		    		$(this).css("display","");
    		    	}
    		    });
        	}
        }
        
    </script>
  </body>

</html>