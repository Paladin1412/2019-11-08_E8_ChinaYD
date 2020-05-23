
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="net.sf.json.JSONArray" %>

<%@ page import="weaver.general.BaseBean" %>
<%@ page import="weaver.conn.RecordSet" %>
<%@ page import="java.util.Map" %>

<%@ page import="weaver.workflow.webservices.WorkflowRequestInfo" %>
<%@ page import="weaver.workflow.webservices.WorkflowService" %>
<%@ page import="weaver.workflow.webservices.WorkflowServiceImpl" %>

<%


WorkflowService service = new WorkflowServiceImpl();
RecordSet rs = new RecordSet();

RecordSet rs02 = new RecordSet();

String mess = "";
String nodeid = "7998";
String tablename = "formtable_main_119";
String field = "Cost_Center";


String userid = "5744";

rs.execute("select * from workflow_requestbase where currentnodeid= "+nodeid+" and creater = "+userid);
while(rs.next()){
	int requestid = rs.getInt("requestid");
	String workflowid = Util.null2String(rs.getString("workflowid"));
	com.westvalley.util.BudgetUtil budget = new com.westvalley.util.BudgetUtil();
	rs02.execute("select * from hrmresource where id = "+userid);
	String subid = "";
	if(rs02.next()){
		subid = Util.null2String(rs02.getString("subcompanyid1"));
	}
	String lcbh = budget.getRequestNum(rs02,subid,"1",workflowid,requestid+"","1212");
	//rs02.execute("update "+tablename+" set "+field+"='"+lcbh+"' where requestid = "+requestid);
	WorkflowRequestInfo request2 = service.getWorkflowRequest(requestid,1, 0);
	String flag = service.submitWorkflowRequest(request2,requestid, 1, "submit", "");
	mess+= flag + requestid+"<br/>";
}


	//WorkflowRequestInfo request2 = service.getWorkflowRequest(66289,1, 0);
	//String flag = service.submitWorkflowRequest(request2,66289, 1, "submit", "");

	out.print(mess);

%>
