<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>仓库添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Cangku/frontlist">仓库列表</a></li>
			    	<li role="presentation" class="active"><a href="#cangkuAdd" aria-controls="cangkuAdd" role="tab" data-toggle="tab">添加仓库</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="cangkuList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="cangkuAdd"> 
				      	<form class="form-horizontal" name="cangkuAddForm" id="cangkuAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="cangku_diqu" class="col-md-2 text-right">所在地区:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="cangku_diqu" name="cangku.diqu" class="form-control" placeholder="请输入所在地区">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="cangku_cangkuName" class="col-md-2 text-right">仓库名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="cangku_cangkuName" name="cangku.cangkuName" class="form-control" placeholder="请输入仓库名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="cangku_mianji" class="col-md-2 text-right">仓库面积:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="cangku_mianji" name="cangku.mianji" class="form-control" placeholder="请输入仓库面积">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="cangku_tdl" class="col-md-2 text-right">仓库吞吐量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="cangku_tdl" name="cangku.tdl" class="form-control" placeholder="请输入仓库吞吐量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="cangku_lianxiren" class="col-md-2 text-right">联系人:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="cangku_lianxiren" name="cangku.lianxiren" class="form-control" placeholder="请输入联系人">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="cangku_telephone" class="col-md-2 text-right">联系电话:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="cangku_telephone" name="cangku.telephone" class="form-control" placeholder="请输入联系电话">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="cangku_address" class="col-md-2 text-right">仓库地址:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="cangku_address" name="cangku.address" class="form-control" placeholder="请输入仓库地址">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="cangku_cangkuMemo" class="col-md-2 text-right">仓库备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="cangku_cangkuMemo" name="cangku.cangkuMemo" rows="8" class="form-control" placeholder="请输入仓库备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxCangkuAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#cangkuAddForm .form-group {margin:10px;}  </style>
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
<script>
var basePath = "<%=basePath%>";
	//提交添加仓库信息
	function ajaxCangkuAdd() { 
		//提交之前先验证表单
		$("#cangkuAddForm").data('bootstrapValidator').validate();
		if(!$("#cangkuAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Cangku/add",
			dataType : "json" , 
			data: new FormData($("#cangkuAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#cangkuAddForm").find("input").val("");
					$("#cangkuAddForm").find("textarea").val("");
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
	//验证仓库添加表单字段
	$('#cangkuAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"cangku.diqu": {
				validators: {
					notEmpty: {
						message: "所在地区不能为空",
					}
				}
			},
			"cangku.cangkuName": {
				validators: {
					notEmpty: {
						message: "仓库名称不能为空",
					}
				}
			},
			"cangku.mianji": {
				validators: {
					notEmpty: {
						message: "仓库面积不能为空",
					}
				}
			},
			"cangku.tdl": {
				validators: {
					notEmpty: {
						message: "仓库吞吐量不能为空",
					}
				}
			},
			"cangku.lianxiren": {
				validators: {
					notEmpty: {
						message: "联系人不能为空",
					}
				}
			},
			"cangku.telephone": {
				validators: {
					notEmpty: {
						message: "联系电话不能为空",
					}
				}
			},
			"cangku.address": {
				validators: {
					notEmpty: {
						message: "仓库地址不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
