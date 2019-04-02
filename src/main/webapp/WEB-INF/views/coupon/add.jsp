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
        <a href="">系统设置</a>
        <a href="">现金券设置</a>
        <a>
          <cite>新增现金券</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/coupon/save">
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>金额
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username14" name="MONEY" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  	<span class="x-red">*</span>开始时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="开始日" name="STARTTIME" id="start" lay-key="1" autocomplete="off" lay-verify="nikename1">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  	<span class="x-red">*</span>结束时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="结束日" name="ENDTIME" id="end" lay-key="2" autocomplete="off" lay-verify="nikename2">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>状态
              </label>
              <div class="layui-input-inline">
                  <select id="shipping" name="STATE" class="valid">
                    <option value="1">启用</option>
                    <option value="0">暂停</option>
                  </select>
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
        
          //自定义验证规则
          form.verify({
            nikename: function(value){
              if(value.length < 1){
                return '金额不许为空';
              }
            }
          });
          
          form.verify({
              nikename1: function(value){
                if(value.length < 1){
                  return '请选择开始时间';
                }
              }
            });
          
          form.verify({
              nikename2: function(value){
                if(value.length < 1){
                  return '请选择结束时间';
                }
              }
            });
        });
        
        layui.use('laydate', function(){
            var laydate = layui.laydate;
            
            //执行一个laydate实例
            laydate.render({
              elem: '#start' //指定元素
            });

            //执行一个laydate实例
            laydate.render({
              elem: '#end' //指定元素
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