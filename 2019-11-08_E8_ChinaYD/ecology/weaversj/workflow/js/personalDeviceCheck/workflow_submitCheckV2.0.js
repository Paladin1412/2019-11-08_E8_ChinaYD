
/**
 * @Writer ：zyz
 * @NowDate：20191111
 * @Message：提交时，根据下拉框，判断一些字段是否发生过更改。无论是否改变都正常提交，或保存。
 * 			场景：
 * 				1、选择否，正常提交/保存，无任何提示。
 * 				2、选择是，正常提交/保存，无任何提示
 * 				3、选择是，然后选择否，更改表单，重新选择是，弹出提示，并将值还原。
 * 				4、初始化，下拉框默认否，更改表单，选择是，弹出提示，并将值还原。
 */

/**
 * 字段信息：
 * 	Information_is_correct		信息是否准确（根据该字段判断）
 *	Serial_Number				主机序号
 *	Host_model					主机型号
 *	Corresponding_order_number	对应订单
 *	Date_of_purchase			购买日期
 *	Maintenance_to				保养至
 *	operating_system			操作系统
 *	CPU							处理器
 *	RAM							内存
 *	Host_category				主机类别
 *	Details						详细内容
 *	MAC_Address					mac地址
 */
var ff;
//字段
var fields = ['Serial_Number','Host_model','Corresponding_order_number','Date_of_purchase','Maintenance_to',
	'operating_system','CPU','RAM','Host_category','Details','MAC_Address'];

//字段类型 1下拉框 2文本 3日期 4文本域
var fieldType = ['2','2','2','3','3','1','2','2','1','4','2'];
//初始化获取 前端id 与 值
var fieldidAndVal = {};
//change事件字段
var fieldChage = "Information_is_correct";
var zcfield = "su_zichanbianhao";
var alertStr = ["您修改过资产内容；如发现资产数据错误，请在【信息是否正确】选择【否】并更正内容；选择【是】则修改过的资产内容自动还原，流程自动提交下一节点。",
	"You have changed the asset information. Please select 【No】 at 【Information Correctness】 to amend. If you would like to revoke your amendment and submit to the administrator, please select 【Yes】. "];

jQuery(function(){
	if(languageid == "7"){
		userAlert = alertStr[0];
	}else{
		userAlert = alertStr[1];
	}
    ff = getFields(jQuery("input[name=workflowid]").val());
	var fieldChage_id = getFieldid(fieldChage);
	var zccode = jQuery("#"+getFieldid(zcfield)).val();
	jQuery.ajax({
		type:"get",
		async: false,
		url: "/weaversj/workflow/js/personalDeviceCheck/getDemoDataCheck.jsp?zccode="+zccode,
        contentType:'application/x-www-form-urlencoded',
		dataType:"json",
		async: false,
		success: function(data){	
			fieldidAndVal = data;
		}
	});
	jQuery("#"+fieldChage_id).change(function(){
		if(jQuery(this).val()==="0"){
			if(!getChecked()){
				top.Dialog.confirm(userAlert, function(){
					setChecked();
	    		}, function () { 
	    			j//Query("#"+fieldChage_id).val("");
	    			//checkinput2('field173769','field173769span',jQuery(this).attr("viewtype"));
	    			//jQuery(this).change();
	    		}, 320, 90,true);
			}
		}
	});
	 var __systemHandleFunction2 = doSubmitNoBack ;
	    doSubmitNoBack = function (btnobj) {
			if(jQuery("#"+fieldChage_id).val()==="0"){

		    	if(!getChecked()){
					top.Dialog.confirm(userAlert, function(){
						setChecked();
			        	__systemHandleFunction2(btnobj);
		    		}, function () { 
		    			j//Query("#"+fieldChage_id).val("");
		    			//checkinput2('field173769','field173769span',jQuery(this).attr("viewtype"));
		    			//jQuery(this).change();
		    		}, 320, 90,true);
				}else{
		        	__systemHandleFunction2(btnobj);
				}
			}else{
	        	__systemHandleFunction2(btnobj);
			}
	    };
	//获取表单所有字段
    	
});


/**
 * 还原操作
 * @returns
 */
function setChecked(){
	for(var i =0;i<fields.length;i++){
		var fieldName = fields[i];
		var field_id = getFieldid(fieldName);
		var fieldTypeToGet = fieldType[i];
		var demoVal = fieldidAndVal[fieldName];
		setFieldVal(field_id,fieldTypeToGet,demoVal);
	}
}

/**
 * 是否更改过
 * */
function getChecked(){
	var flagse = true;
	for(var i =0;i<fields.length;i++){
		var fieldName = fields[i];
		var field_id = getFieldid(fieldName);
		var fieldTypeToGet = fieldType[i];
		var tableVal = getFieldVal(field_id,fieldTypeToGet);
		var demoVal = fieldidAndVal[fieldName];
		if(tableVal != demoVal){
			flagse = false;
			break;
		}
	}
	return flagse;
}
//获取值，文本域特殊处理
function getFieldVal(fieldId,fieldType){
	var val;
	if(fieldType === '4')
		val = jQuery("#"+fieldId).val();
	else
		val = jQuery("#"+fieldId).val();
	return val;
}
//设置值
function setFieldVal(fieldId,fieldType,fieldval){
	if(fieldType === '4'){
		jQuery("#"+fieldId).val(fieldval);
		jQuery("#"+fieldId+"_readonlytext").text(fieldval);
		//jQuery("#"+fieldId).text(fieldval);
		//jQuery("#"+fieldId+"span").text(fieldval);
	}else{
		jQuery("#"+fieldId).val(fieldval);
	}
}

//获取前端id
function getFieldid(sqlField){
	return ff.mid[sqlField];
}

//function hasSpecial(str) {
//    return str.replace(/\r/g,'').replace(/\n/g,'').replace(/\s/g,'');
//}
