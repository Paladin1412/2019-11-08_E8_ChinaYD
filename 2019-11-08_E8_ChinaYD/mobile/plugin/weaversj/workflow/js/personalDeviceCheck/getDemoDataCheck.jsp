<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="weaver.conn.RecordSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="weaver.general.*" %>

<%
	String zccode = Util.null2String(request.getParameter("zccode"));
	RecordSet rs = new RecordSet();
	JSONObject datas = new JSONObject();
	String sql = "select Serial_Number,Host_model,Corresponding_order_number,Date_of_purchase,Maintenance_to,"+
			  "operating_system,CPU,RAM,Host_category,Details,MAC_Address from wv_v_asset where ASSET_NUMBER = '"+zccode+"'";
	rs.execute(sql);
	if(rs.next()){
		datas.put("Serial_Number", Util.null2String(rs.getString("Serial_Number")));
		datas.put("Host_model", Util.null2String(rs.getString("Host_model")));
		datas.put("Corresponding_order_number", Util.null2String(rs.getString("Corresponding_order_number")));
		datas.put("Date_of_purchase", Util.null2String(rs.getString("Date_of_purchase")));
		datas.put("Maintenance_to", Util.null2String(rs.getString("Maintenance_to")));
		datas.put("operating_system", Util.null2String(rs.getString("operating_system")));
		datas.put("CPU", Util.null2String(rs.getString("CPU")));
		datas.put("RAM", Util.null2String(rs.getString("RAM")));
		datas.put("Host_category", Util.null2String(rs.getString("Host_category")));
		datas.put("Details", Util.null2String(rs.getString("Details")));
		datas.put("MAC_Address", Util.null2String(rs.getString("MAC_Address")));
	}
	out.print(datas);
%>


