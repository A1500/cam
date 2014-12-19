<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
%>
<html>
<head>
<title>简报快报期数列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="camsBriefSeasonList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="camsSeasonDataSet" cmd="com.inspur.cams.comm.brief.cmd.CamsBriefSeasonQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.brief.data.CamsBriefSeason"/>
	</model:dataset>
	<model:dataset id="SeasonDs" cmd="com.inspur.cams.comm.brief.cmd.CamsBriefSeasonQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.brief.data.CamsBriefSeason"/>
	</model:dataset>
	<!-- 填报期数列表用-->
	<model:dataset id="tbqsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='CAMS_REPORT_WORK'></model:param>
			<model:param name="value" value='WORK_ID'></model:param>
			<model:param name="text" value='WORK_DESC'></model:param>
		</model:params>
	</model:dataset>
	<!-- 填报期数下拉列表用-->
	<model:dataset id="workDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='CAMS_REPORT_WORK'></model:param>
			<model:param name="value" value='WORK_ID'></model:param>
			<model:param name="text" value='WORK_DESC'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="grid" dataset="camsSeasonDataSet" width="100%" stripeRows="true" height="99.9%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="export" text="填报" handler="toReport"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="seasonId" header="期数ID" width="15%" sortable="false" hidden="true"/>
		<next:Column field="organArea" header="区划代码" width="30%" sortable="false"/>
		<next:Column field="organName" header="区划名称" width="30%" sortable="false"/>
		<next:Column field="reportSeason" header="期数" width="10%" sortable="false" dataset="tbqsDataSet"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="camsSeasonDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id ="SeasonWin" title="编辑消息" expandOnShow="false"
        resizable="false" width="400" height="130"
       closable="false" >
       <next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem text="确定" iconCls="detail" handler="confirm"/>
				<next:ToolBarItem text="关闭" iconCls="undo" handler="closeWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm"  dataset="SeasonDs" onsubmit="return false"  class="L5form">
				<table border="1" width="100%" >
			   		
					<tr>	
						<td  class="FieldLabel" style="width:7%">区划名称:</td>
						<td class="FieldInput" style="width:20%"><input type="text" name="区划名称" id="organName" field="organName" maxlength="50" style="width:80%" readonly />
					<img id="img" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
					<input type="hidden" name="organCode" id="organCode" field="organArea"/></td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:7%">填报期数:</td>
						<td class="FieldInput" style="width:20%">
						<select id="reportSeason" name="填报期数" field="reportSeason" style="width:90%">
		                 <option dataset="workDataSet"></option>
		            	</select></td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>
</body>
</html>