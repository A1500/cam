<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String organCode="";
	String organName="";
	String organLevel="";
	String parentCode="";
	if(ExtBspInfo.getUserInfo(request)!=null){
		organCode=ExtBspInfo.getUserInfo(request).getUserId();
		organName=ExtBspInfo.getUserInfo(request).getUserName();
		organLevel=ExtBspInfo.getUserInfo(request).getOrganType();
		parentCode=ExtBspInfo.getUserInfo(request).getOrganId();
	}else{
		organCode=BspUtil.getCorpOrgan().getOrganCode();
		organName=BspUtil.getCorpOrgan().getOrganName();
		organLevel=BspUtil.getCorpOrgan().getOrganType();
		parentCode=BspUtil.getParentOrgan().getOrganCode();
	}
%>
<script type="text/javascript">
	var organCode='<%=organCode%>';
	var organName='<%=organName%>';
	var organLevel='<%=organLevel%>';
	var parentCode='<%=parentCode%>';
	var organPath='';
	var organPathLevel=organLevel;
	
function statusRender(val,el,rec,rowIndex,colIndex,ds,field,grid){
	var desc;
	if(rec.get("status")=="-1"){
		desc= '<font color="red">' + val + '</font>';
	}else{
		desc= '<font color="blue">' + val + '</font>';
	}
	if(organPathLevel!="JD"){
		desc='<a href="javascript:getChild(\'' + rec.get("organCode") + '\')">' + desc + '</a>'
	}
	return desc;
}
</script>