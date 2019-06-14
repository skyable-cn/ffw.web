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
        <a href="">商户结算</a>
        <a href="">商户结算记录查看</a>
        <a>
          <cite>列表查询</cite></a>
      </span>
    </div>
    <div class="x-body">
    <blockquote class="layui-elem-quote"><span><img width="50" src="<%=request.getContextPath()%>/file/image?FILENAME=${shop.FILEPATH}"/></span><span>${shop.SHOPNAME }</span></blockquote>
    <form class="layui-form layui-col-md12 x-so" method="post" action="<%=request.getContextPath()%>/shopdraw/record/listPage?SHOP_ID=${page.pd.SHOP_ID}">
      <div class="layui-row">
          <input type="text" name="keywords"  placeholder="请输入商户名称" autocomplete="off" class="layui-input" value="${page.pd.keywords}">
         
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        
      </div>
       <xblock>
        <a class="layui-btn" onclick="commonSave('<%=request.getContextPath()%>/shopdraw/goAdd?SHOP_ID=${page.pd.SHOP_ID}')" href="javascript:;"><i class="layui-icon"></i>添加</a>
      </xblock>
      <table class="layui-table x-admin">
        <thead>
          <tr>
            <th>结算单号</th>
            <th>结算时间</th>
            <th>结算金额</th>
            <th>结算人员</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${page.data}">
          	<tr>
          	<td>${var.SHOPDRAWSN}</td>
           	<td>${var.CDT}</td>
            <td>${var.MONEY}</td>
            <td>${var.USERNAME}</td>
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