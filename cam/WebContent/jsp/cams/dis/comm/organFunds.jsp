<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>资金管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
</script>
<script type="text/javascript" src="organFunds.js"></script>
</head>
<body>
<model:datasets>
	<!--单位所剩资金-->
	<model:dataset id="disCurrentMoneyDs"
		cmd="com.inspur.cams.dis.base.cmd.DisCurrentMoneyQueryCmd">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisCurrentMoney"></model:record>
	</model:dataset>
	<!--单位所剩物资-->
	<model:dataset id="disCurrentMoneyDetailDs"
		cmd="com.inspur.cams.dis.base.cmd.DisCurrentMoneyDetailQueryCmd">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisCurrentMoneyDetail"></model:record>
	</model:dataset>
	
	<!-- 发放物资类型-->
	<model:dataset id="dmDisMaterialTypeDs" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DIS_MATERIAL_TYPE'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

	<next:Panel id="panel" title="资金管理">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="disCurrentMoneyDs">
			<table border="0" width="100%">
				<tr>
					<td class="FieldLabel" width="150">资金总金额:</td>
					<td class="FieldInput"><label field="currentMoney" renderer="formatMoneyForDis"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" width="150">物资总金额:</td>
					<td class="FieldInput"><label field="currentMeterial" renderer="formatMoneyForDis"/></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="sourceGrid" dataset="disCurrentMoneyDetailDs"
		height="100%">
		<next:TopBar>
			<next:ToolBarItem text="物资明细"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="25" />
			<next:Column header='物资类型' field="meterialType" width="90" dataset="dmDisMaterialTypeDs">
				<next:TextField editable="false"/>
			</next:Column>
			<next:Column header="物资单位" field="meterialUnit" align="left" width="80">
				<next:TextField editable="false"/>
			</next:Column>
			<next:Column header="物资数量" field="meterialNum" align="right" width="80"
				renderer="formatMoneyForDis">
				<next:TextField />
			</next:Column>
			<next:Column header="物资金额合计" field="meterialAccount" align="right" width="100"
				renderer="formatMoneyForDis">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="disCurrentMoneyDetailDs"/>
		</next:BottomBar>
	</next:GridPanel>
</body>
</html>