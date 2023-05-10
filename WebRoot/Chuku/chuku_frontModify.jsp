<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Chuku" %>
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
    Chuku chuku = (Chuku)request.getAttribute("chuku");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改出库信息</TITLE>
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
  		<li class="active">出库信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="chukuEditForm" id="chukuEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="chuku_chukuId_edit" class="col-md-3 text-right">出库id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="chuku_chukuId_edit" name="chuku.chukuId" class="form-control" placeholder="请输入出库id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="chuku_wuziObj_wuliuNo_edit" class="col-md-3 text-right">出库物资:</label>
		  	 <div class="col-md-9">
			    <select id="chuku_wuziObj_wuliuNo_edit" name="chuku.wuziObj.wuliuNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="chuku_wuziClassObj_wuziClassId_edit" class="col-md-3 text-right">物资种类:</label>
		  	 <div class="col-md-9">
			    <select id="chuku_wuziClassObj_wuziClassId_edit" name="chuku.wuziClassObj.wuziClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="chuku_zhongliang_edit" class="col-md-3 text-right">重量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="chuku_zhongliang_edit" name="chuku.zhongliang" class="form-control" placeholder="请输入重量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="chuku_cangkuObj_cangkuId_edit" class="col-md-3 text-right">出库仓库:</label>
		  	 <div class="col-md-9">
			    <select id="chuku_cangkuObj_cangkuId_edit" name="chuku.cangkuObj.cangkuId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="chuku_chukuTime_edit" class="col-md-3 text-right">出库时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date chuku_chukuTime_edit col-md-12" data-link-field="chuku_chukuTime_edit">
                    <input class="form-control" id="chuku_chukuTime_edit" name="chuku.chukuTime" size="16" type="text" value="" placeholder="请选择出库时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="chuku_okFlag_edit" class="col-md-3 text-right">是否完好:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="chuku_okFlag_edit" name="chuku.okFlag" class="form-control" placeholder="请输入是否完好">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="chuku_workManObj_workUserName_edit" class="col-md-3 text-right">工作人员:</label>
		  	 <div class="col-md-9">
			    <select id="chuku_workManObj_workUserName_edit" name="chuku.workManObj.workUserName" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="chuku_chukuMemo_edit" class="col-md-3 text-right">出库备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="chuku_chukuMemo_edit" name="chuku.chukuMemo" rows="8" class="form-control" placeholder="请输入出库备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxChukuModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#chukuEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改出库界面并初始化数据*/
function chukuEdit(chukuId) {
	$.ajax({
		url :  basePath + "Chuku/" + chukuId + "/update",
		type : "get",
		dataType: "json",
		success : function (chuku, response, status) {
			if (chuku) {
				$("#chuku_chukuId_edit").val(chuku.chukuId);
				$.ajax({
					url: basePath + "Wuzi/listAll",
					type: "get",
					success: function(wuzis,response,status) { 
						$("#chuku_wuziObj_wuliuNo_edit").empty();
						var html="";
		        		$(wuzis).each(function(i,wuzi){
		        			html += "<option value='" + wuzi.wuliuNo + "'>" + wuzi.wuziName + "</option>";
		        		});
		        		$("#chuku_wuziObj_wuliuNo_edit").html(html);
		        		$("#chuku_wuziObj_wuliuNo_edit").val(chuku.wuziObjPri);
					}
				});
				$.ajax({
					url: basePath + "WuziClass/listAll",
					type: "get",
					success: function(wuziClasss,response,status) { 
						$("#chuku_wuziClassObj_wuziClassId_edit").empty();
						var html="";
		        		$(wuziClasss).each(function(i,wuziClass){
		        			html += "<option value='" + wuziClass.wuziClassId + "'>" + wuziClass.wuziClassName + "</option>";
		        		});
		        		$("#chuku_wuziClassObj_wuziClassId_edit").html(html);
		        		$("#chuku_wuziClassObj_wuziClassId_edit").val(chuku.wuziClassObjPri);
					}
				});
				$("#chuku_zhongliang_edit").val(chuku.zhongliang);
				$.ajax({
					url: basePath + "Cangku/listAll",
					type: "get",
					success: function(cangkus,response,status) { 
						$("#chuku_cangkuObj_cangkuId_edit").empty();
						var html="";
		        		$(cangkus).each(function(i,cangku){
		        			html += "<option value='" + cangku.cangkuId + "'>" + cangku.cangkuName + "</option>";
		        		});
		        		$("#chuku_cangkuObj_cangkuId_edit").html(html);
		        		$("#chuku_cangkuObj_cangkuId_edit").val(chuku.cangkuObjPri);
					}
				});
				$("#chuku_chukuTime_edit").val(chuku.chukuTime);
				$("#chuku_okFlag_edit").val(chuku.okFlag);
				$.ajax({
					url: basePath + "WorkMan/listAll",
					type: "get",
					success: function(workMans,response,status) { 
						$("#chuku_workManObj_workUserName_edit").empty();
						var html="";
		        		$(workMans).each(function(i,workMan){
		        			html += "<option value='" + workMan.workUserName + "'>" + workMan.name + "</option>";
		        		});
		        		$("#chuku_workManObj_workUserName_edit").html(html);
		        		$("#chuku_workManObj_workUserName_edit").val(chuku.workManObjPri);
					}
				});
				$("#chuku_chukuMemo_edit").val(chuku.chukuMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交出库信息表单给服务器端修改*/
function ajaxChukuModify() {
	$.ajax({
		url :  basePath + "Chuku/" + $("#chuku_chukuId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#chukuEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#chukuQueryForm").submit();
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
    /*出库时间组件*/
    $('.chuku_chukuTime_edit').datetimepicker({
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
    chukuEdit("<%=request.getParameter("chukuId")%>");
 })
 </script> 
</body>
</html>

