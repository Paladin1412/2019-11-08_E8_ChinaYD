
/**
 * @Writer ：zyz
 * @NowDate：20191111
 * @Message：根据俩个下拉框隐藏文本域
 */

var Marketing_expenses_file_sql = "Marketing_expenses";//营销活动费用
var Whether_the_marketing_file_sql = "Whether_the_marketing";//营销活动是否符合审批内小额审批条件    name = tip1
var marketing_file_sql = "marketing";//是否超出全年市场营销预算    
var confirmation_market_file_sql = "confirmation_market";//是否确认属于市场内的项目     name = hidden_sc_select
var Year_marketing_file_sql = "Year_marketing"; //  全年市场营销预算     编辑框
var campaign_needs_fiel_sql = "campaign_needs";//   营销活动是否需要签合同      name = tip2
var ff;


var Marketing_expenses_filedid;
var MWhether_the_marketing_filedid;
var marketing_filedid;
var confirmation_market_filedid;
var Year_marketing_filedid;
var campaign_needs_fieldid;



var jsonLan={
"0":{
7:"请具体说明新增项目的预算及详情.",
8:"Please specify the details and budget of the new projects."
},
"1":{
7:"请提供项目预算调整原因.",
8:"Please advise the reason for the budget modification."
}
}
$(function(){
	init();
	hideChange(jQuery("#"+Marketing_expenses_filedid).val());
	jQuery("#"+Marketing_expenses_filedid).change(function(){
		hideChange(jQuery(this).val());
	});
	hideChangeToxm(jQuery("#"+confirmation_market_filedid).val());
	jQuery("#"+confirmation_market_filedid).change(function(){
		hideChangeToxm(jQuery(this).val());
	});
	
	hideChangeTomark(jQuery("#"+marketing_filedid).val());
	jQuery("#"+marketing_filedid).change(function(){
		hideChangeTomark(jQuery(this).val());
	});
	
	hideChangeToMWhether(jQuery("#"+MWhether_the_marketing_filedid).val());
	jQuery("#"+MWhether_the_marketing_filedid).change(function(){
		hideChangeToMWhether(jQuery(this).val());
		
	});
	
	hideChangeTocamp(jQuery("#"+campaign_needs_fieldid).val());
	jQuery("#"+campaign_needs_fieldid).change(function(){
		hideChangeTocamp(jQuery(this).val());
	});
	
});






function hideChangeTocamp(val){
	if(val=="0"){
    	 $("div[name='tip2']").show();
	}else{
    	 $("div[name='tip2']").hide();
	}
}

function hideChangeToMWhether(val){
	if(val=="1"){
    	 $("div[name='tip1']").show();
	}else{
		 $("div[name='tip1']").hide();
	}
}

function hideChangeTomark(val){
	if(val != ""){
		document.getElementById(Year_marketing_filedid).placeholder = jsonLan[val][languageid];
		jQuery("#"+Year_marketing_filedid).parent().show();
	}else{
		jQuery("#"+Year_marketing_filedid).parent().hide();
	}
}

function hideChangeToxm(val){
	if(val == '1'){
		addInputCheckField(marketing_filedid);
		$("tr[name='hidden_sc_select']").show();
		if(jQuery("#"+marketing_filedid).val() == "0"){
			jQuery("#"+Year_marketing_filedid).parent().show();
		}else{
			jQuery("#"+Year_marketing_filedid).parent().hide();
		}
	}else{
		$("tr[name='hidden_sc_select']").hide();
		jQuery("#"+Year_marketing_filedid).parent().hide();
		removeInputCheckField(marketing_filedid);
	}
}

function hideChange(val){
	if(val == ""){
		return;
	}
    $("tr[name='zyz_hiddenDocument']").hide();
    
	if(val < 200000){//赋值是
		hideChangeToMWhether(0);
	    jQuery("#"+MWhether_the_marketing_filedid).val("0");
    }else{
    	hideChangeToMWhether(1);
    	jQuery("#"+MWhether_the_marketing_filedid).val("1");
    }
    if(val >= 100000 && val <=200000){

	     $("tr[name='zyz_hiddenDocument']").show();
    }else{
		setTimeout(function(){
			$("tr[name='zyz_hiddenDocument']").hide();
		
		},500);
    }
}
function init(){
    ff = getFields($("input[name=workflowid]").val());
    Marketing_expenses_filedid = ff.mid[Marketing_expenses_file_sql];
	MWhether_the_marketing_filedid= ff.mid[Whether_the_marketing_file_sql];
	marketing_filedid= ff.mid[marketing_file_sql];
	confirmation_market_filedid= ff.mid[confirmation_market_file_sql];
	Year_marketing_filedid= ff.mid[Year_marketing_file_sql];
	campaign_needs_fieldid = ff.mid[campaign_needs_fiel_sql];
}
