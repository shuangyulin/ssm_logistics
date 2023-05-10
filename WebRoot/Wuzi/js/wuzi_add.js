$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('wuzi_wuziDesc');
	var wuzi_wuziDesc_editor = UE.getEditor('wuzi_wuziDesc'); //物资详情编辑框
	$("#wuzi_wuliuNo").validatebox({
		required : true, 
		missingMessage : '请输入物流单号',
	});

	$("#wuzi_wuziClassObj_wuziClassId").combobox({
	    url:'WuziClass/listAll',
	    valueField: "wuziClassId",
	    textField: "wuziClassName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#wuzi_wuziClassObj_wuziClassId").combobox("getData"); 
            if (data.length > 0) {
                $("#wuzi_wuziClassObj_wuziClassId").combobox("select", data[0].wuziClassId);
            }
        }
	});
	$("#wuzi_wuziName").validatebox({
		required : true, 
		missingMessage : '请输入物资名称',
	});

	$("#wuzi_zhongliang").validatebox({
		required : true, 
		missingMessage : '请输入物资重量',
	});

	$("#wuzi_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#wuzi_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#wuzi_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#wuzi_sendTelephone").validatebox({
		required : true, 
		missingMessage : '请输入寄件人电话',
	});

	$("#wuzi_sendAddress").validatebox({
		required : true, 
		missingMessage : '请输入寄件人地址',
	});

	$("#wuzi_receiveUserObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#wuzi_receiveUserObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#wuzi_receiveUserObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#wuzi_receiveTelephone").validatebox({
		required : true, 
		missingMessage : '请输入收件人电话',
	});

	$("#wuzi_receiveAddress").validatebox({
		required : true, 
		missingMessage : '请输入收件人地址',
	});

	$("#wuzi_yunfei").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入运费',
		invalidMessage : '运费输入不对',
	});

	$("#wuzi_wldt").validatebox({
		required : true, 
		missingMessage : '请输入物流动态',
	});

	//单击添加按钮
	$("#wuziAddButton").click(function () {
		if(wuzi_wuziDesc_editor.getContent() == "") {
			alert("请输入物资详情");
			return;
		}
		//验证表单 
		if(!$("#wuziAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#wuziAddForm").form({
			    url:"Wuzi/add",
			    onSubmit: function(){
					if($("#wuziAddForm").form("validate"))  { 
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
                        $("#wuziAddForm").form("clear");
                        wuzi_wuziDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#wuziAddForm").submit();
		}
	});

	//单击清空按钮
	$("#wuziClearButton").click(function () { 
		$("#wuziAddForm").form("clear"); 
	});
});
