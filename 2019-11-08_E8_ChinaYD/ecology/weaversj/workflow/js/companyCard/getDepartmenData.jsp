<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="weaver.conn.RecordSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.*" %>



<%
	String userid = Util.null2String(request.getParameter("userid"));
	RecordSet rs = new RecordSet();
	JSONObject datas = new JSONObject();
	
	String sql = "select t.departmentname,t.id from ("+
			"SELECT a.id,a.departmentname,a.supdepid,b.sfdivition FROM hrmdepartment a "+
			"left join hrmdepartmentdefined b on a.id=b.deptid "+
			"START WITH a.id =(select departmentid from hrmresource where id='"+userid+"') "+
			"CONNECT BY a.id = PRIOR a.supdepid) t "+
			"where t.sfdivition=0 ";
	
	String getCheckSql = "select subcompanyid1,departmentid from hrmresource where id = '"+userid+"' and subcompanyid1 = 21";
	rs.execute(getCheckSql);
	if(rs.next()){//总部
		datas.put("cc", getDepartName(new RecordSet(),Util.null2String(rs.getString("departmentid"))));
		String ddName = "";
		rs.execute(sql);
		if(rs.next()){
			ddName = Util.null2String(rs.getString("departmentname"));
		}
		datas.put("dd",ddName);
	}else{//海外
		String subid = "";
		String sqls = "select subcompanyid1 from hrmresource where id = '"+userid+"'";
		rs.execute(sqls);
		if(rs.next()){
			subid = Util.null2String(rs.getString("subcompanyid1"));
		}
		String ccName = "";
		String ddName = getSubcompanyName(new RecordSet(),subid);
		rs.execute(sql);
		if(rs.next()){
			ccName = Util.null2String(rs.getString("departmentname"));
		}

		datas.put("dd",ddName);
		datas.put("cc",ccName);
	}
	out.print(datas);
%>
<%!
public String getDepartName(RecordSet rs,String id){
	String subName = "";
	rs.execute("select departmentname from hrmdepartment where id = '"+id+"'");
	if(rs.next()){
		subName = Util.null2String(rs.getString("departmentname"));
	}
	return subName;
}
%>
<%!
String subName2 = "";
public String getSubcompanyName(RecordSet rs,String subid){
	rs.execute("select subcompanyname,supsubcomid,tlevel from hrmsubcompany where id = '"+subid+"'");
	if(rs.next()){

		if("2".equals(Util.null2String(rs.getString("tlevel")))){
			subName2 = Util.null2String(rs.getString("subcompanyname"));
		}else{
			getSubcompanyName(new RecordSet(),Util.null2String(rs.getString("supsubcomid")));
		}
	}

	return subName2;
}
%>

