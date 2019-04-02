<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<html  class="x-admin-sm">
<head>
	<meta charset="UTF-8">
	<title>后台登录-${SYSTEM_NAME}</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/xadmin/css/font.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/static/xadmin/css/xadmin.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/xadmin/js/jquery.min.3.2.1.js"></script>
    <script src="<%=request.getContextPath()%>/static/xadmin/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/xadmin/js/xadmin.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/static/xadmin/js/cookie.js"></script>

</head>
<body class="login-bg">
    
    <div class="login layui-anim layui-anim-up">
        <div class="message">${SYSTEM_NAME}-管理登录</div>
        <div id="darkbannerwrap"></div>
        
        <form method="post" class="layui-form" action="<%=request.getContextPath()%>/login">
            <input name="USERNAME" placeholder="用户名"  type="text" lay-verify="required" class="layui-input" >
            <hr class="hr15">
            <input name="PASSWORD" lay-verify="required" placeholder="密码"  type="password" class="layui-input">
            <hr class="hr15">
			<div class="layui-row">
				<div class="layui-col-md7">
				  <input name="CODE" lay-verify="required" placeholder="验证码"  type="text" class="layui-input">
				</div>
				<div class="layui-col-md5">
				  <img width="100%" id="codeImg" src="<%=request.getContextPath()%>/code" alt="验证码图片" title="点击更换图片"/>
				</div>
			</div>
			<hr class="hr15">
            <input value="登录" lay-submit lay-filter="login" type="submit">
            <hr class="hr20" >
        </form>
    </div>
    
    <script>
		//TOCMAT重启之后 点击左侧列表跳转登录首页 
		if (window != top) {
			top.location.href = location.href;
		}
	</script>
    
    <script type="text/javascript">
    
	    $(document).ready(function() {
			$("#codeImg").bind("click", changeCode);
		});

	    setTimeout(changeCode,500);
	
		function changeCode() {
			$("#codeImg").attr("src", "<%=request.getContextPath()%>/code?t=" + new Date().valueOf());
		}
		
		var errInfo = "${errInfo}";
		if(errInfo){
			setTimeout(function(){
				layer.msg(errInfo,function(){
	               
	            });
			},500);
		}
    
    </script>

    <script>
        $(function  () {
            layui.use('form', function(){
              var form = layui.form;
             
            });
        })

        
    </script>
</body>
</html>