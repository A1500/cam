<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>任务查询</title>
<next:ScriptManager></next:ScriptManager>
<%
	String act = request.getParameter("act");
%>
<script language="javascript">

</script>
<script type="text/javascript" src="unitQualificationPrintList.js"></script>
<script language="javascript" type="text/javascript">
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
	<model:dataset id="daiBanDataset" cmd="com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyQueryCmd" method="queryQualificationPrintList">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<!-- 业务信息表 -->
	<model:dataset id="wealFitInfoDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitInfoQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitInfo">
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="legalPeople" type="string" rule="require" />
		<model:field name="regDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 基本意见 -->
	<model:dataset id="wealApplyStauts" enumName="WEAL.APPLY_STAUTS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
			<next:Panel  width="100%" height="100%"  >
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
						<next:ToolBarItem iconCls="print"  text="打印材料" handler="print"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="TASK_CODE" header="业务编码" field="TASK_CODE" hidden="true"></next:Column>	
						<next:Column id="COMPANY_NAME" header="企业名称" field="COMPANY_NAME" width="15%"></next:Column>
						<next:Column id="APPLY_STAUTS" header="审批结果" field="APPLY_STAUTS"  dataset="wealApplyStauts"></next:Column>
						<next:Column id="REG_DATE" header="填表时间" field="REG_DATE" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="daiBanDataset"/>
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
	
</next:ViewPort>

</body>
</html>