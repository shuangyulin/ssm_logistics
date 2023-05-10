<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cangku.css" /> 

<div id="cangku_manage"></div>
<div id="cangku_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="cangku_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="cangku_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="cangku_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="cangku_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="cangku_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="cangkuQueryForm" method="post">
			所在地区：<input type="text" class="textbox" id="diqu" name="diqu" style="width:110px" />
			仓库名称：<input type="text" class="textbox" id="cangkuName" name="cangkuName" style="width:110px" />
			联系人：<input type="text" class="textbox" id="lianxiren" name="lianxiren" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="cangku_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="cangkuEditDiv">
	<form id="cangkuEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">仓库id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_cangkuId_edit" name="cangku.cangkuId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">所在地区:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_diqu_edit" name="cangku.diqu" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_cangkuName_edit" name="cangku.cangkuName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库面积:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_mianji_edit" name="cangku.mianji" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库吞吐量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_tdl_edit" name="cangku.tdl" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_lianxiren_edit" name="cangku.lianxiren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_telephone_edit" name="cangku.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_address_edit" name="cangku.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库备注:</span>
			<span class="inputControl">
				<textarea id="cangku_cangkuMemo_edit" name="cangku.cangkuMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Cangku/js/cangku_manage.js"></script> 
