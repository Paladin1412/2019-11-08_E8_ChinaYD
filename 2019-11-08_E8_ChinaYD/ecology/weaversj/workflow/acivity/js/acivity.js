//明细表1按钮：Detail_button_1
//明细表3按钮：Detail_button_3

var ff;

jQuery(function(){

	var detailButton1 = getButton("运营商查看","openDia(\'detail_1\')");
	var detailButton3 = getButton("企业业务查看","openDia(\'detail_3\')");
	jQuery("#Detail_button_1").html(detailButton1);
	jQuery("#Detail_button_3").html(detailButton3);
	
});



var dialog = null;
function closeDialog(){
	if(dialog)
		dialog.close();
}

function openDia(flags){
	opflag = flags;
	var url = "";
	var title = "";
	var width = 1000;
	var height = 800;
	
	if(flags == "detail_1"){
		title = "运营商业务";
		url = "/weaversj/workflow/acivity/jsp/list.jsp?flags=1&wid="+$("input[name=workflowid]").val()+"&reqid="+$("input[name=requestid]").val();
	}else if(flags == "detail_3"){
		title = "企业业务";
		url = "/weaversj/workflow/acivity/jsp/list.jsp?flags=3&wid="+$("input[name=workflowid]").val()+"&reqid="+$("input[name=requestid]").val();
	}else{
		return ;
	}	
	dialog = new window.top.Dialog();
	dialog.currentWindow = window;
	dialog.Title = title;
	dialog.Width = width;
	dialog.Height = height;
	dialog.Drag = true;
	dialog.URL = url;
	dialog.show();
}


