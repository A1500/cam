<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%
	String organCode="";
	String organName="";
	String organLevel="";
	String communityType="";
	String communityBelongs="";
	String parentCode="";
	String userId="";
	ComExtUser user = ExtBspInfo.getUserInfo(request);
	if(ExtBspInfo.getUserInfo(request)!=null){
		if("JD".equals(user.getOrganType())){
			organCode=user.getAreaCode().substring(0,9)+"000";
		}else{
			organCode=user.getAreaCode();
		}
		userId = user.getUserId();
		organName=user.getUserName();
		organLevel=user.getOrganType();
		communityType=user.getCommunityType();
		parentCode=user.getOrganId();
		communityBelongs = user.getCommunityBelongs();
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
var communityType='<%=communityType%>';
var parentCode='<%=parentCode%>';
var communityBelongs='<%=communityBelongs%>';
if(userStatus !="" && communityBelongs !=""){
	 organCode='<%=userId%>';
}
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
	if(rec.get("status")=="-1"||rec.get("status")=="0"||rec.get("STATUS")=="-1"||rec.get("STATUS")=="0"){
		color= 'red';
	}else if(rec.get("status")=="2"||rec.get("STATUS")=="2"){
		color= 'orange';
	}else{
		color= 'blue';
	}
	return '<font color="'+color+'">'+val+'</font>';
}
</script>