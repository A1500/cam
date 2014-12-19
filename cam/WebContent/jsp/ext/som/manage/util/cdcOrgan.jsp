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
function buttonControl(){
	if(organLevel=="SQ"){
		$("sum1").style.display="none";
		$("sum2").style.display="none";
		$("sum3").style.display="none";
	}else{
		$("detail1").style.display="none";
		$("detail2").style.display="none";
		$("detail3").style.display="none";
	}
}
//未上报显示红色，填报显示蓝色，驳回显示橘色
function statusListRender(val,el,rec){
	var color;
	if(rec.get("status")=="-1"||rec.get("status")=="0"){
		color= 'red';
	}else if(rec.get("status")=="2"){
		color= 'orange';
	}else{
		color= 'blue';
	}
	return '<font color="'+color+'">'+val+'</font>';
}
</script>