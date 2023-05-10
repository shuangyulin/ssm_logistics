<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wuzi.css" />
<div id="wuziAddDiv">
	<form id="wuziAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">物流单号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_wuliuNo" name="wuzi.wuliuNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物资分类:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_wuziClassObj_wuziClassId" name="wuzi.wuziClassObj.wuziClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">物资名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_wuziName" name="wuzi.wuziName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物资重量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_zhongliang" name="wuzi.zhongliang" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">物资详情:</span>
			<span class="inputControl">
				<script name="wuzi.wuziDesc" id="wuzi_wuziDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">寄件人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_userObj_user_name" name="wuzi.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">寄件人电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_sendTelephone" name="wuzi.sendTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">寄件人地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_sendAddress" name="wuzi.sendAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收件人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_receiveUserObj_user_name" name="wuzi.receiveUserObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">收件人电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_receiveTelephone" name="wuzi.receiveTelephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">收件人地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_receiveAddress" name="wuzi.receiveAddress" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">运费:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="wuzi_yunfei" name="wuzi.yunfei" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">物流动态:</span>
			<span class="inputControl">
				<textarea id="wuzi_wldt" name="wuzi.wldt" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">备注信息:</span>
			<span class="inputControl">
				<textarea id="wuzi_wuziMemo" name="wuzi.wuziMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="wuziAddButton" class="easyui-linkbutton">添加</a>
			<a id="wuziClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Wuzi/js/wuzi_add.js"></script> 
