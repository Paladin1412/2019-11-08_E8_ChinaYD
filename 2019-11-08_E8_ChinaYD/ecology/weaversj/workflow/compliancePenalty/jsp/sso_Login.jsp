<%@page import="com.westvalley.userinfo.EIPSSO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%
EIPSSO eip = new EIPSSO(request,response,application);
if(eip.ckUser()){
	//第一个是自己写sso登录jsp，后面是对应需要跳转的报表首页
	eip.loginToUrl("/weaversj/workflow/compliancePenalty/jsp/sso_Login.jsp","/weaversj/workflow/compliancePenalty/jsp/list.jsp");
}else{
	response.sendRedirect("/weaversj/workflow/compliancePenalty/jsp/list.jsp");
}
%>