var wuzi_manage_tool = null; 
$(function () { 
	initWuziManageTool(); //建立Wuzi管理对象
	wuzi_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#wuzi_manage").datagrid({
		url : 'Wuzi/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "wuliuNo",
		sortOrder : "desc",
		toolbar : "#wuzi_manage_tool",
		columns : [[
			{
				field : "wuliuNo",
				title : "物流单号",
				width : 140,
			},
			{
				field : "wuziClassObj",
				title : "物资分类",
				width : 140,
			},
			{
				field : "wuziName",
				title : "物资名称",
				width : 140,
			},
			{
				field : "zhongliang",
				title : "物资重量",
				width : 140,
			},
			{
				field : "userObj",
				title : "寄件人",
				width : 140,
			},
			{
				field : "sendTelephone",
				title : "寄件人电话",
				width : 140,
			},
			{
				field : "receiveUserObj",
				title : "收件人",
				width : 140,
			},
			{
				field : "receiveTelephone",
				title : "收件人电话",
				width : 140,
			},
			{
				field : "yunfei",
				title : "运费",
				width : 70,
			},
		]],
	});

	$("#wuziEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#wuziEditForm").form("validate")) {
					//验证表单 
					if(!$("#wuziEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#wuziEditForm").form({
						    url:"Wuzi/" + $("#wuzi_wuliuNo_edit").val() + "/update",
						    onSubmit: function(){
								if($("#wuziEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#wuziEditDiv").dialog("close");
			                        wuzi_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#wuziEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#wuziEditDiv").dialog("close");
				$("#wuziEditForm").form("reset"); 
			},
		}],
	});
});

function initWuziManageTool() {
	wuzi_manage_tool = {
		init: function() {
			$.ajax({
				url : "WuziClass/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#wuziClassObj_wuziClassId_query").combobox({ 
					    valueField:"wuziClassId",
					    textField:"wuziClassName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{wuziClassId:0,wuziClassName:"不限制"});
					$("#wuziClassObj_wuziClassId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#receiveUserObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#receiveUserObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#wuzi_manage").datagrid("reload");
		},
		redo : function () {
			$("#wuzi_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#wuzi_manage").datagrid("options").queryParams;
			queryParams["wuliuNo"] = $("#wuliuNo").val();
			queryParams["wuziClassObj.wuziClassId"] = $("#wuziClassObj_wuziClassId_query").combobox("getValue");
			queryParams["wuziName"] = $("#wuziName").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["sendTelephone"] = $("#sendTelephone").val();
			queryParams["sendAddress"] = $("#sendAddress").val();
			queryParams["receiveUserObj.user_name"] = $("#receiveUserObj_user_name_query").combobox("getValue");
			queryParams["receiveTelephone"] = $("#receiveTelephone").val();
			queryParams["receiveAddress"] = $("#receiveAddress").val();
			$("#wuzi_manage").datagrid("options").queryParams=queryParams; 
			$("#wuzi_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#wuziQueryForm").form({
			    url:"Wuzi/OutToExcel",
			});
			//提交表单
			$("#wuziQueryForm").submit();
		},
		remove : function () {
			var rows = $("#wuzi_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var wuliuNos = [];
						for (var i = 0; i < rows.length; i ++) {
							wuliuNos.push(rows[i].wuliuNo);
						}
						$.ajax({
							type : "POST",
							url : "Wuzi/deletes",
							data : {
								wuliuNos : wuliuNos.join(","),
							},
							beforeSend : function () {
								$("#wuzi_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#wuzi_manage").datagrid("loaded");
									$("#wuzi_manage").datagrid("load");
									$("#wuzi_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#wuzi_manage").datagrid("loaded");
									$("#wuzi_manage").datagrid("load");
									$("#wuzi_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#wuzi_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Wuzi/" + rows[0].wuliuNo +  "/update",
					type : "get",
					data : {
						//wuliuNo : rows[0].wuliuNo,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (wuzi, response, status) {
						$.messager.progress("close");
						if (wuzi) { 
							$("#wuziEditDiv").dialog("open");
							$("#wuzi_wuliuNo_edit").val(wuzi.wuliuNo);
							$("#wuzi_wuliuNo_edit").validatebox({
								required : true,
								missingMessage : "请输入物流单号",
								editable: false
							});
							$("#wuzi_wuziClassObj_wuziClassId_edit").combobox({
								url:"WuziClass/listAll",
							    valueField:"wuziClassId",
							    textField:"wuziClassName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#wuzi_wuziClassObj_wuziClassId_edit").combobox("select", wuzi.wuziClassObjPri);
									//var data = $("#wuzi_wuziClassObj_wuziClassId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#wuzi_wuziClassObj_wuziClassId_edit").combobox("select", data[0].wuziClassId);
						            //}
								}
							});
							$("#wuzi_wuziName_edit").val(wuzi.wuziName);
							$("#wuzi_wuziName_edit").validatebox({
								required : true,
								missingMessage : "请输入物资名称",
							});
							$("#wuzi_zhongliang_edit").val(wuzi.zhongliang);
							$("#wuzi_zhongliang_edit").validatebox({
								required : true,
								missingMessage : "请输入物资重量",
							});
							wuzi_wuziDesc_editor.setContent(wuzi.wuziDesc, false);
							$("#wuzi_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#wuzi_userObj_user_name_edit").combobox("select", wuzi.userObjPri);
									//var data = $("#wuzi_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#wuzi_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#wuzi_sendTelephone_edit").val(wuzi.sendTelephone);
							$("#wuzi_sendTelephone_edit").validatebox({
								required : true,
								missingMessage : "请输入寄件人电话",
							});
							$("#wuzi_sendAddress_edit").val(wuzi.sendAddress);
							$("#wuzi_sendAddress_edit").validatebox({
								required : true,
								missingMessage : "请输入寄件人地址",
							});
							$("#wuzi_receiveUserObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#wuzi_receiveUserObj_user_name_edit").combobox("select", wuzi.receiveUserObjPri);
									//var data = $("#wuzi_receiveUserObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#wuzi_receiveUserObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#wuzi_receiveTelephone_edit").val(wuzi.receiveTelephone);
							$("#wuzi_receiveTelephone_edit").validatebox({
								required : true,
								missingMessage : "请输入收件人电话",
							});
							$("#wuzi_receiveAddress_edit").val(wuzi.receiveAddress);
							$("#wuzi_receiveAddress_edit").validatebox({
								required : true,
								missingMessage : "请输入收件人地址",
							});
							$("#wuzi_yunfei_edit").val(wuzi.yunfei);
							$("#wuzi_yunfei_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入运费",
								invalidMessage : "运费输入不对",
							});
							$("#wuzi_wldt_edit").val(wuzi.wldt);
							$("#wuzi_wldt_edit").validatebox({
								required : true,
								missingMessage : "请输入物流动态",
							});
							$("#wuzi_wuziMemo_edit").val(wuzi.wuziMemo);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
