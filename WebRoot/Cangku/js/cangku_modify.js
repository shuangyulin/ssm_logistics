$(function () {
	$.ajax({
		url : "Cangku/" + $("#cangku_cangkuId_edit").val() + "/update",
		type : "get",
		data : {
			//cangkuId : $("#cangku_cangkuId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (cangku, response, status) {
			$.messager.progress("close");
			if (cangku) { 
				$("#cangku_cangkuId_edit").val(cangku.cangkuId);
				$("#cangku_cangkuId_edit").validatebox({
					required : true,
					missingMessage : "请输入仓库id",
					editable: false
				});
				$("#cangku_diqu_edit").val(cangku.diqu);
				$("#cangku_diqu_edit").validatebox({
					required : true,
					missingMessage : "请输入所在地区",
				});
				$("#cangku_cangkuName_edit").val(cangku.cangkuName);
				$("#cangku_cangkuName_edit").validatebox({
					required : true,
					missingMessage : "请输入仓库名称",
				});
				$("#cangku_mianji_edit").val(cangku.mianji);
				$("#cangku_mianji_edit").validatebox({
					required : true,
					missingMessage : "请输入仓库面积",
				});
				$("#cangku_tdl_edit").val(cangku.tdl);
				$("#cangku_tdl_edit").validatebox({
					required : true,
					missingMessage : "请输入仓库吞吐量",
				});
				$("#cangku_lianxiren_edit").val(cangku.lianxiren);
				$("#cangku_lianxiren_edit").validatebox({
					required : true,
					missingMessage : "请输入联系人",
				});
				$("#cangku_telephone_edit").val(cangku.telephone);
				$("#cangku_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#cangku_address_edit").val(cangku.address);
				$("#cangku_address_edit").validatebox({
					required : true,
					missingMessage : "请输入仓库地址",
				});
				$("#cangku_cangkuMemo_edit").val(cangku.cangkuMemo);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#cangkuModifyButton").click(function(){ 
		if ($("#cangkuEditForm").form("validate")) {
			$("#cangkuEditForm").form({
			    url:"Cangku/" +  $("#cangku_cangkuId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#cangkuEditForm").form("validate"))  {
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
			$("#cangkuEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
