<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Wuzi" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ page import="com.chengxusheji.po.WuziClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    //获取所有的wuziClassObj信息
    List<WuziClass> wuziClassList = (List<WuziClass>)request.getAttribute("wuziClassList");
    Wuzi wuzi = (Wuzi)request.getAttribute("wuzi");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改物资信息</TITLE>
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
  		<li class="active">物资信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="wuziEditForm" id="wuziEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="wuzi_wuliuNo_edit" class="col-md-3 text-right">物流单号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="wuzi_wuliuNo_edit" name="wuzi.wuliuNo" class="form-control" placeholder="请输入物流单号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="wuzi_wuziClassObj_wuziClassId_edit" class="col-md-3 text-right">物资分类:</label>
		  	 <div class="col-md-9">
			    <select id="wuzi_wuziClassObj_wuziClassId_edit" name="wuzi.wuziClassObj.wuziClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_wuziName_edit" class="col-md-3 text-right">物资名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wuzi_wuziName_edit" name="wuzi.wuziName" class="form-control" placeholder="请输入物资名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_zhongliang_edit" class="col-md-3 text-right">物资重量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wuzi_zhongliang_edit" name="wuzi.zhongliang" class="form-control" placeholder="请输入物资重量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_wuziDesc_edit" class="col-md-3 text-right">物资详情:</label>
		  	 <div class="col-md-9">
			    <script name="wuzi.wuziDesc" id="wuzi_wuziDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_userObj_user_name_edit" class="col-md-3 text-right">寄件人:</label>
		  	 <div class="col-md-9">
			    <select id="wuzi_userObj_user_name_edit" name="wuzi.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_sendTelephone_edit" class="col-md-3 text-right">寄件人电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wuzi_sendTelephone_edit" name="wuzi.sendTelephone" class="form-control" placeholder="请输入寄件人电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_sendAddress_edit" class="col-md-3 text-right">寄件人地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wuzi_sendAddress_edit" name="wuzi.sendAddress" class="form-control" placeholder="请输入寄件人地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_receiveUserObj_user_name_edit" class="col-md-3 text-right">收件人:</label>
		  	 <div class="col-md-9">
			    <select id="wuzi_receiveUserObj_user_name_edit" name="wuzi.receiveUserObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_receiveTelephone_edit" class="col-md-3 text-right">收件人电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wuzi_receiveTelephone_edit" name="wuzi.receiveTelephone" class="form-control" placeholder="请输入收件人电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_receiveAddress_edit" class="col-md-3 text-right">收件人地址:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wuzi_receiveAddress_edit" name="wuzi.receiveAddress" class="form-control" placeholder="请输入收件人地址">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_yunfei_edit" class="col-md-3 text-right">运费:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="wuzi_yunfei_edit" name="wuzi.yunfei" class="form-control" placeholder="请输入运费">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_wldt_edit" class="col-md-3 text-right">物流动态:</label>
		  	 <div class="col-md-9">
			    <textarea id="wuzi_wldt_edit" name="wuzi.wldt" rows="8" class="form-control" placeholder="请输入物流动态"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="wuzi_wuziMemo_edit" class="col-md-3 text-right">备注信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="wuzi_wuziMemo_edit" name="wuzi.wuziMemo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxWuziModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#wuziEditForm .form-group {margin-bottom:5px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var wuzi_wuziDesc_editor = UE.getEditor('wuzi_wuziDesc_edit'); //物资详情编辑框
var basePath = "<%=basePath%>";
/*弹出修改物资界面并初始化数据*/
function wuziEdit(wuliuNo) {
  wuzi_wuziDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(wuliuNo);
  });
}
 function ajaxModifyQuery(wuliuNo) {
	$.ajax({
		url :  basePath + "Wuzi/" + wuliuNo + "/update",
		type : "get",
		dataType: "json",
		success : function (wuzi, response, status) {
			if (wuzi) {
				$("#wuzi_wuliuNo_edit").val(wuzi.wuliuNo);
				$.ajax({
					url: basePath + "WuziClass/listAll",
					type: "get",
					success: function(wuziClasss,response,status) { 
						$("#wuzi_wuziClassObj_wuziClassId_edit").empty();
						var html="";
		        		$(wuziClasss).each(function(i,wuziClass){
		        			html += "<option value='" + wuziClass.wuziClassId + "'>" + wuziClass.wuziClassName + "</option>";
		        		});
		        		$("#wuzi_wuziClassObj_wuziClassId_edit").html(html);
		        		$("#wuzi_wuziClassObj_wuziClassId_edit").val(wuzi.wuziClassObjPri);
					}
				});
				$("#wuzi_wuziName_edit").val(wuzi.wuziName);
				$("#wuzi_zhongliang_edit").val(wuzi.zhongliang);
				wuzi_wuziDesc_editor.setContent(wuzi.wuziDesc, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#wuzi_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#wuzi_userObj_user_name_edit").html(html);
		        		$("#wuzi_userObj_user_name_edit").val(wuzi.userObjPri);
					}
				});
				$("#wuzi_sendTelephone_edit").val(wuzi.sendTelephone);
				$("#wuzi_sendAddress_edit").val(wuzi.sendAddress);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#wuzi_receiveUserObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#wuzi_receiveUserObj_user_name_edit").html(html);
		        		$("#wuzi_receiveUserObj_user_name_edit").val(wuzi.receiveUserObjPri);
					}
				});
				$("#wuzi_receiveTelephone_edit").val(wuzi.receiveTelephone);
				$("#wuzi_receiveAddress_edit").val(wuzi.receiveAddress);
				$("#wuzi_yunfei_edit").val(wuzi.yunfei);
				$("#wuzi_wldt_edit").val(wuzi.wldt);
				$("#wuzi_wuziMemo_edit").val(wuzi.wuziMemo);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交物资信息表单给服务器端修改*/
function ajaxWuziModify() {
	$.ajax({
		url :  basePath + "Wuzi/" + $("#wuzi_wuliuNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#wuziEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#wuziQueryForm").submit();
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
    wuziEdit("<%=request.getParameter("wuliuNo")%>");
 })
 </script> 
</body>
</html>

