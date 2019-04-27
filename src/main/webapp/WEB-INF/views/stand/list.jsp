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
        <a href="">活动管理</a>
        <a href="">展位管理</a>
        <a>
          <cite>列表查询</cite></a>
      </span>
    </div>
    <div class="x-body">
    <form class="layui-form layui-col-md12 x-so" method="post" action="<%=request.getContextPath()%>/stand/listPage">
      <div class="layui-row">
          <input type="text" name="keywords"  placeholder="请输入关键字" autocomplete="off" class="layui-input" value="${page.pd.keywords}">
          
           <div class="layui-input-inline">
                  <select id="shipping" name="STANDTYPE_ID" class="valid">
                  	<option value="">全部类别</option>
                    <c:forEach var="type" items="${typeData}">
                    	<option value="${type.STANDTYPE_ID}"  <c:if test="${type.STANDTYPE_ID eq page.pd.STANDTYPE_ID}">selected="selected"</c:if>>${type.STANDTYPENAME}</option>
                    </c:forEach>
                  </select>
              </div>
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        
      </div>
      <xblock>
        <a class="layui-btn" onclick="commonSave('<%=request.getContextPath()%>/stand/goAdd')" href="javascript:;"><i class="layui-icon"></i>添加</a>
      </xblock>
      <table class="layui-table x-admin">
        <thead>
          <tr>
            <th>图片</th>
            <th>产品</th>
            <th>类别</th>
            <th>创建时间</th>
            <th>审核状态</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${page.data}">
          	<tr>
           	<td><img src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" alt="展位图片" width="150px" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}';"/></td>
            <td>${var.GOODSNAME}</td>
            <td>${var.STANDTYPENAME}</td>
            <td>${var.CREATETIME}</td>
            <td>
            <c:choose>
            	<c:when test="${var.STATE eq 0}">待审核</c:when>
            	<c:when test="${var.STATE eq 1}">已通过</c:when>
            	<c:when test="${var.STATE eq 2}">已打回</c:when>
            	<c:otherwise>未知</c:otherwise>
            </c:choose>
            </td>
            <td class="td-manage">
              <a title="编辑"  onclick="commonEdit('<%=request.getContextPath()%>/stand/goEdit?STAND_ID=${var.STAND_ID}')" href="javascript:;">
                <i class="layui-icon">&#xe642;</i>
              </a>
          	   <a title="删除" onclick="commonDelete('<%=request.getContextPath()%>/stand/delete?STAND_ID=${var.STAND_ID}');" href="javascript:;">
                 <i class="layui-icon">&#xe640;</i>
               </a>
               <c:if test="${var.STATE eq 0}">
              <a title="审核" onclick="commonHref('<%=request.getContextPath()%>/stand/goAuditing?STAND_ID=${var.STAND_ID}');" href="javascript:;">
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