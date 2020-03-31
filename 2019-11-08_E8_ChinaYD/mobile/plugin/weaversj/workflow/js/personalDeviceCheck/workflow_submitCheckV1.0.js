
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
var changeFlags = true;//下拉框是否选择过【否】改变标识
var alertFlags = true;	//是否弹出提醒
var alertStr = ["您修改过资产内容；如发现资产数据错误，请在【信息是否正确】选择【否】并更正内容；选择【是】则修改过的资产内容自动还原，流程自动提交下一节点。",
	"You have changed the asset information. Please select 【No】 at 【Information Correctness】 to amend. If you would like to revoke your amendment and submit to the administrator, please select 【Yes】. "];
var userAlert = "";

jQuery(function(){
	
	if(getUserLanguage() == "7"){
		userAlert = alertStr[0];
	}else{
		userAlert = alertStr[1];
	}
	//获取表单所有字段
    ff = getFields(jQuery("input[name=workflowid]").val());
    //将需要控制的字段，将id与值封存为json格式数据
    getfieldIdAndVal();
    //获取监控change事件id
    var changeFieldId = getFieldid("Information_is_correct");
    //初始化下拉框值。 应用于保存初始化。
    var fieldChangeVal = jQuery("#"+changeFieldId).val();
    setChangeFlags(fieldChangeVal);
    jQuery("#"+changeFieldId).change(function(){
    	fieldChangeVal = jQuery(this).val();
        setChangeFlags(fieldChangeVal);
    });
    
    dobeforecheck = function () {
    	getReadyValIfNoCheck(changeFlags,fieldChangeVal);
	    if(!alertFlags){
	 	   if(confirm(userAlert)){
	 		   setReadyValIfNoCheck(changeFlags,fieldChangeVal);
	 		   return true;
	 	   }else{
	 		   return false;
	 	   }
		}else{
			setReadyValIfNoCheck(changeFlags,fieldChangeVal);
	 		return true;
		}
    }
    
//    
//    //保存事件
//    var __systemHandleFunction = doSubmit_4Mobile ;
//    doSubmit_4Mobile = function (btnobj) {
//      getReadyValIfNoCheck(changeFlags,fieldChangeVal);
//      if(!alertFlags){
//    	   if(confirm("当前表单已经变更，是否继续提交？【确认】将还原并提交，【取消】重新更改")){
//    		   setReadyValIfNoCheck(changeFlags,fieldChangeVal);
//        	   __systemHandleFunction(btnobj);
//    	   }
//	  }else{
//		   setReadyValIfNoCheck(changeFlags,fieldChangeVal);
//    	   __systemHandleFunction(btnobj);
//	  }
//    };
});

//初始化的值与提交或保存的值是否发生改变
function getReadyValIfNoCheck(flags,fVal){
	 alertFlags = true;
	 if(!flags && fVal === "0"){
		 	for(var k in fieldidAndVal){
			   var fieldIndexOf = fields.indexOf(k);
			   if(getFieldVal(k,fieldType[fieldIndexOf])  !== fieldidAndVal[k]){
				   alertFlags = false;
				   return ;
			   }
		   }
	   }
}

//初始化的值与提交或保存的值是否发生改变
function setReadyValIfNoCheck(){
 	for(var k in fieldidAndVal){
	   var fieldIndexOf = fields.indexOf(k);
	   if(getFieldVal(k,fieldType[fieldIndexOf])  !== fieldidAndVal[k]){
		   setFieldVal(k,fieldType[fieldIndexOf],fieldidAndVal[k]);
	   }
   }
}


function setChangeFlags(str){
	if(str === "1"){
		changeFlags = false;
	}
}

//获得前端id 与值
function getfieldIdAndVal(){
	for(var i=0;i<fields.length;i++){
		var fieldId = getFieldid(fields[i]);
		var fieldVal = getFieldVal(fieldId,fieldType[i]);
		fieldidAndVal[fieldId] = fieldVal;
	}
}
//获取值，文本域特殊处理
function getFieldVal(fieldId,fieldType){
	var val;
	if(fieldType === '4')
		val = jQuery("#"+fieldId).text();
	else
		val = jQuery("#"+fieldId).val();
	return val;
}
//设置值
function setFieldVal(fieldId,fieldType,fieldval){
	if(fieldType === '4')
		jQuery("#"+fieldId).text(fieldval);
	else
		jQuery("#"+fieldId).val(fieldval);
}
//获取前端id
function getFieldid(sqlField){
	return ff.mid[sqlField];
}
