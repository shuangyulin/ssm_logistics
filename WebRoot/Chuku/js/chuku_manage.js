var chuku_manage_tool = null; 
$(function () { 
	initChukuManageTool(); //建立Chuku管理对象
	chuku_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#chuku_manage").datagrid({
		url : 'Chuku/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "chukuId",
		sortOrder : "desc",
		toolbar : "#chuku_manage_tool",
		columns : [[
			{
				field : "chukuId",
				title : "出库id",
				width : 70,
			},
			{
				field : "wuziObj",
				title : "出库物资",
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
				title : "出库仓库",
				width : 140,
			},
			{
				field : "chukuTime",
				title : "出库时间",
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

	$("#chukuEditDiv").dialog({
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
				if ($("#chukuEditForm").form("validate")) {
					//验证表单 
					if(!$("#chukuEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#chukuEditForm").form({
						    url:"Chuku/" + $("#chuku_chukuId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#chukuEditForm").form("validate"))  {
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
			                        $("#chukuEditDiv").dialog("close");
			                        chuku_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#chukuEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#chukuEditDiv").dialog("close");
				$("#chukuEditForm").form("reset"); 
			},
		}],
	});
});

function initChukuManageTool() {
	chuku_manage_tool = {
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
			$("#chuku_manage").datagrid("reload");
		},
		redo : function () {
			$("#chuku_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#chuku_manage").datagrid("options").queryParams;
			queryParams["wuziObj.wuliuNo"] = $("#wuziObj_wuliuNo_query").combobox("getValue");
			queryParams["wuziClassObj.wuziClassId"] = $("#wuziClassObj_wuziClassId_query").combobox("getValue");
			queryParams["cangkuObj.cangkuId"] = $("#cangkuObj_cangkuId_query").combobox("getValue");
			queryParams["chukuTime"] = $("#chukuTime").datebox("getValue"); 
			queryParams["workManObj.workUserName"] = $("#workManObj_workUserName_query").combobox("getValue");
			$("#chuku_manage").datagrid("options").queryParams=queryParams; 
			$("#chuku_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#chukuQueryForm").form({
			    url:"Chuku/OutToExcel",
			});
			//提交表单
			$("#chukuQueryForm").submit();
		},
		remove : function () {
			var rows = $("#chuku_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var chukuIds = [];
						for (var i = 0; i < rows.length; i ++) {
							chukuIds.push(rows[i].chukuId);
						}
						$.ajax({
							type : "POST",
							url : "Chuku/deletes",
							data : {
								chukuIds : chukuIds.join(","),
							},
							beforeSend : function () {
								$("#chuku_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#chuku_manage").datagrid("loaded");
									$("#chuku_manage").datagrid("load");
									$("#chuku_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#chuku_manage").datagrid("loaded");
									$("#chuku_manage").datagrid("load");
									$("#chuku_manage").datagrid("unselectAll");
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
			var rows = $("#chuku_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Chuku/" + rows[0].chukuId +  "/update",
					type : "get",
					data : {
						//chukuId : rows[0].chukuId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (chuku, response, status) {
						$.messager.progress("close");
						if (chuku) { 
							$("#chukuEditDiv").dialog("open");
							$("#chuku_chukuId_edit").val(chuku.chukuId);
							$("#chuku_chukuId_edit").validatebox({
								required : true,
								missingMessage : "请输入出库id",
								editable: false
							});
							$("#chuku_wuziObj_wuliuNo_edit").combobox({
								url:"Wuzi/listAll",
							    valueField:"wuliuNo",
							    textField:"wuziName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#chuku_wuziObj_wuliuNo_edit").combobox("select", chuku.wuziObjPri);
									//var data = $("#chuku_wuziObj_wuliuNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#chuku_wuziObj_wuliuNo_edit").combobox("select", data[0].wuliuNo);
						            //}
								}
							});
							$("#chuku_wuziClassObj_wuziClassId_edit").combobox({
								url:"WuziClass/listAll",
							    valueField:"wuziClassId",
							    textField:"wuziClassName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#chuku_wuziClassObj_wuziClassId_edit").combobox("select", chuku.wuziClassObjPri);
									//var data = $("#chuku_wuziClassObj_wuziClassId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#chuku_wuziClassObj_wuziClassId_edit").combobox("select", data[0].wuziClassId);
						            //}
								}
							});
							$("#chuku_zhongliang_edit").val(chuku.zhongliang);
							$("#chuku_zhongliang_edit").validatebox({
								required : true,
								missingMessage : "请输入重量",
							});
							$("#chuku_cangkuObj_cangkuId_edit").combobox({
								url:"Cangku/listAll",
							    valueField:"cangkuId",
							    textField:"cangkuName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#chuku_cangkuObj_cangkuId_edit").combobox("select", chuku.cangkuObjPri);
									//var data = $("#chuku_cangkuObj_cangkuId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#chuku_cangkuObj_cangkuId_edit").combobox("select", data[0].cangkuId);
						            //}
								}
							});
							$("#chuku_chukuTime_edit").datetimebox({
								value: chuku.chukuTime,
							    required: true,
							    showSeconds: true,
							});
							$("#chuku_okFlag_edit").val(chuku.okFlag);
							$("#chuku_okFlag_edit").validatebox({
								required : true,
								missingMessage : "请输入是否完好",
							});
							$("#chuku_workManObj_workUserName_edit").combobox({
								url:"WorkMan/listAll",
							    valueField:"workUserName",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#chuku_workManObj_workUserName_edit").combobox("select", chuku.workManObjPri);
									//var data = $("#chuku_workManObj_workUserName_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#chuku_workManObj_workUserName_edit").combobox("select", data[0].workUserName);
						            //}
								}
							});
							$("#chuku_chukuMemo_edit").val(chuku.chukuMemo);
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
