$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('wuzi_wuziDesc_edit');
	var wuzi_wuziDesc_edit = UE.getEditor('wuzi_wuziDesc_edit'); //物资详情编辑器
	wuzi_wuziDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Wuzi/" + $("#wuzi_wuliuNo_edit").val() + "/update",
		type : "get",
		data : {
			//wuliuNo : $("#wuzi_wuliuNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (wuzi, response, status) {
			$.messager.progress("close");
			if (wuzi) { 
				$("#wuzi_wuliuNo_edit").val(wuzi.wuliuNo);
				$("#wuzi_wuliuNo_edit").validatebox({
					required : true,
					missingMessage : "请输入物流单号",
					editable: false
				});
				$("#wuzi_wuziClassObj_wuziClassId_edit").combobox({
					url:"WuziClass/listAll",
					valueField:"wuziClassId",
					textField:"wuziClassName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#wuzi_wuziClassObj_wuziClassId_edit").combobox("select", wuzi.wuziClassObjPri);
						//var data = $("#wuzi_wuziClassObj_wuziClassId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#wuzi_wuziClassObj_wuziClassId_edit").combobox("select", data[0].wuziClassId);
						//}
					}
				});
				$("#wuzi_wuziName_edit").val(wuzi.wuziName);
				$("#wuzi_wuziName_edit").validatebox({
					required : true,
					missingMessage : "请输入物资名称",
				});
				$("#wuzi_zhongliang_edit").val(wuzi.zhongliang);
				$("#wuzi_zhongliang_edit").validatebox({
					required : true,
					missingMessage : "请输入物资重量",
				});
				wuzi_wuziDesc_edit.setContent(wuzi.wuziDesc);
				$("#wuzi_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#wuzi_userObj_user_name_edit").combobox("select", wuzi.userObjPri);
						//var data = $("#wuzi_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#wuzi_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#wuzi_sendTelephone_edit").val(wuzi.sendTelephone);
				$("#wuzi_sendTelephone_edit").validatebox({
					required : true,
					missingMessage : "请输入寄件人电话",
				});
				$("#wuzi_sendAddress_edit").val(wuzi.sendAddress);
				$("#wuzi_sendAddress_edit").validatebox({
					required : true,
					missingMessage : "请输入寄件人地址",
				});
				$("#wuzi_receiveUserObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#wuzi_receiveUserObj_user_name_edit").combobox("select", wuzi.receiveUserObjPri);
						//var data = $("#wuzi_receiveUserObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#wuzi_receiveUserObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#wuzi_receiveTelephone_edit").val(wuzi.receiveTelephone);
				$("#wuzi_receiveTelephone_edit").validatebox({
					required : true,
					missingMessage : "请输入收件人电话",
				});
				$("#wuzi_receiveAddress_edit").val(wuzi.receiveAddress);
				$("#wuzi_receiveAddress_edit").validatebox({
					required : true,
					missingMessage : "请输入收件人地址",
				});
				$("#wuzi_yunfei_edit").val(wuzi.yunfei);
				$("#wuzi_yunfei_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入运费",
					invalidMessage : "运费输入不对",
				});
				$("#wuzi_wldt_edit").val(wuzi.wldt);
				$("#wuzi_wldt_edit").validatebox({
					required : true,
					missingMessage : "请输入物流动态",
				});
				$("#wuzi_wuziMemo_edit").val(wuzi.wuziMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#wuziModifyButton").click(function(){ 
		if ($("#wuziEditForm").form("validate")) {
			$("#wuziEditForm").form({
			    url:"Wuzi/" +  $("#wuzi_wuliuNo_edit").val() + "/update",
			    onSubmit: function(){
					if($("#wuziEditForm").form("validate"))  {
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
			$("#wuziEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
