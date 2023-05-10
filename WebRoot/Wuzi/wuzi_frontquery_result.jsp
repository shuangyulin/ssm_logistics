<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Wuzi" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ page import="com.chengxusheji.po.WuziClass" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Wuzi> wuziList = (List<Wuzi>)request.getAttribute("wuziList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    //获取所有的wuziClassObj信息
    List<WuziClass> wuziClassList = (List<WuziClass>)request.getAttribute("wuziClassList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String wuliuNo = (String)request.getAttribute("wuliuNo"); //物流单号查询关键字
    WuziClass wuziClassObj = (WuziClass)request.getAttribute("wuziClassObj");
    String wuziName = (String)request.getAttribute("wuziName"); //物资名称查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String sendTelephone = (String)request.getAttribute("sendTelephone"); //寄件人电话查询关键字
    String sendAddress = (String)request.getAttribute("sendAddress"); //寄件人地址查询关键字
    UserInfo receiveUserObj = (UserInfo)request.getAttribute("receiveUserObj");
    String receiveTelephone = (String)request.getAttribute("receiveTelephone"); //收件人电话查询关键字
    String receiveAddress = (String)request.getAttribute("receiveAddress"); //收件人地址查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>物资查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#wuziListPanel" aria-controls="wuziListPanel" role="tab" data-toggle="tab">物资列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Wuzi/wuzi_frontAdd.jsp" style="display:none;">添加物资</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="wuziListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>物流单号</td><td>物资分类</td><td>物资名称</td><td>物资重量</td><td>寄件人</td><td>寄件人电话</td><td>收件人</td><td>收件人电话</td><td>运费</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<wuziList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Wuzi wuzi = wuziList.get(i); //获取到物资对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=wuzi.getWuliuNo() %></td>
 											<td><%=wuzi.getWuziClassObj().getWuziClassName() %></td>
 											<td><%=wuzi.getWuziName() %></td>
 											<td><%=wuzi.getZhongliang() %></td>
 											<td><%=wuzi.getUserObj().getName() %></td>
 											<td><%=wuzi.getSendTelephone() %></td>
 											<td><%=wuzi.getReceiveUserObj().getName() %></td>
 											<td><%=wuzi.getReceiveTelephone() %></td>
 											<td><%=wuzi.getYunfei() %></td>
 											<td>
 												<a href="<%=basePath  %>Wuzi/<%=wuzi.getWuliuNo() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="wuziEdit('<%=wuzi.getWuliuNo() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="wuziDelete('<%=wuzi.getWuliuNo() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>物资查询</h1>
		</div>
		<form name="wuziQueryForm" id="wuziQueryForm" action="<%=basePath %>Wuzi/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="wuliuNo">物流单号:</label>
				<input type="text" id="wuliuNo" name="wuliuNo" value="<%=wuliuNo %>" class="form-control" placeholder="请输入物流单号">
			</div>






            <div class="form-group">
            	<label for="wuziClassObj_wuziClassId">物资分类：</label>
                <select id="wuziClassObj_wuziClassId" name="wuziClassObj.wuziClassId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(WuziClass wuziClassTemp:wuziClassList) {
	 					String selected = "";
 					if(wuziClassObj!=null && wuziClassObj.getWuziClassId()!=null && wuziClassObj.getWuziClassId().intValue()==wuziClassTemp.getWuziClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=wuziClassTemp.getWuziClassId() %>" <%=selected %>><%=wuziClassTemp.getWuziClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="wuziName">物资名称:</label>
				<input type="text" id="wuziName" name="wuziName" value="<%=wuziName %>" class="form-control" placeholder="请输入物资名称">
			</div>






            <div class="form-group">
            	<label for="userObj_user_name">寄件人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="sendTelephone">寄件人电话:</label>
				<input type="text" id="sendTelephone" name="sendTelephone" value="<%=sendTelephone %>" class="form-control" placeholder="请输入寄件人电话">
			</div>






			<div class="form-group">
				<label for="sendAddress">寄件人地址:</label>
				<input type="text" id="sendAddress" name="sendAddress" value="<%=sendAddress %>" class="form-control" placeholder="请输入寄件人地址">
			</div>






            <div class="form-group">
            	<label for="receiveUserObj_user_name">收件人：</label>
                <select id="receiveUserObj_user_name" name="receiveUserObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(receiveUserObj!=null && receiveUserObj.getUser_name()!=null && receiveUserObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="receiveTelephone">收件人电话:</label>
				<input type="text" id="receiveTelephone" name="receiveTelephone" value="<%=receiveTelephone %>" class="form-control" placeholder="请输入收件人电话">
			</div>






			<div class="form-group">
				<label for="receiveAddress">收件人地址:</label>
				<input type="text" id="receiveAddress" name="receiveAddress" value="<%=receiveAddress %>" class="form-control" placeholder="请输入收件人地址">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="wuziEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;物资信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="wuzi.wuziDesc" id="wuzi_wuziDesc_edit" style="width:100%;height:500px;"></textarea>
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
		</form> 
	    <style>#wuziEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxWuziModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var wuzi_wuziDesc_edit = UE.getEditor('wuzi_wuziDesc_edit'); //物资详情编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.wuziQueryForm.currentPage.value = currentPage;
    document.wuziQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.wuziQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.wuziQueryForm.currentPage.value = pageValue;
    documentwuziQueryForm.submit();
}

/*弹出修改物资界面并初始化数据*/
function wuziEdit(wuliuNo) {
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
				wuzi_wuziDesc_edit.setContent(wuzi.wuziDesc, false);
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
				$('#wuziEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除物资信息*/
function wuziDelete(wuliuNo) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Wuzi/deletes",
			data : {
				wuliuNos : wuliuNo,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#wuziQueryForm").submit();
					//location.href= basePath + "Wuzi/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

