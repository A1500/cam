<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>任务查询</title>
<next:ScriptManager></next:ScriptManager>
<%
String organCode = BspUtil.getCorpOrgan().getOrganCode();
if(organCode.endsWith("0000000000")){//省370000000000
	organCode= organCode.substring(0,2);
} else if (organCode.endsWith("00000000")){//市370100000000
	organCode=  organCode.substring(0,4);
} else if (organCode.endsWith("000000")){//县370104000000
	organCode=  organCode.substring(0,6);
} else if (organCode.endsWith("000")){//乡370104003000
	organCode=  organCode.substring(0,9);
}
%>
<script type="text/javascript" src="welfarecorpYearlyCheckList.js"></script>
<script language="javascript" type="text/javascript">
var organCode='<%=organCode%>';
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
	<!-- 待办业务表 -->
	<model:dataset id="daiBanDataset" cmd="com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyQueryCmd" method="queryQualificationList">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<!-- 已办业务表 -->
	<model:dataset id="yiBanDataset" cmd="com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyQueryCmd" method="queryQualificationList">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<!-- 业务信息表 -->
	<model:dataset id="wealUnitInfoDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealUnitInfoQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitInfo">
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="legalPeople" type="string" rule="require" />
		<model:field name="regDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- apply表 -->
	<model:dataset id="ApplyDataset" cmd="com.inspur.cams.welfare.base.cmd.WealUnitApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<!-- 职工信息表 -->
	<model:dataset id="wealWorkerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
		<model:params>
			<model:param name="CERT_CODE@<>" value=''></model:param>
		</model:params>
	</model:dataset>
	
</model:datasets>
<next:ViewPort>
	<next:TabPanel width="100%" height="100%">
		<next:Tabs>
			<next:Panel title="待办任务" width="100%" height="100%" >
				<next:Panel width="100%" border="0">
					<next:Html>			
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form onsubmit="return false;" class="L5form">				
								<table  border="1" width="100%">
									<tr>
										<td class="FieldLabel" width="10%">企业名称：</td>
							            <td class="FieldInput" width="40%"><input type="text"  id="queryCompanyName" style="width:40%" /></td>
										<td class="FieldButton" width="10%"><button onclick="queryDaiban()">查询</button>&nbsp;&nbsp;&nbsp;
										<button type="reset">重置</button></td>
									</tr>
								</table>
							</form>	
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:GridPanel id="daiBanTaskGridPanel" name="daiBanTaskGridPanel" width="100%" height="100%" dataset="daiBanDataset" title="待办列表" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>			
						<next:ToolBarItem iconCls="add"  text="新增" handler="add"/>
						<next:ToolBarItem iconCls="edit"  text="修改" handler="edit"/>
						<next:ToolBarItem iconCls="detail"  text="明细" handler="detailDaiban"/>
						<next:ToolBarItem iconCls="remove"  text="删除" handler="del"/>
						<next:ToolBarItem iconCls="delete"  text="驳回" handler="reject"/>
						<next:ToolBarItem iconCls="select"  text="提交" handler="submit"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="COMPANY_NAME" header="企业名称" field="COMPANY_NAME" width="15%" ></next:Column>
						<next:Column id="DATA_SOURCE" header="数据来源" field="DATA_SOURCE" hidden="true" ></next:Column>
						<next:Column id="APPLY_YEAR" header="业务年度" field="APPLY_YEAR" width="10%" ></next:Column>
						<next:Column id="REG_DATE" header="填表时间" field="REG_DATE" width="15%" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="daiBanDataset"/>
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
	
			<next:Panel title="已办任务" width="100%" height="100%">
				<next:Panel width="100%" border="0" >	
					<next:Html>				
					<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件
							<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
						</legend>
						<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
							<form onsubmit="return false;" class="L5form">				
								<table  border="1" width="100%">
									<tr>						
								 		<td class="FieldLabel" width="10%">企业名称：</td>
				                 		<td class="FieldInput" width="40%"><input type="text"  id="queryCompanyName1" style="width:40%" /></td>
										<td class="FieldButton" width="10%"><button onclick="queryYiban()">查询</button>&nbsp;&nbsp;&nbsp;
										<button type="reset">重置</button></td>
									</tr>
								</table>
							</form>	
						</div>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:GridPanel id="yiBanTaskGridPanel" name="yiBanTaskGridPanel" width="100%" height="100%" dataset="yiBanDataset" title="已办流程列表" notSelectFirstRow="true">
					<next:TopBar>	
						<next:ToolBarItem symbol="->"></next:ToolBarItem>	
						<next:ToolBarItem iconCls="detail"  text="明细" handler="detailYiban"/>	
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="COMPANY_NAME" header="企业名称" field="COMPANY_NAME" width="15%" ></next:Column>
						<next:Column id="DATA_SOURCE" header="数据来源" field="DATA_SOURCE" hidden="true" ></next:Column>
						<next:Column id="APPLY_YEAR" header="业务年度" field="APPLY_YEAR" width="10%" ></next:Column>
						<next:Column id="REG_DATE" header="填表时间" field="REG_DATE" width="15%" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="yiBanDataset"/>
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>

</body>
</html>