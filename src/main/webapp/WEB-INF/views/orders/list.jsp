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
        <a href="">订单管理</a>
        <a href="">交易订单管理</a>
        <a>
          <cite>列表查询</cite></a>
      </span>
    </div>
    <div class="x-body">
    <form class="layui-form layui-col-md12 x-so" method="post" action="<%=request.getContextPath()%>/orders/listPage">
      <div class="layui-row">
          <input type="text" name="keywords"  placeholder="请输入关键字" autocomplete="off" class="layui-input" value="${page.pd.keywords}">
          
           <div class="layui-input-inline">
                  <select id="shipping" name="STATE" class="valid">
                  	<option value="">全部类别</option>
                    <option value="0" <c:if test="${'0' eq page.pd.STATE}">selected="selected"</c:if>>待支付</option>
                    <option value="1" <c:if test="${'1' eq page.pd.STATE}">selected="selected"</c:if>>已支付</option>
                    <option value="2" <c:if test="${'2' eq page.pd.STATE}">selected="selected"</c:if>>待使用</option>
                    <option value="3" <c:if test="${'3' eq page.pd.STATE}">selected="selected"</c:if>>已核销</option>
                    <option value="5" <c:if test="${'5' eq page.pd.STATE}">selected="selected"</c:if>>已退款</option>
                  </select>
              </div>
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        
      </div>
      <table class="layui-table x-admin">
        <thead>
          <tr>
            <th>系统交易</th>
            <th>微信交易</th>
            <th>商户</th>
            <th>产品</th>
            <th>状态</th>
            <th>金额</th>
            <th>微信号</th>
            <th>时间</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${page.data}">
          	<tr>
           	<td>${var.ORDERSN}</td>
            <td>${var.WEIXINSN}</td>
            <td>${var.SHOPNAME}</td>
            <td>${var.GOODSNAME}</td>
            <td>
            	<c:choose>
            		<c:when test="${var.STATE eq 0}">待支付</c:when>
            		<c:when test="${var.STATE eq 1}">已支付</c:when>
            		<c:when test="${var.STATE eq 2}">待使用</c:when>
            		<c:when test="${var.STATE eq 3}">已核销</c:when>
            		<c:when test="${var.STATE eq 5}">已退款</c:when>
            	</c:choose>
            </td>
             <td>${var.MONEY}</td>
             <td>${var.NICKNAME}</td>
             <td>${var.CDT}</td>
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