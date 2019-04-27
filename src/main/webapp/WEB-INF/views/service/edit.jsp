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
  </head>
  
  <body>
  	    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">系统设置</a>
        <a>
          <cite>客服设置</cite></a>
      </span>
    </div>
    <div class="x-body">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/service/edit">
        <input type="hidden" name="SERVICE_ID" value="${pd.SERVICE_ID}"/>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>客服电话
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username" name="SERVICEPHONE" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.SERVICEPHONE}">
              </div>
          </div>
           <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>客服介绍
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc2" name="SERVICEDESC" class="layui-textarea">${pd.SERVICEDESC}</textarea>
              </div>
          </div>
		<div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>微信号
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username" name="SERVICEWECHAT" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.SERVICEWECHAT}">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>微信群
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username" name="SERVICEGROUP" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.SERVICEGROUP}">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_repass" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="" type="submit">
                  修改
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
              if(value.length < 5){
                return '至少得5个字符啊';
              }
            }
          });
          
        });
    </script>
  </body>

</html>