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
  <TITLE>查看出库详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Chuku/frontlist">出库信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">出库id:</div>
		<div class="col-md-10 col-xs-6"><%=chuku.getChukuId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">出库物资:</div>
		<div class="col-md-10 col-xs-6"><%=chuku.getWuziObj().getWuziName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">物资种类:</div>
		<div class="col-md-10 col-xs-6"><%=chuku.getWuziClassObj().getWuziClassName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">重量:</div>
		<div class="col-md-10 col-xs-6"><%=chuku.getZhongliang()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">出库仓库:</div>
		<div class="col-md-10 col-xs-6"><%=chuku.getCangkuObj().getCangkuName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">出库时间:</div>
		<div class="col-md-10 col-xs-6"><%=chuku.getChukuTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">是否完好:</div>
		<div class="col-md-10 col-xs-6"><%=chuku.getOkFlag()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">工作人员:</div>
		<div class="col-md-10 col-xs-6"><%=chuku.getWorkManObj().getName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">出库备注:</div>
		<div class="col-md-10 col-xs-6"><%=chuku.getChukuMemo()%></div>
	</div>
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="history.back();" class="btn btn-primary">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
</body>
</html>

