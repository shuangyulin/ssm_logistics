$(function () {
	$("#ruku_wuziObj_wuliuNo").combobox({
	    url:'Wuzi/listAll',
	    valueField: "wuliuNo",
	    textField: "wuziName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#ruku_wuziObj_wuliuNo").combobox("getData"); 
            if (data.length > 0) {
                $("#ruku_wuziObj_wuliuNo").combobox("select", data[0].wuliuNo);
            }
        }
	});
	$("#ruku_wuziClassObj_wuziClassId").combobox({
	    url:'WuziClass/listAll',
	    valueField: "wuziClassId",
	    textField: "wuziClassName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#ruku_wuziClassObj_wuziClassId").combobox("getData"); 
            if (data.length > 0) {
                $("#ruku_wuziClassObj_wuziClassId").combobox("select", data[0].wuziClassId);
            }
        }
	});
	$("#ruku_zhongliang").validatebox({
		required : true, 
		missingMessage : '请输入重量',
	});

	$("#ruku_cangkuObj_cangkuId").combobox({
	    url:'Cangku/listAll',
	    valueField: "cangkuId",
	    textField: "cangkuName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#ruku_cangkuObj_cangkuId").combobox("getData"); 
            if (data.length > 0) {
                $("#ruku_cangkuObj_cangkuId").combobox("select", data[0].cangkuId);
            }
        }
	});
	$("#ruku_rukuTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#ruku_okFlag").validatebox({
		required : true, 
		missingMessage : '请输入是否完好',
	});

	$("#ruku_workManObj_workUserName").combobox({
	    url:'WorkMan/listAll',
	    valueField: "workUserName",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#ruku_workManObj_workUserName").combobox("getData"); 
            if (data.length > 0) {
                $("#ruku_workManObj_workUserName").combobox("select", data[0].workUserName);
            }
        }
	});
	//单击添加按钮
	$("#rukuAddButton").click(function () {
		//验证表单 
		if(!$("#rukuAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#rukuAddForm").form({
			    url:"Ruku/add",
			    onSubmit: function(){
					if($("#rukuAddForm").form("validate"))  { 
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
                        $("#rukuAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#rukuAddForm").submit();
		}
	});

	//单击清空按钮
	$("#rukuClearButton").click(function () { 
		$("#rukuAddForm").form("clear"); 
	});
});
