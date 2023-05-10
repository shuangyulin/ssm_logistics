<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cangku.css" />
<div id="cangku_editDiv">
	<form id="cangkuEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">仓库id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="cangku_cangkuId_edit" name="cangku.cangkuId" value="<%=request.getParameter("cangkuId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="cangkuModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Cangku/js/cangku_modify.js"></script> 
