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

/**
*	说明：新增角色--》合规处罚意向书权限
*   workflowid：
*/
WeaverSJUtil wUtil = new WeaverSJUtil();
	//获取当前用户
	User user_new = (User)request.getSession(true).getAttribute("weaver_user@bean");	
	String userid = user_new.getUID()+"";	
	String temUserid = user_new.getUID()+"";
	
	BaseUtil baseUtil = new BaseUtil();
	String strsql = "";
	
	ResourceBundle property = ResourceBundle.getBundle("weaversj.workflow_base");
	if(!baseUtil.getCheckRoleResource("合规处罚意向书权限", user_new.getUID())){
		strsql = " and (a.Create_by ='"+userid+"' )";
	}
	
	
			
			
	
	String Number = user.getLanguage()==8?"Number":"流程编号";	
	String Create_by = user.getLanguage()==8?"Create by":"起草人";	
	String Company_Entity = user.getLanguage()==8?"Company":"公司";	
	String Create_date = user.getLanguage()==8?"Create date":"创建日期";
	String Title = user.getLanguage()==8?"Title":"意向书标题";	
	String Procurement_Entity = user.getLanguage()==8?"Procurement Entity":"被处罚部门";	
	
	String bg=user.getLanguage()==8?"Collaborative Office":"战略综合";
	String zc=user.getLanguage()==8?"Daily Administration":"合规管理";	
	String titlenameS=user.getLanguage()==8?"Compliance penalty letter of intent process":"合规处罚意向书";

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
	//正式      测试 53618
	String wfid = "53618";
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
	
	

	//编号
	String str1 = Util.null2String(request.getParameter("Number"));
	if(!str1.equals("")){
		sqlWhere+=" and a.Number like '%"+str1+"%' ";
	}
	//起草人	
	String lastname = Util.null2String(request.getParameter("lastname"));
	if(!lastname.equals("")){
		sqlWhere+=" and a.Create_by = '"+lastname+"' ";
	} 
	//拟稿日期	
	String Create_Dates = Util.null2String(request.getParameter("Create_Date"));
	if(!Create_Dates.equals("")){
		sqlWhere+=" and a.Create_Date = '"+Create_Dates+"' ";
	} 
	
	//标题	
	String Title_req = Util.null2String(request.getParameter("Title"));
	if(!Title_req.equals("")){
		sqlWhere+=" and a.Title like '%"+Title_req+"%' ";
	} 
	
	// 区/部门	
	String Department_or_department_s = Util.null2String(request.getParameter("Procurement_Entity"));
	if(!Department_or_department_s.equals("")){
		sqlWhere+=" and a.Procurement_Entity = '"+Department_or_department_s+"' ";
	}
	
	//公司	
	String Company_Entity_req = Util.null2String(request.getParameter("Company_Entity"));
	if(!Company_Entity_req.equals("")){
		sqlWhere+=" and a.Company_Entity = '"+Company_Entity_req+"' ";
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
								<td class="title_td"><%=Create_by%></td><!-- 起草人 -->							
								<td class="conner_td" >
									<brow:browser viewType="0"  name="lastname" browserValue=""
									   browserurl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?f_weaver_belongto_userid=1&f_weaver_belongto_usertype=0"  
									   hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
									    width="100%">
									 </brow:browser>
								</td>	
																			
								<td class="title_td"><%=Create_date %></td><!-- 拟稿日期   -->								
								<td class="conner_td">
									 <input id="Create_Date" name="Create_Date" type="text"  readonly="true"  
									 onfocus="WdatePicker({isShowClear:false,dateFmt: 'yyyy-MM-dd'})" class="Wdate"/>
							    </td>	
							    
							    <td class="title_td"><%=Company_Entity%></td><!-- 公司 -->							
								<td class="conner_td" >
									<brow:browser viewType="0"  name="Company_Entity" browserValue=""
									   browserurl="/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp"  
									   hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
									    width="100%">
									 </brow:browser>
								</td>												
							</tr>
							<tr>			
										
								<td class="title_td"><%=Title %></td><!-- 名片使用者 -->	
								<td class="conner_td">
									<input type="text" name="Title" id="Title" />
								</td>
																
								<td class="title_td"><%=Procurement_Entity%></td><!-- 区/部门 -->							
								<td class="conner_td" >
									<brow:browser viewType="0"  name="Procurement_Entity" browserValue=""
									   browserurl="/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp"  
									   hasInput="true" isSingle="true" hasBrowser = "true" isMustInput='1'
									    width="100%">
									 </brow:browser>
								</td>	
																			
								<td class="title_td"><%=Number %></td><!-- 申请编号-->	
								<td class="conner_td">
									<input type="text" name="Number" id="Number" />
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
				
				String backfields =" a.*,h1.lastname as CreateName,h2.SUBCOMPANYNAME as  CompanyName,h3.departmentname as ProcurementName  "; 				
				String fromSql  = " from  "+tablename +" a   "+
								  " left join workflow_requestbase  b on a.requestid=b.requestid "+
								  " left join hrmresource h1 on h1.id = a.Create_by    "+
								  " left join hrmsubcompany h2 on h2.id = a.Company_Entity    "+
								  " left join hrmdepartment h3 on h3.id = a.Procurement_Entity  " ;
				
				String orderby = ""; 
							
				wUtil.logWrites("backfields:"+backfields);
				wUtil.logWrites("fromSql:"+fromSql);
				wUtil.logWrites("sqlWhere:"+sqlWhere);

				String tableString =" <table pagesize=\""+perpage+"\"  tabletype=\"checkbox\">"+
						" <sql backfields=\""+backfields+"\"    sqlform=\""+fromSql+"\" sqlwhere=\""+sqlWhere+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"b.requestid\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
						"	<head>"+
								//编号							
								"<col width=\"200px\"  text=\""+Number+"\"  column=\"Number\"  orderkey=\"Number\"  href=\"/workflow/request/ViewRequest.jsp\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"/>"+									
						        //拟稿人
								"<col width=\"120px\"  text=\""+Create_by+"\" column=\"CreateName\" orderkey=\"CreateName\" />"+
								//公司		 											
								"<col width=\"120px\"  text=\""+Company_Entity+"\" column=\"CompanyName\"  orderkey=\"CompanyName\"/>"+									

								//起草日期
								"<col width=\"120px\"  text=\""+Create_date+"\" column=\"Create_date\" orderkey=\"Create_date\" />"+
								//起草日期		 											
								"<col width=\"120px\"  text=\""+Title+"\" column=\"Title\"  orderkey=\"Title\"/>"+									
								//标题					
								"<col width=\"120px\"  text=\""+Procurement_Entity+"\" column=\"ProcurementName\" orderkey=\"ProcurementName\"/>"+
								//部门/地区
							
						"</head>";
			tableString+="</table>";
			
			%>
			<wea:SplitPageTag  tableString="<%=tableString%>" mode="run" />
				</wea:item>
			</wea:group>
		</wea:layout>		
	</body>
</HTML>