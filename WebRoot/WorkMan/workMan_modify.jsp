<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/workMan.css" />
<div id="workMan_editDiv">
	<form id="workManEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">工作人员账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_workUserName_edit" name="workMan.workUserName" value="<%=request.getParameter("workUserName") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_password_edit" name="workMan.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">姓名:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_name_edit" name="workMan.name" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">性别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_gender_edit" name="workMan.gender" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出生日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_birthDate_edit" name="workMan.birthDate" />

			</span>

		</div>
		<div>
			<span class="label">工作人员照片:</span>
			<span class="inputControl">
				<img id="workMan_workManPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="workMan_workManPhoto" name="workMan.workManPhoto"/>
				<input id="workManPhotoFile" name="workManPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_telephone_edit" name="workMan.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">家庭地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_address_edit" name="workMan.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">备注信息:</span>
			<span class="inputControl">
				<textarea id="workMan_workManMemo_edit" name="workMan.workManMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="workManModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/WorkMan/js/workMan_modify.js"></script> 
