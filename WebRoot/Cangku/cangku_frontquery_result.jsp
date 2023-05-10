<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Cangku" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Cangku> cangkuList = (List<Cangku>)request.getAttribute("cangkuList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String diqu = (String)request.getAttribute("diqu"); //所在地区查询关键字
    String cangkuName = (String)request.getAttribute("cangkuName"); //仓库名称查询关键字
    String lianxiren = (String)request.getAttribute("lianxiren"); //联系人查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系电话查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>仓库查询</title>
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
			    	<li role="presentation" class="active"><a href="#cangkuListPanel" aria-controls="cangkuListPanel" role="tab" data-toggle="tab">仓库列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Cangku/cangku_frontAdd.jsp" style="display:none;">添加仓库</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="cangkuListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>仓库id</td><td>所在地区</td><td>仓库名称</td><td>仓库面积</td><td>仓库吞吐量</td><td>联系人</td><td>联系电话</td><td>仓库地址</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<cangkuList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Cangku cangku = cangkuList.get(i); //获取到仓库对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=cangku.getCangkuId() %></td>
 											<td><%=cangku.getDiqu() %></td>
 											<td><%=cangku.getCangkuName() %></td>
 											<td><%=cangku.getMianji() %></td>
 											<td><%=cangku.getTdl() %></td>
 											<td><%=cangku.getLianxiren() %></td>
 											<td><%=cangku.getTelephone() %></td>
 											<td><%=cangku.getAddress() %></td>
 											<td>
 												<a href="<%=basePath  %>Cangku/<%=cangku.getCangkuId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="cangkuEdit('<%=cangku.getCangkuId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="cangkuDelete('<%=cangku.getCangkuId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>仓库查询</h1>
		</div>
		<form name="cangkuQueryForm" id="cangkuQueryForm" action="<%=basePath %>Cangku/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="diqu">所在地区:</label>
				<input type="text" id="diqu" name="diqu" value="<%=diqu %>" class="form-control" placeholder="请输入所在地区">
			</div>






			<div class="form-group">
				<label for="cangkuName">仓库名称:</label>
				<input type="text" id="cangkuName" name="cangkuName" value="<%=cangkuName %>" class="form-control" placeholder="请输入仓库名称">
			</div>






			<div class="form-group">
				<label for="lianxiren">联系人:</label>
				<input type="text" id="lianxiren" name="lianxiren" value="<%=lianxiren %>" class="form-control" placeholder="请输入联系人">
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
<div id="cangkuEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;仓库信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#cangkuEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCangkuModify();">提交</button>
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
    document.cangkuQueryForm.currentPage.value = currentPage;
    document.cangkuQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.cangkuQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.cangkuQueryForm.currentPage.value = pageValue;
    documentcangkuQueryForm.submit();
}

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
				$('#cangkuEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除仓库信息*/
function cangkuDelete(cangkuId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Cangku/deletes",
			data : {
				cangkuIds : cangkuId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#cangkuQueryForm").submit();
					//location.href= basePath + "Cangku/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

