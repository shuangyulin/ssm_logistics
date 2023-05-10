<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wuzi.css" /> 

<div id="wuzi_manage"></div>
<div id="wuzi_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="wuzi_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="wuzi_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="wuzi_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="wuzi_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="wuzi_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="wuziQueryForm" method="post">
			物流单号：<input type="text" class="textbox" id="wuliuNo" name="wuliuNo" style="width:110px" />
			物资分类：<input class="textbox" type="text" id="wuziClassObj_wuziClassId_query" name="wuziClassObj.wuziClassId" style="width: auto"/>
			物资名称：<input type="text" class="textbox" id="wuziName" name="wuziName" style="width:110px" />
			寄件人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			寄件人电话：<input type="text" class="textbox" id="sendTelephone" name="sendTelephone" style="width:110px" />
			寄件人地址：<input type="text" class="textbox" id="sendAddress" name="sendAddress" style="width:110px" />
			收件人：<input class="textbox" type="text" id="receiveUserObj_user_name_query" name="receiveUserObj.user_name" style="width: auto"/>
			收件人电话：<input type="text" class="textbox" id="receiveTelephone" name="receiveTelephone" style="width:110px" />
			收件人地址：<input type="text" class="textbox" id="receiveAddress" name="receiveAddress" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="wuzi_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="wuziEditDiv">
	<form id="wuziEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物流单号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_wuliuNo_edit" name="wuzi.wuliuNo" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">物资分类:</span>
			<span class="inputControl">
				<input class="textbox"  id="wuzi_wuziClassObj_wuziClassId_edit" name="wuzi.wuziClassObj.wuziClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">物资名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_wuziName_edit" name="wuzi.wuziName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物资重量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_zhongliang_edit" name="wuzi.zhongliang" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物资详情:</span>
			<span class="inputControl">
				<script name="wuzi.wuziDesc" id="wuzi_wuziDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">寄件人:</span>
			<span class="inputControl">
				<input class="textbox"  id="wuzi_userObj_user_name_edit" name="wuzi.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">寄件人电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_sendTelephone_edit" name="wuzi.sendTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">寄件人地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_sendAddress_edit" name="wuzi.sendAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收件人:</span>
			<span class="inputControl">
				<input class="textbox"  id="wuzi_receiveUserObj_user_name_edit" name="wuzi.receiveUserObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收件人电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_receiveTelephone_edit" name="wuzi.receiveTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收件人地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_receiveAddress_edit" name="wuzi.receiveAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">运费:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_yunfei_edit" name="wuzi.yunfei" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">物流动态:</span>
			<span class="inputControl">
				<textarea id="wuzi_wldt_edit" name="wuzi.wldt" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">备注信息:</span>
			<span class="inputControl">
				<textarea id="wuzi_wuziMemo_edit" name="wuzi.wuziMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var wuzi_wuziDesc_editor = UE.getEditor('wuzi_wuziDesc_edit'); //物资详情编辑器
</script>
<script type="text/javascript" src="Wuzi/js/wuzi_manage.js"></script> 
