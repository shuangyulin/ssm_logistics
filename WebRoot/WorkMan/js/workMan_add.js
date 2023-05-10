$(function () {
	$("#workMan_workUserName").validatebox({
		required : true, 
		missingMessage : '请输入工作人员账号',
	});

	$("#workMan_password").validatebox({
		required : true, 
		missingMessage : '请输入登录密码',
	});

	$("#workMan_name").validatebox({
		required : true, 
		missingMessage : '请输入姓名',
	});

	$("#workMan_gender").validatebox({
		required : true, 
		missingMessage : '请输入性别',
	});

	$("#workMan_birthDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#workMan_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	//单击添加按钮
	$("#workManAddButton").click(function () {
		//验证表单 
		if(!$("#workManAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#workManAddForm").form({
			    url:"WorkMan/add",
			    onSubmit: function(){
					if($("#workManAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#workManAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#workManAddForm").submit();
		}
	});

	//单击清空按钮
	$("#workManClearButton").click(function () { 
		$("#workManAddForm").form("clear"); 
	});
});
