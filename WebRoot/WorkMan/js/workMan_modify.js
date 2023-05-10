$(function () {
	$.ajax({
		url : "WorkMan/" + $("#workMan_workUserName_edit").val() + "/update",
		type : "get",
		data : {
			//workUserName : $("#workMan_workUserName_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (workMan, response, status) {
			$.messager.progress("close");
			if (workMan) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#workManModifyButton").click(function(){ 
		if ($("#workManEditForm").form("validate")) {
			$("#workManEditForm").form({
			    url:"WorkMan/" +  $("#workMan_workUserName_edit").val() + "/update",
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
			$("#workManEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
