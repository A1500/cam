<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>受理通知书修改</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var serviceType='<%=request.getParameter("serviceType")%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		</script>
<script type="text/javascript" src="acceptNoticeUpdate.js"></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 受理通知书 -->
	<model:dataset id="DisabilityNoticeDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityNoticeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice"></model:record>
	</model:dataset>
	<!-- 伤残业务类型 -->
	<model:dataset id="ServiceTypeDataSet" enumName="DISABILITY.SERVICE.TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
					
<next:Panel width="100%" height="100%">
	<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="print"  text="生成" handler="print"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
				<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="DisabilityNoticeDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
			<input type="hidden" name="applyId" field="applyId" title="号"/>
	   		<tr>
	   			<td  class="FieldLabel" style="width:15%">字：</td>
				<td class="FieldInput" style="width:15%"><input type="text" name="letter" field="letter" title="字"/><font color="red">*</font> </td>
				<td  class="FieldLabel" style="width:15%">号：</td>
				<td class="FieldInput" ><input type="text" name="number" field="number" title="号"/><font color="red">*</font> </td>
				<td  class="FieldLabel" >通知书日期：</td>
				<td class="FieldInput"><input type="text" name="noticeDate" field="noticeDate" format="Y-m-d"  style="width: 100px;"maxlength="10"  onpropertychange="changeDateStyle(this)" title="通知书日期"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font> </td>
			</tr>
			
			<tr>
				<td  class="FieldLabel" >姓名：</td>
				<td  class="FieldInput" ><label name="name" field="name"  /></td>

				<td  class="FieldLabel" >业务类型：</td>
				<td  class="FieldInput" colspan="3"><label name="serviceType" field="serviceType" dataset="ServiceTypeDataSet"></label></td>
				
				
			</tr>
				<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/assessdisability/table/acceptNotice_apptable.doc"/>
				<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
				<%--<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/> --%>
				<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
				<input type="hidden" id="method" name="queryData" queryData="queryData" value="queryAcceptNotice"/>
				<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
		</table>
		</form>
   </next:Html>
</next:Panel>
<script type="text/javascript">
	
function print() {
		var url="../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</body>
</html>
