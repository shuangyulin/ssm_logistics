<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ruku.css" />
<div id="rukuAddDiv">
	<form id="rukuAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">入库物资:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_wuziObj_wuliuNo" name="ruku.wuziObj.wuliuNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">物资种类:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_wuziClassObj_wuziClassId" name="ruku.wuziClassObj.wuziClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">重量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_zhongliang" name="ruku.zhongliang" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">入库仓库:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_cangkuObj_cangkuId" name="ruku.cangkuObj.cangkuId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入库时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_rukuTime" name="ruku.rukuTime" />

			</span>

		</div>
		<div>
			<span class="label">是否完好:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_okFlag" name="ruku.okFlag" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作人员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_workManObj_workUserName" name="ruku.workManObj.workUserName" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">入库备注:</span>
			<span class="inputControl">
				<textarea id="ruku_rukuMemo" name="ruku.rukuMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="rukuAddButton" class="easyui-linkbutton">添加</a>
			<a id="rukuClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Ruku/js/ruku_add.js"></script> 
