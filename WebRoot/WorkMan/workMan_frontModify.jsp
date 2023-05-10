<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.WorkMan" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    WorkMan workMan = (WorkMan)request.getAttribute("workMan");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改工作人员信息</TITLE>
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
  		<li class="active">工作人员信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="workManEditForm" id="workManEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="workMan_workUserName_edit" class="col-md-3 text-right">工作人员账号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="workMan_workUserName_edit" name="workMan.workUserName" class="form-control" placeholder="请输入工作人员账号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="workMan_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="workMan_password_edit" name="workMan.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="workMan_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="workMan_name_edit" name="workMan.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="workMan_gender_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="workMan_gender_edit" name="workMan.gender" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="workMan_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date workMan_birthDate_edit col-md-12" data-link-field="workMan_birthDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="workMan_birthDate_edit" name="workMan.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="workMan_workManPhoto_edit" class="col-md-3 text-right">工作人员照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="workMan_workManPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="workMan_workManPhoto" name="workMan.workManPhoto"/>
			    <input id="workManPhotoFile" name="workManPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="workMan_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="workMan_telephone_edit" name="workMan.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="workMan_address_edit" class="col-md-3 text-right">家庭地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="workMan_address_edit" name="workMan.address" class="form-control" placeholder="请输入家庭地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="workMan_workManMemo_edit" class="col-md-3 text-right">备注信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="workMan_workManMemo_edit" name="workMan.workManMemo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxWorkManModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#workManEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改工作人员界面并初始化数据*/
function workManEdit(workUserName) {
	$.ajax({
		url :  basePath + "WorkMan/" + workUserName + "/update",
		type : "get",
		dataType: "json",
		success : function (workMan, response, status) {
			if (workMan) {
				$("#workMan_workUserName_edit").val(workMan.workUserName);
				$("#workMan_password_edit").val(workMan.password);
				$("#workMan_name_edit").val(workMan.name);
				$("#workMan_gender_edit").val(workMan.gender);
				$("#workMan_birthDate_edit").val(workMan.birthDate);
				$("#workMan_workManPhoto").val(workMan.workManPhoto);
				$("#workMan_workManPhotoImg").attr("src", basePath +　workMan.workManPhoto);
				$("#workMan_telephone_edit").val(workMan.telephone);
				$("#workMan_address_edit").val(workMan.address);
				$("#workMan_workManMemo_edit").val(workMan.workManMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交工作人员信息表单给服务器端修改*/
function ajaxWorkManModify() {
	$.ajax({
		url :  basePath + "WorkMan/" + $("#workMan_workUserName_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#workManEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#workManQueryForm").submit();
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
    /*出生日期组件*/
    $('.workMan_birthDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    workManEdit("<%=request.getParameter("workUserName")%>");
 })
 </script> 
</body>
</html>

