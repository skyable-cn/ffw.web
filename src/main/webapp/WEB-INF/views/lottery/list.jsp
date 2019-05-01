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
        <a href="">抽奖管理</a>
        <a>
          <cite>列表查询</cite></a>
      </span>
    </div>
    <div class="x-body">
    <form class="layui-form layui-col-md12 x-so" method="post" action="<%=request.getContextPath()%>/lottery/listPage">
      <div class="layui-row">
          <input type="text" name="keywords"  placeholder="请输入关键字" autocomplete="off" class="layui-input" value="${page.pd.keywords}">
          <input class="layui-input" placeholder="开始日" name="STARTTIME" id="start" autocomplete="off" value="${page.pd.STARTTIME}">
          <input class="layui-input" placeholder="结束日" name="ENDTIME" id="end" autocomplete="off" value="${page.pd.ENDTIME}">
          <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
        
      </div>
      <xblock>
        <a class="layui-btn" onclick="commonSave('<%=request.getContextPath()%>/lottery/goAdd')" href="javascript:;"><i class="layui-icon"></i>添加</a>
      </xblock>
      <table class="layui-table x-admin">
        <thead>
          <tr>
            <th>图片</th>
            <th>抽奖介绍</th>
            <th>抽奖时间</th>
            <th>赞助商</th>
            <th>状态</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${page.data}">
          	<tr>
           	<td><img src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" alt="展位图片" width="100" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}';"/></td>
            <td>${var.LOTTERYDESC}</td>
            <td>开始:${var.STARTTIME} <br/> 结束:${var.ENDTIME} <br/> 开奖:${var.SHOWTIME}</td>
            <td>${var.SPONSORNAME}</td>
            <td>
            	<c:if test="${var.STATE eq 0 and var.KJFLAG eq 0 }"><a class="layui-btn layui-btn-disabled" href="javascript:layer.alert('该抽奖活动待开奖');">待开奖</a></c:if>
            	<c:if test="${var.STATE eq 0 and var.KJFLAG eq 1 }"><a class="layui-btn layui-btn-normal" onclick="commonDelete('<%=request.getContextPath()%>/lottery/open?LOTTERY_ID=${var.LOTTERY_ID}','确认开奖该抽奖活动?')" href="javascript:;">请开奖</a></c:if>
            	<c:if test="${var.STATE eq 1}"><a class="layui-btn layui-btn-disabled" href="javascript:layer.alert('该抽奖活动已开奖');">已开奖</a></c:if>
            </td>
            <td class="td-manage">
              <a title="编辑"  onclick="commonEdit('<%=request.getContextPath()%>/lottery/goEdit?LOTTERY_ID=${var.LOTTERY_ID}')" href="javascript:;">
                <i class="layui-icon">&#xe642;</i>
              </a>
          	   <a title="删除" onclick="commonDelete('<%=request.getContextPath()%>/lottery/delete?LOTTERY_ID=${var.LOTTERY_ID}');" href="javascript:;">
                 <i class="layui-icon">&#xe640;</i>
               </a>
               <a title="查看" onclick="commonInfo('<%=request.getContextPath()%>/lottery/goInfo?LOTTERY_ID=${var.LOTTERY_ID}');" href="javascript:;">
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
    <script type="text/javascript">
	    
    	layui.use('laydate', function(){
	        var laydate = layui.laydate;
	        
	        //执行一个laydate实例
	        laydate.render({
	          elem: '#start' //指定元素
	        });
	
	        //执行一个laydate实例
	        laydate.render({
	          elem: '#end' //指定元素
	        });
	      });
    
    </script>
  </body>
</html>