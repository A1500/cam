<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List"%>
<HTML>
<%
  List actDefList=(List)request.getAttribute("hisActivityDefList");
%>
<HEAD>
<TITLE>选择环节</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY topmargin="10px" onload="init()">
<model:datasets>
	<model:dataset id="actDataSet"
		cmd="org.loushang.workflow.client.common.help.cmd.TaskHelpCmd" global="true" autoLoad="true" method="selectHistoryActivitiesAndEmployeesByPkAndActDefId">
		<model:record >
			<model:field name="text" mapping="actDefName" type="string"></model:field>
			<model:field name="value" mapping="actDefUniqueId" type="string"></model:field>
			<model:field name="actDefId" type="string"></model:field>
			<model:field name="activityId" type="string"></model:field>
			<model:field name="actType"  type="string"></model:field>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
<next:Panel >
	<next:Html>
		<form id="userForm" method="post"  onsubmit="return false" class="L5form">
 <table border="1">
    <tr>
    <td class="FieldLabel">
   	选择要启动的环节及参与者
    </td>
    </tr>
    </table>
    <table>
    <tr>
    <td class="FieldLabel">
     环节:&nbsp;&nbsp;&nbsp;&nbsp;
    </td>
    <td class="FieldInput">
	<select name="actDefInfo" id="actDefInfo">
		<option dataset="actDataSet" ></option>
	</select>
	</td>
	</tr>
	<tr>
	<td class="FieldLabel">
	参与者:
	</td>
	<td class="FieldInput">
	<input type="text" id="" name="organNames" readonly="true" value=""/>
    <img src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"  style="cursor:hand"  border="0" onclick="selectOrganId()">
	<input type="hidden" name="organIds" value=""/>
	</td>
	</tr>
	</table>
		</form>
	</next:Html>
	<next:TopBar>
			<next:ToolBarItem iconCls="save"  text="确定" handler="forConfirm"/>
			<next:ToolBarItem iconCls="undo"  text="取消" handler="forCancels"/>
	</next:TopBar>
</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</BODY>
</HTML>
<script language="javascript">
function init(){
}
function selectOrganId(){
	var actDefInfo=document.getElementById("actDefInfo").value;
	var record = actDataSet.getById(actDefInfo);
	var url =L5.webPath+"/jsp/workflow/client/help/selecthistoryemployees.jsp?activityId="+record.get("activityId");      
    var win = showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:500px;dialogHeight:550px");
    if (win == null) {
  	return;
   }else if(win[0]=="cancel"){
  	document.all("organIds").value="";
   	document.all("organNames").value=""; 
  	return;
  }
  else{
   document.all("organIds").value=win[0];
   document.all("organNames").value=win[1];
  }
}
function forCancels(){
	parent.close();
}

function forConfirm(){
	var returnV=new Array(4);
	var actDefInfo=document.getElementById("actDefInfo").value;
	var record = actDataSet.getById(actDefInfo);
	returnV[0]=actDefInfo;
	returnV[1]=document.all("organIds").value;
	returnV[2]=document.all("organNames").value;
	returnV[3]=record.get("text");
	
	parent.returnValue=returnV;
	parent.close();
}

</script>