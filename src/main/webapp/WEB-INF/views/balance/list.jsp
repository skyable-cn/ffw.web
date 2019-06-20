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
        <a href="">结算管理</a>
        <a href="">机构结算</a>
        <a>
          <cite>列表查询</cite></a>
      </span>
    </div>
    <div class="x-body">
    <form class="layui-form layui-col-md12 x-so" method="post" action="<%=request.getContextPath()%>/balance/listPage">
      <div class="layui-row">
          <input type="text" name="keywords"  placeholder="请输入机构名称" autocomplete="off" class="layui-input" value="${page.pd.keywords}">
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        
      </div>
      <div style="text-align:right;">
        <a class="layui-btn layui-btn-normal" href="javascript:;">总共交易流水：${count.INCOMEMONEY}</a>
        <a class="layui-btn layui-btn-normal" href="javascript:;">总共机构收益：${count.PROFITMONEY}</a>
        <a class="layui-btn layui-btn-normal" href="javascript:;">总共上缴费用：${count.SERVICEMONEY}</a>
      </div>
      <table class="layui-table x-admin">
        <thead>
          <tr>
            <th>机构名称</th>
            <th>交易流水</th>
            <th>机构收益</th>
            <th>上缴比列</th>
            <th>上缴费用</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${page.data}">
          	<tr>
            <td>${var.DM_NAME}</td>
            <td>${var.INCOMEMONEY}</td>
            <td>${var.PROFITMONEY}</td>
            <td>${var.PERCENT}</td>
            <td>${var.SERVICEMONEY}</td>
          </tr>
          </c:forEach>
          
        </tbody>
      </table>
      <div class="page">
       ${page.pageStr} 
      </div>
	</form>
    </div>
    <%@ include file="../common/foot.jsp"%>
  </body>
</html>