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
        <a href="">分销提现审批</a>
        <a>
          <cite>列表查询</cite></a>
      </span>
    </div>
    <div class="x-body">
    <form class="layui-form layui-col-md12 x-so" method="post" action="<%=request.getContextPath()%>/withdraw/listPage">
      <div class="layui-row">
          <input type="text" name="keywords"  placeholder="请输入昵称" autocomplete="off" class="layui-input" value="${page.pd.keywords}">
          <div class="layui-input-inline">
                  <select id="shipping" name="CLASS" class="valid">
                  	<option value="">全部来源</option>
                    <option value="wx"  <c:if test="${'wx' eq page.pd.CLASS}">selected="selected"</c:if>>微信</option>
                    <option value="dy"  <c:if test="${'dy' eq page.pd.CLASS}">selected="selected"</c:if>>抖音</option>
                  </select>
          </div>
          <div class="layui-input-inline">
                  <select id="shipping" name="STATE" class="valid">
                  	<option value="">全部状态</option>
                    <option value="0"  <c:if test="${'0' eq page.pd.STATE}">selected="selected"</c:if>>待审核</option>
                    <option value="1"  <c:if test="${'1' eq page.pd.STATE}">selected="selected"</c:if>>已通过</option>
                    <option value="2"  <c:if test="${'2' eq page.pd.STATE}">selected="selected"</c:if>>已打回</option>
                  </select>
              </div>
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        
      </div>
      
      <table class="layui-table x-admin">
        <thead>
          <tr>
            <th>头像</th>
            <th>昵称</th>
            <th>来源</th>
            <th>提现金额</th>
            <th>提现时间</th>
            <th>审核时间</th>
            <th>WXOPEN_ID</th>
            <th>状态</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${page.data}">
          	<tr>
           	<td><img alt="" src="${var.PHOTO}" width="50"></td>
            <td>${var.NICKNAME}</td>
            <td>
            	<c:choose>
            		<c:when test="${var.CLASS eq 'wx'}">微信</c:when>
            		<c:when test="${var.CLASS eq 'dy'}">抖音</c:when>
            		<c:otherwise>未知</c:otherwise>
            	</c:choose>
            </td>
            <td>${var.MONEY}</td>
            <td>${var.CDT}</td>
            <td>${var.ADT}</td>
            <td>${var.WXOPEN_ID}</td>
            <td>
            	<c:choose>
            		<c:when test="${var.STATE eq 0}">待审核</c:when>
            		<c:when test="${var.STATE eq 1}">已通过</c:when>
            		<c:when test="${var.STATE eq 2}">已打回</c:when>
            		<c:otherwise>未知</c:otherwise>
            	</c:choose>
            </td>
            <td>
            	<a title="查看" onclick="commonInfo('<%=request.getContextPath()%>/withdraw/goInfo?WITHDRAW_ID=${var.WITHDRAW_ID}');" href="javascript:;">
                <i class="layui-icon">&#xe63c;</i>
              </a>
              <c:if test="${var.STATE eq 0}">
              <a title="审核" onclick="commonHref('<%=request.getContextPath()%>/withdraw/goAuditing?WITHDRAW_ID=${var.WITHDRAW_ID}');" href="javascript:;">
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