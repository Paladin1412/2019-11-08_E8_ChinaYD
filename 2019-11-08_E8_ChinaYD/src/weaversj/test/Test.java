package weaversj.test;

import weaver.conn.RecordSet;
import weaver.workflow.webservices.WorkflowRequestInfo;
import weaver.workflow.webservices.WorkflowService;
import weaver.workflow.webservices.WorkflowServiceImpl;

public class Test {

	public static void main(String[] args){
		WorkflowService service = new WorkflowServiceImpl();
		RecordSet rs = new RecordSet();
		
		rs.execute("select * from workflow_requestbase where currentnodeid= 7998 and creater = 1");
		 
		while(rs.next()){
			int requestid = rs.getInt("requestid");
			WorkflowRequestInfo request = service.getWorkflowRequest(requestid,1, 0);
			String flag = service.submitWorkflowRequest(request,requestid, 1, "submit", "");
		}
	}
}
