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
           	<a href="">商户模块</a>
        <a href="">商户管理</a>
        <a>
          <cite>查看商户</cite></a>
      </span>
    </div>
    <div class="x-body">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/shop/edit">
        <input type="hidden" name="SHOP_ID" value="${pd.SHOP_ID}"/>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商户名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username" name="ROLENAME" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.SHOPNAME}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商户描述
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc" name="SHOPDESC" class="layui-textarea" disabled="disabled">${pd.SHOPDESC}</textarea>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商户详细地址
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username4" name="SHOPADDRESS" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.SHOPADDRESS}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>联系人
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username5" name="CONTRACTPERSON" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.CONTRACTPERSON}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>联系电话
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username6" name="CONTRACTPHONE" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.CONTRACTPHONE}" disabled="disabled">
              </div>
          </div>
          
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>人均消费
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username7" name="AVGMONEY" required="" lay-verify="nikename22"
                  autocomplete="off" class="layui-input" value="${pd.AVGMONEY}" disabled="disabled">
              </div>
          </div>
          
          <div class="layui-form-item">
          <hr/>
          </div>
          
           <div class="layui-form-item">
              <label class="layui-form-label"><span class="x-red">*</span>关联小程序</label>
              <div class="layui-input-inline" style="height:50px;">
                <input value="1" type="checkbox" name="WXFLAG" lay-skin="primary" title="微信" lay-filter="filter" <c:if test="${pd.WXFLAG eq 1}">checked="checked"</c:if> disabled="disabled"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>微信</span><i class="layui-icon layui-icon-ok"></i></div>
              </div>
          </div>
          
          <div class="layui-form-item wx-div">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户微信管理员
              </label>
              <div class="layui-input-inline">
                  <select id="member" name="MEMBER_ID" class="valid" disabled="disabled">
                    <c:forEach var="m" items="${memberData}">
                    	<c:if test="${m.CLASS eq 'wx'}">
                    	<option value="${m.MEMBER_ID}" <c:if test="${pd.MEMBER_ID eq m.MEMBER_ID}">selected="selected"</c:if>>${m.NICKNAME}</option>
                    	</c:if>
                    </c:forEach>
                  </select>
              </div>
          </div>
          
          <div class="layui-form-item wx-div">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户微信店员
              </label>
              <div class="layui-input-inline" style="width:500px;">
                  <input type="text" id="L_username777"
                  autocomplete="off" class="layui-input" onclick="showWXMember();" value="${wxNAMES}" disabled="disabled">
              </div>
          </div>
          
          <div class="layui-form-item">
          <hr/>
          </div>
          
          <div class="layui-form-item">
              <label class="layui-form-label"><span class="x-red">*</span>关联小程序</label>
              <div class="layui-input-inline" style="height:50px;">
                <input value="1" type="checkbox" name="DYFLAG" lay-skin="primary" title="抖音" lay-filter="filter" <c:if test="${pd.DYFLAG eq 1}">checked="checked"</c:if> disabled="disabled"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>抖音</span><i class="layui-icon layui-icon-ok"></i></div>
              </div>
          </div>
          
          <div class="layui-form-item dy-div">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户抖音管理员
              </label>
              <div class="layui-input-inline">
                  <select id="member_dy" name="MEMBER_ID_DY" class="valid" disabled="disabled">
                    <c:forEach var="m" items="${memberData}">
                    	<c:if test="${m.CLASS eq 'dy'}">
                    	<option value="${m.MEMBER_ID}" <c:if test="${pd.MEMBER_ID_DY eq m.MEMBER_ID}">selected="selected"</c:if>>${m.NICKNAME}</option>
                    	</c:if>
                    </c:forEach>
                  </select>
              </div>
          </div>
          
          <div class="layui-form-item dy-div">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户抖音店员
              </label>
              <div class="layui-input-inline" style="width:500px;">
                  <input type="text" id="L_username888"
                  autocomplete="off" class="layui-input" onclick="showDYMember();" value="${dyNAMES}" disabled="disabled">
              </div>
          </div>
          
          <div class="layui-form-item">
          <hr/>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>Web账号
              </label>
               <label for="L_username" class="layui-form-label">
                  <span>${pd.ACCOUNTER}</span>
              </label>
          </div>
           <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>审核状态
              </label>
              <div class="layui-input-inline">
                  <select id="rolemodule" name="SHOPSTATE_ID" class="valid" disabled="disabled">
                    <c:forEach var="var" items="${stateData}">
                    	<option value="${var.SHOPSTATE_ID}"  <c:if test="${var.SHOPSTATE_ID eq pd.SHOPSTATE_ID}">selected="selected"</c:if>>${var.SHOPSTATENAME}</option>
                    </c:forEach>
                  </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_repass" class="layui-form-label">
              </label>
              <button  class="layui-btn layui-btn-normal" onclick="history.back()" type="button">
                  返回
              </button>
          </div>
      </form>
      <h3>历史审核记录</h3>
      <hr/>
       <table class="layui-table x-admin">
        <thead>
          <tr>
            <th>时间</th>
            <th>结果</th>
            <th>备注</th>
            </tr>
        </thead>
        <tbody>
          <c:forEach var="var" items="${approveData}">
          	<tr>
           	<td>${var.CDT}</td>
            <td>${var.SHOPSTATENAME}</td>
            <td>${var.APPROVECOMMENT}</td>
          </tr>
          </c:forEach>
          
        </tbody>
      </table>
    </div>
  </body>

</html>