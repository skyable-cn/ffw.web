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
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/static/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/static/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/static/ueditor/lang/zh-cn/zh-cn.js"></script>
  </head>
  
  <body>
  	    <div class="x-nav">
      <span class="layui-breadcrumb">
        <a href="">产品管理</a>
        <a href="">产品维护</a>
        <a>
          <cite>查看产品</cite></a>
      </span>
    </div>
    <div class="x-body">
        <form class="layui-form" method="post" action="<%=request.getContextPath()%>/goods/edit">
          <input type="hidden" name="GOODS_ID" value="${pd.GOODS_ID}"/>
          
          <div class="layui-form-item">
              <label class="layui-form-label"><span class="x-red">*</span>关联小程序</label>
              <div class="layui-input-inline" style="height:50px;">
                <input value="1" type="checkbox" name="WXFLAG" lay-skin="primary" title="微信" lay-filter="filter"  <c:if test="${pd.WXFLAG eq 1}">checked="checked"</c:if> disabled="disabled"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>微信</span><i class="layui-icon layui-icon-ok"></i></div>
                <input value="1" type="checkbox" name="DYFLAG" lay-skin="primary" title="抖音" lay-filter="filter"  <c:if test="${pd.DYFLAG eq 1}">checked="checked"</c:if> disabled="disabled"><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>抖音</span><i class="layui-icon layui-icon-ok"></i></div>
              </div>
          </div>
          
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品名称
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username8" name="GOODSNAME" lay-verify="nikename"
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
                  <span class="x-red">*</span>标题
              </label>
              <div class="layui-input-inline">
                  <textarea placeholder="请输入内容" id="desc3" name="GOODSDESC" class="layui-textarea" disabled="disabled">${pd.GOODSDESC}</textarea>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>购买须知
              </label>
              <div class="layui-input-inline" style="width:calc(100% - 200px);max-width:800px;">
                  <script id="editor" type="text/plain" style="width:100%;min-height:300px;">${pd.BUYNOTICE}</script>
              </div>
          </div>
          <div class="layui-form-item">
          <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品详情
              </label>
              <div class="layui-input-inline" style="width:calc(100% - 200px);max-width:800px;">
          		  <input type="hidden" id="GOODSDETIAL" name="GOODSDETIAL" value='${pd.GOODSDETIAL}'/>
                  <script id="editor2" type="text/plain" style="width:100%;min-height:300px;">${pd.GOODSDETIAL}</script>
          	</div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品售卖价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username9" name="SELLMONEY" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.SELLMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品原始价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username10" name="ORIGINALMONEY" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.ORIGINALMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>产品结算价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username11" name="BALANCEMONEY" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.BALANCEMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>普通用户返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username112" name="MEMBERBACKMONEY" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.MEMBERBACKMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>会员用户返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username113" name="VIPBACKMONEY" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.VIPBACKMONEY}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>本级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username12" name="BACKMONEY0" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.BACKMONEY0}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>一级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username13" name="BACKMONEY1" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.BACKMONEY1}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>二级分销返利价格
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username14" name="BACKMONEY2" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.BACKMONEY2}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  	售卖开始时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="开始日" name="STARTTIME" id="start" lay-key="1" value="${pd.STARTTIME}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  	售卖结束时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="结束日" name="ENDTIME" id="end" lay-key="2" value="${pd.ENDTIME}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  	核销开始时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="开始日" name="USESTARTTIME" id="ustart" lay-key="3" value="${pd.USESTARTTIME}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  	核销结束时间
              </label>
              <div class="layui-input-inline">
                  <input class="layui-input" placeholder="结束日" name="USEENDTIME" id="uend" lay-key="4" value="${pd.USEENDTIME}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>库存
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username15" name="STORE" lay-verify="nikename"
                  autocomplete="off" class="layui-input" value="${pd.STORE}" disabled="disabled">
              </div>
          </div>
          <div class="layui-form-item">
                <label for="L_username" class="layui-form-label">
                    虚拟已售
                </label>
                <div class="layui-input-inline">
                    <input type="text" id="L_username155" name="VIRTUALSELLED" value="${pd.VIRTUALSELLED}"
                           autocomplete="off" class="layui-input" disabled="disabled">
                </div>
            </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>提供人员
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username151" name="PROVIDE" lay-verify="nikename11"
                  autocomplete="off" class="layui-input" value="${pd.PROVIDE}" disabled="disabled">
              </div>
          </div>
          <div id="shopDiv" class="layui-form-item">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户
              </label>
              <div class="layui-input-inline">
               <input type="hidden" id="SHOP_ID_HIDDEN" name="SHOP_ID" value="${pd.SHOP_ID}"/>
              <input type="text" id="L_username777"
                  autocomplete="off" class="layui-input" onclick="showShop();" value="${pd.SHOPNAME}" disabled="disabled">
              <!-- 
                  <select id="shipping" name="SHOP_ID" class="valid" disabled="disabled">
                    <c:forEach var="shop" items="${shopData}">
                    	<option value="${shop.SHOP_ID}" <c:if test="${shop.SHOP_ID eq pd.SHOP_ID}">selected="selected"</c:if>>${shop.SHOPNAME}</option>
                    </c:forEach>
                  </select>
               -->    
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
                    <option value="2" <c:if test="${pd.STATE eq 2}">selected="selected"</c:if>>售空</option>
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
    <script type="text/javascript">
    
    	var ue = UE.getEditor('editor');
    	
    	var ue2 = UE.getEditor('editor2');
    
    </script>
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
            
            laydate.render({
                elem: '#ustart' //指定元素
              	  ,type: 'datetime'
              });

              //执行一个laydate实例
              laydate.render({
                elem: '#uend' //指定元素
              	  ,type: 'datetime'
              });
          });
    </script>
  </body>

</html>