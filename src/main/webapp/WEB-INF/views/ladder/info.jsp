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
     	width:600px;
     }
     #fileTable tr td{
     	  padding:10px;
     	  border:1px #dddddd solid;
     }
     
     #fileTable tr td input{
     	  width:100px;
     }
     
     tr.thd td{
     	background:#eeeeee;
     	text-align: center;
     	font-size:14px;
     }
     
     </style>
  </head>
  
  <body>
  	    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">活动管理</a>
        <a href="">阶梯价管理</a>
        <a>
          <cite>查看阶梯价</cite></a>
      </span>
    </div>
    <div class="x-body">
        <form id="form" class="layui-form" method="post" action="<%=request.getContextPath()%>/ladder/edit">
          <input type="hidden" name="LADDER_ID" value="${pd.LADDER_ID}"/>
          <input id="remark" name="REMARK" type="hidden" value="${pd.REMARK}"/>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>产品(商家)
              </label>
              <div class="layui-input-inline">
                  <select id="rolemodule" name="GOODS_ID" class="valid" disabled="disabled">
                    <c:forEach var="goods" items="${goodsData}">
                    	<option value="${goods.GOODS_ID}" <c:if test="${goods.GOODS_ID eq pd.GOODS_ID}">selected="selected"</c:if>>${goods.GOODSNAME} (${goods.SHOPNAME})</option>
                    </c:forEach>
                  </select>
              </div>
          </div>
          
         <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>区间设置
              </label>
              <div class="layui-input-inline">
                  <table id="fileTable">
                  		<tr><td colspan="4" style="border: none;"><button class="layui-btn layui-btn-primary add"  type="button" style="float: right;" disabled="disabled">添加一行</button></td></tr>
                  		<tr class="thd"><td>开始值</td><td>结束值</td><td>价格</td><td>操作</td></tr>
                  		<tbody id="tbd">
                  		<c:forEach items="${pd.ITEMS}" var="item">
                  		<tr><td><input value="${item.START}" disabled="disabled"/></td><td><input value="${item.END}" disabled="disabled"/></td><td><input value="${item.MONEY}" disabled="disabled"/></td><td><button class="layui-btn layui-btn-primary delete" type="button" disabled="disabled">删除</button></td></tr>
                  		</c:forEach>
                  		</tbody>
                  	</table>
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
        
        $(".add").click(function(){
        	$("#tbd").append(`<tr><td><input/></td><td><input/></td><td><input/></td><td><button class="layui-btn layui-btn-primary delete" type="button">删除</button></td></tr>`);
        	$(".delete").click(function(){
            	$(this).parent().parent().remove();
            });
        });
        
        $(".delete").click(function(){
        	$(this).parent().parent().remove();
        });
        
        var remark = '';
        
        $(".sure").click(function(){
        	remark = '';
        	$("tbody#tbd tr").each(function(trindex,tritem){
        		remarkitem = '';
             $(tritem).find("input").each(function(tdindex,tditem){
            	 remarkitem+=$(tditem).val()+"/";
             });
             remark+=remarkitem+",";
         });
        	$("#remark").val(remark);
        	$("#form").submit();
        });
        
    </script>
  </body>

</html>