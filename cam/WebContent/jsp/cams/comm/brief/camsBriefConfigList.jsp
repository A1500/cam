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
<title>简报快报配置列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="camsBriefConfigList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="camsBriefDataSet" cmd="com.inspur.cams.comm.brief.cmd.CamsBriefConfigQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.brief.data.CamsBriefConfig"/>
	</model:dataset>
	<model:dataset id="briefDs" cmd="com.inspur.cams.comm.brief.cmd.CamsBriefConfigQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.brief.data.CamsBriefConfig"/>
	</model:dataset>
	<!-- 是否加粗 -->
	<model:dataset id="ifBoldDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">录入名称：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "enter_name" /></td>
					<td class="FieldLabel" style="width:10%">显示名称：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "show_name" /></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="camsBriefDataSet" width="100%" stripeRows="true" height="99.9%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="configId" header="简报ID" width="15%" sortable="false" hidden="true"/>
		<next:Column field="enterName" header="录入名称" width="30%" sortable="false"/>
		<next:Column field="showName" header="显示名称" width="30%" sortable="false"/>
		<next:Column field="indexCode" header="指标代码" width="10%" sortable="false"/>
		<next:Column field="unit" header="单位" width="7%" sortable="false"/>
		<next:Column field="enterSerialNum" header="录入顺序号" width="10%" sortable="true"/>
		<next:Column field="showSerialNum" header="显示顺序号" width="10%" sortable="true"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="camsBriefDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id ="briefWin" title="编辑消息" expandOnShow="false"
        resizable="false" width="600" height="325"
       closable="false" >
       <next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem text="确定" iconCls="detail" handler="confirm"/>
				<next:ToolBarItem text="关闭" iconCls="undo" handler="closeWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm"  dataset="briefDs" onsubmit="return false"  class="L5form">
				<table border="1" width="100%" >
			   		<tr>	
						<td  class="FieldLabel" style="width:7%">录入名称:</td>
						<td class="FieldInput" style="width:20%"><input id="enterName" field="enterName" style="width:100%"></input></td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:7%">显示名称:</td>
						<td class="FieldInput" style="width:20%"><input id="showName" field="showName" style="width:100%"></input></td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:7%">指标代码:</td>
						<td class="FieldInput" style="width:20%"><input id="indexCode" field="indexCode" style="width:100%"></input></td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:7%">单位:</td>
						<td class="FieldInput" style="width:20%"><input id="unit" field="unit" style="width:100%"></input></td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:7%">录入顺序号:</td>
						<td class="FieldInput" style="width:20%"><input id="enterSerialNum" field="enterSerialNum" style="width:100%" maxlength="3"></input></td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:7%">显示顺序号:</td>
						<td class="FieldInput" style="width:20%"><input id="showSerialNum" field="showSerialNum" style="width:100%" maxlength="3"></input></td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:7%">缩进级别:</td>
						<td class="FieldInput"  style="width:20%">
							<select id="sjjbquery" field="indentLevel">
								<option value="">不缩进</option>
								<option value="1">一</option>
								<option value="2">二</option>
								<option value="3">三</option>
								<option value="4">四</option>
							</select>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:7%">是否加粗:</td>
						<td class="FieldInput"  style="width:20%">
							<select id="ifBold" field="ifBold" name="是否加粗" >
		                 		<option dataset="ifBoldDataset"></option>
		            		</select>
						</td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>
</body>
</html>