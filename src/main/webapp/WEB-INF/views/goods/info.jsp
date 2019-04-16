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
     
     #fileTable2{
     	min-width:550px;
     }
     #fileTable2 tr td{
     	  padding:10px;
     }
     #fileTable2 tr{
     	  border:1px #dddddd solid;
     }
    </style>
  </head>
  
  <body>
  	    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">产品管理</a>
        <a href="">产品维护</a>
        <a>
          <cite>查看产品</cite></a>
      </span>
      <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">ဂ</i></a>
    </div>
    <div class="x-body">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/goods/edit">
          <input type="hidden" name="GOODS_ID" value="${pd.GOODS_ID}"/>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username8" name="GOODSNAME" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.GOODSNAME}" disabled="disabled">
              </div>
          </div>
           <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品图片
              </label>
              <div class="layui-input-inline">
                  	<table id="fileTable">
                  		<c:forEach var="var" items="${fileDataList}">
                  			<tr><td>文件名称:${var.FILENAME}</br>文件大小:${var.FILESIZE} / M</td><td><img src="<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}" alt="产品图片" width="150px" lt="${var.FILE_ID}" style="cursor:pointer;" onerror="javascript:this.src='<%=request.getContextPath()%>/file/image?FILENAME=${var.FILEPATH}';"/></td><td></td></tr>
                  		</c:forEach>
                   </table>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品介绍
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc3" name="GOODSDESC" class="layui-textarea" disabled="disabled">${pd.GOODSDESC}</textarea>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>购买须知
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc4" name="BUYNOTICE" class="layui-textarea" disabled="disabled">${pd.BUYNOTICE}</textarea>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品售卖价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username9" name="SELLMONEY" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.SELLMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品原始价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username10" name="ORIGINALMONEY" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.ORIGINALMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品结算价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username11" name="BALANCEMONEY" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.BALANCEMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>普通用户返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username112" name="MEMBERBACKMONEY" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.MEMBERBACKMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>会员用户返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username113" name="VIPBACKMONEY" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.VIPBACKMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>本级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username12" name="BACKMONEY0" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.BACKMONEY0}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>一级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username13" name="BACKMONEY1" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.BACKMONEY1}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>二级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username14" name="BACKMONEY2" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.BACKMONEY2}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  	开始时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="开始日" name="STARTTIME" id="start" lay-key="1" value="${pd.STARTTIME}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  	结束时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="结束日" name="ENDTIME" id="end" lay-key="2" value="${pd.ENDTIME}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>库存
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username15" name="STORE" required="" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.STORE}" disabled="disabled">
              </div>
          </div>
          <div id="shopDiv" class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户
              </label>
              <div class="layui-input-inline">
                  <select id="shipping" name="SHOP_ID" class="valid" disabled="disabled">
                    <c:forEach var="shop" items="${shopData}">
                    	<option value="${shop.SHOP_ID}" <c:if test="${shop.SHOP_ID eq pd.SHOP_ID}">selected="selected"</c:if>>${shop.SHOPNAME}</option>
                    </c:forEach>
                  </select>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>分销海报
              </label>
              <div class="layui-input-inline">
                  <table id="fileTable2">
                  		<tr><td>文件名称:${fileData.FILENAME}</br>文件大小:${fileData.FILESIZE} / M</td><td><img src="<%=request.getContextPath()%>/file/image?FILENAME=${fileData.FILEPATH}" alt="海报图片"  width="150px" id="image-1" style="cursor:pointer;"/></td><td></td></tr>
                  	</table>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>分享描述
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc5" name="SHAREDESC" class="layui-textarea" disabled="disabled">${pd.SHAREDESC}</textarea>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>状态
              </label>
              <div class="layui-input-inline">
                  <select id="shipping" name="STATE" class="valid"  disabled="disabled">
                    <option value="1" <c:if test="${pd.STATE eq 1}">selected="selected"</c:if>>启用</option>
                    <option value="0" <c:if test="${pd.STATE eq 0}">selected="selected"</c:if>>暂停</option>
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
    </div>
    <%@ include file="../common/foot.jsp"%>
    <script>
        layui.use(['form','layer'], function(){
            $ = layui.jquery;
          var form = layui.form
          ,layer = layui.layer;
        
          //自定义验证规则
          form.verify({
            nikename: function(value){
              if(value.length < 1){
                return '昵称至少得1个字符啊';
              }
            }
          });
          
        });
        
        layui.use('laydate', function(){
            var laydate = layui.laydate;
            
            //执行一个laydate实例
            laydate.render({
              elem: '#start' //指定元素
            	  ,type: 'datetime'
            });

            //执行一个laydate实例
            laydate.render({
              elem: '#end' //指定元素
            	  ,type: 'datetime'
            });
          });
    </script>
  </body>

</html>