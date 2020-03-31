
/**
 * @Writer ：zyz
 * @NowDate：20191111
 * @Message：根据俩个下拉框隐藏文本域
 */



$(function(){
	var field1 = "Whether_the_marketing";//营销活动是否符合审批权限内的小额  ==0
	var field2 = "campaign_needs";//营销活动是否需要签合同 == 1
    var ff = getFields($("input[name=workflowid]").val());
    var fieldCheckId1 = "#"+ff.mid[field1];
    var fieldCheckId2 = "#"+ff.mid[field2];
    hiddenFieldIf($(fieldCheckId1).val(),$(fieldCheckId2).val());
    $(fieldCheckId1).change(function(){
        hiddenFieldIf(jQuery(this).val(),$(fieldCheckId2).val());
    });
    $(fieldCheckId2).change(function(){
        hiddenFieldIf($(fieldCheckId1).val(),$(this).val());
    });
});

function hiddenFieldIf(str1,str2){
	if(str1 === "0" && str2 === "1"){
        $("tr[name='zyz_hiddenDocument']").hide();
    }else{
        $("tr[name='zyz_hiddenDocument']").show();
    }
}