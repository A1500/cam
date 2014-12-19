
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>

<html>
	<head>
		<title>安全日志列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="pubauditlog_list.js"></script>
		<script language="javascript">
		 //查询条件打开合并函数
		 	function collapse(element){
	 			var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("table")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("table")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="org.loushang.bsp.permit.audit.cmd.PubAuditLogQueryCommand" global="true" pageSize="15" pageAble="true"  >
		<model:record fromBean="org.loushang.bsp.permit.audit.data.SecurityLog">
		<model:field name="deptName" type="string" />
		<model:field name="corpName" type="string" />
		</model:record>
	</model:dataset>
	<model:dataset id="logDs" global="true">
	<model:record fromBean="org.loushang.bsp.permit.audit.data.SecurityLog">
	<model:field name="operationName" type="string" />	
	</model:record>
   </model:dataset>
</model:datasets>
<next:ViewPort id="cards">
<next:CardLayout>
<next:Panel id="loglist" width="100%" height="100%" >
<next:Panel  name="form" width="100%" border="0"  autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">安全日志查询
			<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this)"/>
		</legend> 
		<form class="L5form">
		<table  border="1" width="100%" >
		<tr>
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
					color="red">*</font></td>
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
			<td class="FieldLabel"><button type="button" onclick="query()">查询</button> </td>
			<td class="FieldLabel"><button type="button" onclick="reset()">重置</button> </td>
		    </tr>
		</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="pubauditlogGrid" width="100%" stripeRows="true" height="100%" dataset="ds" title="安全日志" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail"  text='日志明细' handler="detail"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="logId" header="日志序号" field="LOG_ID" width="80" hidden='true'>
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="userId" header="用户帐号" field="USER_ID" width="160" >
			<next:TextField  />
		</next:Column>

		<next:Column id="userName" header="用户名称" field="USER_NAME" width="160" >
			<next:TextField  />
		</next:Column>

		<next:Column id="moduleName" header="模块名称" field="MODULE_NAME" width="160" >
			<next:TextField  />
		</next:Column>

		<next:Column id="functionName" header="功能名称" field="FUNCTION_NAME" width="160" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="operationName" header="操作名称" field="OPERATION_NAME" width="160" >
		<next:TextField  />
	   </next:Column>
       
	   <next:Column id="operationType" header="操作类型" field="OPERATION_TYPE" width="160" hidden="true" >
		<next:TextField  />
	   </next:Column>
	   	   
	   <next:Column id="logType" header="日志类型" field="LOG_TYPE" width="160" >
		<next:TextField  />
	   </next:Column>
	   
		<next:Column id="logTime" header="日志时间" field="logTime" width="200" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="remotehost" header="客户端" field="loginIp"  width="120" hidden="true">
		<next:TextField  />
		</next:Column>

		<next:Column id="serverhost" header="服务器" field="serverIp"  width="120" hidden="true">
		<next:TextField  />
		</next:Column>		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</next:Panel>

<next:Panel id="detailpanel"  hidden="true" title="日志明细" border="0" autoScroll="true">
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	<next:ToolBarItem iconCls="button"  text='返回' handler="back2list"/>
</next:TopBar>
	<next:Html >
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">日志信息</legend>
 	      <form class="L5form" dataset="ds">
			 <table style="width:100%">
				<tr>
					<td style="width:20%" class="FieldLabel">用户帐号</td>
					<td style="width:30%" class="FieldInput" >
						<label id="userId" field="USER_ID">
					</td>
					<td style="width:20%" class="FieldLabel">用户名称</td>
					<td style="width:30%" class="FieldInput">
						<label id="userName" field="USER_NAME">
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">所属部门</td>
					<td class="FieldInput">
						<label id="deptName" field="deptName"/>
					</td>
					<td class="FieldLabel">所属公司</td>
					<td class="FieldInput">
						<label id="corpName" field="corpName"/>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel">客户端</td>
					<td class="FieldInput">
						<label id="loginIp" field="LOGIN_IP"/>
					</td>
					<td class="FieldLabel">服务器</td>
					<td class="FieldInput">
						<label id="serverIp" field="SERVER_IP"/>
					</td>
				</tr>
				
				<tr>
				<td class="FieldLabel">模块名称</td>
				<td class="FieldInput">
					<label id="moduleName" field="MODULE_NAME"/>
				</td>
				<td class="FieldLabel">功能名称</td>
				<td class="FieldInput">
					<label id="functionName" field="FUNCTION_NAME"/>
				</td>
			  </tr>
				<tr>
					<td class="FieldLabel">操作名称</td>
					<td class="FieldInput">
						<label id="operationName" field="OPERATION_NAME"/>
					</td>
					<td class="FieldLabel">操作类型</td>
					<td class="FieldInput">
						<label id="operationType" field="OPERATION_TYPE_NAME"/>
					</td>
				</tr>
				<tr>
				<td class="FieldLabel">日志类型</td>
				<td class="FieldInput">
					<label id="logType" field="LOG_TYPE"/>
				</td>
				<td class="FieldLabel">记录时间</td>
				<td class="FieldInput">
					<label id="logTime" field="LOG_TIME"/>
				</td>
			</tr>
			<tr>
			<td class="FieldLabel">URL</td>
			<td class="FieldInput" colspan="3">
				<label id="url" field="URL"/>
			</td>
		    </tr>
			</table>
 	      </form>
 	 </fieldset>
 </next:Html>
 </next:Panel>
	
</next:CardLayout>
</next:ViewPort>
</body>
</html>
