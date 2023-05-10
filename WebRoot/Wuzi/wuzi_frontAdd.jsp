<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ page import="com.chengxusheji.po.WuziClass" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>物资添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Wuzi/frontlist">物资列表</a></li>
			    	<li role="presentation" class="active"><a href="#wuziAdd" aria-controls="wuziAdd" role="tab" data-toggle="tab">添加物资</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="wuziList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="wuziAdd"> 
				      	<form class="form-horizontal" name="wuziAddForm" id="wuziAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
							 <label for="wuzi_wuliuNo" class="col-md-2 text-right">物流单号:</label>
							 <div class="col-md-8"> 
							 	<input type="text" id="wuzi_wuliuNo" name="wuzi.wuliuNo" class="form-control" placeholder="请输入物流单号">
							 </div>
						  </div> 
						  <div class="form-group">
						  	 <label for="wuzi_wuziClassObj_wuziClassId" class="col-md-2 text-right">物资分类:</label>
						  	 <div class="col-md-8">
							    <select id="wuzi_wuziClassObj_wuziClassId" name="wuzi.wuziClassObj.wuziClassId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_wuziName" class="col-md-2 text-right">物资名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wuzi_wuziName" name="wuzi.wuziName" class="form-control" placeholder="请输入物资名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_zhongliang" class="col-md-2 text-right">物资重量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wuzi_zhongliang" name="wuzi.zhongliang" class="form-control" placeholder="请输入物资重量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_wuziDesc" class="col-md-2 text-right">物资详情:</label>
						  	 <div class="col-md-8">
							    <textarea name="wuzi.wuziDesc" id="wuzi_wuziDesc" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_userObj_user_name" class="col-md-2 text-right">寄件人:</label>
						  	 <div class="col-md-8">
							    <select id="wuzi_userObj_user_name" name="wuzi.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_sendTelephone" class="col-md-2 text-right">寄件人电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wuzi_sendTelephone" name="wuzi.sendTelephone" class="form-control" placeholder="请输入寄件人电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_sendAddress" class="col-md-2 text-right">寄件人地址:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wuzi_sendAddress" name="wuzi.sendAddress" class="form-control" placeholder="请输入寄件人地址">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_receiveUserObj_user_name" class="col-md-2 text-right">收件人:</label>
						  	 <div class="col-md-8">
							    <select id="wuzi_receiveUserObj_user_name" name="wuzi.receiveUserObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_receiveTelephone" class="col-md-2 text-right">收件人电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wuzi_receiveTelephone" name="wuzi.receiveTelephone" class="form-control" placeholder="请输入收件人电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_receiveAddress" class="col-md-2 text-right">收件人地址:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wuzi_receiveAddress" name="wuzi.receiveAddress" class="form-control" placeholder="请输入收件人地址">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_yunfei" class="col-md-2 text-right">运费:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="wuzi_yunfei" name="wuzi.yunfei" class="form-control" placeholder="请输入运费">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_wldt" class="col-md-2 text-right">物流动态:</label>
						  	 <div class="col-md-8">
							    <textarea id="wuzi_wldt" name="wuzi.wldt" rows="8" class="form-control" placeholder="请输入物流动态"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="wuzi_wuziMemo" class="col-md-2 text-right">备注信息:</label>
						  	 <div class="col-md-8">
							    <textarea id="wuzi_wuziMemo" name="wuzi.wuziMemo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxWuziAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#wuziAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var wuzi_wuziDesc_editor = UE.getEditor('wuzi_wuziDesc'); //物资详情编辑器
var basePath = "<%=basePath%>";
	//提交添加物资信息
	function ajaxWuziAdd() { 
		//提交之前先验证表单
		$("#wuziAddForm").data('bootstrapValidator').validate();
		if(!$("#wuziAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(wuzi_wuziDesc_editor.getContent() == "") {
			alert('物资详情不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Wuzi/add",
			dataType : "json" , 
			data: new FormData($("#wuziAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#wuziAddForm").find("input").val("");
					$("#wuziAddForm").find("textarea").val("");
					wuzi_wuziDesc_editor.setContent("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证物资添加表单字段
	$('#wuziAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"wuzi.wuliuNo": {
				validators: {
					notEmpty: {
						message: "物流单号不能为空",
					}
				}
			},
			"wuzi.wuziName": {
				validators: {
					notEmpty: {
						message: "物资名称不能为空",
					}
				}
			},
			"wuzi.zhongliang": {
				validators: {
					notEmpty: {
						message: "物资重量不能为空",
					}
				}
			},
			"wuzi.sendTelephone": {
				validators: {
					notEmpty: {
						message: "寄件人电话不能为空",
					}
				}
			},
			"wuzi.sendAddress": {
				validators: {
					notEmpty: {
						message: "寄件人地址不能为空",
					}
				}
			},
			"wuzi.receiveTelephone": {
				validators: {
					notEmpty: {
						message: "收件人电话不能为空",
					}
				}
			},
			"wuzi.receiveAddress": {
				validators: {
					notEmpty: {
						message: "收件人地址不能为空",
					}
				}
			},
			"wuzi.yunfei": {
				validators: {
					notEmpty: {
						message: "运费不能为空",
					},
					numeric: {
						message: "运费不正确"
					}
				}
			},
			"wuzi.wldt": {
				validators: {
					notEmpty: {
						message: "物流动态不能为空",
					}
				}
			},
		}
	}); 
	//初始化物资分类下拉框值 
	$.ajax({
		url: basePath + "WuziClass/listAll",
		type: "get",
		success: function(wuziClasss,response,status) { 
			$("#wuzi_wuziClassObj_wuziClassId").empty();
			var html="";
    		$(wuziClasss).each(function(i,wuziClass){
    			html += "<option value='" + wuziClass.wuziClassId + "'>" + wuziClass.wuziClassName + "</option>";
    		});
    		$("#wuzi_wuziClassObj_wuziClassId").html(html);
    	}
	});
	//初始化寄件人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#wuzi_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#wuzi_userObj_user_name").html(html);
    	}
	});
	//初始化收件人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#wuzi_receiveUserObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#wuzi_receiveUserObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
