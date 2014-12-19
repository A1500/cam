<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>轮养休养批次编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var orgName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
			var orgCode ='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
			var newid =  '<%=IdHelp.getUUID32()%>';
		</script>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
		<script type="text/javascript" src="bptrecuperate_edit.js"></script>
		<script type="text/javascript" src="../../comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.bptrecuperate.cmd.BptRecuperateQueryCommand" method="query" global="true">
		<model:record fromBean="com.inspur.cams.bpt.bptrecuperate.data.BptRecuperate"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel title="轮养休养批次" width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="disable"  text="关闭" handler="func_Close"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
	   		<tr>
				<td class="FieldLabel" style="width:16%">编制时间</td>
				<td class="FieldInput" style="width:16%"><input type="text" name="createTime" format="Y-m-d" field="createTime" maxlength="10"style="width: 100px;"   onpropertychange="changeDateStyle(this)"  /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);"> </td>
				<td class="FieldLabel" style="width:16%">年度</td>
				<td class="FieldInput" style="width:16%"><input type="text" id="year" name="year" field="year" maxlength="4"/></td>
				<td class="FieldLabel" style="width:16%">批次</td>
				<td class="FieldInput" style="width:16%"><input type="text" id="batchName" name="batchName" field="batchName"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"  >轮养（休养）开始时间</td>
				<td class="FieldInput"><input type="text" field="beginTime" format="Y-m-d" maxlength="10"style="width: 100px;"   onpropertychange="changeDateStyle(this)"  /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);"> </td>
				<td class="FieldLabel"  >轮养（休养）结束时间</td>
				<td class="FieldInput"><input type="text" field="endTime" format="Y-m-d" maxlength="10"style="width: 100px;"   onpropertychange="changeDateStyle(this)"  /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this);"> </td>
				<td class="FieldLabel" >人数</td>
				<td class="FieldInput"><input type="text" name="peopleCount" field="peopleCount" readonly="readonly"/></td>
			</tr>
			<tr>
				<td  class="FieldLabel">备注</td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="note" field="note" style="width:90%" rows="2"></textarea></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
