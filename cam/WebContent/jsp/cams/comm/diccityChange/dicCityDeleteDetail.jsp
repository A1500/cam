<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<html>
<head>
<title>行政区划撤销明细</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	<%
	String reqTime=DateUtil.getDay();
	String organCode=BspUtil.getCorpOrgan().getOrganCode();
	String organName=BspUtil.getCorpOrgan().getOrganName();
	String userName=GetBspInfo.getBspInfo().getUserName();
	%>
</script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var changeId='<%=request.getParameter("changeId")%>';
	var reqTime='<%=reqTime%>';
	var organCode='<%=organCode%>';
	var organName='<%=organName%>';
	var userName='<%=userName%>';
</script>
<script type="text/javascript" src="dicCityDelete.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>

</head>
<body>
<model:datasets>
	<model:dataset id="dicCityChangeDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChange"/>
	</model:dataset>
	<model:dataset id="dicCityDetailDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityDataTransQueryCmd" method="getUnder" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityDataTrans"/>
	</model:dataset>
	<!-- 迁移类型-->
	<model:dataset id="transTypeDataSet" enumName="COMM.TRANS.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="dicCityChangeDataSet" onsubmit="return false" class="L5form">
<fieldset>
	<legend>行政区划变更</legend>
	<table width="100%">
		<tr >
			<td class="FieldLabel" style="width:18%">待撤销区划名称：</td>
			<td class="FieldInput" style="width:36%"><label name="变更前区划名称" id="preChangeName" field="preChangeName" style="width:90%" ></label></td>
		</tr>
		<tr >
			<td class="FieldLabel" style="width:18%">待撤销区划代码：</td>
			<td class="FieldInput" style="width:36%"><label name="变更前区划代码" id="preChangeCode" field="preChangeCode"></label></td>
		</tr>
		<tr >
			<td class="FieldLabel" style="width:18%">待撤销上级区划代码：</td>
			<td class="FieldInput" style="width:36%"><label name="变更前上级区划代码" id="preUpsCode" field="preUpsCode"></label></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">序号：</td>
			<td class="FieldInput" style="width:36%" colspan="2"><label name="序号" id="serialNum" field="serialNum" style="width:90%" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">变更说明：</td>
			<td class="FieldInput" style="width:36%"><textarea   disabled name="变更说明" id="remark" field="remark"  style="width:90%" readonly="readonly"></textarea></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:GridPanel id="detailGrid" dataset="dicCityDetailDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="TRANS_ID" header="数据迁移ID" width="10%" sortable="false" hidden="true"/>
		<next:Column field="CHANGE_ID" header="变更业务ID" width="10%" sortable="false" hidden="true"/>
		<next:Column field="TRANS_TYPE" header="迁移类型" dataset="transTypeDataSet" width="10%"></next:Column>
		<next:Column field="ID" header="迁移前区划代码" width="10%" sortable="false"/>
		<next:Column field="NAME" header="迁移前区划名称" width="15%" sortable="false"/>
		<next:Column field="POST_CHANGE_CODE" header="迁移前区划代码" width="15%" sortable="false" hidden="true"></next:Column>
		<next:Column field="POST_CHANGE_NAME" header="迁移前区划名称" width="15%" sortable="false" hidden="true"></next:Column>
		<next:Column field="POST_UPS_CODE" header="迁移后上级区划代码" width="15%" sortable="false"></next:Column>
		<next:Column field="POST_UPS_NAME" header="迁移后上级区划名称" width="15%" sortable="false"></next:Column>
		<next:Column field="POST_CHANGE_CODE" header="迁移后区划代码" width="15%" sortable="false"></next:Column>
		<next:Column field="POST_CHANGE_NAME" header="迁移后区划名称" width="15%" sortable="false"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="dicCityDetailDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>