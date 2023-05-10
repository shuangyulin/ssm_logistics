var workMan_manage_tool = null; 
$(function () { 
	initWorkManManageTool(); //建立WorkMan管理对象
	workMan_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#workMan_manage").datagrid({
		url : 'WorkMan/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "workUserName",
		sortOrder : "desc",
		toolbar : "#workMan_manage_tool",
		columns : [[
			{
				field : "workUserName",
				title : "工作人员账号",
				width : 140,
			},
			{
				field : "name",
				title : "姓名",
				width : 140,
			},
			{
				field : "gender",
				title : "性别",
				width : 140,
			},
			{
				field : "birthDate",
				title : "出生日期",
				width : 140,
			},
			{
				field : "workManPhoto",
				title : "工作人员照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "telephone",
				title : "联系电话",
				width : 140,
			},
		]],
	});

	$("#workManEditDiv").dialog({
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
				if ($("#workManEditForm").form("validate")) {
					//验证表单 
					if(!$("#workManEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#workManEditForm").form({
						    url:"WorkMan/" + $("#workMan_workUserName_edit").val() + "/update",
						    onSubmit: function(){
								if($("#workManEditForm").form("validate"))  {
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
			                        $("#workManEditDiv").dialog("close");
			                        workMan_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#workManEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#workManEditDiv").dialog("close");
				$("#workManEditForm").form("reset"); 
			},
		}],
	});
});

function initWorkManManageTool() {
	workMan_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#workMan_manage").datagrid("reload");
		},
		redo : function () {
			$("#workMan_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#workMan_manage").datagrid("options").queryParams;
			queryParams["workUserName"] = $("#workUserName").val();
			queryParams["name"] = $("#name").val();
			queryParams["birthDate"] = $("#birthDate").datebox("getValue"); 
			queryParams["telephone"] = $("#telephone").val();
			$("#workMan_manage").datagrid("options").queryParams=queryParams; 
			$("#workMan_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#workManQueryForm").form({
			    url:"WorkMan/OutToExcel",
			});
			//提交表单
			$("#workManQueryForm").submit();
		},
		remove : function () {
			var rows = $("#workMan_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var workUserNames = [];
						for (var i = 0; i < rows.length; i ++) {
							workUserNames.push(rows[i].workUserName);
						}
						$.ajax({
							type : "POST",
							url : "WorkMan/deletes",
							data : {
								workUserNames : workUserNames.join(","),
							},
							beforeSend : function () {
								$("#workMan_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#workMan_manage").datagrid("loaded");
									$("#workMan_manage").datagrid("load");
									$("#workMan_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#workMan_manage").datagrid("loaded");
									$("#workMan_manage").datagrid("load");
									$("#workMan_manage").datagrid("unselectAll");
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
			var rows = $("#workMan_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "WorkMan/" + rows[0].workUserName +  "/update",
					type : "get",
					data : {
						//workUserName : rows[0].workUserName,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (workMan, response, status) {
						$.messager.progress("close");
						if (workMan) { 
							$("#workManEditDiv").dialog("open");
							$("#workMan_workUserName_edit").val(workMan.workUserName);
							$("#workMan_workUserName_edit").validatebox({
								required : true,
								missingMessage : "请输入工作人员账号",
								editable: false
							});
							$("#workMan_password_edit").val(workMan.password);
							$("#workMan_password_edit").validatebox({
								required : true,
								missingMessage : "请输入登录密码",
							});
							$("#workMan_name_edit").val(workMan.name);
							$("#workMan_name_edit").validatebox({
								required : true,
								missingMessage : "请输入姓名",
							});
							$("#workMan_gender_edit").val(workMan.gender);
							$("#workMan_gender_edit").validatebox({
								required : true,
								missingMessage : "请输入性别",
							});
							$("#workMan_birthDate_edit").datebox({
								value: workMan.birthDate,
							    required: true,
							    showSeconds: true,
							});
							$("#workMan_workManPhoto").val(workMan.workManPhoto);
							$("#workMan_workManPhotoImg").attr("src", workMan.workManPhoto);
							$("#workMan_telephone_edit").val(workMan.telephone);
							$("#workMan_telephone_edit").validatebox({
								required : true,
								missingMessage : "请输入联系电话",
							});
							$("#workMan_address_edit").val(workMan.address);
							$("#workMan_workManMemo_edit").val(workMan.workManMemo);
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
