<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wuzi.css" />
<div id="wuzi_editDiv">
	<form id="wuziEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物流单号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_wuliuNo_edit" name="wuzi.wuliuNo" value="<%=request.getParameter("wuliuNo") %>" style="width:200px" />
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
				<script id="wuzi_wuziDesc_edit" name="wuzi.wuziDesc" type="text/plain"   style="width:750px;height:500px;"></script>

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
		<div class="operation">
			<a id="wuziModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Wuzi/js/wuzi_modify.js"></script> 
