
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>日志明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="pubauditlog_list.js"></script>
	</head>
<body>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">安全日志查询
			<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)"/>
		</legend>
		<table  border="1" width="100%" >
		<tr >
				<td class="FieldLabel">用户ID:</td>
				<td class="FieldInput"><input type="text" id="userId" title="用户ID"  class="TextEditor"/> </td>
				
				<td class="FieldLabel">开始时间:</td>
				<td class="FieldInput">
							<input id="pmStartTime_id" type="text"  format="Ymd H:i:s"/>
							<img  src="<%=SkinUtils.getImage(request,"default/shared/calendar.gif")%>"
							 height="20" onclick="LoushangDatetime('pmStartTime_id')" /><font
								color="red">*</font>
							</td>
				<td class="FieldLabel">结束时间:</td>
				<td class="FieldInput">
				<input id="pmEndTime_id" type="text" 	format="Ymd H:i:s" />
				<img  src="<%=SkinUtils.getImage(request,"default/shared/calendar.gif")%>"
				 height="20" onclick="LoushangDatetime('pmEndTime_id')" /><font
					color="red">*</font>
				</td>
			</tr>
			
			<tr >
			<td class="FieldLabel">模块名称:</td>
			<td class="FieldInput"><input type="text" id="moduleName"  disabled="disabled"/>
			<input type="hidden" id="moduleCode" />
			<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="selectModule(this)" />
			</td>
			<td class="FieldLabel">功能名称:</td>
			<td class="FieldInput"><input type="text" id="functionName"  disabled="disabled"/>
			<input type="hidden" id="functionCode" />
			<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="selectFunction(this)" />
			</td>
			<td class="FieldLabel">操作名称:</td>
			<td class="FieldInput"><input type="text" id="operationName"  disabled="disabled"/>
			<input type="hidden" id="operationCode"/>
			<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="selectOperation(this)" />
			</td>
			<td class="FieldLabel"><button type="button" onclick="query()">查 询</button> </td>
		    </tr>
			
		</table>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="pubauditlogGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="安全日志">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="button"  text='日志明细' handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="logId" header="日志序号" field="logId" width="80" hidden='true'>
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="userId" header="用户帐号" field="userId" width="160" >
			<next:TextField  />
		</next:Column>

		<next:Column id="userName" header="用户名称" field="userName" width="160" >
			<next:TextField  />
		</next:Column>

		<next:Column id="moduleName" header="模块名称" field="moduleName" width="160" >
			<next:TextField  />
		</next:Column>

		<next:Column id="functionName" header="功能名称" field="functionName" width="160" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="operationName" header="操作名称" field="operationName" width="160" >
		<next:TextField  />
	   </next:Column>
       
	   <next:Column id="operationType" header="操作类型" field="OPERATION_TYPE" width="160" hidden="true" >
		<next:TextField  />
	   </next:Column>
	   	   
	   <next:Column id="logType" header="日志类型" field="logType" width="160" hidden="true">
		<next:TextField  />
	   </next:Column>
	   
		<next:Column id="logTime" header="日志时间" field="logTime" width="200" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="remotehost" header="客户端IP" field="loginIp"  width="120" hidden="true">
		<next:TextField  />
		</next:Column>

		<next:Column id="serverhost" header="服务器IP" field="serverIp"  width="120" hidden="true">
		<next:TextField  />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
