<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.util.DateUtil"%>
<%	
	String method=request.getParameter("method");
%>
<html>
<head>
<title>殡仪馆收费价格公示表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src=fisPriceGoodsServiceQuery.js></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<script type="text/javascript">
	//var priceApplyId = '<%=request.getParameter("priceApplyId")%>';//批次ID
	//var funeralCode = '<%=request.getParameter("createOrgan")%>';//殡仪馆编号
	//var funeralName = decodeURIComponent('<%=request.getParameter("createOrganName")%>');//殡仪馆名称
	var method='<%=method%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var newHisId = '<%=IdHelp.getUUID32()%>';
</script>


<model:datasets>
	<model:dataset id="fisPriceGoodsServiceDS" cmd="com.inspur.cams.fis.ex.cmd.FisPriceGoodsServiceQueryCommand" method="queryPrice"  pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceGoodsService"/>
	</model:dataset>
	<!-- 定价形式 -->
	<model:dataset id="dingjiaDS" enumName="FIS.PRICE_STANDARD" autoLoad="true" global="true">
	</model:dataset>
	<model:dataset id="queryDs" cmd="com.inspur.cams.fis.ex.cmd.FisPriceApplyQueryCommand"  pageSize="-1">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceApply"/>
	</model:dataset>
	<model:dataset id="queryDs1" cmd="com.inspur.cams.fis.ex.cmd.FisPriceApplyQueryCommand"  pageSize="-1">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceApply"/>
	</model:dataset>
	<!-- 审核历史 -->
	<model:dataset id="his" cmd="com.inspur.cams.fis.ex.cmd.FisPriceApplyHisQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceApplyHis"/>
	</model:dataset>
	<!-- 审核结果 -->
	<model:dataset id="resultD" enumName="FIS.FEEP.OPINIONS" autoLoad="true" global="true"></model:dataset>
	<!-- 服务类型 -->
	<model:dataset id="workTypeDS" enumName="FIS.WORK_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 费用类型 -->
	<model:dataset id="feeTypeDS" enumName="FIS.FEE_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 收费性质 -->
	<model:dataset id="shoufeiDS" enumName="FIS.INVOICE_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0" >
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">殡仪馆名称：</td>
					<td class="FieldInput" style="width:15%"><input type="text" id="qName" /></td>
					<td class="FieldLabel" style="width:10%">收费标准（不加单位）：</td>
					<td class="FieldInput" style="width:15%"><input type="text" id="qBZQ" style="width:45%" onchange="CheckTxt('qBZQ','收费标准起');"/>-<input type="text" id="qBZZ" style="width:45%" onchange="CheckTxt('qBZZ','收费标准止');"/></td>
					<td class="FieldLabel" style="width:10%">减免标准（不加单位）：</td>
					<td class="FieldInput" style="width:15%"><input type="text" id="qJMQ" style="width:45%" onchange="CheckTxt('qJMQ','减免标准起');"/>-<input type="text" id="qJMZ" style="width:45%" onchange="CheckTxt('qJMZ','减免标准止');"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">收费性质：</td>
					<td class="FieldInput" style="width:15%"><select id="qXZ" title="收费性质">
											<option dataset="shoufeiDS"/>
										</select></td>
					<td class="FieldLabel" style="width:10%">收费项目名称：</td>
					<td class="FieldInput" style="width:15%"><input type="text"  id="qSName" /></td>
					
					<td class="FieldLabel" style="width:10%">定价形式：</td>
					<td class="FieldInput" style="width:15%"><select type="text" id="qDJ" 
											class="TextEditor" title="定价形式">
											<option dataset="dingjiaDS"/>
										</select></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">执行时间：</td>
					<td class="FieldInput" style="width:15%"><input type="text" id="qtime" format="Y-m-d" onclick="LoushangDate(this)" /></td>
					<td class="FieldButton"  colspan="4">
					<button onclick="querys()">查询</button>&nbsp;&nbsp;&nbsp;<button type="reset">重置</button>
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel title="殡仪馆收费价格公示表" id="grid" dataset="fisPriceGoodsServiceDS" width="100%" stripeRows="true" height="99.9%">
    <next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="chart" text="导出Excel" handler="forExcel"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
	</next:TopBar>
		<next:Columns>
		   		<next:RowNumberColumn/>
		   		<next:RadioBoxColumn/>
		   		<next:Column field="WORK_ID" header="业务ID" width="10%" sortable="false" hidden="true"/>
		   		<next:Column field="FEE_ITEM_ID" header="业务批次ID" width="10%" sortable="false" hidden="true"/>
				<next:Column field="FUNERAL_NAME" header="殡仪馆名称" width="10%" sortable="false"  />
				<next:Column field="WORK_TYPE" header="服务类型" width="10%" sortable="false" dataset="workTypeDS"/>
				<next:Column field="FEE_TYPE" header="收费类型" width="10%" sortable="false" dataset="feeTypeDS"/>
				<next:Column field="SERVICE_NAME" header="项目名称" width="10%" sortable="false" />
		   		<next:Column field="PRICE_DESC" header="收费标准" width="12%" sortable="false" />
		   		<next:Column field="INVOICE_CODE_TYPE" header="收费性质" width="10%" sortable="false" dataset="shoufeiDS"/>
				<next:Column field="PRICE_STANDARD" header="定价形式" width="10%" sortable="false" dataset="dingjiaDS"/>
				<next:Column field="PRICE_FILE_NUM" header="收费依据" width="10%" sortable="false"/>
				<next:Column field="PRICE_EXE_TIME" header="执行时间" width="10%" sortable="false"/>
				<next:Column field="REMISSION_TARGET" header="减免对象" width="15%" sortable="false"  />
				<next:Column field="REMISSION_DESC" header="政府减免标准" width="12%" sortable="false"/>
				<next:Column field="REMISSION_FILE_NUM" header="减免依据" width="10%" sortable="false"  />
				<next:Column field="REMISSION_EXE_TIME" header="减免执行时间" width="10%" sortable="false" />
				<next:Column field="FUNERAL_CODE" header="殡仪馆编码" width="10%" sortable="false" hidden="true"/>
				<next:Column field="CREATE_ORGAN_NAME" header="登记单位名称" width="10%" sortable="false"  />
		</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fisPriceGoodsServiceDS"/>
	</next:BottomBar>
</next:EditGridPanel>		
</body>
</html>