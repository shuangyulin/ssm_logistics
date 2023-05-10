<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chuku.css" />
<div id="chuku_editDiv">
	<form id="chukuEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">出库id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_chukuId_edit" name="chuku.chukuId" value="<%=request.getParameter("chukuId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">出库物资:</span>
			<span class="inputControl">
				<input class="textbox"  id="chuku_wuziObj_wuliuNo_edit" name="chuku.wuziObj.wuliuNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">物资种类:</span>
			<span class="inputControl">
				<input class="textbox"  id="chuku_wuziClassObj_wuziClassId_edit" name="chuku.wuziClassObj.wuziClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">重量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_zhongliang_edit" name="chuku.zhongliang" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出库仓库:</span>
			<span class="inputControl">
				<input class="textbox"  id="chuku_cangkuObj_cangkuId_edit" name="chuku.cangkuObj.cangkuId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出库时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_chukuTime_edit" name="chuku.chukuTime" />

			</span>

		</div>
		<div>
			<span class="label">是否完好:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_okFlag_edit" name="chuku.okFlag" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作人员:</span>
			<span class="inputControl">
				<input class="textbox"  id="chuku_workManObj_workUserName_edit" name="chuku.workManObj.workUserName" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出库备注:</span>
			<span class="inputControl">
				<textarea id="chuku_chukuMemo_edit" name="chuku.chukuMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="chukuModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Chuku/js/chuku_modify.js"></script> 
