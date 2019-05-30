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
     </style>
  </head>
  
  <body>
  	    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">商城模块</a>
        <a href="">商城模块管理</a>
        <a>
          <cite>新增商城模块</cite></a>
      </span>
    </div>
    <div class="x-body">
        <form enctype="multipart/form-data" class="layui-form" method="post" action="<%=request.getContextPath()%>/market/save">
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商城Logo
              </label>
              <div class="layui-input-inline">
                  <table id="fileTable">
                  		<tr><td><input id="file-0" type="file" lt="image-0" name="file-0" onchange="showImg(this)" accept="image/*" lay-verify="nikename"/></td><td><img alt="邀请海报图片"  width="150px" id="image-0" style="display:none;cursor:pointer;"/></td><td></td></tr>
                  	</table>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商城名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username14" name="MARKETNAME" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
           <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商城描述
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc3" name="MARKETDESC" class="layui-textarea"></textarea>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>联系人
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username15" name="CONTRACTPEOPLE" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>联系方式
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username16" name="CONTRACTPHONE" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>抽成比例
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="PERCENT" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
          <hr/>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label"><span class="x-red">*</span>关联小程序</label>
              <div class="layui-input-inline" style="height:50px;">
                <input value="1" type="checkbox" name="WXFLAG" lay-skin="primary" title="微信" lay-filter="filter" checked="checked"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>微信</span><i class="layui-icon layui-icon-ok"></i></div>
              </div>
          </div>
          <div class="layui-form-item wx-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>微信Appid
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="WXAPPID" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item wx-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>微信Appsecret
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="WXAPPSECRET" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item wx-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>微信商户ID
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="WXMCHID" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item wx-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>微信商户Key
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="WXMCHKEY" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item wx-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>微信商户cert
              </label>
              <div class="layui-input-inline">
                  <table id="fileTable">
                  		<tr><td><input type="file" name="file-1"/>
                  		</td>
                  		</tr>
                  		</table>
              </div>
          </div>
          <div class="layui-form-item">
          <hr/>
          </div>
          <div class="layui-form-item">
              <label class="layui-form-label"><span class="x-red">*</span>关联小程序</label>
              <div class="layui-input-inline" style="height:50px;">
                <input value="1" type="checkbox" name="DYFLAG" lay-skin="primary" title="抖音" lay-filter="filter" checked="checked"><div class="layui-unselect layui-form-checkbox layui-form-checked" lay-skin="primary"><span>抖音</span><i class="layui-icon layui-icon-ok"></i></div>
              </div>
          </div>
          <div class="layui-form-item dy-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>抖音Appid
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="DYAPPID" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item dy-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>抖音Appsecret
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="DYAPPSECRET" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item dy-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>抖音商户ID
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="DYMCHID" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item dy-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>抖音商户公钥
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="DYPUBLICKEY" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item dy-div">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>抖音商户私钥
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username17" name="DYPRIVATEKEY" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_repass" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="" type="submit">
                  增加
              </button>
          </div>
      </form>
    </div>
    <script>
        layui.use(['form','layer'], function(){
            $ = layui.jquery;
          var form = layui.form
          ,layer = layui.layer;
          
          form.on('checkbox(filter)', function(data){
        	  if(data.elem.checked){
        		  if($(data.elem).attr("name")=="WXFLAG"){
        			  $(".wx-div").css("display","");
        		  }
        		  
        		  if($(data.elem).attr("name")=="DYFLAG"){
        			  $(".dy-div").css("display","");
        		  }
        		  
        	  }else{
        		  if($(data.elem).attr("name")=="WXFLAG"){
        			  $(".wx-div").css("display","none");
        		  }
        		  
        		  if($(data.elem).attr("name")=="DYFLAG"){
        			  $(".dy-div").css("display","none");
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
          });
        
        function showImg(obj){
        	var imageSrc = window.URL?window.URL.createObjectURL(obj.files[0]):obj.value;
        	$("#"+$(obj).attr("lt"))[0].src=imageSrc;
        	$("#"+$(obj).attr("lt")).css("display","");
        }
        
        
        
    </script>
  </body>

</html>