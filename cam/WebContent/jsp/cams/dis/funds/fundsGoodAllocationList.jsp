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
<script type="text/javascript" src="fundsGoodAllocationList.js"></script>
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
	<model:dataset id="disDetailBatchDs"
		cmd="com.inspur.cams.dis.base.cmd.DisDetailBatchQueryCmd" sortField="RECEIVE_TIME DESC,FILL_TIME DESC,BATCH_ID">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisDetailBatch"></model:record>
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

<!--	物资调拨		-->
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
				<td class="FieldLabel" nowrap>年度：</td>
				<td class="FieldInput"><input type="text" id="qDisYear"
					class="TextEditor" title="年度" maxlength="4" /></td>
				<td class="FieldLabel" nowrap>调拨单号：</td>
				<td class="FieldInput"><input type="text" id="qUpAllocationNum"
					class="TextEditor" title="调拨单号" /></td>
				<td nowrap="nowrap" class="FieldLabel" colspan="4" rowspan="2">
				<button onclick="query()">查 询</button>
				&nbsp;
				<button type="reset">重 置</button>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>物资用途：</td>
				<td class="FieldInput"><select id="qUpAllocationPurpose"
					class="TextEditor" title="物资用途" style="width: 180px;">
					<option dataset="disAllocationPurposeDs"></option>
				</select></td>
				<td class="FieldLabel" nowrap>是否确认：</td>
				<td class="FieldInput"><select id="qInConfirm" class="TextEditor"
					title="是否确认">
					<option dataset="commYesOrNoDS"></option>
				</select></td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="allocationGridPanel" dataset="disDetailBatchDs" autoExpandColumn="note"
	name="allocationGridPanel" width="99.9%" height="100%" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem text="救灾物资调拨管理"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="新增" handler="addAllo"/>
		<next:ToolBarItem iconCls="edit" text="修改" handler="editAllo"/>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delAllo"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detailAllo"/>
		<next:ToolBarItem iconCls="yes" text="确认" handler="confirmAllo"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="batchId" header="批次ID" field="batchId"
			align="center" hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="disYear" header="年度" field="disYear" align="center"
			width="60">
			<next:TextField />
		</next:Column>
		<next:Column id="receiveTime" header="调拨日期" field="receiveTime"
			align="center" width="80">
			<next:TextField />
		</next:Column>
		<next:Column id="upAllocationNum" header="调拨单号"
			field="upAllocationNum" align="center" width="120">
			<next:TextField />
		</next:Column>

		<next:Column id="inConfirm" header="是否确认" field="inConfirm" align="center"
			width="70" renderer="inConfirmRenderer">
			<next:TextField />
		</next:Column>
		
		<next:Column id="upAllocationPurpose" header="物资用途"
			field="upAllocationPurpose" align="left" renderer="upAllocationPurposeRenderer" width="130">
			<next:TextField />
		</next:Column>
		<next:Column id="note" header="备注"
			field="note" align="left">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="disDetailBatchDs" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>