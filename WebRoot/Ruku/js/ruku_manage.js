var ruku_manage_tool = null; 
$(function () { 
	initRukuManageTool(); //建立Ruku管理对象
	ruku_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#ruku_manage").datagrid({
		url : 'Ruku/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "rukuId",
		sortOrder : "desc",
		toolbar : "#ruku_manage_tool",
		columns : [[
			{
				field : "rukuId",
				title : "入库id",
				width : 70,
			},
			{
				field : "wuziObj",
				title : "入库物资",
				width : 140,
			},
			{
				field : "wuziClassObj",
				title : "物资种类",
				width : 140,
			},
			{
				field : "zhongliang",
				title : "重量",
				width : 140,
			},
			{
				field : "cangkuObj",
				title : "入库仓库",
				width : 140,
			},
			{
				field : "rukuTime",
				title : "入库时间",
				width : 140,
			},
			{
				field : "okFlag",
				title : "是否完好",
				width : 140,
			},
			{
				field : "workManObj",
				title : "工作人员",
				width : 140,
			},
		]],
	});

	$("#rukuEditDiv").dialog({
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
				if ($("#rukuEditForm").form("validate")) {
					//验证表单 
					if(!$("#rukuEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#rukuEditForm").form({
						    url:"Ruku/" + $("#ruku_rukuId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#rukuEditForm").form("validate"))  {
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
			                        $("#rukuEditDiv").dialog("close");
			                        ruku_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#rukuEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#rukuEditDiv").dialog("close");
				$("#rukuEditForm").form("reset"); 
			},
		}],
	});
});

function initRukuManageTool() {
	ruku_manage_tool = {
		init: function() {
			$.ajax({
				url : "Wuzi/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#wuziObj_wuliuNo_query").combobox({ 
					    valueField:"wuliuNo",
					    textField:"wuziName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{wuliuNo:"",wuziName:"不限制"});
					$("#wuziObj_wuliuNo_query").combobox("loadData",data); 
				}
			});
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
				url : "Cangku/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#cangkuObj_cangkuId_query").combobox({ 
					    valueField:"cangkuId",
					    textField:"cangkuName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{cangkuId:0,cangkuName:"不限制"});
					$("#cangkuObj_cangkuId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "WorkMan/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#workManObj_workUserName_query").combobox({ 
					    valueField:"workUserName",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{workUserName:"",name:"不限制"});
					$("#workManObj_workUserName_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#ruku_manage").datagrid("reload");
		},
		redo : function () {
			$("#ruku_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#ruku_manage").datagrid("options").queryParams;
			queryParams["wuziObj.wuliuNo"] = $("#wuziObj_wuliuNo_query").combobox("getValue");
			queryParams["wuziClassObj.wuziClassId"] = $("#wuziClassObj_wuziClassId_query").combobox("getValue");
			queryParams["cangkuObj.cangkuId"] = $("#cangkuObj_cangkuId_query").combobox("getValue");
			queryParams["rukuTime"] = $("#rukuTime").datebox("getValue"); 
			queryParams["workManObj.workUserName"] = $("#workManObj_workUserName_query").combobox("getValue");
			$("#ruku_manage").datagrid("options").queryParams=queryParams; 
			$("#ruku_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#rukuQueryForm").form({
			    url:"Ruku/OutToExcel",
			});
			//提交表单
			$("#rukuQueryForm").submit();
		},
		remove : function () {
			var rows = $("#ruku_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var rukuIds = [];
						for (var i = 0; i < rows.length; i ++) {
							rukuIds.push(rows[i].rukuId);
						}
						$.ajax({
							type : "POST",
							url : "Ruku/deletes",
							data : {
								rukuIds : rukuIds.join(","),
							},
							beforeSend : function () {
								$("#ruku_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#ruku_manage").datagrid("loaded");
									$("#ruku_manage").datagrid("load");
									$("#ruku_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#ruku_manage").datagrid("loaded");
									$("#ruku_manage").datagrid("load");
									$("#ruku_manage").datagrid("unselectAll");
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
			var rows = $("#ruku_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Ruku/" + rows[0].rukuId +  "/update",
					type : "get",
					data : {
						//rukuId : rows[0].rukuId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (ruku, response, status) {
						$.messager.progress("close");
						if (ruku) { 
							$("#rukuEditDiv").dialog("open");
							$("#ruku_rukuId_edit").val(ruku.rukuId);
							$("#ruku_rukuId_edit").validatebox({
								required : true,
								missingMessage : "请输入入库id",
								editable: false
							});
							$("#ruku_wuziObj_wuliuNo_edit").combobox({
								url:"Wuzi/listAll",
							    valueField:"wuliuNo",
							    textField:"wuziName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#ruku_wuziObj_wuliuNo_edit").combobox("select", ruku.wuziObjPri);
									//var data = $("#ruku_wuziObj_wuliuNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#ruku_wuziObj_wuliuNo_edit").combobox("select", data[0].wuliuNo);
						            //}
								}
							});
							$("#ruku_wuziClassObj_wuziClassId_edit").combobox({
								url:"WuziClass/listAll",
							    valueField:"wuziClassId",
							    textField:"wuziClassName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#ruku_wuziClassObj_wuziClassId_edit").combobox("select", ruku.wuziClassObjPri);
									//var data = $("#ruku_wuziClassObj_wuziClassId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#ruku_wuziClassObj_wuziClassId_edit").combobox("select", data[0].wuziClassId);
						            //}
								}
							});
							$("#ruku_zhongliang_edit").val(ruku.zhongliang);
							$("#ruku_zhongliang_edit").validatebox({
								required : true,
								missingMessage : "请输入重量",
							});
							$("#ruku_cangkuObj_cangkuId_edit").combobox({
								url:"Cangku/listAll",
							    valueField:"cangkuId",
							    textField:"cangkuName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#ruku_cangkuObj_cangkuId_edit").combobox("select", ruku.cangkuObjPri);
									//var data = $("#ruku_cangkuObj_cangkuId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#ruku_cangkuObj_cangkuId_edit").combobox("select", data[0].cangkuId);
						            //}
								}
							});
							$("#ruku_rukuTime_edit").datetimebox({
								value: ruku.rukuTime,
							    required: true,
							    showSeconds: true,
							});
							$("#ruku_okFlag_edit").val(ruku.okFlag);
							$("#ruku_okFlag_edit").validatebox({
								required : true,
								missingMessage : "请输入是否完好",
							});
							$("#ruku_workManObj_workUserName_edit").combobox({
								url:"WorkMan/listAll",
							    valueField:"workUserName",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#ruku_workManObj_workUserName_edit").combobox("select", ruku.workManObjPri);
									//var data = $("#ruku_workManObj_workUserName_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#ruku_workManObj_workUserName_edit").combobox("select", data[0].workUserName);
						            //}
								}
							});
							$("#ruku_rukuMemo_edit").val(ruku.rukuMemo);
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
