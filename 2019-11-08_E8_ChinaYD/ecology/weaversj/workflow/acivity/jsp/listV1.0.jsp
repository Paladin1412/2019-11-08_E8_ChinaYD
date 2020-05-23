<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.lang.reflect.Array"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="weaver.hrm.resource.ResourceComInfo"%>
<%@page import="weaver.hrm.job.JobTitlesComInfo"%>
<%@page import="weaver.hrm.company.DepartmentComInfo"%>
<%@page import="weaver.hrm.company.SubCompanyComInfo"%>
<%@page import="weaver.login.Account"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="weaver.general.TimeUtil"%>
<%@page import="weaver.file.Prop"%>
<%@page import="com.westvalley.util.DataUtil"%>
<%@page import="weaver.conn.RecordSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/hrm/header.jsp" %>
<%@ page import="weaver.general.Util" %>
<%@page import="weaversj.util.BaseUtil"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="weaversj.util.WeaverSJUtil"%>

<%

WeaverSJUtil wUtil = new WeaverSJUtil();
//获取当前用户
User user_new = (User)request.getSession(true).getAttribute("weaver_user@bean");	
String userid = user_new.getUID()+"";	
String temUserid = user_new.getUID()+"";

BaseUtil baseUtil = new BaseUtil();
String strsql = "";

//明细1
String Need_to_submit_a_report = user.getLanguage()==8?"Submit by":"报告人";	
String Participation_in_activities = user.getLanguage()==8?"Any activities?":"是否有活动";	
String Exceed_The_Submission_Date = user.getLanguage()==8?"Late Submission":"是否超出呈报日期";	
String Dept = user.getLanguage()==8?"Dept":"部门";	
String Date_of_activity = user.getLanguage()==8?"Event date":"活动发生日期";	
String Launch_date = user.getLanguage()==8?"Deadline":"报告收集日期";	
String Event_Title = user.getLanguage()==8?"Event Title":"活动名称";	
String Activity_Brief1 = user.getLanguage()==8?"Background":"活动简介";	
String budget = user.getLanguage()==8?"Budget (HKD)":"预算（HKD）";	
String Number_and_category = user.getLanguage()==8?"Participants No. & Category":"参与人数及类别";	
String List_of_participants1 = user.getLanguage()==8?"Participant List":"参会名单（如有）";	
String Expected_results = user.getLanguage()==8?"Expected Outcome":"预计效果（请量化）";	
String Actual_results = user.getLanguage()==8?"Actual Results":"实际效果（请量化）";	
String Held_OR_Attended = user.getLanguage()==8?"Will join or organise again？":"将来还会举办或参加同类型活动";	
String Other_suggestions1 = user.getLanguage()==8?"Other":"其他建议";	
String Activity_photos = user.getLanguage()==8?"Photos ":"活动照片";	
String Related_processes = user.getLanguage()==8?"Relevant EIP/ERP process":"相关活动流程";	
String Upload_other_attachments = user.getLanguage()==8?"Attachments":"其他附件上传";	


String bg=user.getLanguage()==8?"Collaborative Office":"业务发展";
String zc=user.getLanguage()==8?"Daily Administration":"企业/运营商";	
String titlenameS=user.getLanguage()==8?"Company Card Request":"活动报告汇总流程";
//头部信息 
String titlenamePa="<div id='topLogo'><span>"+bg+"</span><span>"+zc+"</span><span>"+titlenameS+"</span></div>";

String searchS=SystemEnv.getHtmlLabelName(20331,user.getLanguage());
String exportExcelS=user.getLanguage()==8?"Confire Export":"确认导出";

String ExportC=SystemEnv.getHtmlLabelName(-10005,user.getLanguage());
String ExportA=SystemEnv.getHtmlLabelName(-10006,user.getLanguage());
//首页
String sy=SystemEnv.getHtmlLabelName(18363,user.getLanguage());
String syy=SystemEnv.getHtmlLabelName(1258,user.getLanguage());
String xyy=SystemEnv.getHtmlLabelName(1259,user.getLanguage());
String wy=SystemEnv.getHtmlLabelName(18362,user.getLanguage());
String tz=SystemEnv.getHtmlLabelName(-9912,user.getLanguage());
String qr=SystemEnv.getHtmlLabelName(16631,user.getLanguage());
String g=SystemEnv.getHtmlLabelName(-9914,user.getLanguage());
String y=SystemEnv.getHtmlLabelName(-9913,user.getLanguage());	
String todoMsg=SystemEnv.getHtmlLabelName(-9988,user.getLanguage());


//获取流程id
//String wfid = property.getString("company_card_workflowid");	
//正式11111 测试 28602
String wfid = Util.null2String(request.getParameter("wid"));
String reqid = Util.null2String(request.getParameter("reqid"));

String detailIndex = Util.null2String(request.getParameter("flags"));
String tablename = "";
String mainTable = DataUtil.getTableName(wfid);
//获取流程对应表单
if(detailIndex.equals("1")){
	tablename = mainTable+"_dt1";	
}else if(detailIndex.equals("3")){
	tablename = mainTable+"_dt3";	
}

String perpage ="10";
String imagefilename = "/images/hdReport_wev8.gif";
String needfav ="1";
String needhelp ="";
%>
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<LINK href="../css/base.css" type=text/css rel=STYLESHEET>
		<LINK href="../css/main.css" type=text/css rel=STYLESHEET>
		<LINK href="/westvalley/css/listTable_css.css" type=text/css rel=STYLESHEET>
		<LINK href="/westvalley/css/tablogo_css.css" type=text/css rel=STYLESHEET>
		<LINK href="/westvalley/MIPreport/css/accoutCss.css" type=text/css rel=STYLESHEET>
		<script language="javascript" src="/js/weaver_wev8.js"></script>
		<SCRIPT language="javascript" defer="defer" src="/js/datetime_wev8.js"></script>
		<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
		
		<script type="text/javascript">
		
		jQuery(document).ready(function(){
			
			
			document.title="<%=titlenameS%>";
			
			var sb=jQuery("select[name='Degree_of_Emergency2']").attr("sb");
			var sbHer=jQuery("#sbHolder_"+sb).attr("style","width: 57%;");
			
			var sbOp=jQuery("#sbOptions_"+sb).attr("style","width: 70%;"); 
			
			//开始渲染样式
			var objS=jQuery("span[class='groupbg']:first");
			objS.css("background-image","url(/westvalley/images/arrow-up.png)");
			
			jQuery("span[class='groupbg']:last").css("background-image","url(/westvalley/images/notebook.png)");
			
			jQuery("span.hideBlockDiv").hide();
			
			jQuery("div[class='e8_boxhead']").height("40px").css("background-image","url(/westvalley/images/topbg1.png)");
			jQuery("#e8_tablogo").hide();
			jQuery("ul[class='tab_menu']").hide();
			jQuery(".LayoutTable:first td.field").css("text-align","left");
			
			jQuery(".LayoutTable:first td.field input").css("width","50%");
			
			//移动位置
			jQuery("#butYu").insertBefore(jQuery("span[class='toolbar']:last"));    //移动节点
			jQuery("span[class='toolbar']:last").hide();
			
			objS.attr("name","1");
			objS.click(function(){
				if(this.name=="1"){
					this.name="2";
					objS.css("background-image","url(/westvalley/images/arrow-down.png)");
					jQuery("tr[class='items intervalTR']:first").hide();
				}else{
					this.name="1";
					jQuery("tr[class='items intervalTR']:first").show();
					objS.css("background-image","url(/westvalley/images/arrow-up.png)");
				}
			});
		});
		
		//重构分页控件
		var pageSiZe=0;
		var pageNum=0;
		function afterDoWhenLoaded(){
			try{
			
				jQuery("td[name='text']").removeAttr("style","");
				jQuery("td[name='text']").attr("style","height: 30px; vertical-align: middle;word-wrap:break-word;word-spacing:normal;  word-break: keep-all; overflow: hidden;");
			
				jQuery(jQuery("#_xTable").find(".table")[0]).attr("style","overflow: auto");
			}catch (e) {
			}
			
			//移除
			var PageInfo=jQuery("div[class='xTable_info'] table tbody tr");
			
			PageInfo.find("td:first").remove();
			PageInfo.find("td").attr("colspan","2");
			PageInfo.find("td div").hide();
			
			//获取总页数
			pageSiZe=(jQuery("span.e8_splitpageinfo span:last").text().split("共")[1]+"").replace("条","")*1.0;
			if(isNaN(pageSiZe)){
				pageSiZe=(jQuery("span.e8_splitpageinfo span:last").text().split("total")[1]+"").replace("Records","")*1.0;
			}
			if(pageSiZe%10!=0){
				pageSiZe=parseInt(pageSiZe/10)+1;
			}else{
				pageSiZe=pageSiZe/10;
			}
			
			//获取当前页数
			pageNum=jQuery("#-weaverTable-0_XTABLE_GOPAGE_buttom").val()*1.0;
			var staNum=1;
			var endNum=10;
			if(pageNum>10&&(pageNum%10!=0)){
				staNum=pageNum-(pageNum%10)+1;
				endNum=(pageNum+(10-(pageNum%10)));
			}else if(pageNum>10&&(pageNum%10==0)){
				staNum=pageNum-9;
				endNum=pageNum;
			}
			
			var pageTxt="<div align=\"center\" id=\"divPager\">"+
							"<span id=\"listGridPager\" class=\"whj_jqueryPaginationCss-1\">"+
							"	<a id=\"listGridPager_lbtFirstPage\" class=\"whj_border whj_padding whj_bgc whj_hover\""+
							"	    href=\"javascript:_table.firstPage()\">"+"<%=sy%>"+"</a>"+
							"	<a id=\"listGridPager_lbtPrevPage\" class=\"whj_border whj_padding whj_bgc whj_hover\""+
							"	    href=\"javascript:_table. prePage()\">"+"<%=syy%>"+"</a>";
							
				for(var k=staNum;k<=endNum;k++){
					if(k<=pageSiZe){
						pageTxt+="	<a id=\"listGridPager_lbtNumPage_"+k+"\" class=\"whj_border whj_padding whj_bgc whj_hover\""+
								"		href=\"javascript:_table.goPage("+k+")\">"+k+"</a>";
					}
				}
				pageTxt+="	 <a id=\"listGridPager_lbtNextPage\" class=\"whj_border whj_padding whj_bgc whj_hover\""+
							"		href=\"javascript:_table. nextPage()\">"+"<%=xyy%>"+"</a>"+
							"<a id=\"listGridPager_lbtLastPage\" class=\"whj_border whj_padding whj_bgc whj_hover\""+
							"		href=\"javascript:_table.lastPage()\">"+"<%=wy%>"+"</a>"+
							"	<span class=\"whj_padding whj_color\">"+"<%=tz%>"+"</span>"+
							"	<input name=\"listGridPager$txtPageIndex\" type=\"text\" value=\""+pageNum+"\" id=\"listGridPager_txtPageIndex\" class=\"whj_border whj_color\" "+
							"	onkeypress=\"entFun(1)\">"+
							"	<input type=\"submit\" onclick=\"entFun(2)\" name=\"listGridPager$btnGotoPage\" value=\""+"<%=qr%>"+"\" id=\"listGridPager_btnGotoPage\" class=\"whj_border whj_padding whj_bgc whj_hover\">"+
							"	<span class=\"whj_padding whj_color\">"+"<%=g%>"+""+pageSiZe+""+"<%=y%>"+"</span>"+
							"</span>"+
						"</div>";
			PageInfo.find("td").append(pageTxt);
			
			//设置选中样式
			jQuery("#listGridPager_lbtNumPage_"+pageNum).attr("class","whj_border whj_padding whj_bgc whj_checked");
			
			
			if(pageNum<=1){
				jQuery("#listGridPager_lbtFirstPage").attr("disabled","disabled");
				jQuery("#listGridPager_lbtFirstPage").attr("class","whj_border whj_padding whj_bgc whj_hoverDisable");
				jQuery("#listGridPager_lbtPrevPage").attr("disabled","disabled");
				jQuery("#listGridPager_lbtPrevPage").attr("class","whj_border whj_padding whj_bgc whj_hoverDisable");
			}
			
			if(pageNum==pageSiZe){
				jQuery("#listGridPager_lbtNextPage").attr("disabled","disabled");
				jQuery("#listGridPager_lbtNextPage").attr("class","whj_border whj_padding whj_bgc whj_hoverDisable");
				jQuery("#listGridPager_lbtLastPage").attr("disabled","disabled");
				jQuery("#listGridPager_lbtLastPage").attr("class","whj_border whj_padding whj_bgc whj_hoverDisable");
			}
		}
		
		function entFun(v){
			var tem=parseInt(jQuery("#listGridPager_txtPageIndex").val()*1);
			if(tem<0||tem>pageSiZe){
				tem=pageNum;
			}
			if (event.keyCode==13&&v=="1") {
				_table.goPage(tem);
			}else if(v=="2"){
				_table.goPage(tem);
			}
		}
	
		//导出
		function exportExcel(){
			var exportExcelS="<%=exportExcelS%>"+"?";
			if(confirm(exportExcelS)){
				_xtable_getAllExcel();
			}
		}
	
		
		function changAcc(obj){
			
		}
		
		function closeFun(){
			jQuery("div[class='accoutListBox']").hide();
			jQuery("div[class='toast']").hide();
		}
	
		
		//function onOpenRequest(reid,wftype){
		//	if(wftype!=""){
		//		window.open("/workflow/request/ViewRequest.jsp?requestid="+reid,"_blank");     
		//	}else{
		//		window.top.Dialog.alert("<%=todoMsg%>");
		//	}
		//}
		function reset1(){
			var status_type = jQuery("select[name='Winners']").attr("sb");
			jQuery("select[name='Winners']").val("");
			jQuery("#sbSelector_"+status_type).html("");
			var status_type = jQuery("select[name='Awarding_Institution']").attr("sb");
			jQuery("select[name='Awarding_Institution']").val("");
			jQuery("#sbSelector_"+status_type).html("");
			
			var status_type = jQuery("select[name='Award_Level']").attr("sb");
			jQuery("select[name='Award_Level']").val("");
			jQuery("#sbSelector_"+status_type).html("");
			
			jQuery("#Draftsmanspan").html("");
			jQuery("#frmmain").find("input").val(""); 
			
		}
		
		
		function downloadPdf(){
			
		}
		function Exe(){
// 			var exportExcelS="<%=exportExcelS%>"+"?";
// 			if(confirm(exportExcelS)){
				_xtable_getAllExcel();
			//}
		}
		function Import(){
			openFullWindowBySelf("/westvalley/report/location/import.jsp?id=-1");
		}
		
		</script>
	</head>
	<BODY>
	
		
			    <div id="butYu" align="right"  style="padding-right: 20px;">
												
						&nbsp;
						<button type="button" onclick="exportExcel()" style="padding: 0px 0pt 1px 18px !important;
						background: url(/westvalley/images/export.png) no-repeat 0pt 2px;">
						<%=user.getLanguage()==8?"Export to Excel":"导出Excel" %>
						</button>
				</div>
				<br>
				<wea:layout type="diycol">
					<wea:group context="<%=titlenameS %>" >
						<wea:item  attributes="{'isTableList':'true','colspan':'full'}">
							<%

							String backfields = "";
							String fromSql = "";
							String orderby = "a.id"; 
							String tableString ="";
							String sqlWhere = " mainid = (select id from "+mainTable+" where requestid = "+reqid+")";
							if("1".equals(detailIndex)){
								backfields ="a.*,s1.selectname as activities_name,s2.selectname as Held_OR_Name,s3.selectname as Exceed_The_Name,"
										+"h2.lastname as Need_to_submiName,h3.departmentname as DeptName,w1.requestname as Related_processesName"; 				
					 			fromSql  = " from  "+tablename +" a   "+
									  " left join  (select distinct ws.selectname, ws.selectvalue from workflow_selectitem ws where ws.fieldid in "+
									  " (select c.id from workflow_base a inner join workflow_bill b on a.formid = b.id inner join workflow_billfield c "+
									  " on c.billid = b.id where a.id = '"+wfid+"'  and c.fieldname = 'Participation_in_activities')) s1"+
									  " on s1.selectvalue = a.Participation_in_activities "+
					
									  " left join  (select distinct ws.selectname, ws.selectvalue from workflow_selectitem ws where ws.fieldid in "+
									  " (select c.id from workflow_base a inner join workflow_bill b on a.formid = b.id inner join workflow_billfield c "+
									  " on c.billid = b.id where a.id = '"+wfid+"'  and c.fieldname = 'Held_OR_Attended')) s2"+
									  " on s2.selectvalue = a.Held_OR_Attended "+
					
									  " left join  (select distinct ws.selectname, ws.selectvalue from workflow_selectitem ws where ws.fieldid in "+
									  " (select c.id from workflow_base a inner join workflow_bill b on a.formid = b.id inner join workflow_billfield c "+
									  " on c.billid = b.id where a.id = '"+wfid+"'  and c.fieldname = 'Exceed_The_Submission_Date')) s3"+
									  " on s3.selectvalue = a.Exceed_The_Submission_Date "+
							
									  " left join hrmresource h2 on h2.id = a.Need_to_submit_a_report    "+
									  " left join hrmdepartment h3 on h3.id = a.Dept  "+
									  " left join workflow_requestbase w1 on w1.requestid = a.Related_processes  ";
					 			tableString =" <table pagesize=\""+perpage+"\"  tabletype=\"none\">"+
										" <sql backfields=\""+backfields+"\"    sqlform=\""+fromSql+"\" sqlwhere=\""+sqlWhere+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
										"	<head>"+
												//报告人						
												"<col width=\"120px\"  name=\"text\" text=\""+Need_to_submit_a_report+"\" column=\"Need_to_submiName\" orderkey=\"Need_to_submit_a_report\" />"+
												//是否有活动-->
												"<col width=\"120px\"  name=\"text\" text=\""+Participation_in_activities+"\" column=\"activities_name\" orderkey=\"Participation_in_activities\" />"+
												//是否超出呈报日期-->
												"<col width=\"120px\"  name=\"text\" text=\""+Exceed_The_Submission_Date+"\" column=\"Exceed_The_Name\" orderkey=\"Exceed_The_Submission_Date\" />"+
												//部门-->
												"<col width=\"120px\"  name=\"text\" text=\""+Dept+"\" column=\"DeptName\" orderkey=\"Dept\" />"+
												//活动发生日期-->
												"<col width=\"120px\"  name=\"text\" text=\""+Date_of_activity+"\" column=\"Date_of_activity\" orderkey=\"Date_of_activity\" />"+
												//报告收集日期-->
												"<col width=\"120px\"  name=\"text\" text=\""+Launch_date+"\" column=\"Launch_date\" orderkey=\"Launch_date\" />"+
												//活动名称-->		
												"<col width=\"120px\"  name=\"text\" text=\""+Event_Title+"\" column=\"Event_Title\" orderkey=\"Event_Title\" />"+
												//活动简介-->
												"<col width=\"120px\"  name=\"text\" text=\""+Activity_Brief1+"\" column=\"Activity_Brief1\" orderkey=\"Activity_Brief1\" />"+
												//预算（HKD）-->
												"<col width=\"120px\"  name=\"text\" text=\""+budget+"\" column=\"budget\" orderkey=\"budget\" />"+
												//参与人数及类别-->
												"<col width=\"120px\"  name=\"text\" text=\""+Number_and_category+"\" column=\"Number_and_category\" orderkey=\"Number_and_category\" />"+
												//参会名单（如有）-->
												//"<col width=\"120px\"  name=\"text\" text=\""+List_of_participants1+"\" column=\"List_of_participants1\" transmethod=\"weaversj.workflow.activity.WorkflowMethodUtil.getImageFileName\" orderkey=\"List_of_participants1\" />"+
												//预计效果（请量化）-->
												"<col width=\"120px\"  name=\"text\" text=\""+Expected_results+"\" column=\"Expected_results\" orderkey=\"Expected_results\" />"+
												//实际效果（请量化））-->
												"<col width=\"120px\" name=\"text\"  text=\""+Actual_results+"\" column=\"Actual_results\" orderkey=\"Actual_results\" />"+
												//将来还会举办或参加同类型活动-->
												"<col width=\"120px\"  name=\"text\" text=\""+Held_OR_Attended+"\" column=\"Held_OR_Name\" orderkey=\"Held_OR_Attended\" />"+
												//其他建议）-->
												"<col width=\"200px\"  name=\"text\" text=\""+Other_suggestions1+"\" column=\"Other_suggestions1\" orderkey=\"Other_suggestions1\" />"+
												//活动照片-->
												//"<col width=\"130px\"  name=\"text\" text=\""+Activity_photos+"\" column=\"Activity_photos\" transmethod=\"weaversj.workflow.activity.WorkflowMethodUtil.getImageFileName\" orderkey=\"Activity_photos\" />"+
												//相关活动流程-->
												"<col width=\"120px\"  name=\"text\" text=\""+Related_processes+"\" column=\"Related_processesName\" orderkey=\"Related_processes\" />"+
												//其他附件上传-->
												//"<col width=\"120px\"  name=\"text\" text=\""+Upload_other_attachments+"\" transmethod=\"weaversj.workflow.activity.WorkflowMethodUtil.getImageFileName\" column=\"Upload_other_attachments\" orderkey=\"Upload_other_attachments\" />"+
										"</head>";
										tableString+="</table>";
							}else{

								backfields ="a.*,s1.selectname as activities_name,s2.selectname as Held_OR_Name,s3.selectname as Exceed_The_Name,"
										+"h2.lastname as Need_to_submiName,h3.departmentname as DeptName,w1.requestname as Related_processesName"; 				
					 			fromSql  = " from  "+tablename +" a   "+
									  " left join  (select distinct ws.selectname, ws.selectvalue from workflow_selectitem ws where ws.fieldid in "+
									  " (select c.id from workflow_base a inner join workflow_bill b on a.formid = b.id inner join workflow_billfield c "+
									  " on c.billid = b.id where a.id = '"+wfid+"'  and c.fieldname = 'Participation_in_activities')) s1"+
									  " on s1.selectvalue = a.Participation_in_activities "+
					
									  " left join  (select distinct ws.selectname, ws.selectvalue from workflow_selectitem ws where ws.fieldid in "+
									  " (select c.id from workflow_base a inner join workflow_bill b on a.formid = b.id inner join workflow_billfield c "+
									  " on c.billid = b.id where a.id = '"+wfid+"'  and c.fieldname = 'Held_OR_Attended')) s2"+
									  " on s2.selectvalue = a.Held_OR_Attended "+
					
									  " left join  (select distinct ws.selectname, ws.selectvalue from workflow_selectitem ws where ws.fieldid in "+
									  " (select c.id from workflow_base a inner join workflow_bill b on a.formid = b.id inner join workflow_billfield c "+
									  " on c.billid = b.id where a.id = '"+wfid+"'  and c.fieldname = 'Exceed_The_Submission_Date')) s3"+
									  " on s3.selectvalue = a.Exceed_The_Submission_Date "+
							
									  " left join hrmresource h2 on h2.id = a.notified_person    "+
									  " left join hrmdepartment h3 on h3.id = a.Dept  "+
									  " left join workflow_requestbase w1 on w1.requestid = a.Related_processes  ";
					 			tableString =" <table pagesize=\""+perpage+"\"  tabletype=\"none\">"+
										" <sql backfields=\""+backfields+"\"    sqlform=\""+fromSql+"\" sqlwhere=\""+sqlWhere+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
										"	<head>"+
												//报告人						
												"<col width=\"120px\"  name=\"text\" text=\""+Need_to_submit_a_report+"\" column=\"Need_to_submiName\" orderkey=\"Need_to_submit_a_report\" />"+
												//是否有活动-->
												"<col width=\"120px\"  name=\"text\" text=\""+Participation_in_activities+"\" column=\"activities_name\" orderkey=\"Participation_in_activities\" />"+
												//是否超出呈报日期-->
												"<col width=\"120px\"  name=\"text\" text=\""+Exceed_The_Submission_Date+"\" column=\"Exceed_The_Name\" orderkey=\"Exceed_The_Submission_Date\" />"+
												//部门-->
												"<col width=\"120px\"  name=\"text\" text=\""+Dept+"\" column=\"DeptName\" orderkey=\"Dept\" />"+
												//活动发生日期-->
												"<col width=\"120px\"  name=\"text\" text=\""+Date_of_activity+"\" column=\"Date_of_activity\" orderkey=\"Date_of_activity\" />"+
												//报告收集日期-->
												"<col width=\"120px\"  name=\"text\" text=\""+Launch_date+"\" column=\"Launch_date\" orderkey=\"Launch_date\" />"+
												//活动名称-->		
												"<col width=\"120px\"  name=\"text\" text=\""+Event_Title+"\" column=\"Event_Title\" orderkey=\"Event_Title\" />"+
												//活动简介-->
												"<col width=\"120px\"  name=\"text\" text=\""+Activity_Brief1+"\" column=\"Activity_Brief1\" orderkey=\"Activity_Brief1\" />"+
												//预算（HKD）-->
												"<col width=\"120px\"  name=\"text\" text=\""+budget+"\" column=\"budget\" orderkey=\"budget\" />"+
												//参与人数及类别-->
												"<col width=\"120px\"  name=\"text\" text=\""+Number_and_category+"\" column=\"Number_and_category\" orderkey=\"Number_and_category\" />"+
												//参会名单（如有）-->
												//"<col width=\"120px\"  name=\"text\" text=\""+List_of_participants1+"\" column=\"List_of_participants1\" transmethod=\"weaversj.workflow.activity.WorkflowMethodUtil.getImageFileName\" orderkey=\"List_of_participants1\" />"+
												//预计效果（请量化）-->
												"<col width=\"120px\"  name=\"text\" text=\""+Expected_results+"\" column=\"Expected_results\" orderkey=\"Expected_results\" />"+
												//实际效果（请量化））-->
												"<col width=\"120px\"  name=\"text\" text=\""+Actual_results+"\" column=\"Actual_results\" orderkey=\"Actual_results\" />"+
												//将来还会举办或参加同类型活动-->
												"<col width=\"120px\"  name=\"text\" text=\""+Held_OR_Attended+"\" column=\"Held_OR_Name\" orderkey=\"Held_OR_Attended\" />"+
												//其他建议）-->
												"<col width=\"200px\"  name=\"text\" text=\""+Other_suggestions1+"\" column=\"Other_suggestions1\" orderkey=\"Other_suggestions1\" />"+
												//活动照片-->
												//"<col width=\"130px\"  name=\"text\" text=\""+Activity_photos+"\" column=\"Activity_photos\" transmethod=\"weaversj.workflow.activity.WorkflowMethodUtil.getImageFileName\" orderkey=\"Activity_photos\" />"+
												//相关活动流程-->
												"<col width=\"120px\"  name=\"text\" text=\""+Related_processes+"\" column=\"Related_processesName\" orderkey=\"Related_processes\" />"+
												//其他附件上传-->
												//"<col width=\"120px\"  name=\"text\" text=\""+Upload_other_attachments+"\" transmethod=\"weaversj.workflow.activity.WorkflowMethodUtil.getImageFileName\" column=\"Upload_other_attachments\" orderkey=\"Upload_other_attachments\" />"+
										"</head>";
										tableString+="</table>";
							}

						
						%>
							<wea:SplitPageTag  tableString="<%=tableString%>" mode="run" />
						</wea:item>
					</wea:group>
				</wea:layout>
	</body>
</HTML>