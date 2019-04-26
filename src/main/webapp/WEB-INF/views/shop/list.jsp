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
        <a href="">商户管理</a>
        <a>
          <cite>列表查询</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
    <form class="layui-form layui-col-md12 x-so" method="post" action="<%=request.getContextPath()%>/shop/listPage">
      <div class="layui-row">
          <input type="text" name="keywords"  placeholder="请输入关键字" autocomplete="off" class="layui-input" value="${page.pd.keywords}">
          
           <div class="layui-input-inline">
                  <select id="shipping" name="SHOPSTATE_ID" class="valid">
                  	<option value="">全部状态</option>
                    <c:forEach var="var" items="${stateData}">
                    	<option value="${var.SHOPSTATE_ID}"  <c:if test="${var.SHOPSTATE_ID eq page.pd.SHOPSTATE_ID}">selected="selected"</c:if>>${var.SHOPSTATENAME}</option>
                    </c:forEach>
                  </select>
              </div>
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        
      </div>
      
      <table class="layui-table x-admin">
        <thead>
          <tr>
          	<th>商户图片</th>
            <th>商户名称</th>
            <th>联系人</th>
            <th>联系方式</th>
            <th>Web账号</th>
            <th>审核状态</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${page.data}">
          	<tr>
          	<td><img src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}"/></td>
           	<td>${var.SHOPNAME}</td>
            <td>${var.CONTRACTPERSON}</td>
            <td>${var.CONTRACTPHONE}</td>
            <td>${var.ACCOUNTER}</td>
            <td>${var.SHOPSTATENAME}</td>
            <td class="td-manage">
              <a title="编辑"  onclick="commonEdit('<%=request.getContextPath()%>/shop/goEdit?SHOP_ID=${var.SHOP_ID}')" href="javascript:;">
                <i class="layui-icon">&#xe642;</i>
              </a>
              <a title="删除" onclick="commonDelete('<%=request.getContextPath()%>/shop/delete?SHOP_ID=${var.SHOP_ID}');" href="javascript:;">
                <i class="layui-icon">&#xe640;</i>
              </a>
              <a title="查看" onclick="commonInfo('<%=request.getContextPath()%>/shop/goInfo?SHOP_ID=${var.SHOP_ID}');" href="javascript:;">
                <i class="layui-icon">&#xe63c;</i>
              </a>
              <c:if test="${var.SHOPSTATE_ID eq 1}">
              <a title="审核" onclick="commonHref('<%=request.getContextPath()%>/shop/goAuditing?SHOP_ID=${var.SHOP_ID}');" href="javascript:;">
                <i class="layui-icon">&#xe6b2;</i>
              </a>
              </c:if>
            </td>
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