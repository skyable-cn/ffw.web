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
    <style>
     #fileTable{
     	min-width:550px;
     }
     #fileTable tr td{
     	  padding:10px;
     }
     #fileTable tr{
     	  border:1px #dddddd solid;
     }
     </style>
  </head>
  
  <body>
  	    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">商户管理</a>
        <a>
          <cite>编辑商户</cite></a>
      </span>
    </div>
    <div class="x-body">
        <form enctype="multipart/form-data" class="layui-form" method="post" action="<%=request.getContextPath()%>/shop/edit">
        <input type="hidden" name="SHOP_ID" value="${pd.SHOP_ID}"/>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户所属分类
              </label>
              <div class="layui-input-inline">
                  <select id="shoptype" name="SHOPTYPE_ID" class="valid">
                    <c:forEach var="t" items="${typeData}">
                    	<option value="${t.SHOPTYPE_ID}" <c:if test="${t.SHOPTYPE_ID eq pd.SHOPTYPE_ID}">selected="selected"</c:if>>${t.SHOPTYPENAME}</option>
                    </c:forEach>
                  </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商户图片
              </label>
              <div class="layui-input-inline">
                  <table id="fileTable">
                  		<tr><td><input id="file" type="file" name="file" onchange="showImg(this)" accept="image/*" lay-verify="nikename1"/></td><td><img src="<%=request.getContextPath()%>/file/image?FILENAME=${pd.FILEPATH}" alt="展位图片"  width="150px" id="image" style="cursor:pointer;"/></td><td></td></tr>
                  	</table>
              </div>
          </div>
          
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商户名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username" name="SHOPNAME" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.SHOPNAME}" >
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商户描述
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc" name="SHOPDESC" class="layui-textarea">${pd.SHOPDESC}</textarea>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>商户详细地址
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username4" name="SHOPADDRESS" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.SHOPADDRESS}" >
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>联系人
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username5" name="CONTRACTPERSON" required="" lay-verify="nikename1"
                  autocomplete="off" class="layui-input" value="${pd.CONTRACTPERSON}" >
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>联系电话
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username6" name="CONTRACTPHONE" required="" lay-verify="nikename2"
                  autocomplete="off" class="layui-input" value="${pd.CONTRACTPHONE}" >
              </div>
          </div>
          
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>人均消费
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username7" name="AVGMONEY" required="" lay-verify="nikename22"
                  autocomplete="off" class="layui-input" value="${pd.AVGMONEY}" >
              </div>
          </div>

          <div class="layui-form-item">
              <label for="L_repass" class="layui-form-label">
              </label>
              <button  class="layui-btn" lay-filter="add" lay-submit="" type="submit">
                  编辑
              </button>
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
              if(value.length < 5){
                return '昵称至少得5个字符啊';
              }
            }
          });
          
        });
        
        function showImg(obj){
        	var imageSrc = window.URL?window.URL.createObjectURL(obj.files[0]):obj.value;
        	$("#image")[0].src=imageSrc;
        	$("#image").css("display","");
        }
    </script>
  </body>

</html>