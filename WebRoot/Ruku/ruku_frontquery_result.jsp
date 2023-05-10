<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Ruku" %>
<%@ page import="com.chengxusheji.po.Cangku" %>
<%@ page import="com.chengxusheji.po.WorkMan" %>
<%@ page import="com.chengxusheji.po.Wuzi" %>
<%@ page import="com.chengxusheji.po.WuziClass" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Ruku> rukuList = (List<Ruku>)request.getAttribute("rukuList");
    //获取所有的cangkuObj信息
    List<Cangku> cangkuList = (List<Cangku>)request.getAttribute("cangkuList");
    //获取所有的workManObj信息
    List<WorkMan> workManList = (List<WorkMan>)request.getAttribute("workManList");
    //获取所有的wuziObj信息
    List<Wuzi> wuziList = (List<Wuzi>)request.getAttribute("wuziList");
    //获取所有的wuziClassObj信息
    List<WuziClass> wuziClassList = (List<WuziClass>)request.getAttribute("wuziClassList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Wuzi wuziObj = (Wuzi)request.getAttribute("wuziObj");
    WuziClass wuziClassObj = (WuziClass)request.getAttribute("wuziClassObj");
    Cangku cangkuObj = (Cangku)request.getAttribute("cangkuObj");
    String rukuTime = (String)request.getAttribute("rukuTime"); //入库时间查询关键字
    WorkMan workManObj = (WorkMan)request.getAttribute("workManObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>入库查询</title>
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
			    	<li role="presentation" class="active"><a href="#rukuListPanel" aria-controls="rukuListPanel" role="tab" data-toggle="tab">入库列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Ruku/ruku_frontAdd.jsp" style="display:none;">添加入库</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="rukuListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>入库id</td><td>入库物资</td><td>物资种类</td><td>重量</td><td>入库仓库</td><td>入库时间</td><td>是否完好</td><td>工作人员</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<rukuList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Ruku ruku = rukuList.get(i); //获取到入库对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=ruku.getRukuId() %></td>
 											<td><%=ruku.getWuziObj().getWuziName() %></td>
 											<td><%=ruku.getWuziClassObj().getWuziClassName() %></td>
 											<td><%=ruku.getZhongliang() %></td>
 											<td><%=ruku.getCangkuObj().getCangkuName() %></td>
 											<td><%=ruku.getRukuTime() %></td>
 											<td><%=ruku.getOkFlag() %></td>
 											<td><%=ruku.getWorkManObj().getName() %></td>
 											<td>
 												<a href="<%=basePath  %>Ruku/<%=ruku.getRukuId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="rukuEdit('<%=ruku.getRukuId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="rukuDelete('<%=ruku.getRukuId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>入库查询</h1>
		</div>
		<form name="rukuQueryForm" id="rukuQueryForm" action="<%=basePath %>Ruku/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="wuziObj_wuliuNo">入库物资：</label>
                <select id="wuziObj_wuliuNo" name="wuziObj.wuliuNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Wuzi wuziTemp:wuziList) {
	 					String selected = "";
 					if(wuziObj!=null && wuziObj.getWuliuNo()!=null && wuziObj.getWuliuNo().equals(wuziTemp.getWuliuNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=wuziTemp.getWuliuNo() %>" <%=selected %>><%=wuziTemp.getWuziName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="wuziClassObj_wuziClassId">物资种类：</label>
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
            	<label for="cangkuObj_cangkuId">入库仓库：</label>
                <select id="cangkuObj_cangkuId" name="cangkuObj.cangkuId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Cangku cangkuTemp:cangkuList) {
	 					String selected = "";
 					if(cangkuObj!=null && cangkuObj.getCangkuId()!=null && cangkuObj.getCangkuId().intValue()==cangkuTemp.getCangkuId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=cangkuTemp.getCangkuId() %>" <%=selected %>><%=cangkuTemp.getCangkuName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="rukuTime">入库时间:</label>
				<input type="text" id="rukuTime" name="rukuTime" class="form-control"  placeholder="请选择入库时间" value="<%=rukuTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="workManObj_workUserName">工作人员：</label>
                <select id="workManObj_workUserName" name="workManObj.workUserName" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(WorkMan workManTemp:workManList) {
	 					String selected = "";
 					if(workManObj!=null && workManObj.getWorkUserName()!=null && workManObj.getWorkUserName().equals(workManTemp.getWorkUserName()))
 						selected = "selected";
	 				%>
 				 <option value="<%=workManTemp.getWorkUserName() %>" <%=selected %>><%=workManTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="rukuEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;入库信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#rukuEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxRukuModify();">提交</button>
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
    document.rukuQueryForm.currentPage.value = currentPage;
    document.rukuQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.rukuQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.rukuQueryForm.currentPage.value = pageValue;
    documentrukuQueryForm.submit();
}

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
				$('#rukuEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除入库信息*/
function rukuDelete(rukuId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Ruku/deletes",
			data : {
				rukuIds : rukuId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#rukuQueryForm").submit();
					//location.href= basePath + "Ruku/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

