<%@page import="java.util.Iterator"%>
<%@page import="weaver.login.Account"%>
<%@page import="weaver.hrm.resource.ResourceComInfo"%>
<%@page import="weaver.hrm.job.JobTitlesComInfo"%>
<%@page import="weaver.hrm.company.DepartmentComInfo"%>
<%@page import="weaver.hrm.company.SubCompanyComInfo"%>
<%@page import="weaver.hrm.HrmUserVarify"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="weaver.hrm.OnLineMonitor"%>
<%@page import="java.util.List"%>
<%@page import="weaver.login.VerifyLogin"%>
<%@page import="weaver.general.BaseBean"%>
<%@page import="weaver.hrm.User"%>
<%@page import="weaver.file.Prop"%>
<%@page import="com.westvalley.util.DataUtil"%>
<%@page import="weaver.conn.RecordSet"%>
<%@page language="java" contentType="text/html; charset=UTF-8" %> 
<%@page import="weaver.general.Util" %>
<%@page import="com.westvalley.util.LogTool"%>
<%@include file="/hrm/header.jsp" %>
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
	
	ResourceBundle property = ResourceBundle.getBundle("weaversj.workflow_base");
	if(!baseUtil.getCheckRoleResource("公司名片申请权限", user_new.getUID())){
		strsql = " and (a.Draft_man ='"+userid+"' or a.Business_card_user = '"+userid+"')";
	}
	
	String Request_NoS = user.getLanguage()==8?"Application No":"申请编号";	
	String requestname = user.getLanguage()==8?"requestname":"标题";	
	String DrafterS = user.getLanguage()==8?"Drafter":"拟稿人";	
	String Create_DateS = user.getLanguage()==8?"Application":"起草日期";
	String status = user.getLanguage()==8?"status":"申请状态";	
	String Business_card_user = user.getLanguage()==8?"Business card user":"名片使用者";	
	String Number_of_applications = user.getLanguage()==8?"Number of applications":"申请数量";	
	String Department_or_department = user.getLanguage()==8?"Division/Region":"部/地区";	

	
	String bg=user.getLanguage()==8?"Collaborative Office":"协同办公";
	String zc=user.getLanguage()==8?"Daily Administration":"日常行政";	
	String titlenameS=user.getLanguage()==8?"Company Card Request":"公司名片申请";

	//头部信息 
	String titlenamePa="<div id='topLogo'><span>"+bg+"</span><span>"+zc+"</span><span>"+titlenameS+"</span></div>";
	
	String searchS=SystemEnv.getHtmlLabelName(20331,user.getLanguage());
	String exportExcelS=user.getLanguage()==8?"Confire Export":"确认导出";
	String nodataS=user.getLanguage()==8?"Please Check the Box":"请勾选数据";
	String delS=user.getLanguage()==8?"confire delete":"确认删除";
	String delF=user.getLanguage()==8?"Dlete Fail":"删除失败";
	
	String ExportC=SystemEnv.getHtmlLabelName(-10005,user.getLanguage());
	String ExportA=SystemEnv.getHtmlLabelName(-10006,user.getLanguage());
	//不可同时删除多条数据
	String noMore=SystemEnv.getHtmlLabelName(-9928,user.getLanguage());
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
	String wfid = "11111";
	//获取流程对应表单
	String tablename = DataUtil.getTableName(wfid);	
	
	//查询是否有主从账户
	String accids="";
	List accounts =(List)session.getAttribute("accounts");
	boolean isBelongto=false;
	if(accounts!=null&&accounts.size()>1){
		isBelongto=true;
		Iterator iter=accounts.iterator();
		while(iter.hasNext()){
			Account a=(Account)iter.next();
			if("".equals(accids)){
				accids=a.getId()+"";
			}else{
				accids+=","+a.getId();
			}
		}
		userid=accids;
	}	
	String sqlWhere = " where 1=1 and  b.requestid is not null "+strsql;
	String perpage ="10";
	String imagefilename = "/images/hdReport_wev8.gif";
	String needfav ="1";
	String needhelp ="";
	
	//标题	
	String str1 = Util.null2String(request.getParameter("requestname"));
	if(!str1.equals("")){
		sqlWhere+=" and b.requestname like '%"+str1+"%' ";
	}
	//起草人	
	String lastname = Util.null2String(request.getParameter("lastname"));
	if(!lastname.equals("")){
		sqlWhere+=" and a.Draft_man = '"+lastname+"' ";
	} 
	//拟稿日期	
	String Create_Date = Util.null2String(request.getParameter("Create_Date"));
	if(!Create_Date.equals("")){
		sqlWhere+=" and a.Draft_ate = '"+Create_Date+"' ";
	} 
	
	//名片使用者	
	String Business_card_user_s = Util.null2String(request.getParameter("Business_card_user"));
	if(!Business_card_user_s.equals("")){
		sqlWhere+=" and a.Business_card_user = '"+Business_card_user_s+"' ";
	} 
	// 区/部门	
	String Department_or_department_s = Util.null2String(request.getParameter("Department_or_department"));
	if(!Department_or_department_s.equals("")){
		sqlWhere+=" and a.Department_or_department = '"+Department_or_department_s+"' ";
	}
	//申请数量 	
	String Number_of_applications_s = Util.null2String(request.getParameter("Number_of_applications"));
	if(!Number_of_applications_s.equals("")){
		sqlWhere+=" and a.Number_of_applications = '"+Number_of_applications_s+"' ";
	}	
		
	//申请编号	
	String Request_No = Util.null2String(request.getParameter("Request_No"));
	if(!Request_No.equals("")){
		sqlWhere+=" and a.Application_number like '%"+Request_No+"%' ";
	}
	//申请状态
	String type = Util.null2String(request.getParameter("type"));
	if(!type.equals("")){
		if("1".equals(type)){
			sqlWhere+=" and b.currentnodetype in ('1','2')  ";
		}
	/*	else if("4".equals(type)){
			sqlWhere+=" and b.status ='强制归档'  ";
		}*/
		else{
			sqlWhere+=" and b.currentnodetype = '"+type+"' ";

		}
	} 
	
	    
    

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
							"	    href=\"javascript:_table.firstPage()\"><%=sy%></a>"+
							"	<a id=\"listGridPager_lbtPrevPage\" class=\"whj_border whj_padding whj_bgc whj_hover\""+
							"	    href=\"javascript:_table. prePage()\"><%=syy%></a>";
							
				for(var k=staNum;k<=endNum;k++){
					if(k<=pageSiZe){
						pageTxt+="	<a id=\"listGridPager_lbtNumPage_"+k+"\" class=\"whj_border whj_padding whj_bgc whj_hover\""+
								 "	href=\"javascript:_table.goPage("+k+")\">"+k+"</a>";
					}
				}
			   pageTxt+="<a id=\"listGridPager_lbtNextPage\" class=\"whj_border whj_padding whj_bgc whj_hover\""+
						"		href=\"javascript:_table. nextPage()\"><%=xyy%></a>"+
						"<a id=\"listGridPager_lbtLastPage\" class=\"whj_border whj_padding whj_bgc whj_hover\""+
						"		href=\"javascript:_table.lastPage()\"><%=wy%></a>"+
						"<span class=\"whj_padding whj_color\"><%=tz%></span>"+
						"<input name=\"listGridPager$txtPageIndex\" type=\"text\" value=\""+pageNum+"\" id=\"listGridPager_txtPageIndex\" class=\"whj_border whj_color\" "+
						"	onkeypress=\"entFun(1)\">"+
						"<input type=\"submit\" onclick=\"entFun(2)\" name=\"listGridPager$btnGotoPage\" value=\"<%=qr%>\" id=\"listGridPager_btnGotoPage\" class=\"whj_border whj_padding whj_bgc whj_hover\">"+
						"<span class=\"whj_padding whj_color\"><%=g%>"+pageSiZe+"<%=y%></span>"+
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
		
		//搜索
		function onSubmit() {
		
			document.frmmain.submit();  
		}
		
		//重置
		function onReset(){

			jQuery("#frmmain").find("input").val("");//重置 所有
		}
		//导出
		function exportExcel(){
			var exportExcelS="<%=exportExcelS%>"+"?";
			if(confirm(exportExcelS)){
				_xtable_getAllExcel();
			}
		}
		
		function onAdd(){		
			window.open("/workflow/request/AddRequest.jsp?isagent=0&beagenter=0&f_weaver_belongto_userid=&workflowid=<%=wfid%>","_blank");     	
		}

		//新增
		function changAcc(obj){
			jQuery("div[class='accoutListBox']").hide();
			jQuery("div[class='toast']").hide();
			
			jQuery.ajax({
				type: "post", 
				url: "/westvalley/barrier/ITService/ITServiceReport/IdentityShift.jsp?shiftid="+jQuery(obj).attr("userid"), 
				dataType:  "json" , 
				success: function(data){
					if(data.sta =="0"){
						window.open("/workflow/request/AddRequest.jsp?isagent=0&beagenter=0&f_weaver_belongto_userid=&workflowid=<%=wfid%>","_blank");     
						onSubmit();
					} 
				} ,
				error:function(data){
					var t=data;
				}
			});
		}
		
		function closeFun(){
			jQuery("div[class='accoutListBox']").hide();
			jQuery("div[class='toast']").hide();
		}


		</script>
	</head>
	<BODY>		
		<%
			if(isBelongto){
				Iterator iter=accounts.iterator();
				
		%>
		<div class="accoutListBox" style="max-height: 600px; overflow: hidden; outline: none;">
			<%
			SubCompanyComInfo SubCompanyComInfo=new SubCompanyComInfo(); 
			DepartmentComInfo DepartmentComInfo=new DepartmentComInfo(); 
			JobTitlesComInfo JobTitlesComInfo=new JobTitlesComInfo(); 
			ResourceComInfo ResourceComInfo=new ResourceComInfo();
			
			while(iter.hasNext()){
				Account a=(Account)iter.next();
				if("".equals(accids)){
					accids=a.getId()+"";
				}else{
					accids+=","+a.getId();
				}
				String subcompanyname=SubCompanyComInfo.getSubCompanyname(""+a.getSubcompanyid());
              	String departmentname=DepartmentComInfo.getDepartmentname(""+a.getDepartmentid());
            	String jobtitlename=JobTitlesComInfo.getJobTitlesname(""+a.getJobtitleid());  
            	String userName = ResourceComInfo.getResourcename(""+a.getId());
			%>
			<div class="accountItem " userid="<%=a.getId()%>" onclick="changAcc(this)">
					<div class="accountText">
						<font color="#363636" title="<%=userName %>">
							<%=userName%>
						</font>&nbsp;&nbsp;&nbsp;&nbsp;
						<font color="#0071ca" title="<%=jobtitlename %>">
							<%=jobtitlename %>
						</font>
						<br>
						<font color="#868686"  title="<%=subcompanyname +"/"+departmentname %>">
							<%=subcompanyname +"/"+departmentname %>
						</font>
					</div >
					
					<div class="accountIcon">
					<%if(temUserid.equals(a.getId()+"")){ %>
						<img style="width: 16px;height: 16px;vertical-align: middle;" src="/images/check.png">
					<%} %>
					</div>
					<div style="clear:both;"></div>
			</div>
			<div style="background-color:#d4d4d4;height:1px;width:298px;"></div>   
			<%
			}
			%>  
		</div>
		<div class="toast" onclick="closeFun()"></div>
		<%
			}
		%>

		<jsp:include page="/systeminfo/commonTabHead.jsp">
		   <jsp:param name="mouldID" value="assest"/>
		   <jsp:param name="navName" value="<%=titlenamePa%>"/>
		</jsp:include>
		
		<form id="frmmain" name=frmmain method=post action="list.jsp" >
		
				<wea:layout type="4col">
				<wea:group context="<%=user.getLanguage()==8?"Search":"查询" %>">
					<wea:item attributes="{\"colspan\":\"4\"}">
						<table id="row_table">
							<tr>						
								<td class="title_td"><%=requestname %></td><!-- 标题 -->	
								<td class="conner_td">
									<input type="text" name="requestname" id="requestname" />
								</td>
																
								<td class="title_td"><%=DrafterS%></td><!-- 起草人 -->							
								<td class="conner_td" >
									<brow:browser viewType="0"  name="lastname" browserValue=""
									   browserurl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?f_weaver_belongto_userid=1&f_weaver_belongto_usertype=0"  
									   hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
									    width="100%">
									 </brow:browser>
								</td>	
																			
								<td class="title_td"><%=Create_DateS %></td><!-- 拟稿日期   -->								
								<td class="conner_td">
									 <input id="Create_Date" name="Create_Date" type="text"  readonly="true"  
									 onfocus="WdatePicker({isShowClear:false,dateFmt: 'yyyy-MM-dd'})" class="Wdate"/>
							    </td>												
							</tr>
							<tr>			
										
								<td class="title_td"><%=Business_card_user %></td><!-- 名片使用者 -->	
								<td class="conner_td">
									<brow:browser viewType="0"  name="Business_card_user" browserValue=""
									   browserurl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?f_weaver_belongto_userid=1&f_weaver_belongto_usertype=0"  
									   hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
									    width="100%">
									 </brow:browser>
								</td>
																
								<td class="title_td"><%=Department_or_department%></td><!-- 区/部门 -->							
								<td class="conner_td" >
									<brow:browser viewType="0"  name="Department_or_department" browserValue=""
									   browserurl="/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp"  
									   hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
									    width="100%">
									 </brow:browser>
								</td>	
																			
								<td class="title_td"><%=Number_of_applications %></td><!-- 申请数量  -->								
								<td class="conner_td">
									<select notbeauty="true" class="Inputstyle" style="height:auto;" 
											id="Number_of_applications" name="Number_of_applications" >
										<option value=""></option>
											<%
												RecordSet rs02 = new RecordSet();
											rs02.execute("select distinct ws.selectname, ws.selectvalue from workflow_selectitem ws where ws.fieldid in "+
														 "  (select c.id from workflow_base a inner join workflow_bill b on a.formid = b.id inner join workflow_billfield c "+
														 "  on c.billid = b.id where a.id = '"+wfid+"'  and c.fieldname = 'Number_of_applications') order by selectvalue ");
												while(rs02.next()){
											%>
													<option value=<%= Util.null2String(rs02.getString("selectvalue"))%>><%=Util.null2String(rs02.getString("selectname")) %></option>
											<% 
												}
											%>
									</select>							   
								 </td>												
							</tr>						
							<tr>
								<td class="title_td"><%=Request_NoS %></td><!-- 申请编号-->	
								<td class="conner_td">
									<input type="text" name="Request_No" id="Request_No" />
								</td>
								<td class="title_td"><%=status %></td><!-- 申请状态-->	
								<td class="conner_td">
									<select notbeauty="true" class="Inputstyle" style="height:auto;" 
											id="type" name="type" >
										<option value=""></option>
										<option value="0">草稿</option>
										<option value="1">进行中</option>
										<option value="3">已完成</option>
										<!-- <option value="4">强制归档</option> -->
									</select>
								</td>						
							</tr>
					
														
						</table>
					</wea:item>
					<wea:item attributes="{\"id\":\"ss\",\"colspan\":\"4\"}">
						<div class="fr">
							<button id="btnQueryID" title="<%=SystemEnv.getHtmlLabelName(527,user.getLanguage()) %>" onclick="onSubmit()" class="commonButton " type="button" ><%=SystemEnv.getHtmlLabelName(527,user.getLanguage()) %></button>
							<button id="clear" title="<%=SystemEnv.getHtmlLabelName(27088,user.getLanguage()) %>" onclick="onReset()" class="clearButton" type="button"><%=SystemEnv.getHtmlLabelName(27088,user.getLanguage()) %></button>
						</div>
					</wea:item>
				</wea:group>
			</wea:layout>

		</form>
				<div id="butYu" align="right"  style="padding-right: 20px;">
				
						<button type="button" onclick="onAdd()" style="padding: 0px 0pt 1px 18px !important;
						background: url(/westvalley/images/add.png) no-repeat 0pt 2px;" class="x-btn-text add">
						<%=user.getLanguage()==8?"Add":"新增" %>
						</button>									
						&nbsp;
						<button type="button" onclick="exportExcel()" style="padding: 0px 0pt 1px 18px !important;
						background: url(/westvalley/images/export.png) no-repeat 0pt 2px;">
						<%=user.getLanguage()==8?"Export to Excel":"导出Excel" %>
						</button>
				</div>
				<br>
		<wea:layout type="diycol">
			<wea:group context="<%=SystemEnv.getHtmlLabelName(-9920,user.getLanguage()) %>" >
				<wea:item  attributes="{'isTableList':'true','colspan':'full'}">
			<%
				
				String backfields =" h1.lastname as Business_card_user_name,h2.lastname as Draft_man_name,s1.selectname as Number_of_applications_name,h3.departmentname as Department_or_department_name,  b.requestname,b.status, "+
						" (case when b.status='强制归档' then '强制归档' when b.currentnodetype='0' then '草稿' when b.currentnodetype='1' then '进行中' when b.currentnodetype='2' then '进行中' "+
						" when b.currentnodetype='3' then '已完成' else '' end) as type ,a.*  "; 				
				String fromSql  = " from  "+tablename +" a   "+
								  " left join workflow_requestbase  b on a.requestid=b.requestid   "+
								  " left join hrmresource h1 on h1.id = a.Business_card_user    "+
								  " left join hrmresource h2 on h2.id = a.Draft_man    "+
								  " left join hrmdepartment h3 on h3.id = a.Department_or_department  "+
								  
								  " left join  (select distinct ws.selectname, ws.selectvalue from workflow_selectitem ws where ws.fieldid in "+
								  " (select c.id from workflow_base a inner join workflow_bill b on a.formid = b.id inner join workflow_billfield c "+
								  " on c.billid = b.id where a.id = '"+wfid+"'  and c.fieldname = 'Number_of_applications')) s1"+
								  " on s1.selectvalue = a.Number_of_applications "
								  ;

				String orderby = ""; 
							
				String tableString =" <table pagesize=\""+perpage+"\"  tabletype=\"checkbox\">"+
						" <sql backfields=\""+backfields+"\"    sqlform=\""+fromSql+"\" sqlwhere=\""+sqlWhere+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"a.Draft_ate\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
						"	<head>"+
								//标题							
								"<col width=\"200px\"  text=\""+requestname+"\"  column=\"requestname\"  orderkey=\"requestname\" href=\"/workflow/request/ViewRequest.jsp\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"/>"+									
	
								//申请编号
								"<col width=\"120px\"  text=\""+Request_NoS+"\" column=\"Application_number\" orderkey=\"Application_number\" />"+
						        //拟稿人
								"<col width=\"120px\"  text=\""+DrafterS+"\" column=\"Draft_man_name\" orderkey=\"Draft_man_name\" />"+
								//起草日期		 											
								"<col width=\"120px\"  text=\""+Create_DateS+"\" column=\"Draft_ate\"  orderkey=\"Draft_ate\"/>"+									
								//名片申请人					
								"<col width=\"120px\"  text=\""+Business_card_user+"\" column=\"Business_card_user_name\" orderkey=\"Business_card_user_name\"/>"+
								//部门/地区
								"<col width=\"120px\"  text=\""+Department_or_department+"\" column=\"Department_or_department_name\" orderkey=\"Department_or_department_name\" />"+
								//申请数量
								"<col width=\"120px\"  text=\""+Number_of_applications+"\" column=\"Number_of_applications_name\" orderkey=\"Number_of_applications_name\" />"+
						     	//申请状态
						        "<col width=\"120px\"  text=\""+status+"\" column=\"type\" orderkey=\"type\" />"+
							
						"</head>";
			tableString+="</table>";
			
			%>
			<wea:SplitPageTag  tableString="<%=tableString%>" mode="run" />
				</wea:item>
			</wea:group>
		</wea:layout>		
	</body>
</HTML>