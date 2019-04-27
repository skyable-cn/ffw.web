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
        <a href="">活动管理</a>
        <a href="">展位管理</a>
        <a>
          <cite>编辑展位</cite></a>
      </span>
    </div>
    <div class="x-body">
        <form enctype="multipart/form-data" class="layui-form" method="post" action="<%=request.getContextPath()%>/stand/edit">
          <input type="hidden" name="STAND_ID" value="${pd.STAND_ID}"/>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>展位图片
              </label>
              <div class="layui-input-inline">
                  <table id="fileTable">
                  		<tr><td><input id="file" type="file" name="file" onchange="showImg(this)" accept="image/*" lay-verify="nikename1"/></td><td><img src="<%=request.getContextPath()%>/file/image?FILENAME=${pd.FILEPATH}" alt="展位图片"  width="150px" id="image" style="cursor:pointer;"/></td><td></td></tr>
                  	</table>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>产品(商家)
              </label>
              <div class="layui-input-inline">
                  <select id="rolemodule" name="GOODS_ID" class="valid">
                    <c:forEach var="goods" items="${goodsData}">
                    	<option value="${goods.GOODS_ID}" <c:if test="${goods.GOODS_ID eq pd.GOODS_ID}">selected="selected"</c:if>>${goods.GOODSNAME} (${goods.SHOPNAME})</option>
                    </c:forEach>
                  </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>类别
              </label>
              <div class="layui-input-inline">
                  <select id="rolemodule2" name="STANDTYPE_ID" class="valid">
                    <c:forEach var="type" items="${typeData}">
                    	<option value="${type.STANDTYPE_ID}"  <c:if test="${type.STANDTYPE_ID eq pd.STANDTYPE_ID}">selected="selected"</c:if>>${type.STANDTYPENAME}</option>
                    </c:forEach>
                  </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>描述
              </label>
              <div class="layui-input-inline">
                   <textarea placeholder="请输入内容" id="desc3" name="STANDDESC" class="layui-textarea">${pd.STANDDESC}</textarea>
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
              if(value.length < 1){
                return '展位图片不许为空';
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