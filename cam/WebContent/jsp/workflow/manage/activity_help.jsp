<%@ taglib uri="/tags/web-i18n" prefix="web"%>  
<%@ taglib uri="/tags/web-flex" prefix="flex"%>
<%@ taglib uri="/tags/web-grid" prefix="grid"%>
<%@ taglib uri="/tags/web-html" prefix="html"%>
<%@ taglib uri="/tags/web-loushang" prefix="loushang"%>
<%@ taglib uri="/tags/loushang-bsp" prefix="bsp"%>
<%@ page import="org.loushang.waf.ResourcesFactory"%>
<%@ page import="java.util.*"%>
<%@ page import="org.loushang.workflow.processdefinition.data.ActivityDef"%>
<HTML>
<%
  List actDefList=(List)request.getAttribute("actDefList");
%>
<HEAD>
<TITLE><%=ResourcesFactory.getString("WorkFlow.SelectActivity")%></TITLE>
<link rel="stylesheet" type="text/css" href="<loushang:ui css='skin.css'/>">
<link rel="stylesheet" type="text/css" href="<loushang:ui css='flexgrid.css'/>">
<web:js src="flexgrid.js"/>
<web:js src="flexgrid.js"/>
</HEAD>
<BODY topmargin="10px" onload="init()">
<html:form name="frmSelect" action="">
<bsp:container title='<%=ResourcesFactory.getString("WorkFlow.SelectActivity")%>' >
    <bsp:containbutton onclick="forConfirm()" text='<%=ResourcesFactory.getString("COMMON.OK")%>' ></bsp:containbutton>
    <bsp:containbutton onclick="forCancels()" text='<%=ResourcesFactory.getString("COMMON.CANCEL")%>' ></bsp:containbutton>
    <table>
    <tr>
    <td>
    <%=ResourcesFactory.getString("WorkFlow.SelectActivityAndParticipant")%>
    <td>
    </tr>
    </table>
    <table>
    <tr>
    <td>
    <%=ResourcesFactory.getString("WorkFlow.Activity")%>:
    </td>
    <td>
    <select name="actDefUniqueId">
	<%
	for(Iterator iter=actDefList.iterator();iter.hasNext();){
		ActivityDef activityDef=(ActivityDef)iter.next();
		String activityDefId=activityDef.getId();
		String activityDefName=activityDef.getName();
		%>
		<option  value='<%=activityDefId%>'><%=activityDefName%></option>
		<%
	}
	%>
	</select>
	</td>
	<td>
	<%=ResourcesFactory.getString("WorkFlow.Participant")%>
	</td>
	<td>
    <img src="skins/default/images/liulan.gif" style="cursor:hand"  border="0" onclick="selectOrganId()">
	<input type="hidden" name="organIds" value=""/>
	<input type="text" id="" name="organNames" readonly="true" value=""/>
	</td>
	</tr>
	</table>
</bsp:container>
</html:form>
</BODY>
</HTML>
<script language="javascript">
function init(){
}
function selectOrganId(){
var url ="stru.cmd?method=getSelectRoot&isCheckBox=1&isIncludeSelf=1&isTree=1&rootId=1";      
  var win = showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:500px;dialogHeight:550px");
  if (win == null) {  
  	return;
  }else{
   document.getElementById("organIds").value=win[0];
   document.getElementById("organNames").value=win[1];
  }
}
function forCancels(){
	parent.close();
}

function forConfirm(){
	var returnV=new Array(3);
	returnV[0]=document.getElementById("actDefUniqueId").value;
	returnV[1]=document.getElementById("organIds").value;
	returnV[2]=document.getElementById("organNames").value;
	parent.returnValue=returnV;
	parent.close();
}

</script>