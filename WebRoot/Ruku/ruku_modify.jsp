<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/ruku.css" />
<div id="ruku_editDiv">
	<form id="rukuEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">入库id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="ruku_rukuId_edit" name="ruku.rukuId" value="<%=request.getParameter("rukuId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="rukuModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Ruku/js/ruku_modify.js"></script> 
