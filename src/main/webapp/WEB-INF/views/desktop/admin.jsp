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
        <a>
          <cite>我的桌面</cite></a>
      </span>
    </div>
    <div class="x-body">
    <div class="layui-row layui-col-space20">
	  <div class="layui-col-md6">
	    <div style="background:#F7F7F7;color:#444444;border-radius:10px;">
	    	<div style="padding:20px;font-size:20px;">本月新增区域数</div>
	    	<div style="padding:20px;font-size:16px;text-align:right;">${domainDataSize} / 个</div>
	    </div>
	  </div>
	  <div class="layui-col-md6">
		<div style="background:#F7F7F7;color:#444444;border-radius:10px;">
	    	<div style="padding:20px;font-size:20px;">本月新增商城数</div>
	    	<div style="padding:20px;font-size:16px;text-align:right;">${marketDataSize} / 个</div>
	    </div>
	  </div>
	  <div class="layui-col-md6">
		<div style="background:#F7F7F7;color:#444444;border-radius:10px;">
	    	<div style="padding:20px;font-size:20px;">本月新增商户数</div>
	    	<div style="padding:20px;font-size:16px;text-align:right;">${shopDataSize} / 个</div>
	    </div>
	  </div>
	  <div class="layui-col-md6">
	    <div style="background:#F7F7F7;color:#444444;border-radius:10px;">
	    	<div style="padding:20px;font-size:20px;">本月新增产品数</div>
	    	<div style="padding:20px;font-size:16px;text-align:right;">${goodsDataSize} / 个</div>
	    </div>
	  </div>
	</div>
    </div>
    <%@ include file="../common/foot.jsp"%>
  </body>
</html>