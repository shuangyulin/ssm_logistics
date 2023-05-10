<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ruku.css" /> 

<div id="ruku_manage"></div>
<div id="ruku_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="ruku_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="ruku_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="ruku_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="ruku_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="ruku_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="rukuQueryForm" method="post">
			入库物资：<input class="textbox" type="text" id="wuziObj_wuliuNo_query" name="wuziObj.wuliuNo" style="width: auto"/>
			物资种类：<input class="textbox" type="text" id="wuziClassObj_wuziClassId_query" name="wuziClassObj.wuziClassId" style="width: auto"/>
			入库仓库：<input class="textbox" type="text" id="cangkuObj_cangkuId_query" name="cangkuObj.cangkuId" style="width: auto"/>
			入库时间：<input type="text" id="rukuTime" name="rukuTime" class="easyui-datebox" editable="false" style="width:100px">
			工作人员：<input class="textbox" type="text" id="workManObj_workUserName_query" name="workManObj.workUserName" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="ruku_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="rukuEditDiv">
	<form id="rukuEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">入库id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_rukuId_edit" name="ruku.rukuId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">入库物资:</span>
			<span class="inputControl">
				<input class="textbox"  id="ruku_wuziObj_wuliuNo_edit" name="ruku.wuziObj.wuliuNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">物资种类:</span>
			<span class="inputControl">
				<input class="textbox"  id="ruku_wuziClassObj_wuziClassId_edit" name="ruku.wuziClassObj.wuziClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">重量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_zhongliang_edit" name="ruku.zhongliang" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">入库仓库:</span>
			<span class="inputControl">
				<input class="textbox"  id="ruku_cangkuObj_cangkuId_edit" name="ruku.cangkuObj.cangkuId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入库时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_rukuTime_edit" name="ruku.rukuTime" />

			</span>

		</div>
		<div>
			<span class="label">是否完好:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_okFlag_edit" name="ruku.okFlag" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作人员:</span>
			<span class="inputControl">
				<input class="textbox"  id="ruku_workManObj_workUserName_edit" name="ruku.workManObj.workUserName" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入库备注:</span>
			<span class="inputControl">
				<textarea id="ruku_rukuMemo_edit" name="ruku.rukuMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Ruku/js/ruku_manage.js"></script> 
