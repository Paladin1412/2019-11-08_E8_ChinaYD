
/**
 * @Writer ：zyz
 * @NowDate：20191111
 * @Message：根据明细下拉框自动赋值
 */






var field1 = "Chinese_Name";
var field2 = "English_name";
var field3 = "Business_card_user";
var setfield1 = "Team_or_Country";//团队/国家
var setfield2 = "Department";    // 部/地区
var setfield3 = "External_Title";//外部头衔-中文
var setfield4 = "External_Title_English";//外部头衔-英文

var field1_m = "English_name";//姓名	明细
var field2_m = "Language_list";//语言
var field3_m = "job_title";//外部头衔
jQuery(function(){
	
	
	setTimeout(function(){
		var ff = getFields($("input[name=workflowid]").val());
		var fieldCheckId1 = ff.did2[field1_m];
		var fieldCheckId2 = ff.did2[field2_m];
		var fieldCheckId3 = ff.did2[field3_m];

		var fieldval1 = ff.mid[field1];
		var fieldval2 = ff.mid[field2];
        var fieldval3 = ff.mid[field3];
        var setfieldval1 = ff.mid[setfield1];
        var setfieldval2 = ff.mid[setfield2];
        var setfieldval3 = ff.mid[setfield3];
        var setfieldval4 = ff.mid[setfield4];


		setDepartment(jQuery("#"+fieldval3).val(),setfieldval1,setfieldval2);
		jQuery("#"+fieldval3).bindPropertyChange(function () {       
			setDepartment(jQuery("#"+fieldval3).val(),setfieldval1,setfieldval2);
			jQuery("select[id^='"+fieldCheckId2+"']").each(function(){
				var id_index = jQuery(this).attr("id").split("_")[1];
				var field_index = fieldCheckId1+"_"+id_index;
				var field_index2 = fieldCheckId3+"_"+id_index;
				
				if(jQuery(this).val() == "0"){
					jQuery("#"+field_index).val(jQuery("#"+fieldval1).val());
					jQuery("#"+field_index2).val(jQuery("#"+setfieldval3).val());
					if(getEleHideFlag(field_index)){
						jQuery("#"+field_index+"span").text(jQuery("#"+fieldval1).val());
					}
					if(getEleHideFlag(field_index2)){
						jQuery("#"+field_index2+"span").text(jQuery("#"+setfieldval3).val());
					}
				}else if(jQuery(this).val() == "1"){
					jQuery("#"+field_index).val(jQuery("#"+fieldval2).val());
					jQuery("#"+field_index2).val(jQuery("#"+setfieldval4).val());
					if(getEleHideFlag(field_index)){
						jQuery("#"+field_index+"span").text(jQuery("#"+fieldval2).val());
					}
					if(getEleHideFlag(field_index2)){
						jQuery("#"+field_index2+"span").text(jQuery("#"+setfieldval4).val());
					}
				}else{
					jQuery("#"+field_index).val("");
					jQuery("#"+field_index+"span").text("");
					jQuery("#"+field_index2).val("");
					jQuery("#"+field_index2+"span").text("");
				}
			});
		});
		
		jQuery("#"+fieldval1).bindPropertyChange(function () {       
			jQuery("select[id^='"+fieldCheckId2+"']").each(function(){
				var id_index = jQuery(this).attr("id").split("_")[1];
				var field_index = fieldCheckId1+"_"+id_index;
				var field_index2 = fieldCheckId3+"_"+id_index;

				if(jQuery(this).val() == "0"){
					jQuery("#"+field_index).val(jQuery("#"+fieldval1).val());
					jQuery("#"+field_index2).val(jQuery("#"+setfieldval3).val());
					if(getEleHideFlag(field_index)){
						jQuery("#"+field_index+"span").text(jQuery("#"+fieldval1).val());
					}
					if(getEleHideFlag(field_index2)){
						jQuery("#"+field_index2+"span").text(jQuery("#"+setfieldval3).val());
					}
				}else if(jQuery(this).val() == "1"){
					jQuery("#"+field_index).val(jQuery("#"+fieldval2).val());
					jQuery("#"+field_index2).val(jQuery("#"+setfieldval4).val());
					if(getEleHideFlag(field_index)){
						jQuery("#"+field_index+"span").text(jQuery("#"+fieldval2).val());
					}
					if(getEleHideFlag(field_index2)){
						jQuery("#"+field_index2+"span").text(jQuery("#"+setfieldval4).val());
					}
				}else{
					jQuery("#"+field_index).val("");
					jQuery("#"+field_index+"span").text("");
					jQuery("#"+field_index2).val("");
					jQuery("#"+field_index2+"span").text("");
				}
			});
		});
		
		jQuery("select[id^='"+fieldCheckId2+"']").change(function(){
			var id_index = jQuery(this).attr("id").split("_")[1];
			var field_index = fieldCheckId1+"_"+id_index;
			var field_index2 = fieldCheckId3+"_"+id_index;

			if(jQuery(this).val() == "0"){
					jQuery("#"+field_index).val(jQuery("#"+fieldval1).val());
					jQuery("#"+field_index2).val(jQuery("#"+setfieldval3).val());
					if(getEleHideFlag(field_index)){
						jQuery("#"+field_index+"span").text(jQuery("#"+fieldval1).val());
					}
					if(getEleHideFlag(field_index2)){
						jQuery("#"+field_index2+"span").text(jQuery("#"+setfieldval3).val());
					}
				}else if(jQuery(this).val() == "1"){
					jQuery("#"+field_index).val(jQuery("#"+fieldval2).val());
					jQuery("#"+field_index2).val(jQuery("#"+setfieldval4).val());
					if(getEleHideFlag(field_index)){
						jQuery("#"+field_index+"span").text(jQuery("#"+fieldval2).val());
					}
					if(getEleHideFlag(field_index2)){
						jQuery("#"+field_index2+"span").text(jQuery("#"+setfieldval4).val());
					}
				}else{
					jQuery("#"+field_index).val("");
					jQuery("#"+field_index+"span").text("");
					jQuery("#"+field_index2).val("");
					jQuery("#"+field_index2+"span").text("");
				}
		});
		jQuery("button[name='addbutton1']").click(function(){
			jQuery("select[id^='"+fieldCheckId2+"']").change(function(){
				var id_index = jQuery(this).attr("id").split("_")[1];
				var field_index = fieldCheckId1+"_"+id_index;
				var field_index2 = fieldCheckId3+"_"+id_index;

				if(jQuery(this).val() == "0"){
					jQuery("#"+field_index).val(jQuery("#"+fieldval1).val());
					jQuery("#"+field_index2).val(jQuery("#"+setfieldval3).val());
					if(getEleHideFlag(field_index)){
						jQuery("#"+field_index+"span").text(jQuery("#"+fieldval1).val());
					}
					if(getEleHideFlag(field_index2)){
						jQuery("#"+field_index2+"span").text(jQuery("#"+setfieldval3).val());
					}
				}else if(jQuery(this).val() == "1"){
					jQuery("#"+field_index).val(jQuery("#"+fieldval2).val());
					jQuery("#"+field_index2).val(jQuery("#"+setfieldval4).val());
					if(getEleHideFlag(field_index)){
						jQuery("#"+field_index+"span").text(jQuery("#"+fieldval2).val());
					}
					if(getEleHideFlag(field_index2)){
						jQuery("#"+field_index2+"span").text(jQuery("#"+setfieldval4).val());
					}
				}else{
					jQuery("#"+field_index).val("");
					jQuery("#"+field_index+"span").text("");
					jQuery("#"+field_index2).val("");
					jQuery("#"+field_index2+"span").text("");
				}
			});
		});
				
	},500);	
});

function setDepartment(userid,setStrId1,setStrId2){
	jQuery.ajax({
		type:"get",
		async: false,
		url: "/weaversj/workflow/js/companyCard/getDepartmenData.jsp?userid="+userid,
        contentType:'application/x-www-form-urlencoded',
		dataType:"json",
		async: false,
		success: function(data){	
			jQuery("#"+setStrId1).val(data.cc);
			jQuery("#"+setStrId1+"span").text(data.cc);
			jQuery("#"+setStrId2+"span").text(data.dd);
			jQuery("#"+setStrId2).val(data.dd);
		}
	});
}