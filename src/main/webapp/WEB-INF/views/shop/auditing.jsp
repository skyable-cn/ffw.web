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
          <cite>审核商户</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/shop/auditing">
        <input type="hidden" name="SHOP_ID" value="${pd.SHOP_ID}"/>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>审核结果
              </label>
              <div class="layui-input-inline">
                  <select id="shipping" name="SHOPSTATE_ID" class="valid">
                    <option value="2">通过</option>
                    <option value="3">打回</option>
                  </select>
              </div>
          </div>
           <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>审核备注
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc" name="APPROVECOMMENT" class="layui-textarea" lay-verify="mark"></textarea>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_repass" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="" type="submit">
                  确定
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
    <script>
        layui.use(['form','layer'], function(){
            $ = layui.jquery;
          var form = layui.form
          ,layer = layui.layer;
        
          //自定义验证规则
          form.verify({
            mark: function(value){
              if(value.length < 2){
                return '备注至少得2个字符啊';
              }
            }
          });
          
        });
    </script>
  </body>

</html>