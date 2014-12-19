<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.*"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="preapplyList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript">
<%
	String sorgType= request.getParameter("sorgType");

	String startString ="";
	if("S".equals(sorgType)){
		startString="0%";
	}else if("J".equals(sorgType)){
		startString="2%";
	}else if("M".equals(sorgType)){
		startString="1%";
	}
%>
var sorgId='<%=request.getParameter("sorgId")%>';
var sorgType='<%=request.getParameter("sorgType")%>';
var morgArea='<%=BspUtil.getOrganCode()%>';
var startString='<%=startString%>';
var errorMsg="请选择一条记录进行查看!";
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" method="queryHasAcceptStatusNew" pageSize="15" global="true" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<model:dataset id="somApplyYiBanDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" method="queryHasAcceptStatusYiBanNew" pageSize="15" global="true" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="applyTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='com_som_apply_type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="applyTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='com_som_apply_type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN_ONLINE'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='SORG_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="onlineStatusDataSet" enumName="SOM.ONLINE_STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="onlineStatusDS" enumName="SOM.ONLINE_STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:TabPanel width="100%" height="100%">
		<next:Tabs>
			<next:Panel width="100%" height="100%" title="待办业务">
				<next:Panel  width="100%"  border="0">
					<next:Html>
						<form class="L5form">
						<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件</legend>
						<table border="1" width="100%">
							<tr>
								<td class="FieldLabel" style="width: 10%">社会组织名称：</td>
								<td class="FieldInput" style="width: 20%"><input
									type="text" id="cnName" style="width: 80%" /></td>
								<td class="FieldLabel" style="width: 10%">受理编号：</td>
								<td class="FieldInput" style="width: 20%"><input
									type="text" id="taskCode" style="width: 80%" /></td>

										<td class="FieldLabel" style="width: 10%">登记证号：</td>
								<td class="FieldInput" style="width: 20%"><input
									type="text" id="sorgCode" style="width: 80%" /></td>

								<td class="FieldButton" style="width: 20%">
								<button onclick="queryItem()">查询</button>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 10%">业务种类：</td>
								<td class="FieldInput" style="width: 20%"><select
									id="applyType" style="width:80%">
									<option dataset="applyTypeDataset"></option>
								</select></td>
								<td class="FieldLabel" style="width: 10%">交换状态：</td>
								<td class="FieldInput" style="width: 20%"><select
									id="onlineStatus" style="width:80%">
									<option dataset="onlineStatusDataSet"  ></option>
								</select></td>
									<td class="FieldLabel" style="width: 10%"> &nbsp;</td>
								<td class="FieldInput" style="width: 20%"> &nbsp;</td>

								<td class="FieldButton" style="width: 20%">
								<button type="reset">重置</button>
								</td>
							</tr>
						</table>
						</fieldset>
						</form>
					</next:Html>
				</next:Panel>
					<next:GridPanel id="preGrid" dataset="somApplyDataSet" title="社会组织外网受理待办列表"
						width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="detail" text="受理" handler="detail"></next:ToolBarItem>
							<next:ToolBarItem iconCls="delete" text="删除" handler="updateOnlineStatusDel"></next:ToolBarItem>
							<next:ToolBarItem iconCls="undo" text="退回" handler="updateOnlineStatusN"></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="受理编号" field="TASK_CODE" sortable="true"
								width="20%" editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="业务种类" field="APPLY_TYPE"
								dataset="applyTypeDS" sortable="true" width="20%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="社会组织名称" field="CN_NAME" sortable="true"
								editable="false" width="20%">
								<next:TextField></next:TextField>
							</next:Column>
							<next:Column header="登记证号" field="SORG_CODE" sortable="true"
								editable="false" width="10%"  >
								<next:TextField></next:TextField>
							</next:Column>
							<next:Column field="ONLINE_STATUS" header="业务状态" width="10%" sortable="false"
							 dataset="onlineStatusDataSet"></next:Column>
							<next:Column header="创建时间" field="CREATE_TIME" sortable="true"
								editable="false" width="10%">
								<next:TextField />
							</next:Column>
							<next:Column header="创建人" field="CREATE_PERSON" sortable="true"
								editable="false" width="10%">
								<next:TextField />
							</next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somApplyDataSet" />
						</next:BottomBar>
					</next:GridPanel>
				</next:Panel>
			<next:Panel width="100%" height="100%" title="已办业务">
				<next:Panel  width="100%"  border="0">
					<next:Html>
						<form class="L5form">
						<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件</legend>
						<table border="1" width="100%">
							<tr>
								<td class="FieldLabel" style="width: 15%">社会组织名称：</td>
								<td class="FieldInput" style="width: 25%"><input
									type="text" id="cnNameY" style="width: 80%" /></td>
								<td class="FieldLabel" style="width: 15%">受理编号：</td>
								<td class="FieldInput" style="width: 25%"><input
									type="text" id="taskCodeY" style="width: 80%" /></td>
								<td class="FieldButton" style="width: 20%">
								<button onclick="queryItemYiBan()">查询</button>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 15%">业务种类：</td>
								<td class="FieldInput" style="width: 25%"><select
									id="applyTypeY" style="width:90%">
									<option dataset="applyTypeDataset"></option>
								</select></td>

								<td class="FieldLabel" style="width: 15%">登记证号：</td>
								<td class="FieldInput" style="width: 25%"><input
									type="text" id="sorgCodeY" style="width: 80%" /></td>
								<td class="FieldButton" style="width: 20%">
								<button type="reset">重置</button>
								</td>
							</tr>
						</table>
						</fieldset>
						</form>
					</next:Html>
				</next:Panel>
					<next:GridPanel dataset="somApplyYiBanDataSet" title="社会组织外网受理已办列表"
						width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="受理编号" field="TASK_CODE" sortable="true"
								width="20%" editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="业务种类" field="APPLY_TYPE"
								dataset="applyTypeDS" sortable="true" width="20%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="社会组织名称" field="CN_NAME" sortable="true"
								editable="false" width="20%">
								<next:TextField></next:TextField>
							</next:Column>
							<next:Column header="登记证号" field="SORG_CODE" sortable="true"
								editable="false" width="10%"  >
								<next:TextField></next:TextField>
							</next:Column>
							<next:Column header="业务状态" field="ONLINE_STATUS" sortable="true"
								editable="false" width="10%" dataset="onlineStatusDS">
								<next:TextField />
							</next:Column>
							<next:Column header="创建时间" field="CREATE_TIME" sortable="true"
								editable="false" width="10%">
								<next:TextField />
							</next:Column>
							<next:Column header="创建人" field="CREATE_PERSON" sortable="true"
								editable="false" width="10%">
								<next:TextField />
							</next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somApplyYiBanDataSet" />
						</next:BottomBar>
					</next:GridPanel>
				</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>
<next:Window id="undo_Win" closeAction="hide" title="回退原因窗口" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="确定" handler="confirmSubmitFuncN"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeSubmitFuncN"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post"  onsubmit="return false" class="L5form" >
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 20%">回退原因：</td>
					<td class="FieldInput" style="width: 80%"><textarea id="undoSeason" rows="3" style="width: 98%" name='回退原因' ></textarea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
</body>
</html>