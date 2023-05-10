<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Cangku" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Cangku cangku = (Cangku)request.getAttribute("cangku");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改仓库信息</TITLE>
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
  		<li class="active">仓库信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="cangkuEditForm" id="cangkuEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="cangku_cangkuId_edit" class="col-md-3 text-right">仓库id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="cangku_cangkuId_edit" name="cangku.cangkuId" class="form-control" placeholder="请输入仓库id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="cangku_diqu_edit" class="col-md-3 text-right">所在地区:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="cangku_diqu_edit" name="cangku.diqu" class="form-control" placeholder="请输入所在地区">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="cangku_cangkuName_edit" class="col-md-3 text-right">仓库名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="cangku_cangkuName_edit" name="cangku.cangkuName" class="form-control" placeholder="请输入仓库名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="cangku_mianji_edit" class="col-md-3 text-right">仓库面积:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="cangku_mianji_edit" name="cangku.mianji" class="form-control" placeholder="请输入仓库面积">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="cangku_tdl_edit" class="col-md-3 text-right">仓库吞吐量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="cangku_tdl_edit" name="cangku.tdl" class="form-control" placeholder="请输入仓库吞吐量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="cangku_lianxiren_edit" class="col-md-3 text-right">联系人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="cangku_lianxiren_edit" name="cangku.lianxiren" class="form-control" placeholder="请输入联系人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="cangku_telephone_edit" class="col-md-3 text-right">联系电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="cangku_telephone_edit" name="cangku.telephone" class="form-control" placeholder="请输入联系电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="cangku_address_edit" class="col-md-3 text-right">仓库地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="cangku_address_edit" name="cangku.address" class="form-control" placeholder="请输入仓库地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="cangku_cangkuMemo_edit" class="col-md-3 text-right">仓库备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="cangku_cangkuMemo_edit" name="cangku.cangkuMemo" rows="8" class="form-control" placeholder="请输入仓库备注"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCangkuModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#cangkuEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改仓库界面并初始化数据*/
function cangkuEdit(cangkuId) {
	$.ajax({
		url :  basePath + "Cangku/" + cangkuId + "/update",
		type : "get",
		dataType: "json",
		success : function (cangku, response, status) {
			if (cangku) {
				$("#cangku_cangkuId_edit").val(cangku.cangkuId);
				$("#cangku_diqu_edit").val(cangku.diqu);
				$("#cangku_cangkuName_edit").val(cangku.cangkuName);
				$("#cangku_mianji_edit").val(cangku.mianji);
				$("#cangku_tdl_edit").val(cangku.tdl);
				$("#cangku_lianxiren_edit").val(cangku.lianxiren);
				$("#cangku_telephone_edit").val(cangku.telephone);
				$("#cangku_address_edit").val(cangku.address);
				$("#cangku_cangkuMemo_edit").val(cangku.cangkuMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交仓库信息表单给服务器端修改*/
function ajaxCangkuModify() {
	$.ajax({
		url :  basePath + "Cangku/" + $("#cangku_cangkuId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#cangkuEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#cangkuQueryForm").submit();
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
    cangkuEdit("<%=request.getParameter("cangkuId")%>");
 })
 </script> 
</body>
</html>

