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
<script type="text/javascript" src=fisPriceGoodsService.js></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<script type="text/javascript">
	var priceApplyId = '<%=request.getParameter("priceApplyId")%>';//批次ID
	var funeralCode = '<%=request.getParameter("createOrgan")%>';//殡仪馆编号
	var funeralName = decodeURIComponent('<%=request.getParameter("createOrganName")%>');//殡仪馆名称
	var method='<%=method%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var newHisId = '<%=IdHelp.getUUID32()%>';
	var applyStatus = '<%=request.getParameter("applyStatus")%>';
</script>


<model:datasets>
	<model:dataset id="fisPriceGoodsServiceDS" cmd="com.inspur.cams.fis.ex.cmd.FisPriceGoodsServiceQueryCommand"  pageSize="10">
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
					<td class="FieldLabel" style="width:15%">登记单位名称：</td>
					<td class="FieldInput" style="width:18%"><input type="text" id="qName" /></td>
					<td class="FieldLabel" style="width:15%">项目名称：</td>
					<td class="FieldInput" style="width:18%"><input type="text"  id="qSName" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%">定价形式：</td>
					<td class="FieldInput" style="width:18%"><select id="qDJ" title="定价形式" >
											<option dataset="dingjiaDS"/>
										</select></td>
					<td class="FieldButton" style="width:20%" colspan="2">
					<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;<button type="reset">重置</button>
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
		<next:ToolBarItem id="reject" iconCls="detail" text="查看驳回原因" handler="forReject"></next:ToolBarItem>
		<next:ToolBarItem iconCls="chart" text="导出Excel" handler="forExcel"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="预览公示表" handler="readPublic"></next:ToolBarItem>
		<next:ToolBarItem id="yes" iconCls="edit" text="审核" handler="winShow"></next:ToolBarItem>
		<next:ToolBarItem id="add" iconCls="add" text="增加" handler="insert" ></next:ToolBarItem>
		<next:ToolBarItem id="edit" iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem id="delete" iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
	</next:TopBar>
		<next:Columns>
		   		<next:RowNumberColumn/>
		   		<next:RadioBoxColumn/>
		   		<next:Column field="workId" header="业务ID" width="10%" sortable="false" hidden="true"/>
		   		<next:Column field="feeItemId" header="业务批次ID" width="10%" sortable="false" hidden="true"/>
				<next:Column field="workType" header="服务类型" width="10%" sortable="false" dataset="workTypeDS"/>
				<next:Column field="feeType" header="收费类型" width="10%" sortable="false" dataset="feeTypeDS"/>
				<next:Column field="serviceName" header="项目名称" width="10%" sortable="false" />
		   		<next:Column field="priceDesc" header="收费标准" width="12%" sortable="false" />
		   		<next:Column field="invoiceCodeType" header="收费性质" width="10%" sortable="false" dataset="shoufeiDS"/>
				<next:Column field="priceStandard" header="定价形式" width="10%" sortable="false" dataset="dingjiaDS"/>
				<next:Column field="priceFileNum" header="收费依据" width="10%" sortable="false"/>
				<next:Column field="priceExeTime" header="执行时间" width="10%" sortable="false"/>
				<next:Column field="remissionDesc" header="政府减免标准" width="12%" sortable="false"/>
				<next:Column field="remissionFileNum" header="减免依据" width="10%" sortable="false"  />
				<next:Column field="remissionTarget" header="减免对象" width="15%" sortable="false"  />
				<next:Column field="remissionExeTime" header="减免执行时间" width="10%" sortable="false" />
				<next:Column field="funeralCode" header="殡仪馆编码" width="10%" sortable="false" hidden="true"/>
				<next:Column field="funeralName" header="殡仪馆名称" width="10%" sortable="false"  />
				<next:Column field="createOrganName" header="登记单位名称" width="10%" sortable="false"  />
		</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fisPriceGoodsServiceDS"/>
	</next:BottomBar>
</next:EditGridPanel>
<next:Window id ="reasonWin" title="审核意见" expandOnShow="false"
        resizable="false" width="400" height="200"
       closable="false" >
       <next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem text="确定" iconCls="detail" handler="confirm"/>
				<next:ToolBarItem text="关闭" iconCls="undo" handler="closeWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm"  dataset="queryDs" onsubmit="return false"  class="L5form">
				<table border="1"  width="100%" >
			   		<tr>	
						<td  class="FieldLabel" style="width:20%">审核意见:</td>
						<td class="FieldInput" style="width:80%"><select style="width:100%" id="batchType" field="batchStatus"  >
							<option dataSet="resultD"></option>
						</select> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:20%">意见补充:</td>
						<td class="FieldInput" style="width:80%"><textArea id="checkOppion" style="width:100%;height:100" field="batchType" ></textArea> </td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>
<next:Window id ="reasonWin2" title="审核意见" expandOnShow="false"
        resizable="false" width="400" height="300"
       closable="false" >
       <next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem text="确定" iconCls="detail" handler="confirm"/>
				<next:ToolBarItem text="关闭" iconCls="undo" handler="closeWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm"  dataset="queryDs" onsubmit="return false"  class="L5form">
				<table border="1"  width="100%" >
					<tr>	
						<td  class="FieldLabel" style="width:25%">市级审核意见:</td>
						<td class="FieldInput" style="width:75%"><label style="width:100%" dataset="resultD" id="batchType1" field="batchStatus">
						</label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:25%">市级审核时间:</td>
						<td class="FieldInput" style="width:75%"><label id="checkTime" field="checkTime"  ></label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:25%">市级意见补充:</td>
						<td class="FieldInput" style="width:75%"><label id="checkOppion1" style="width:100%;height:50" field="batchType"  ></label> </td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:25%">省级审核意见:</td>
						<td class="FieldInput" style="width:75%"><select style="width:100%" id="auditT" field="auditStatus">
							<option dataSet="resultD"></option>
						</select> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:25%">省级意见补充:</td>
						<td class="FieldInput" style="width:75%"><textArea id="auditType" style="width:100%;height:80" field="auditType"  ></textArea> </td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>			
<next:Window id ="rejectWin" title="查看审核意见" expandOnShow="false"
        resizable="false" width="400" height="200"
       closable="false" >
       <next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem text="关闭" iconCls="undo" handler="closeRejectWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm"  dataset="queryDs" onsubmit="return false"  class="L5form">
				<table border="1"  width="100%" >
			   		<tr>	
						<td  class="FieldLabel" style="width:20%">审核意见:</td>
						<td class="FieldInput" style="width:80%"><label field="batchStatus" dataSet="resultD"></label>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:20%">意见补充:</td>
						<td class="FieldInput" style="width:80%"><textArea id="checkOppion" style="width:100%;height:100" field="batchType" readonly="readonly"></textArea> </td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>
<next:Window id ="rejectWin2" title="查看审核意见" expandOnShow="false"
        resizable="false" width="400" height="300"
       closable="false" >
       <next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem text="关闭" iconCls="undo" handler="closeRejectWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm"  dataset="queryDs" onsubmit="return false"  class="L5form">
				<table border="1"  width="100%" >
					<tr>	
						<td  class="FieldLabel" style="width:25%">市级审核意见:</td>
						<td class="FieldInput" style="width:75%"><label style="width:100%" dataset="resultD" id="batchType1" field="batchStatus">
						</label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:25%">市级审核时间:</td>
						<td class="FieldInput" style="width:75%"><label id="checkTime" field="checkTime"  ></label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:25%">市级意见补充:</td>
						<td class="FieldInput" style="width:75%"><label id="checkOppion1" style="width:100%;height:50" field="batchType"  ></label> </td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:25%">省级审核意见:</td>
						<td class="FieldInput" style="width:75%"><label id="auditT" field="auditStatus" dataSet="resultD"></label>
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:25%">省级意见补充:</td>
						<td class="FieldInput" style="width:75%"><textArea id="auditType" style="width:100%;height:80" field="auditType" readonly="readonly"></textArea> </td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>		
</body>
</html>