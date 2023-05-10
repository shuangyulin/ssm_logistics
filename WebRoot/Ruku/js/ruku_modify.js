$(function () {
	$.ajax({
		url : "Ruku/" + $("#ruku_rukuId_edit").val() + "/update",
		type : "get",
		data : {
			//rukuId : $("#ruku_rukuId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (ruku, response, status) {
			$.messager.progress("close");
			if (ruku) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#rukuModifyButton").click(function(){ 
		if ($("#rukuEditForm").form("validate")) {
			$("#rukuEditForm").form({
			    url:"Ruku/" +  $("#ruku_rukuId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#rukuEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
