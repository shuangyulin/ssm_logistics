$(function () {
	$("#cangku_diqu").validatebox({
		required : true, 
		missingMessage : '请输入所在地区',
	});

	$("#cangku_cangkuName").validatebox({
		required : true, 
		missingMessage : '请输入仓库名称',
	});

	$("#cangku_mianji").validatebox({
		required : true, 
		missingMessage : '请输入仓库面积',
	});

	$("#cangku_tdl").validatebox({
		required : true, 
		missingMessage : '请输入仓库吞吐量',
	});

	$("#cangku_lianxiren").validatebox({
		required : true, 
		missingMessage : '请输入联系人',
	});

	$("#cangku_telephone").validatebox({
		required : true, 
		missingMessage : '请输入联系电话',
	});

	$("#cangku_address").validatebox({
		required : true, 
		missingMessage : '请输入仓库地址',
	});

	//单击添加按钮
	$("#cangkuAddButton").click(function () {
		//验证表单 
		if(!$("#cangkuAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#cangkuAddForm").form({
			    url:"Cangku/add",
			    onSubmit: function(){
					if($("#cangkuAddForm").form("validate"))  { 
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
                        $("#cangkuAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#cangkuAddForm").submit();
		}
	});

	//单击清空按钮
	$("#cangkuClearButton").click(function () { 
		$("#cangkuAddForm").form("clear"); 
	});
});
