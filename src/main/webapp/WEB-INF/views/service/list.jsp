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
        <a href="">系统管理</a>
        <a href="">角色管理</a>
        <a>
          <cite>列表查询</cite></a>
      </span>
    </div>
    <div class="x-body">
    <form class="layui-form layui-col-md12 x-so" method="post" action="<%=request.getContextPath()%>/role/listPage">
      <div class="layui-row">
          <input type="text" name="keywords"  placeholder="请输入角色名称" autocomplete="off" class="layui-input" value="${page.pd.keywords}">
          
           <div class="layui-input-inline">
                  <select id="shipping" name="ROLEMODULE_ID" class="valid">
                  	<option value="">全部角色模块</option>
                    <c:forEach var="roleModule" items="${roleModuleData}">
                    	<option value="${roleModule.ROLEMODULE_ID}"  <c:if test="${roleModule.ROLEMODULE_ID eq page.pd.ROLEMODULE_ID}">selected="selected"</c:if>>${roleModule.ROLEMODULENAME}</option>
                    </c:forEach>
                  </select>
              </div>
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        
      </div>
      <xblock>
        <a class="layui-btn" onclick="commonSave('<%=request.getContextPath()%>/role/goAdd')" href="javascript:;"><i class="layui-icon"></i>添加</a>
      </xblock>
      <table class="layui-table x-admin">
        <thead>
          <tr>
            <th>角色ID</th>
            <th>角色名称</th>
            <th>角色模块</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${page.data}">
          	<tr>
           	<td>${var.ROLE_ID}</td>
            <td>${var.ROLENAME}</td>
            <td>${var.ROLEMODULENAME}</td>
            <td class="td-manage">
              <a title="编辑"  onclick="commonEdit('<%=request.getContextPath()%>/role/goEdit?ROLE_ID=${var.ROLE_ID}')" href="javascript:;">
                <i class="layui-icon">&#xe642;</i>
              </a>
              <c:choose>
            	<c:when test="${var.DELETEFLAG eq 1 }">
            		<a title="删除" onclick="commonAlert('系统内置账户不可删除');" href="javascript:;">
	                  <i class="layui-icon">&#xe640;</i>
	                </a>
            	</c:when>
            	<c:otherwise>
            		<a title="删除" onclick="commonDelete('<%=request.getContextPath()%>/role/delete?ROLE_ID=${var.ROLE_ID}');" href="javascript:;">
	                  <i class="layui-icon">&#xe640;</i>
	                </a>
            	</c:otherwise>
            </c:choose>
            
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