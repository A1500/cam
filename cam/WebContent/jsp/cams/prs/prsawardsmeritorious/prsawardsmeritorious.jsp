<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>立功受奖情况</title>
		<next:ScriptManager/>
			<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>	
		<script type="text/javascript" src="prsawardsmeritorious.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="prsawardsmeritoriousDataset"
		cmd="com.inspur.cams.prs.prsawardsmeritorious.cmd.PrsAwardsMeritoriousQueryCommand"
		global="true">
		<model:record  fromBean="com.inspur.cams.prs.prsawardsmeritorious.dao.PrsAwardsMeritorious" >
			<model:field name="awardsId" mapping="AWARDS_ID" type="string" />
			<model:field name="soldiersId" mapping="SOLDIERS_ID" type="string" />
			<model:field name="awardsType" mapping="AWARDS_TYPE" type="string" />
			<model:field name="awardsName" mapping="AWARDS_NAME" type="string" />
			<model:field name="awardsNumber" mapping="AWARDS_NUMBER" type="string" />
			<model:field name="awardsTime" mapping="AWARDS_TIME" type="string" />
			<model:field name="awardsNote" mapping="AWARDS_NOTE" type="string" />
		</model:record>
	</model:dataset>
    <!-- 立功受奖种类 -->
	<model:dataset id="AwardsTypeDataset" enumName="AWARDS.CODE" 
             autoLoad="true" global="true"></model:dataset>	
    <!-- 立功受奖名称 -->
	<model:dataset id="AwardsNameDataset" enumName="AWARDS.CASE" 
             autoLoad="true" global="true"></model:dataset>	
</model:datasets>
<next:EditGridPanel id="awardGridPanel" name="prsawardsmeritoriousGrid" width="100%" stripeRows="true" height="100%" clickToSelectedForChkSM="true" dataset="prsawardsmeritoriousDataset" >
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	        <next:ToolBarItem symbol="-" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="增加" handler="insertWin"  />
			<next:ToolBarItem iconCls="edit" text="修改" handler="update" />
			<next:ToolBarItem iconCls="remove" text="删除" handler="del"  />
			<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="awardsType" header="立功受奖种类" dataset="AwardsTypeDataset" field="awardsType"
							width="95">
			
		</next:Column>

		<next:Column id="awardsName" header="立功受奖名称" field="awardsName" dataset="AwardsNameDataset" width="200">
			
		</next:Column>
		<next:Column id="awardsNumber" header="立功受奖次数" field="awardsNumber" width="95" renderer="changeAwardsNumber">
			
		</next:Column>
		<next:Column id="awardsTime" header="立功受奖年份" field="awardsTime" width="100">
			
		</next:Column>
		<next:Column id="awardsNote" header="立功受奖具体时间" field="awardsNote" width="450">
			
		</next:Column>
		</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="prsawardsmeritoriousDataset"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id="awardWin" title="增加立功受奖" expandOnShow="false" closeAction="hide"  resizable="false" width="500" height="300" closable="false">
	<next:Html>
		<fieldset>
			<form id="awardForm" method="post"
				dataset="prsawardsmeritoriousDataset" onsubmit="return false"
				style="padding: 5px;" class="L5form">
			<table border="0" width="98%">
				<tr>
					<td class="FieldLabel" >立功受奖种类</td>
					<td class="FieldInput" width="70%"><select id="awardsType" 
					 name="awardsType" field="awardsType" title="立功受奖种类" />
					 <option dataset="AwardsTypeDataset"></option>
					 </select><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">立功受奖名称</td>
					<td class="FieldInput"><select id="awardsName"
					 name="awardsName" field="awardsName" title="立功受奖名称" />
					 <option dataset="AwardsNameDataset"></option>
					 </select><font color="red">*</font></td>
				</tr>
				<tr>
					<td class="FieldLabel">立功受奖次数</td>
					<td class="FieldInput"><input type="text" id="awardsNumber"
					 name="awardsNumber" field="awardsNumber" title="立功受奖次数" /><font color="red">*</font></td>
				     </tr>
				<tr>
					<td class="FieldLabel">立功受奖年份</td>
					<td class="FieldInput"><input type="text" id="awardsTime"
					 name="awardsTime" field="awardsTime" title="立功受奖年份" 
					 maxlength="4" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">立功受奖具体时间</td>
					<td class="FieldInput" ><textarea id="awardsNote" width="300" style="width:80%"
					 name="awardsNote" field="awardsNote" title="立功受奖具体时间" rows="5" /></textarea></td> 
				</tr>
			</table>
		</fieldset>
	</next:Html>
	<next:Buttons>
		<next:ToolButton text="继续添加" handler="awardSubmit"></next:ToolButton>
		<next:ToolButton text="确定" handler="hide"></next:ToolButton>
		<next:ToolButton text="关闭" handler="close"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>
