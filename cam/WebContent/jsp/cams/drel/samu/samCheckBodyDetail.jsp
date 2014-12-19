<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>供养对象查体信息列表维护</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="samCheckInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	<%
		String organArea=BspUtil.getCorpOrgan().getOrganCode();
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		String gerocomiumId=request.getParameter("gerocomiumId");
		String checkDate=request.getParameter("checkDate");
	%>
	var gerocomiumId='<%=gerocomiumId%>';
	var checkDate='<%=checkDate%>';
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="samCheckDetailDataSet" cmd="com.inspur.cams.drel.samu.cmd.SamGeroApplyQueryCmd" method="queryCheckDetail" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.samu.data.SamGeroApply"/>
		<model:record>
			<model:field name="PERSON_NAME"/>
			<model:field name="PERSON_ID"/>
			<model:field name="APPLY_ID"/>
			<model:field name="ID_CARD"/>
			<model:field name="GEROCOMIUM_ID"/>
			<model:field name="IN_ROOM"/>
			<model:field name="IN_BED"/>
			<model:field name="CHECK_DATE"/>
			<model:field name="CHECK_RESULT"/>
		</model:record>
	</model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="checkResultDataset" enumName="SAM_SAMU_HEALTH" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width: 15%">姓名</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="名称" id="personNameQuery" maxlength="50" style="width: 80%" /></td>
					<td class="FieldLabel" style="width: 15%">身份证号</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="名称" id="idCardQuery" maxlength="50" style="width: 80%" /></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">房间</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="名称" id="inRoomQuery" maxlength="50" style="width: 80%" /></td>	
					<td class="FieldLabel" style="width: 15%">床位</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						name="名称" id="inBedQuery" maxlength="50" style="width: 80%" /></td>
					<td class="FieldButton" style="width:20%"><button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="infoQueryGrid" name="samCheckDetailDataSet"
	stripeRows="true" height="100%" width="100%" dataset="samCheckDetailDataSet" clickToSelectedForChkSM="true">
	<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
	</next:TopBar>
	<next:Columns>
   		<next:RowNumberColumn width="30"/>
   		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="姓名" field="PERSON_NAME" width="80" align="center" />
		<next:Column header="身份证号" field="ID_CARD" width="135" align="center" />
		<next:Column header="房间" field="IN_ROOM" width="80" align="center"/>
		<next:Column header="床位" field="IN_BED" width="80" align="center"/>
		<next:Column header="查体时间" field="CHECK_DATE" width="80" align="center">
		</next:Column>
		<next:Column header="查体结果" field="CHECK_RESULT" width="100" align="center" dataset="checkResultDataset">
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="samCheckDetailDataSet" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>