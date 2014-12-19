
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>批次信息明细</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="query_batch_detail_list.js"></script>
		<script>
			var batchId='<%=request.getParameter("batchId")%>';
			 var organCode = '<%=BspUtil.getOrganCode()%>';
		   	 var organName = '<%=BspUtil.getOrganName()%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCommand" global="true" method="queryDetail">
		<model:record>
			<model:field name="batchId" mapping="BATCH_ID" type="string"></model:field>
			<model:field name="batchDetailId" mapping="BATCH_DETAIL_ID" type="string"></model:field>
			<model:field name="reliefType" mapping="RELIEF_TYPE" type="string"></model:field>
			<model:field name="batchName" mapping="BATCH_NAME" type="string"></model:field>
			<model:field name="requiredOrganCode" mapping="REQUIRED_ORGAN_CODE" type="string"></model:field>
			<model:field name="requiredOrganName" mapping="REQUIRED_ORGAN_NAME" type="string"></model:field>
			<model:field name="fillState" mapping="FILL_STATE" type="string"></model:field>
			<model:field name="fillPeople" mapping="FILL_PEOPLE" type="string"></model:field>
			<model:field name="fillTime" mapping="FILL_TIME" type="string"></model:field>
			<model:field name="approvalFood" mapping="APPROVAL_FOOD" type="string"></model:field>
			<model:field name="approvalClothes" mapping="APPROVAL_CLOTHES" type="string"></model:field>
			<model:field name="approvalRebuiledHouse" mapping="APPROVAL_REBUILED_HOUSE" type="string"></model:field>
			<model:field name="approvalRepairedHouse" mapping="APPROVAL_REPAIRED_HOUSE" type="string"></model:field>
			<model:field name="approvalMonry" mapping="APPROVAL_MONRY" type="string"></model:field>
		</model:record>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="reliefTypeDs" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true">
	</model:dataset>
	<model:dataset id="fillstateDs" enumName="DIS.BATCHDETAIL_FILL_STATE" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>

<next:Panel name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
									
								<td class="FieldLabel">填报单位名称:</td>
								<td class="FieldInput">
									<input type="hidden" id="organcode" name="organcode" value="" />
									<input type="text" id="organname" name="organname" title="填报单位名称"  readonly="readonly" style="width:180px" />
									
									<img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand"  onclick="forOrganSelect()"/>
								</td>	
							
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" height="100%" name="disreliefinfoGrid" clickToSelectedForChkSM="true" width="100%" stripeRows="true"clickToSelectedForChkSM="true" dataset="ds" title="批次救助记录">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="详细" iconCls="detail" handler="detail" />
		<next:ToolBarItem text="返回" iconCls="undo" handler="back" />
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	
		<next:Column id="batchId" header="批次编号" field="batchId" width="120" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="batchName" header="批次名称" field="batchName" width="90" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="reliefType" header="救助类型" field="reliefType" width="180" dataset="reliefTypeDs">
			<next:TextField></next:TextField>
		</next:Column>
		
		<next:Column id="requiredOrganCode" header="填报单位区划" field="requiredOrganCode" width="180" hidden="true" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="requiredOrganName" header="填报单位名称" field="requiredOrganName" width="180" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="approvalFood" header="核准救助粮食（公斤）" field="approvalFood" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalClothes" header="核准救助衣被（件）" field="approvalClothes" width="90" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="approvalRebuiledHouse" header="核准重建间数（间）" field="approvalRebuiledHouse" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalRepairedHouse" header="核准修缮间数（间）" field="approvalRepairedHouse" width="90" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalMonry" header="核准救助资金（元）" field="approvalMonry" width="90" >
			<next:NumberField  />
		</next:Column>
	
		<next:Column id="fillPeople" header="提交人" field="fillPeople" width="90" hidden="true" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="fillTime" header="提交时间" field="fillTime" width="180" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="fillState" header="填报状态" field="fillState" dataset="fillstateDs" width="90" >
			<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>