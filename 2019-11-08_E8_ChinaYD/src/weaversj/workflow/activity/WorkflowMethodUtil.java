package weaversj.workflow.activity;

import weaver.conn.RecordSet;
import weaver.general.Util;

public class WorkflowMethodUtil {

	public String getImageFileName(String docid){
		RecordSet rs = new RecordSet();
		rs.execute("select imagefilename from docimagefile where docid in("+docid+")");
		String name = "";
		while(rs.next()){
			name+=Util.null2String(rs.getString("imagefilename"))+"<br/>";
		}
		return name;
	}
	public String getDepartMentName(String departid){
		if("".equals(departid)){
			return "";
		}
		RecordSet rs = new RecordSet();
		rs.execute("select departmentname from hrmdepartment where id in("+departid+")");
		String name = "";
		while(rs.next()){
			name+=","+Util.null2String(rs.getString("departmentname"));
		}
		return name.substring(1);
	}
}
