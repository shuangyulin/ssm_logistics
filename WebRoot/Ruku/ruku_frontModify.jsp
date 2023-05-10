<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Ruku" %>
<%@ page import="com.chengxusheji.po.Cangku" %>
<%@ page import="com.chengxusheji.po.WorkMan" %>
<%@ page import="com.chengxusheji.po.Wuzi" %>
<%@ page import="com.chengxusheji.po.WuziClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的cangkuObj信息
    List<Cangku> cangkuList = (List<Cangku>)request.getAttribute("cangkuList");
    //获取所有的workManObj信息
    List<WorkMan> workManList = (List<WorkMan>)request.getAttribute("workManList");
    //获取所有的wuziObj信息
    List<Wuzi> wuziList = (List<Wuzi>)request.getAttribute("wuziList");
    //获取所有的wuziClassObj信息
    List<WuziClass> wuziClassList = (List<WuziClass>)request.getAttribute("wuziClassList");
    Ruku ruku = (Ruku)request.getAttribute("ruku");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改入库信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">入库信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="rukuEditForm" id="rukuEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="ruku_rukuId_edit" class="col-md-3 text-right">入库id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="ruku_rukuId_edit" name="ruku.rukuId" class="form-control" placeholder="请输入入库id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="ruku_wuziObj_wuliuNo_edit" class="col-md-3 text-right">入库物资:</label>
		  	 <div class="col-md-9">
			    <select id="ruku_wuziObj_wuliuNo_edit" name="ruku.wuziObj.wuliuNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="ruku_wuziClassObj_wuziClassId_edit" class="col-md-3 text-right">物资种类:</label>
		  	 <div class="col-md-9">
			    <select id="ruku_wuziClassObj_wuziClassId_edit" name="ruku.wuziClassObj.wuziClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="ruku_zhongliang_edit" class="col-md-3 text-right">重量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="ruku_zhongliang_edit" name="ruku.zhongliang" class="form-control" placeholder="请输入重量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="ruku_cangkuObj_cangkuId_edit" class="col-md-3 text-right">入库仓库:</label>
		  	 <div class="col-md-9">
			    <select id="ruku_cangkuObj_cangkuId_edit" name="ruku.cangkuObj.cangkuId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="ruku_rukuTime_edit" class="col-md-3 text-right">入库时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date ruku_rukuTime_edit col-md-12" data-link-field="ruku_rukuTime_edit">
                    <input class="form-control" id="ruku_rukuTime_edit" name="ruku.rukuTime" size="16" type="text" value="" placeholder="请选择入库时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="ruku_okFlag_edit" class="col-md-3 text-right">是否完好:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="ruku_okFlag_edit" name="ruku.okFlag" class="form-control" placeholder="请输入是否完好">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="ruku_workManObj_workUserName_edit" class="col-md-3 text-right">工作人员:</label>
		  	 <div class="col-md-9">
			    <select id="ruku_workManObj_workUserName_edit" name="ruku.workManObj.workUserName" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="ruku_rukuMemo_edit" class="col-md-3 text-right">入库备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="ruku_rukuMemo_edit" name="ruku.rukuMemo" rows="8" class="form-control" placeholder="请输入入库备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxRukuModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#rukuEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改入库界面并初始化数据*/
function rukuEdit(rukuId) {
	$.ajax({
		url :  basePath + "Ruku/" + rukuId + "/update",
		type : "get",
		dataType: "json",
		success : function (ruku, response, status) {
			if (ruku) {
				$("#ruku_rukuId_edit").val(ruku.rukuId);
				$.ajax({
					url: basePath + "Wuzi/listAll",
					type: "get",
					success: function(wuzis,response,status) { 
						$("#ruku_wuziObj_wuliuNo_edit").empty();
						var html="";
		        		$(wuzis).each(function(i,wuzi){
		        			html += "<option value='" + wuzi.wuliuNo + "'>" + wuzi.wuziName + "</option>";
		        		});
		        		$("#ruku_wuziObj_wuliuNo_edit").html(html);
		        		$("#ruku_wuziObj_wuliuNo_edit").val(ruku.wuziObjPri);
					}
				});
				$.ajax({
					url: basePath + "WuziClass/listAll",
					type: "get",
					success: function(wuziClasss,response,status) { 
						$("#ruku_wuziClassObj_wuziClassId_edit").empty();
						var html="";
		        		$(wuziClasss).each(function(i,wuziClass){
		        			html += "<option value='" + wuziClass.wuziClassId + "'>" + wuziClass.wuziClassName + "</option>";
		        		});
		        		$("#ruku_wuziClassObj_wuziClassId_edit").html(html);
		        		$("#ruku_wuziClassObj_wuziClassId_edit").val(ruku.wuziClassObjPri);
					}
				});
				$("#ruku_zhongliang_edit").val(ruku.zhongliang);
				$.ajax({
					url: basePath + "Cangku/listAll",
					type: "get",
					success: function(cangkus,response,status) { 
						$("#ruku_cangkuObj_cangkuId_edit").empty();
						var html="";
		        		$(cangkus).each(function(i,cangku){
		        			html += "<option value='" + cangku.cangkuId + "'>" + cangku.cangkuName + "</option>";
		        		});
		        		$("#ruku_cangkuObj_cangkuId_edit").html(html);
		        		$("#ruku_cangkuObj_cangkuId_edit").val(ruku.cangkuObjPri);
					}
				});
				$("#ruku_rukuTime_edit").val(ruku.rukuTime);
				$("#ruku_okFlag_edit").val(ruku.okFlag);
				$.ajax({
					url: basePath + "WorkMan/listAll",
					type: "get",
					success: function(workMans,response,status) { 
						$("#ruku_workManObj_workUserName_edit").empty();
						var html="";
		        		$(workMans).each(function(i,workMan){
		        			html += "<option value='" + workMan.workUserName + "'>" + workMan.name + "</option>";
		        		});
		        		$("#ruku_workManObj_workUserName_edit").html(html);
		        		$("#ruku_workManObj_workUserName_edit").val(ruku.workManObjPri);
					}
				});
				$("#ruku_rukuMemo_edit").val(ruku.rukuMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交入库信息表单给服务器端修改*/
function ajaxRukuModify() {
	$.ajax({
		url :  basePath + "Ruku/" + $("#ruku_rukuId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#rukuEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#rukuQueryForm").submit();
            }else{
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
    /*入库时间组件*/
    $('.ruku_rukuTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    rukuEdit("<%=request.getParameter("rukuId")%>");
 })
 </script> 
</body>
</html>

