<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.*"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>省级增加基金页面</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var year = '<%=DateUtil.getYear()%>';
		</script>
		<script type="text/javascript" src="fundsmanage_edit.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisFundsSourceQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisFundsSource"></model:record>
	</model:dataset>
	<model:dataset id="allocationStatusSelect" enumName="DIS.ALLOCATION_STATUS" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="allocationTypeSelect" enumName="DIS.ALLOCATION_TYPE" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="allocationPurposeSelect" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true"></model:dataset>	
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  title="省级增加资金页面">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="provinceSave"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
	   		<tr>
				<td  class="FieldLabel" >年度</td>
				<td class="FieldInput"><input type="text" name="disYear" field="disYear"  maxlength="4"/> </td>
				<td  class="FieldLabel" >拨付状态</td>
				<td class="FieldInput">
				<select field="allocationStatus" id="allocationStatus" name='"拨付状态"'>
					<option dataset="allocationStatusSelect"></option>
				</select>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >上级下拨文号</td>
				<td class="FieldInput"><input type="text" name="upAllocationNum" field="upAllocationNum"  /> </td>
			
				<td  class="FieldLabel" >上级下拨资金类型</td>
				<td class="FieldInput">
				<select field="upAllocationType" id="upAllocationType" name='"上级下拨资金类型"'>
					<option dataset="allocationTypeSelect"></option>
				</select>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >上级下拨资金用途</td>
				<td class="FieldInput" colspan="3">
				<input type="text"  id='upAllocationPurposeName' style="width:85.8%" readOnly="true" />
				<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="openTypeWin()"/>
				<input type="hidden" field="upAllocationPurpose" id='upAllocationPurpose'>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >上级下拨资金总额</td>
				<td class="FieldInput"><input type="text" name="upAllocationTotalCount" field="upAllocationTotalCount"  /> </td>
				<td  class="FieldLabel"></td>
				<td class="FieldInput"></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
<jsp:include page="../../comm/purposeWin.jsp" flush="true"/>   
</body>
</html>
