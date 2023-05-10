<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.WorkMan" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<WorkMan> workManList = (List<WorkMan>)request.getAttribute("workManList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String workUserName = (String)request.getAttribute("workUserName"); //工作人员账号查询关键字
    String name = (String)request.getAttribute("name"); //姓名查询关键字
    String birthDate = (String)request.getAttribute("birthDate"); //出生日期查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系电话查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>工作人员查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>WorkMan/frontlist">工作人员信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>WorkMan/workMan_frontAdd.jsp" style="display:none;">添加工作人员</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<workManList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		WorkMan workMan = workManList.get(i); //获取到工作人员对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>WorkMan/<%=workMan.getWorkUserName() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=workMan.getWorkManPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		工作人员账号:<%=workMan.getWorkUserName() %>
			     	</div>
			     	<div class="field">
	            		姓名:<%=workMan.getName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=workMan.getGender() %>
			     	</div>
			     	<div class="field">
	            		出生日期:<%=workMan.getBirthDate() %>
			     	</div>
			     	<div class="field">
	            		联系电话:<%=workMan.getTelephone() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>WorkMan/<%=workMan.getWorkUserName() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="workManEdit('<%=workMan.getWorkUserName() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="workManDelete('<%=workMan.getWorkUserName() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>工作人员查询</h1>
		</div>
		<form name="workManQueryForm" id="workManQueryForm" action="<%=basePath %>WorkMan/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="workUserName">工作人员账号:</label>
				<input type="text" id="workUserName" name="workUserName" value="<%=workUserName %>" class="form-control" placeholder="请输入工作人员账号">
			</div>
			<div class="form-group">
				<label for="name">姓名:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入姓名">
			</div>
			<div class="form-group">
				<label for="birthDate">出生日期:</label>
				<input type="text" id="birthDate" name="birthDate" class="form-control"  placeholder="请选择出生日期" value="<%=birthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="telephone">联系电话:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入联系电话">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="workManEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;工作人员信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#workManEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxWorkManModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.workManQueryForm.currentPage.value = currentPage;
    document.workManQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.workManQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.workManQueryForm.currentPage.value = pageValue;
    documentworkManQueryForm.submit();
}

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
				$('#workManEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除工作人员信息*/
function workManDelete(workUserName) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "WorkMan/deletes",
			data : {
				workUserNames : workUserName,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#workManQueryForm").submit();
					//location.href= basePath + "WorkMan/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

