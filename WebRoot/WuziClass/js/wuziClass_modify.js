$(function () {
	$.ajax({
		url : "WuziClass/" + $("#wuziClass_wuziClassId_edit").val() + "/update",
		type : "get",
		data : {
			//wuziClassId : $("#wuziClass_wuziClassId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (wuziClass, response, status) {
			$.messager.progress("close");
			if (wuziClass) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#wuziClassModifyButton").click(function(){ 
		if ($("#wuziClassEditForm").form("validate")) {
			$("#wuziClassEditForm").form({
			    url:"WuziClass/" +  $("#wuziClass_wuziClassId_edit").val() + "/update",
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
			$("#wuziClassEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
