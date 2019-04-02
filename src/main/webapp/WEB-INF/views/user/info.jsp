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
    <div class="x-body">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/user/edit">
        <input type="hidden" name="USER_ID" value="${pd.USER_ID}"/>
        	<div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>账号
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username1" name="USERNAME1" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.USERNAME}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>密码
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username2" name="USERNAME2" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="********" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>姓名
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username" name="NICKNAME" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.NICKNAME}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="phone" class="layui-form-label">
                  <span class="x-red">*</span>手机
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="phone" name="PHONE" required="" lay-verify="phone"
                  autocomplete="off" class="layui-input" value="${pd.PHONE}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>角色
              </label>
              <div class="layui-input-inline">
                  <select id="shipping" name="ROLE_ID" class="valid" disabled="disabled">
                    <c:forEach var="role" items="${roleData}">
                    	<option value="${role.ROLE_ID}" <c:if test="${role.ROLE_ID eq pd.ROLE_ID}">selected="selected"</c:if>>${role.ROLENAME}</option>
                    </c:forEach>
                  </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>状态
              </label>
              <div class="layui-input-inline">
                  <select id="shipping" name="STATE" class="valid" disabled="disabled">
                    <option value="1" <c:if test="${pd.STATE eq 1}">selected="selected"</c:if>>启用</option>
                    <option value="0" <c:if test="${pd.STATE eq 0}">selected="selected"</c:if>>暂停</option>
                  </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red"></span>注册日期
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username" name="NICKNAME" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.CDT}" disabled="disabled">
              </div>
          </div>
      </form>
    </div>
    <script>
        layui.use(['form','layer'], function(){
            $ = layui.jquery;
          var form = layui.form
          ,layer = layui.layer;
        
          //自定义验证规则
          form.verify({
            nikename: function(value){
              if(value.length < 2){
                return '昵称至少得2个字符啊';
              }
            }
          });
          
        });
    </script>
  </body>

</html>