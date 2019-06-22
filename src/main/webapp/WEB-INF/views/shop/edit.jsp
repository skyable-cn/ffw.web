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
           	<a href="">商户模块</a>
        <a href="">商户管理</a>
        <a>
          <cite>编辑商户</cite></a>
      </span>
    </div>
    <div class="x-body">
        <form enctype="multipart/form-data" class="layui-form" method="post" action="<%=request.getContextPath()%>/shop/edit">
          <input id="WXMEMBERIDS" name="WXMEMBERIDS" type="hidden" value="${wxIDS}"/>
          <input id="DYMEMBERIDS" name="DYMEMBERIDS" type="hidden" value="${dyIDS}"/>
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
                  <textarea placeholder="请输入内容" id="desc" name="SHOPDESC" class="layui-textarea" lay-verify="nikenamess">${pd.SHOPDESC}</textarea>
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  商户详细地址
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username4" name="SHOPADDRESS" required="" lay-verify="nikenamedizhi"
                  autocomplete="off" class="layui-input" value="${pd.SHOPADDRESS}" >
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>联系人
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username5" name="CONTRACTPERSON" required="" lay-verify="nikenameren"
                  autocomplete="off" class="layui-input" value="${pd.CONTRACTPERSON}" >
              </div>
          </div>
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  联系电话
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username6" name="CONTRACTPHONE" required="" lay-verify="nikenamephone"
                  autocomplete="off" class="layui-input" value="${pd.CONTRACTPHONE}" >
              </div>
          </div>
          
          <div class="layui-form-item">
              <label for="L_username" class="layui-form-label">
                  <span class="x-red">*</span>人均消费
              </label>
              <div class="layui-input-inline">
                  <input type="text" id="L_username7" name="AVGMONEY" required="" lay-verify="nikenamerenxiaofei"
                  autocomplete="off" class="layui-input" value="${pd.AVGMONEY}" >
              </div>
          </div>
          
          <div class="layui-form-item">
          <hr/>
          </div>
          
           <div class="layui-form-item">
              <label class="layui-form-label"><span class="x-red">*</span>关联小程序</label>
              <div class="layui-input-inline" style="height:50px;">
                <input value="1" type="checkbox" name="WXFLAG" lay-skin="primary" title="微信" lay-filter="filter" <c:if test="${pd.WXFLAG eq 1}">checked="checked"</c:if>><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>微信</span><i class="layui-icon layui-icon-ok"></i></div>
              </div>
          </div>
          
          <div class="layui-form-item wx-div">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户微信管理员
              </label>
              <div class="layui-input-inline">
                  <select id="member" name="MEMBER_ID" class="valid">
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
                  autocomplete="off" class="layui-input" onclick="showWXMember();" value="${wxNAMES}">
              </div>
          </div>
          
          <div class="layui-form-item">
          <hr/>
          </div>
          
          <div class="layui-form-item">
              <label class="layui-form-label"><span class="x-red">*</span>关联小程序</label>
              <div class="layui-input-inline" style="height:50px;">
                <input value="1" type="checkbox" name="DYFLAG" lay-skin="primary" title="抖音" lay-filter="filter" <c:if test="${pd.DYFLAG eq 1}">checked="checked"</c:if>><div class="layui-unselect layui-form-checkbox" lay-skin="primary"><span>抖音</span><i class="layui-icon layui-icon-ok"></i></div>
              </div>
          </div>
          
          <div class="layui-form-item dy-div">
              <label for="username" class="layui-form-label">
                  <span class="x-red">*</span>商户抖音管理员
              </label>
              <div class="layui-input-inline">
                  <select id="member_dy" name="MEMBER_ID_DY" class="valid">
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
                  autocomplete="off" class="layui-input" onclick="showDYMember();" value="${dyNAMES}">
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
          
          form.on('checkbox(filter)', function(data){
        	  if(data.elem.checked){
        		  if($(data.elem).attr("name")=="WXFLAG"){
        			  $(".wx-div").css("display","");
        		  }
        		  
        		  if($(data.elem).attr("name")=="DYFLAG"){
        			  $(".dy-div").css("display","");
        		  }
        		  
        	  }else{
        		  if($(data.elem).attr("name")=="WXFLAG"){
        			  $(".wx-div").css("display","none");
        		  }
        		  
        		  if($(data.elem).attr("name")=="DYFLAG"){
        			  $(".dy-div").css("display","none");
        		  }
        	  }
        	  
        	  
        	}); 

            //自定义验证规则
            form.verify({
                nikename: function(value){
                    if(value.length < 2){
                        return '昵称至少得2个字符啊';
                    }
                },
                //nikename1: function(value){
                //    if(value.length < 2){
                //        return '请提供商户图片';
                //    }
                //},
                nikenamess: function(value){
                    if(value.length < 2){
                        return '请输入商户描述';
                    }
                },nikenameren: function(value){
                    if(value.length < 2){
                        return '请输入联系人';
                    }
                },nikenamerenxiaofei: function(value){
                    if(value.length < 2){
                        return '请输入人均消费';
                    }
                }
          });
          
        });
        
        function showImg(obj){
        	var imageSrc = window.URL?window.URL.createObjectURL(obj.files[0]):obj.value;
        	$("#image")[0].src=imageSrc;
        	$("#image").css("display","");
        }
        
        var wxIDS = "${wxIDS}";
        var wxNAMES = "${wxNAMES}";
        
        function showWXMember(){
        	var wxids = wxIDS.split(",");
        	var wxtbody = "<tbody id = 'wxMember'>";
        	<c:forEach var="m" items="${memberData}">
        		var checkflag= "";
        		if(wxids.indexOf("${m.MEMBER_ID}") >= 0){
        			checkflag = "checked='checked'";
        		}
            	<c:if test="${m.CLASS eq 'wx'}">
            		wxtbody+="<tr id='WX_${m.MEMBER_ID}' ln='${m.NICKNAME}'><td><img src='${m.PHOTO}' width='50'/>'</td><td>${m.NICKNAME}</td><td><input type='checkbox' style='width:30px;' value='${m.MEMBER_ID}' ln='${m.NICKNAME}' "+checkflag+"/></td></tr>";
            	</c:if>
            </c:forEach>
            wxtbody+="</tbody>";
        	var table = "<table class='layui-table'>";
        	table+=wxtbody;
        	table += "</table>";
        	layer.open({
        	  title:'商户微信店员',
        	  area: ['600px', '400px'],
        	  content: '<div><input type="text" id="searchWXMember" name="autocomplete="off" class="layui-input" onblur="searchWXMember()" placeholder="请输入昵称"/></div><div>'+table+'</div>'
        	  ,btn: ['确认', '取消']
        	  ,yes: function(index, layero){
        		  wxIDS = "";
        		  wxNAMES = "";
        	    $("#wxMember").find("input[type='checkbox']").each(function(){
        	    	if($(this).is(':checked')){
        	    		wxIDS+=$(this).val()+',';
        	    		wxNAMES+=$(this).attr("ln")+',';
        	    	}
        	    });
        	    
        	    if(wxIDS.length > 0){
        	    	wxIDS = wxIDS.substr(0,wxIDS.length-1);
        	    	wxNAMES = wxNAMES.substr(0,wxNAMES.length-1).replace(/,/g,"  ,  ");
        	    }
        	    
        		$("#WXMEMBERIDS").val(wxIDS);
        	    
        	    $("#L_username777").val(wxNAMES);
        	    layer.close(index);
        	  }
        	  ,btn2: function(index, layero){
        	    //按钮【按钮二】的回调
        	    
        	    //return false 开启该代码可禁止点击该按钮关闭
        	  }
        	  ,cancel: function(){ 
        	    //右上角关闭回调
        	    
        	    //return false 开启该代码可禁止点击该按钮关闭
        	  }
        	});
        }
        
        function searchWXMember(){
        	var searchWXMember = $("#searchWXMember").val();
        	if(!searchWXMember){
        		$("#wxMember").find("tr").each(function(){
    				$(this).css("display","");
    		    });
        		return;
        	}
        	if(searchWXMember){
    	    	$("#wxMember").find("tr").each(function(){
    		    	if($(this).attr("ln").indexOf(searchWXMember) == -1 ){
    		    		$(this).css("display","none");
    		    	}else{
    		    		$(this).css("display","");
    		    	}
    		    });
        	}
        }
        
        var dyIDS = "${dyIDS}";
        var dyNAMES = "${dyNAMES}";
        
        function showDYMember(){
        	var dyids = dyIDS.split(",");
        	var dytbody = "<tbody id = 'dyMember'>";
        	<c:forEach var="m" items="${memberData}">
        		var checkflag= "";
        		if(dyids.indexOf("${m.MEMBER_ID}") >= 0){
        			checkflag = "checked='checked'";
        		}
            	<c:if test="${m.CLASS eq 'dy'}">
            		dytbody+="<tr id='WX_${m.MEMBER_ID}' ln='${m.NICKNAME}'><td><img src='${m.PHOTO}' width='50'/>'</td><td>${m.NICKNAME}</td><td><input type='checkbox' style='width:30px;' value='${m.MEMBER_ID}' ln='${m.NICKNAME}' "+checkflag+"/></td></tr>";
            	</c:if>
            </c:forEach>
            dytbody+="</tbody>";
        	var table = "<table class='layui-table'>";
        	table+=dytbody;
        	table += "</table>";
        	layer.open({
        	  title:'商户抖音店员',
        	  area: ['600px', '400px'],
        	  content: '<div><input type="text" id="searchDYMember" name="autocomplete="off" class="layui-input" onblur="searchDYMember()" placeholder="请输入昵称"/></div><div>'+table+'</div>'
        	  ,btn: ['确认', '取消']
        	  ,yes: function(index, layero){
        		  dyIDS = "";
        		  dyNAMES = "";
        	    $("#dyMember").find("input[type='checkbox']").each(function(){
        	    	if($(this).is(':checked')){
        	    		dyIDS+=$(this).val()+',';
        	    		dyNAMES+=$(this).attr("ln")+',';
        	    	}
        	    });
        	    
        	    if(dyIDS.length > 0){
        	    	dyIDS = dyIDS.substr(0,dyIDS.length-1);
        	    	dyNAMES = dyNAMES.substr(0,dyNAMES.length-1).replace(/,/g,"  ,  ");
        	    }
        	    
        		$("#DYMEMBERIDS").val(dyIDS);
        	    
        	    $("#L_username888").val(dyNAMES);
        	    layer.close(index);
        	  }
        	  ,btn2: function(index, layero){
        	    //按钮【按钮二】的回调
        	    
        	    //return false 开启该代码可禁止点击该按钮关闭
        	  }
        	  ,cancel: function(){ 
        	    //右上角关闭回调
        	    
        	    //return false 开启该代码可禁止点击该按钮关闭
        	  }
        	});
        }
        
        function searchDYMember(){
        	var searchDYMember = $("#searchDYMember").val();
        	if(!searchDYMember){
        		$("#dyMember").find("tr").each(function(){
    				$(this).css("display","");
    		    });
        		return;
        	}
        	if(searchDYMember){
    	    	$("#dyMember").find("tr").each(function(){
    		    	if($(this).attr("ln").indexOf(searchDYMember) == -1 ){
    		    		$(this).css("display","none");
    		    	}else{
    		    		$(this).css("display","");
    		    	}
    		    });
        	}
        }
    </script>
  </body>

</html>