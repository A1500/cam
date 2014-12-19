<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.marry.util.CheckStatus"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>等级评定</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "cams.js") %>"></script>
<script type="text/javascript" src="mrmLevelReCheckCheckList.js"></script>
<script type="text/javascript">
var ifDepart='<%=request.getParameter("ifDepart")%>';
var DJC_BC = '<%=CheckStatus.DJC_BC%>';
var DJC_SB = '<%=CheckStatus.DJC_SB%>';
var QX_TG = '<%=CheckStatus.QX_TG%>';
var QX_WTG = '<%=CheckStatus.QX_WTG%>';
var DS_TG = '<%=CheckStatus.DS_TG%>';
var DS_WTG = '<%=CheckStatus.DS_WTG%>';
var S_TG = '<%=CheckStatus.S_TG%>';
var S_WTG = '<%=CheckStatus.S_WTG%>';
var B_TG = '<%=CheckStatus.B_TG%>';
var B_WTG = '<%=CheckStatus.B_WTG%>';
var organCode = '<%=BspUtil.getOrganCode()%>';
var organType = '<%=BspUtil.getOrganType()%>';
if("1"==ifDepart){
	organCode="999";
	organType="0";
}
//查询条件面板打开合并函数
function collapse(element){
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){	
		fieldsetParent.getElementsByTagName("div")[0].style.display="none";
		element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
		element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
		element.expand =true;
	}
}
</script>

</head>
<body>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="daiBanDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
			<model:field name="lastOrganName" type="string" />
			<model:field name="lastAuditTime" type="string" />
		</model:record>
	</model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="yiBanDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
			<model:field name="yiBanOpinionId" type="string" />
			<model:field name="yiBanTime" type="string" />
		</model:record>
	</model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="banJieDataSet" cmd="com.inspur.cams.marry.base.cmd.MrmOrganStandardApplyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmOrganStandardApply">
		</model:record>
	</model:dataset>
	<!-- 等级 -->
	<model:dataset id="evaluLevelDataSet" enumName="MRM.EVALULEVEL.TYPE" global="true" autoLoad="true" />
	<model:dataset id="opinionDataSet" enumName="MRM.WORKFLOW.OPINION" autoLoad="true" global="true" />
</model:datasets>

<next:ViewPort>
	<next:TabPanel width="100%" height="100%">
		<next:Tabs>			
			<next:Panel id="dbPan" title="待办任务" width="100%" height="100%">
				<next:Panel width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html><center>		
					<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">
						查询条件 <img class="GroupBoxExpandButton"
							src="<%=SkinUtils.getImage(request,
										"groupbox_collapse.gif")%>"
							onclick="collapse(this)" />
					</legend>
					<div>
						<form style="width: 98%; height: 100%;" class="L5form">
							<table  border="1" width="100%">
								<tr>
								 	<td class="FieldLabel" style="width:10%">申报单位</td>
					                <td class="FieldInput" style="width:20%"><input id="dbOrganName" style="width:80%"/></td>					               
					                <td class="FieldLabel" style="width:10%">申报等级</td>
					                <td class="FieldInput" style="width:20%">
					                	<select id="dbApplyLevel" style="width:80%">
					                		<option dataset="evaluLevelDataSet"></option>
					                	</select>
					                </td>		
					                <td class="FieldButton" style="width:20%">
						                <button onclick="queryDaiBan()">查询</button>&nbsp;&nbsp;<button type="reset">重置</button>
					                </td>
								</tr>
							</table>
						</form>
					</div>
					</fieldset>
					</center></next:Html>
				</next:Panel>
				 <next:GridPanel id="daiBanGridPanel" title="待办任务列表" dataset="daiBanDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:TopBar>		
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
						<next:ToolBarItem iconCls="detail"  text="办理" handler="handle"/>
					</next:TopBar>
					<next:Columns>
		   				<next:RowNumberColumn/>
		   				<next:RadioBoxColumn/>
				        <next:Column header="申报单位" field="organName" width="200" renderer="renderOrganName"></next:Column>
		    			<next:Column header="申报等级" field="applyLevel" width="120" dataset="evaluLevelDataSet"></next:Column>
						<next:Column header="申报时间" field="applyTime" width="150" renderer="renderTime" ></next:Column>
						<next:Column header="上一环节处理单位" field="lastOrganName" width="200" ></next:Column>
						<next:Column header="上一环节处理时间" field="lastAuditTime" width="150" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="daiBanDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			
			<next:Panel id="ybPan" title="已办任务" width="100%" height="100%">
				<next:Panel width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html><center>		
					<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">
						查询条件 <img class="GroupBoxExpandButton"
							src="<%=SkinUtils.getImage(request,
										"groupbox_collapse.gif")%>"
							onclick="collapse(this)" />
					</legend>
					<div>
						<form style="width: 98%; height: 100%;" class="L5form">
							<table  border="1" width="100%">
								<tr>
								 	<td class="FieldLabel" style="width:10%">申报单位</td>
					                <td class="FieldInput" style="width:20%"><input id="ybOrganName" style="width:80%"/></td>					               
					                <td class="FieldLabel" style="width:10%">申报等级</td>
					                <td class="FieldInput" style="width:20%">
					                	<select id="ybApplyLevel" style="width:80%">
					                		<option dataset="evaluLevelDataSet"></option>
					                	</select>
					                </td>		
					                <td class="FieldButton" style="width:20%">
						                <button onclick="queryYiBan()">查询</button>&nbsp;&nbsp;<button type="reset">重置</button>
					                </td>
								</tr>
							</table>
						</form>
					</div>
					</fieldset>
					</center></next:Html>
				</next:Panel>
				<next:GridPanel id="yiBanGridPanel" title="已办任务列表" dataset="yiBanDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:Columns>
		   				<next:RowNumberColumn/>
		   				<next:RadioBoxColumn/>
				        <next:Column header="申报单位" field="organName" width="200" renderer="renderOrganName"></next:Column>
		    			<next:Column header="申报等级" field="applyLevel" width="120" dataset="evaluLevelDataSet"></next:Column>
						<next:Column header="申报时间" field="applyTime" width="150" renderer="renderTime" ></next:Column>
						<next:Column header="本级审核意见" field="yiBanOpinionId" width="150" dataset="opinionDataSet"></next:Column>
						<next:Column header="本级审核时间" field="yiBanTime" width="150" ></next:Column>
						<next:Column header="当前环节处理单位" field="curOrganName" width="200" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="yiBanDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			
			<next:Panel id="bjPan" title="办结任务" width="100%" height="100%">
				<next:Panel width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
					<next:Html><center>		
					<fieldset  style="width:98%;overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">
						查询条件 <img class="GroupBoxExpandButton"
							src="<%=SkinUtils.getImage(request,
										"groupbox_collapse.gif")%>"
							onclick="collapse(this)" />
					</legend>
					<div>
						<form style="width: 98%; height: 100%;" class="L5form">
							<table  border="1" width="100%">
								<tr>
								 	<td class="FieldLabel" style="width:10%">申报单位</td>
					                <td class="FieldInput" style="width:20%"><input id="bjOrganName" style="width:80%"/></td>					               
					                <td class="FieldLabel" style="width:10%">申报等级</td>
					                <td class="FieldInput" style="width:20%">
					                	<select id="bjApplyLevel" style="width:80%">
					                		<option dataset="evaluLevelDataSet"></option>
					                	</select>
					                </td>		
					                <td class="FieldButton" style="width:20%">
						                <button onclick="queryBanJie()">查询</button>&nbsp;&nbsp;<button type="reset">重置</button>
					                </td>
								</tr>
							</table>
						</form>
					</div>
					</fieldset>
					</center></next:Html>
				</next:Panel>
				 <next:GridPanel id="banJieGridPanel" title="办结任务列表" dataset="banJieDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
					<next:Columns>
		   				<next:RowNumberColumn/>
		   				<next:RadioBoxColumn/>
				        <next:Column header="申报单位" field="organName" width="200" renderer="renderOrganName"></next:Column>
		    			<next:Column header="申报等级" field="applyLevel" width="120" dataset="evaluLevelDataSet"></next:Column>
						<next:Column header="申报时间" field="applyTime" width="150" renderer="renderTime" ></next:Column>
						<next:Column header="审批结果" field="auditResult"  width="100"  renderer="renderAuditResult"></next:Column>							
						<next:Column header="审批时间" field="departmentAuditTime" width="150" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="banJieDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>
</body>
</html>