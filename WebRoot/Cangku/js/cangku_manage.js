var cangku_manage_tool = null; 
$(function () { 
	initCangkuManageTool(); //建立Cangku管理对象
	cangku_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#cangku_manage").datagrid({
		url : 'Cangku/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "cangkuId",
		sortOrder : "desc",
		toolbar : "#cangku_manage_tool",
		columns : [[
			{
				field : "cangkuId",
				title : "仓库id",
				width : 70,
			},
			{
				field : "diqu",
				title : "所在地区",
				width : 140,
			},
			{
				field : "cangkuName",
				title : "仓库名称",
				width : 140,
			},
			{
				field : "mianji",
				title : "仓库面积",
				width : 140,
			},
			{
				field : "tdl",
				title : "仓库吞吐量",
				width : 140,
			},
			{
				field : "lianxiren",
				title : "联系人",
				width : 140,
			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
			{
				field : "address",
				title : "仓库地址",
				width : 140,
			},
		]],
	});

	$("#cangkuEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#cangkuEditForm").form("validate")) {
					//验证表单 
					if(!$("#cangkuEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#cangkuEditForm").form({
						    url:"Cangku/" + $("#cangku_cangkuId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#cangkuEditForm").form("validate"))  {
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
			                        $("#cangkuEditDiv").dialog("close");
			                        cangku_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#cangkuEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#cangkuEditDiv").dialog("close");
				$("#cangkuEditForm").form("reset"); 
			},
		}],
	});
});

function initCangkuManageTool() {
	cangku_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#cangku_manage").datagrid("reload");
		},
		redo : function () {
			$("#cangku_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#cangku_manage").datagrid("options").queryParams;
			queryParams["diqu"] = $("#diqu").val();
			queryParams["cangkuName"] = $("#cangkuName").val();
			queryParams["lianxiren"] = $("#lianxiren").val();
			queryParams["telephone"] = $("#telephone").val();
			$("#cangku_manage").datagrid("options").queryParams=queryParams; 
			$("#cangku_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#cangkuQueryForm").form({
			    url:"Cangku/OutToExcel",
			});
			//提交表单
			$("#cangkuQueryForm").submit();
		},
		remove : function () {
			var rows = $("#cangku_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var cangkuIds = [];
						for (var i = 0; i < rows.length; i ++) {
							cangkuIds.push(rows[i].cangkuId);
						}
						$.ajax({
							type : "POST",
							url : "Cangku/deletes",
							data : {
								cangkuIds : cangkuIds.join(","),
							},
							beforeSend : function () {
								$("#cangku_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#cangku_manage").datagrid("loaded");
									$("#cangku_manage").datagrid("load");
									$("#cangku_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#cangku_manage").datagrid("loaded");
									$("#cangku_manage").datagrid("load");
									$("#cangku_manage").datagrid("unselectAll");
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
			var rows = $("#cangku_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Cangku/" + rows[0].cangkuId +  "/update",
					type : "get",
					data : {
						//cangkuId : rows[0].cangkuId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (cangku, response, status) {
						$.messager.progress("close");
						if (cangku) { 
							$("#cangkuEditDiv").dialog("open");
							$("#cangku_cangkuId_edit").val(cangku.cangkuId);
							$("#cangku_cangkuId_edit").validatebox({
								required : true,
								missingMessage : "请输入仓库id",
								editable: false
							});
							$("#cangku_diqu_edit").val(cangku.diqu);
							$("#cangku_diqu_edit").validatebox({
								required : true,
								missingMessage : "请输入所在地区",
							});
							$("#cangku_cangkuName_edit").val(cangku.cangkuName);
							$("#cangku_cangkuName_edit").validatebox({
								required : true,
								missingMessage : "请输入仓库名称",
							});
							$("#cangku_mianji_edit").val(cangku.mianji);
							$("#cangku_mianji_edit").validatebox({
								required : true,
								missingMessage : "请输入仓库面积",
							});
							$("#cangku_tdl_edit").val(cangku.tdl);
							$("#cangku_tdl_edit").validatebox({
								required : true,
								missingMessage : "请输入仓库吞吐量",
							});
							$("#cangku_lianxiren_edit").val(cangku.lianxiren);
							$("#cangku_lianxiren_edit").validatebox({
								required : true,
								missingMessage : "请输入联系人",
							});
							$("#cangku_telephone_edit").val(cangku.telephone);
							$("#cangku_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							$("#cangku_address_edit").val(cangku.address);
							$("#cangku_address_edit").validatebox({
								required : true,
								missingMessage : "请输入仓库地址",
							});
							$("#cangku_cangkuMemo_edit").val(cangku.cangkuMemo);
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
