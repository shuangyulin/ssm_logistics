<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wuziClass.css" />
<div id="wuziClass_editDiv">
	<form id="wuziClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物资种类id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuziClass_wuziClassId_edit" name="wuziClass.wuziClassId" value="<%=request.getParameter("wuziClassId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">物资种类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuziClass_wuziClassName_edit" name="wuziClass.wuziClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="wuziClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/WuziClass/js/wuziClass_modify.js"></script> 
