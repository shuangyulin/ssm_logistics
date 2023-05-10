<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Cangku" %>
<%@ page import="com.chengxusheji.po.WorkMan" %>
<%@ page import="com.chengxusheji.po.Wuzi" %>
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
<title>入库添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Ruku/frontlist">入库列表</a></li>
			    	<li role="presentation" class="active"><a href="#rukuAdd" aria-controls="rukuAdd" role="tab" data-toggle="tab">添加入库</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="rukuList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="rukuAdd"> 
				      	<form class="form-horizontal" name="rukuAddForm" id="rukuAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="ruku_wuziObj_wuliuNo" class="col-md-2 text-right">入库物资:</label>
						  	 <div class="col-md-8">
							    <select id="ruku_wuziObj_wuliuNo" name="ruku.wuziObj.wuliuNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="ruku_wuziClassObj_wuziClassId" class="col-md-2 text-right">物资种类:</label>
						  	 <div class="col-md-8">
							    <select id="ruku_wuziClassObj_wuziClassId" name="ruku.wuziClassObj.wuziClassId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="ruku_zhongliang" class="col-md-2 text-right">重量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="ruku_zhongliang" name="ruku.zhongliang" class="form-control" placeholder="请输入重量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="ruku_cangkuObj_cangkuId" class="col-md-2 text-right">入库仓库:</label>
						  	 <div class="col-md-8">
							    <select id="ruku_cangkuObj_cangkuId" name="ruku.cangkuObj.cangkuId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="ruku_rukuTimeDiv" class="col-md-2 text-right">入库时间:</label>
						  	 <div class="col-md-8">
				                <div id="ruku_rukuTimeDiv" class="input-group date ruku_rukuTime col-md-12" data-link-field="ruku_rukuTime">
				                    <input class="form-control" id="ruku_rukuTime" name="ruku.rukuTime" size="16" type="text" value="" placeholder="请选择入库时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="ruku_okFlag" class="col-md-2 text-right">是否完好:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="ruku_okFlag" name="ruku.okFlag" class="form-control" placeholder="请输入是否完好">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="ruku_workManObj_workUserName" class="col-md-2 text-right">工作人员:</label>
						  	 <div class="col-md-8">
							    <select id="ruku_workManObj_workUserName" name="ruku.workManObj.workUserName" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="ruku_rukuMemo" class="col-md-2 text-right">入库备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="ruku_rukuMemo" name="ruku.rukuMemo" rows="8" class="form-control" placeholder="请输入入库备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxRukuAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#rukuAddForm .form-group {margin:10px;}  </style>
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
	//提交添加入库信息
	function ajaxRukuAdd() { 
		//提交之前先验证表单
		$("#rukuAddForm").data('bootstrapValidator').validate();
		if(!$("#rukuAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Ruku/add",
			dataType : "json" , 
			data: new FormData($("#rukuAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#rukuAddForm").find("input").val("");
					$("#rukuAddForm").find("textarea").val("");
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
	//验证入库添加表单字段
	$('#rukuAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"ruku.zhongliang": {
				validators: {
					notEmpty: {
						message: "重量不能为空",
					}
				}
			},
			"ruku.rukuTime": {
				validators: {
					notEmpty: {
						message: "入库时间不能为空",
					}
				}
			},
			"ruku.okFlag": {
				validators: {
					notEmpty: {
						message: "是否完好不能为空",
					}
				}
			},
		}
	}); 
	//初始化入库物资下拉框值 
	$.ajax({
		url: basePath + "Wuzi/listAll",
		type: "get",
		success: function(wuzis,response,status) { 
			$("#ruku_wuziObj_wuliuNo").empty();
			var html="";
    		$(wuzis).each(function(i,wuzi){
    			html += "<option value='" + wuzi.wuliuNo + "'>" + wuzi.wuziName + "</option>";
    		});
    		$("#ruku_wuziObj_wuliuNo").html(html);
    	}
	});
	//初始化物资种类下拉框值 
	$.ajax({
		url: basePath + "WuziClass/listAll",
		type: "get",
		success: function(wuziClasss,response,status) { 
			$("#ruku_wuziClassObj_wuziClassId").empty();
			var html="";
    		$(wuziClasss).each(function(i,wuziClass){
    			html += "<option value='" + wuziClass.wuziClassId + "'>" + wuziClass.wuziClassName + "</option>";
    		});
    		$("#ruku_wuziClassObj_wuziClassId").html(html);
    	}
	});
	//初始化入库仓库下拉框值 
	$.ajax({
		url: basePath + "Cangku/listAll",
		type: "get",
		success: function(cangkus,response,status) { 
			$("#ruku_cangkuObj_cangkuId").empty();
			var html="";
    		$(cangkus).each(function(i,cangku){
    			html += "<option value='" + cangku.cangkuId + "'>" + cangku.cangkuName + "</option>";
    		});
    		$("#ruku_cangkuObj_cangkuId").html(html);
    	}
	});
	//初始化工作人员下拉框值 
	$.ajax({
		url: basePath + "WorkMan/listAll",
		type: "get",
		success: function(workMans,response,status) { 
			$("#ruku_workManObj_workUserName").empty();
			var html="";
    		$(workMans).each(function(i,workMan){
    			html += "<option value='" + workMan.workUserName + "'>" + workMan.name + "</option>";
    		});
    		$("#ruku_workManObj_workUserName").html(html);
    	}
	});
	//入库时间组件
	$('#ruku_rukuTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#rukuAddForm').data('bootstrapValidator').updateStatus('ruku.rukuTime', 'NOT_VALIDATED',null).validateField('ruku.rukuTime');
	});
})
</script>
</body>
</html>
