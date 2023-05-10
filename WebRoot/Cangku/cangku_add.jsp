<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cangku.css" />
<div id="cangkuAddDiv">
	<form id="cangkuAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">所在地区:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_diqu" name="cangku.diqu" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_cangkuName" name="cangku.cangkuName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库面积:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_mianji" name="cangku.mianji" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库吞吐量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_tdl" name="cangku.tdl" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_lianxiren" name="cangku.lianxiren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_telephone" name="cangku.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_address" name="cangku.address" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">仓库备注:</span>
			<span class="inputControl">
				<textarea id="cangku_cangkuMemo" name="cangku.cangkuMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="cangkuAddButton" class="easyui-linkbutton">添加</a>
			<a id="cangkuClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Cangku/js/cangku_add.js"></script> 
