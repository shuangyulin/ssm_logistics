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
<title>出库添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Chuku/frontlist">出库列表</a></li>
			    	<li role="presentation" class="active"><a href="#chukuAdd" aria-controls="chukuAdd" role="tab" data-toggle="tab">添加出库</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="chukuList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="chukuAdd"> 
				      	<form class="form-horizontal" name="chukuAddForm" id="chukuAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="chuku_wuziObj_wuliuNo" class="col-md-2 text-right">出库物资:</label>
						  	 <div class="col-md-8">
							    <select id="chuku_wuziObj_wuliuNo" name="chuku.wuziObj.wuliuNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="chuku_wuziClassObj_wuziClassId" class="col-md-2 text-right">物资种类:</label>
						  	 <div class="col-md-8">
							    <select id="chuku_wuziClassObj_wuziClassId" name="chuku.wuziClassObj.wuziClassId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="chuku_zhongliang" class="col-md-2 text-right">重量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="chuku_zhongliang" name="chuku.zhongliang" class="form-control" placeholder="请输入重量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="chuku_cangkuObj_cangkuId" class="col-md-2 text-right">出库仓库:</label>
						  	 <div class="col-md-8">
							    <select id="chuku_cangkuObj_cangkuId" name="chuku.cangkuObj.cangkuId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="chuku_chukuTimeDiv" class="col-md-2 text-right">出库时间:</label>
						  	 <div class="col-md-8">
				                <div id="chuku_chukuTimeDiv" class="input-group date chuku_chukuTime col-md-12" data-link-field="chuku_chukuTime">
				                    <input class="form-control" id="chuku_chukuTime" name="chuku.chukuTime" size="16" type="text" value="" placeholder="请选择出库时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="chuku_okFlag" class="col-md-2 text-right">是否完好:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="chuku_okFlag" name="chuku.okFlag" class="form-control" placeholder="请输入是否完好">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="chuku_workManObj_workUserName" class="col-md-2 text-right">工作人员:</label>
						  	 <div class="col-md-8">
							    <select id="chuku_workManObj_workUserName" name="chuku.workManObj.workUserName" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="chuku_chukuMemo" class="col-md-2 text-right">出库备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="chuku_chukuMemo" name="chuku.chukuMemo" rows="8" class="form-control" placeholder="请输入出库备注"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxChukuAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#chukuAddForm .form-group {margin:10px;}  </style>
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
	//提交添加出库信息
	function ajaxChukuAdd() { 
		//提交之前先验证表单
		$("#chukuAddForm").data('bootstrapValidator').validate();
		if(!$("#chukuAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Chuku/add",
			dataType : "json" , 
			data: new FormData($("#chukuAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#chukuAddForm").find("input").val("");
					$("#chukuAddForm").find("textarea").val("");
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
	//验证出库添加表单字段
	$('#chukuAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"chuku.zhongliang": {
				validators: {
					notEmpty: {
						message: "重量不能为空",
					}
				}
			},
			"chuku.chukuTime": {
				validators: {
					notEmpty: {
						message: "出库时间不能为空",
					}
				}
			},
			"chuku.okFlag": {
				validators: {
					notEmpty: {
						message: "是否完好不能为空",
					}
				}
			},
		}
	}); 
	//初始化出库物资下拉框值 
	$.ajax({
		url: basePath + "Wuzi/listAll",
		type: "get",
		success: function(wuzis,response,status) { 
			$("#chuku_wuziObj_wuliuNo").empty();
			var html="";
    		$(wuzis).each(function(i,wuzi){
    			html += "<option value='" + wuzi.wuliuNo + "'>" + wuzi.wuziName + "</option>";
    		});
    		$("#chuku_wuziObj_wuliuNo").html(html);
    	}
	});
	//初始化物资种类下拉框值 
	$.ajax({
		url: basePath + "WuziClass/listAll",
		type: "get",
		success: function(wuziClasss,response,status) { 
			$("#chuku_wuziClassObj_wuziClassId").empty();
			var html="";
    		$(wuziClasss).each(function(i,wuziClass){
    			html += "<option value='" + wuziClass.wuziClassId + "'>" + wuziClass.wuziClassName + "</option>";
    		});
    		$("#chuku_wuziClassObj_wuziClassId").html(html);
    	}
	});
	//初始化出库仓库下拉框值 
	$.ajax({
		url: basePath + "Cangku/listAll",
		type: "get",
		success: function(cangkus,response,status) { 
			$("#chuku_cangkuObj_cangkuId").empty();
			var html="";
    		$(cangkus).each(function(i,cangku){
    			html += "<option value='" + cangku.cangkuId + "'>" + cangku.cangkuName + "</option>";
    		});
    		$("#chuku_cangkuObj_cangkuId").html(html);
    	}
	});
	//初始化工作人员下拉框值 
	$.ajax({
		url: basePath + "WorkMan/listAll",
		type: "get",
		success: function(workMans,response,status) { 
			$("#chuku_workManObj_workUserName").empty();
			var html="";
    		$(workMans).each(function(i,workMan){
    			html += "<option value='" + workMan.workUserName + "'>" + workMan.name + "</option>";
    		});
    		$("#chuku_workManObj_workUserName").html(html);
    	}
	});
	//出库时间组件
	$('#chuku_chukuTimeDiv').datetimepicker({
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
		$('#chukuAddForm').data('bootstrapValidator').updateStatus('chuku.chukuTime', 'NOT_VALIDATED',null).validateField('chuku.chukuTime');
	});
})
</script>
</body>
</html>
