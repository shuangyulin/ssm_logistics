$(function () {
	$.ajax({
		url : "Chuku/" + $("#chuku_chukuId_edit").val() + "/update",
		type : "get",
		data : {
			//chukuId : $("#chuku_chukuId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (chuku, response, status) {
			$.messager.progress("close");
			if (chuku) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#chukuModifyButton").click(function(){ 
		if ($("#chukuEditForm").form("validate")) {
			$("#chukuEditForm").form({
			    url:"Chuku/" +  $("#chuku_chukuId_edit").val() + "/update",
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
			$("#chukuEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
