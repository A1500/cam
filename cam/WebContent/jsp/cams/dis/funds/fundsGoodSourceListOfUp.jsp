<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>物资调拨</title>
<next:ScriptManager />
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "cams.js")%>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "camsCheck.js")%>"></script>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
</script>
<script type="text/javascript" src="fundsComm.js"></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="fundsGoodSourceListOfUp.js"></script>
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
		</script>
</head>
<body>

<model:datasets>
	<!--物资调拨批次-->
	<model:dataset id="disDetailSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailSourceQueryCmd"
		sortField="DIS_YEAR DESC,ALLOCATION_TIME DESC,DETAIL_ID">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisDetailSource">
		</model:record>
	</model:dataset>
	
	<!--物资明细-->
	<model:dataset id="disDetailBatchSourceDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailBatchSourceQueryCmd"
		pageAble="false" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisDetailBatchSource">
		</model:record>
	</model:dataset>

	<!-- 发放物资类型-->
	<model:dataset id="dmDisMaterialTypeDs"
		cmd="com.inspur.cams.dis.base.cmd.DicDisMaterialTypeQueryCmd" autoLoad="true" 
		pageAble="false" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DicDisMaterialType">
	 		<model:field name="value" mapping="code" type="string" />
			<model:field name="text" mapping="name" type="string" />
		</model:record>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 资金类型 -->
	<model:dataset id="disAllocationTypeDs" enumName="DIS.ALLOCATION_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="disAllocationPurposeDs"
		enumName="DIS.ALLOCATION_PURPOSE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<!--	资金拨付		-->
<next:Panel width="100%" border="0">
	<next:Html>
		<fieldset><legend>查询条件 <img
			class="GroupBoxExpandButton"
			src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>
			onclick="collapse(this)" /> </legend>
		<div>
		<form class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel" width="100px">年度：</td>
				<td class="FieldInput" width="200px"><input type="text"
					id="qDisYear" class="TextEditor" title="年度" maxlength="4"
					style="width: 60px;" /></td>
				<td class="FieldLabel" width="100px">调拨单号：</td>
				<td class="FieldInput"><input type="text" id="qUpAllocationNum"
					class="TextEditor" title="调拨单号" /></td>

			</tr>
			<tr>
				<td class="FieldLabel" nowrap>物资用途：</td>
				<td class="FieldInput"><select id="qUpAllocationPurpose"
					class="TextEditor" title="物资用途" style="width: 180px;">
					<option dataset="disAllocationPurposeDs"></option>
				</select></td>
				<td nowrap="nowrap" class="FieldLabel" colspan="2">
				<button onclick="query()">查 询</button>
				&nbsp;
				<button type="reset">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="allocationGridPanel" dataset="disDetailSourceDs"
	autoExpandColumn="note" name="allocationGridPanel" width="99.9%"
	height="100%" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem text="上级调拨物资管理"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detailAllo" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="batchId" header="批次ID" field="batchId" align="center"
			hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="disYear" header="年度" field="disYear" align="center"
			width="60">
			<next:TextField />
		</next:Column>
		<next:Column id="allocationTime" header="调拨日期" field="allocationTime"
			align="center" width="80">
			<next:TextField />
		</next:Column>
		<next:Column id="upAllocationNum" header="调拨单号"
			field="upAllocationNum" align="center" width="120">
			<next:TextField />
		</next:Column>

		<next:Column id="upAllocationPurpose" header="物资用途"
			field="upAllocationPurpose" align="left"
			renderer="upAllocationPurposeRenderer" width="130">
			<next:TextField />
		</next:Column>
		<next:Column id="note" header="备注" field="note" align="left">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="disDetailSourceDs" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>

<!--物资采购基本信息维护-->
<next:Window id="sourceUpWin" width="800" height="400"
	collapsible="false" closable="close" resizable="false" modal="true"
	title="上级调拨物资信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="btnCancel" iconCls="no" text="取消"
			handler="onCloseDetails"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel width="100%" height="100%">
		<next:Panel>
			<next:Html>
				<form method="post" onsubmit="return false" class="L5form"
					dataset="disDetailSourceDs">
				<table border="0" width="100%">
					<tr>
						<td class="FieldLabel" width="15%">年度:</td>
						<td class="FieldInput"><label field="disYear" /></td>
						<td class="FieldLabel" width="15%" rowspan="3">物资用途:</td>
						<td class="FieldInput" rowspan="3"><input type="checkbox"
							name="upAllocationPurpose" value="DC" field="upAllocationPurpose"
							disabled="disabled" />冬春生活救助 <br />
						<input type="checkbox" name="upAllocationPurpose" value="YJ"
							field="upAllocationPurpose" disabled="disabled" />应急生活救助 <br />
						<input type="checkbox" name="upAllocationPurpose" value="CJ"
							field="upAllocationPurpose" disabled="disabled" />灾区民房恢复重建补助 <br />
						<input type="checkbox" name="upAllocationPurpose" value="GD"
							field="upAllocationPurpose" disabled="disabled" />过渡性生活补助 <br />
						<input type="checkbox" name="upAllocationPurpose" value="SW"
							field="upAllocationPurpose" label="物资用途" disabled="disabled" />遇难人员家属抚慰</td>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" width="15%">调拨日期:</td>
						<td class="FieldInput"><label field="allocationTime" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="15%">调拨单号:</td>
						<td class="FieldInput"><label field="upAllocationNum" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" width="15%">备注:</td>
						<td class="FieldInput" colspan="3"><label field="note" /></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="allocationAllGrid"
			dataset="disDetailBatchSourceDs" height="198" width="98%"
			stripeRows="true" notSelectFirstRow="true">
			<next:TopBar>
				<next:ToolBarItem text="上级调拨物资明细"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="45" />
				<next:Column header='物资类型' field="meterialType" width="130"
					renderer="meterialTypeRenderer">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="物资单位" field="meterialUnit" align="center"
					width="80">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="物资数量" field="meterialNum" align="right"
					renderer="formatMoneyForDis" width="120">
					<next:TextField editable="false" />
				</next:Column>
			</next:Columns>
		</next:GridPanel>
	</next:Panel>
</next:Window>