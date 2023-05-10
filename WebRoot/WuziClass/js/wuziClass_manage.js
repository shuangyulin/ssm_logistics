var wuziClass_manage_tool = null; 
$(function () { 
	initWuziClassManageTool(); //建立WuziClass管理对象
	wuziClass_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#wuziClass_manage").datagrid({
		url : 'WuziClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "wuziClassId",
		sortOrder : "desc",
		toolbar : "#wuziClass_manage_tool",
		columns : [[
			{
				field : "wuziClassId",
				title : "物资种类id",
				width : 70,
			},
			{
				field : "wuziClassName",
				title : "物资种类名称",
				width : 140,
			},
		]],
	});

	$("#wuziClassEditDiv").dialog({
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
				if ($("#wuziClassEditForm").form("validate")) {
					//验证表单 
					if(!$("#wuziClassEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#wuziClassEditForm").form({
						    url:"WuziClass/" + $("#wuziClass_wuziClassId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#wuziClassEditForm").form("validate"))  {
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
			                        $("#wuziClassEditDiv").dialog("close");
			                        wuziClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#wuziClassEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#wuziClassEditDiv").dialog("close");
				$("#wuziClassEditForm").form("reset"); 
			},
		}],
	});
});

function initWuziClassManageTool() {
	wuziClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#wuziClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#wuziClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#wuziClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#wuziClassQueryForm").form({
			    url:"WuziClass/OutToExcel",
			});
			//提交表单
			$("#wuziClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#wuziClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var wuziClassIds = [];
						for (var i = 0; i < rows.length; i ++) {
							wuziClassIds.push(rows[i].wuziClassId);
						}
						$.ajax({
							type : "POST",
							url : "WuziClass/deletes",
							data : {
								wuziClassIds : wuziClassIds.join(","),
							},
							beforeSend : function () {
								$("#wuziClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#wuziClass_manage").datagrid("loaded");
									$("#wuziClass_manage").datagrid("load");
									$("#wuziClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#wuziClass_manage").datagrid("loaded");
									$("#wuziClass_manage").datagrid("load");
									$("#wuziClass_manage").datagrid("unselectAll");
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
			var rows = $("#wuziClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "WuziClass/" + rows[0].wuziClassId +  "/update",
					type : "get",
					data : {
						//wuziClassId : rows[0].wuziClassId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (wuziClass, response, status) {
						$.messager.progress("close");
						if (wuziClass) { 
							$("#wuziClassEditDiv").dialog("open");
							$("#wuziClass_wuziClassId_edit").val(wuziClass.wuziClassId);
							$("#wuziClass_wuziClassId_edit").validatebox({
								required : true,
								missingMessage : "请输入物资种类id",
								editable: false
							});
							$("#wuziClass_wuziClassName_edit").val(wuziClass.wuziClassName);
							$("#wuziClass_wuziClassName_edit").validatebox({
								required : true,
								missingMessage : "请输入物资种类名称",
							});
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
