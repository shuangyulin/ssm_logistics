<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/workMan.css" />
<div id="workManAddDiv">
	<form id="workManAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">工作人员账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_workUserName" name="workMan.workUserName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_password" name="workMan.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_name" name="workMan.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_gender" name="workMan.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_birthDate" name="workMan.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">工作人员照片:</span>
			<span class="inputControl">
				<input id="workManPhotoFile" name="workManPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_telephone" name="workMan.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_address" name="workMan.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">备注信息:</span>
			<span class="inputControl">
				<textarea id="workMan_workManMemo" name="workMan.workManMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="workManAddButton" class="easyui-linkbutton">添加</a>
			<a id="workManClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/WorkMan/js/workMan_add.js"></script> 
