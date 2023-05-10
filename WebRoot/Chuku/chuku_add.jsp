<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/chuku.css" />
<div id="chukuAddDiv">
	<form id="chukuAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">出库物资:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_wuziObj_wuliuNo" name="chuku.wuziObj.wuliuNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">物资种类:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_wuziClassObj_wuziClassId" name="chuku.wuziClassObj.wuziClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">重量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_zhongliang" name="chuku.zhongliang" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出库仓库:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_cangkuObj_cangkuId" name="chuku.cangkuObj.cangkuId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出库时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_chukuTime" name="chuku.chukuTime" />

			</span>

		</div>
		<div>
			<span class="label">是否完好:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_okFlag" name="chuku.okFlag" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">工作人员:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="chuku_workManObj_workUserName" name="chuku.workManObj.workUserName" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出库备注:</span>
			<span class="inputControl">
				<textarea id="chuku_chukuMemo" name="chuku.chukuMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="chukuAddButton" class="easyui-linkbutton">添加</a>
			<a id="chukuClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Chuku/js/chuku_add.js"></script> 
