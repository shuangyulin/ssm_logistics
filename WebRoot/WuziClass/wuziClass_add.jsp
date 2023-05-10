<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wuziClass.css" />
<div id="wuziClassAddDiv">
	<form id="wuziClassAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物资种类名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuziClass_wuziClassName" name="wuziClass.wuziClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="wuziClassAddButton" class="easyui-linkbutton">添加</a>
			<a id="wuziClassClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/WuziClass/js/wuziClass_add.js"></script> 
