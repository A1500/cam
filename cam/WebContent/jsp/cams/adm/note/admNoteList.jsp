<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>区划数量明细表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="admNoteList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<model:datasets>
	<model:dataset id="admNote1DataSet" cmd="com.inspur.cams.adm.note.base.cmd.AdmNoteQueryCmd" method="queryDic" pageSize="200">
		<model:record fromBean="com.inspur.cams.adm.note.base.data.AdmNote">
		</model:record>
	</model:dataset>
	<model:dataset id="admNote1D" cmd="com.inspur.cams.adm.note.base.cmd.AdmNoteQueryCmd"  pageSize="200">
		<model:record fromBean="com.inspur.cams.adm.note.base.data.AdmNote">
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">截至时间</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">截至时间：</td>
					<td class="FieldInput" style="width:36%"><input type="text" id="endTime" field="endTime"  maxlength="50" />
					<font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="admNote1DataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="保存" handler="saves"></next:ToolBarItem>
		<next:ToolBarItem iconCls="del" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="CODE" header="区划代码" width="15%" sortable="false" hidden="true"/>
		<next:Column field="NAME" header="区划名称" width="10%" sortable="false" align="center"/>
		<next:Column field="CITY_NUM" header="市" width="8%" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="COUNTRY_NUM" header="县(市、区)" width="8%" sortable="false">
			<next:TextField/>
		</next:Column>
		<next:Column field="TOWN_NUM" header="乡镇(街道)" width="8%" sortable="false">
			<next:TextField />
		</next:Column>
		<next:Column field="VILLAGE_NUM" header="社区" width="8%" sortable="false" hidden="true">
			<next:TextField/>
		</next:Column>
		<next:Column field="NOTE" header="备注" width="30%" sortable="false">
			<next:TextField/>
		</next:Column>
		<next:Column field="END_TIME" header="截至时间" width="30%" sortable="false" hidden="true">
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="admNote1DataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>