<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/workMan.css" /> 

<div id="workMan_manage"></div>
<div id="workMan_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="workMan_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="workMan_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="workMan_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="workMan_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="workMan_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="workManQueryForm" method="post">
			工作人员账号：<input type="text" class="textbox" id="workUserName" name="workUserName" style="width:110px" />
			姓名：<input type="text" class="textbox" id="name" name="name" style="width:110px" />
			出生日期：<input type="text" id="birthDate" name="birthDate" class="easyui-datebox" editable="false" style="width:100px">
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="workMan_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="workManEditDiv">
	<form id="workManEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">工作人员账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="workMan_workUserName_edit" name="workMan.workUserName" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="WorkMan/js/workMan_manage.js"></script> 
