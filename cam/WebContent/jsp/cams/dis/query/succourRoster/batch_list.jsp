
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>批次列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="batch_list.js"></script>
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
			 var organCode = '<%=BspUtil.getOrganCode()%>';
		   	 var organName = '<%=BspUtil.getOrganName()%>';
		   	var reliefType='<%=request.getParameter("reliefType")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="batchds" cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCommand" method="queryBatchForRoster" global="true" pageSize="10">
		<model:record >
			<model:field name="batchId" mapping="BATCH_ID" type="string"/>
			<model:field name="batchDetailId" mapping="DETAIL_PID" type="string"/>
			<model:field name="batchName" mapping="BATCH_NAME" type="string" />
			<model:field name="areaCode" mapping="AREA_CODE" type="string"/>
			<model:field name="areaName" mapping="AREA_NAME" type="string"/>
			<model:field name="reliefType" mapping="RELIEF_TYPE" type="string" />
			<model:field name="year" mapping="YEAR" type="string"/>
			<model:field name="createPerson" mapping="CREATE_PERSON" type="string" />
			<model:field name="createOrgan" mapping="CREATE_ORGAN" type="string"/>
			<model:field name="createTime" mapping="CREATE_TIME" type="string" />
			<model:field name="approvalFood" mapping="APPROVAL_FOOD" type="string"></model:field>
			<model:field name="approvalClothes" mapping="APPROVAL_CLOTHES" type="string"></model:field>
			<model:field name="approvalRebuiledHouse" mapping="APPROVAL_REBUILED_HOUSE" type="string"></model:field>
			<model:field name="approvalRepairedHouse" mapping="APPROVAL_REPAIRED_HOUSE" type="string"></model:field>
			<model:field name="approvalMonry" mapping="APPROVAL_MONRY" type="string"></model:field>
		</model:record>
	</model:dataset>
	<model:dataset id="ReliefTypeDataset" enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>

<next:Panel  name="form" width="100%" border="0" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
									
								
								<td class="FieldLabel">所属年份:</td>
								<td class="FieldInput">
								
								<input type="text" id="ssnf" name="ssnf" title="所属年份" value="" />
								
								</td>																
								<td class="FieldLabel"  style="text-align:left;padding-left:69px;"><button onclick="query()">查 询</button> </td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="disreliefinfoGrid" width="100%" stripeRows="true" clickToSelectedForChkSM="true" height="100%" dataset="batchds" title="批次信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="sure()"></next:ToolBarItem>
		<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
		<next:ToolBarItem id="closeButoon" iconCls="no" text="清除" handler="clears()"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	
		<next:Column  header="批次名称" field="batchName" width="120" >
			<next:TextField allowBlank="false"/>
		</next:Column>
	
		<next:Column  header="所需填报单位名称" field="areaName" width="400" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column header="救助类型" field="reliefType" dataset="ReliefTypeDataset" width="150" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column header="所属年份" field="year" id="year" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="approvalFood" header="核准救助粮食（公斤）" field="approvalFood" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalClothes" header="核准救助衣被（件）" field="approvalClothes" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="approvalRebuiledHouse" header="核准重建间数（间）" field="approvalRebuiledHouse" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalRepairedHouse" header="核准修缮间数（间）" field="approvalRepairedHouse" width="90" hidden="true">
			<next:TextField  />
		</next:Column>
	
		<next:Column id="approvalMonry" header="核准救助资金（元）" field="approvalMonry" width="90" hidden="true">
			<next:NumberField  />
		</next:Column>
		<next:Column header="创建人" field="createPerson" width="100" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="创建单位" field="createOrgan" width="100" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column header="创建时间" field="createTime"  width="100" >
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="batchds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
