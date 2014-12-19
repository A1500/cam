
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.dis.base.data.DisReliefBatchDetail;"%>
<html>
	<head>
		<title>过度性生活救助批次列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="pc_list.js"></script>
		<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
			
			var _DISRELIEFBATCHDETAIL_STATE_LR = '<%=DisReliefBatchDetail.FILL_STATE_LR%>';
			var _DISRELIEFBATCHDETAIL_STATE_XJ = '<%=DisReliefBatchDetail.FILL_STATE_XJ%>';
			var _DISRELIEFBATCHDETAIL_STATE_WC = '<%=DisReliefBatchDetail.FILL_STATE_WC%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCommand" global="true" method="queryAssistanceBatch">
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
		</model:record>
		<model:params>
			<model:param name="reliefType" value="GD"></model:param>
		</model:params>
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
									
								<td class="FieldLabel">救灾名称:</td>
								<td class="FieldInput"><input type="text"  id="pcmc" class="TextEditor" title="救灾名称"  /></td>	
							
								<td class="FieldLabel">状态:</td>
								<td class="FieldInput">
									<select id="fillstate" name="fillstate" title="状态">
										<option dataset="fillstateDs"></option>
									</select>
								</td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" height="100%" name="disreliefinfoGrid" clickToSelectedForChkSM="true" width="100%" stripeRows="true"clickToSelectedForChkSM="true" dataset="ds" title="过度性生活救助">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="提交" iconCls="add" handler="batchSubmit" />
		<next:ToolBarItem text="办理" iconCls="detail" handler="detail" />
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
		
		<next:Column id="requiredOrganCode" header="填报单位区划" field="requiredOrganCode" width="180" >
			<next:TextField  />
		</next:Column>
		
		<next:Column id="requiredOrganName" header="填报单位名称" field="requiredOrganName" width="180" >
			<next:TextField  />
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
