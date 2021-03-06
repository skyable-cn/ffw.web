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
        <a href="">产品管理</a>
        <a href="">产品查询</a>
        <a>
          <cite>列表查询</cite></a>
      </span>
    </div>
    <div class="x-body">
    <form class="layui-form layui-col-md12 x-so" method="post" action="<%=request.getContextPath()%>/goods/search">
      <div class="layui-row">
          <input type="text" name="keywords"  placeholder="请输入产品名称" autocomplete="off" class="layui-input" value="${page.pd.keywords}">
          <div class="layui-input-inline">
                  <select id="shipping" name="STATE" class="valid">
                  	<option value="">全部状态</option>
                    <option value="1" <c:if test="${page.pd.STATE ne  null && page.pd.STATE eq '1'}">selected="selected"</c:if>>启用</option>
                    <option value="0" <c:if test="${page.pd.STATE ne  null && page.pd.STATE eq '0'}">selected="selected"</c:if>>暂停</option>
                    <option value="2" <c:if test="${page.pd.STATE ne  null && page.pd.STATE eq '2'}">selected="selected"</c:if>>售空</option>
                  </select>
          </div>
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        
      </div>
      
      <table class="layui-table x-admin">
        <thead>
          <tr>
          	<th>产品图片</th>
            <th>产品名称</th>
            <th>更新时间</th>
            <th>状态</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${page.data}">
          	<tr>
          	<td><img width="100" src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}';"/></td>
           	<td>${var.GOODSNAME}</td>
           	<td>${var.UPDATETIME}</td>
            <td>
            <c:choose>
            	<c:when test="${var.STATE eq 1}">启用</c:when>
            	<c:when test="${var.STATE eq 0}">暂停</c:when>
            	<c:when test="${var.STATE eq 2}">售空</c:when>
            	<c:otherwise>未知</c:otherwise>
            </c:choose>
            </td>
            <td class="td-manage">
              <a title="查看" onclick="commonInfo('<%=request.getContextPath()%>/goods/goInfo?GOODS_ID=${var.GOODS_ID}');" href="javascript:;">
                <i class="layui-icon">&#xe63c;</i>
              </a>
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