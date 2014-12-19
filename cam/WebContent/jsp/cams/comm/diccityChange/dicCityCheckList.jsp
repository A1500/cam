<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>行政区划调整列表</title>
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
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
%>
<script type="text/javascript" src="dicCityCheckList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
	var organArea = '<%=organArea%>';
	var organName = '<%=organName%>';
	var organCode = '<%=organCode%>';   
	var batchId = '<%=IdHelp.getUUID32()%>';
</script> 
</head>
<body>
<model:datasets>
	<!-- 批次表 -->
	<model:dataset id="ds" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchQueryCmd" sortField="batchMonth" sortDirection="desc" isGroup="true" groupField="batchId" pageSize="15">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch"/>
	</model:dataset>
	<!-- 批次表(查询用) -->
	<model:dataset id="queryDs" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch"/>
	</model:dataset>
	<!-- 变更类型 -->
	<model:dataset id="changeTypeDataset" enumName="COMM.CHANGE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 处理结果 -->
	<model:dataset id="changeResultDataset" enumName="COMM.CHANGE.RESULT" autoLoad="true" global="true"></model:dataset>
	<%--附件表--%>
	<model:dataset id="attachDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchAttachQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChangeBatchAttach"></model:record>
	</model:dataset>
	<%--附件表--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchAttachQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChangeBatchAttach"></model:record>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetCity" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" width="4%">地区:</td>
					<td class="FieldInput" width="8%">
					<input type="text" name="地区" id="organNamequery" maxlength="50" style="width:80%" readonly />
					<img id="img" src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" />
					<input type="hidden" name="organCode" id="organCodequery"/>
					<td class="FieldLabel" style="width:4%">市级审核意见：</td>
					<td class="FieldInput" style="width:8%">
							<select id="shyjquery">
								<option value="">请选择...</option>
								<option value="1">已提交</option>
								<option value="2">同意</option>
							</select></td>
					<td class="FieldLabel" style="width:4%">省级审批意见：</td>
					<td class="FieldInput" style="width:8%">
							<select id="sjspquery">
								<option value="">请选择...</option>
								<option value="0">未审批</option>
								<option value="1">同意</option>
								<option value="2">已执行</option>
								<option value="3">退回</option>
							</select></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:4%">批次日期：</td>
					<td class="FieldInput" style="width:8%"><input type="text" onclick="WdatePicker({dateFmt:'yyyy-MM'})"  readonly id = "pre_date" /></td>
					<td class="FieldLabel" style="width:4%">批次名称：</td>
					<td class="FieldInput" style="width:8%"><input type="text" id = "pre_name" />
					</td>
					<td class="FieldLabel" style="width:4%"></td>
					<td class="FieldInput" style="width:8%">
					&nbsp;&nbsp;&nbsp;<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="grid" dataset="ds" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="审批" handler="winShow"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="明细" handler="detail"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="batchId" header="批次Id" width="10%" sortable="false" hidden="true"/>
		<next:Column field="city" header="所在地市" width="6%" sortable="false"/>
		<next:Column field="organCode" header="提报地区代码" width="10%" sortable="false" hidden="true"/>
		<next:Column field="organName" header="提报地区" width="18%" sortable="false"  renderer="batchNameRender"/>
		<next:Column field="batchMonth" header="批次日期" width="10%" sortable="false"/>
		<next:Column field="batchName" header="批次名称" width="20%" sortable="false"/>
		<next:Column field="applyPeo" header="申请人" width="10%" sortable="false"/>
		<next:Column field="applyPhone" header="申请人联系电话" width="10%" sortable="false"/>
		<next:Column field="batchType" header="市级审核意见" width="10%" dataset="changeResultDataset" sortable="false"/>
		<next:Column field="auditType" header="省级审批意见" width="10%" dataset="changeResultDataset" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
<next:Window id ="reasonWin" title="审批意见" expandOnShow="false"
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
						<td class="FieldInput" style="width:80%"><select style="width:100%" id="batchType" field="batchType"  >
							<option >请选择...</option>
							<option value="2">同意</option>
							<option value="3">退回</option>
						</select> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:20%">意见补充:</td>
						<td class="FieldInput" style="width:80%"><textArea id="checkOppion" style="width:100%;height:100" field="checkOppion"  ></textArea> </td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>
<next:Window id ="reasonWin2" title="审批意见" expandOnShow="false"
        resizable="false" width="400" height="330"
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
						<td  class="FieldLabel" style="width:20%">市级审核意见:</td>
						<td class="FieldInput" style="width:80%"><label style="width:100%" dataset="changeResultDataset" id="batchType1" field="batchType"  >
						</label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:20%">市级审核时间:</td>
						<td class="FieldInput" style="width:80%"><label id="checkTime" field="checkTime"  ></label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:20%">市级意见补充:</td>
						<td class="FieldInput" style="width:80%"><label id="checkOppion1" style="width:100%;height:50" field="checkOppion"  ></label> </td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:20%">审批意见:</td>
						<td class="FieldInput" style="width:80%"><select style="width:100%" id="auditType" field="auditType"  >
							<option >请选择...</option>
							<option value="2">同意</option>
							<option value="3">退回</option>
						</select> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" style="width:20%">审批意见补充:</td>
						<td class="FieldInput" style="width:80%"><textArea id="auditOpinion" style="width:100%;height:80" field="auditOpinion"  ></textArea> </td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>
<!-- 下载附件窗口 -->
<next:Window id="downloadWin" title="附件列表" closeAction="hide" height="400" width="550"modal="true">
	<next:EditGridPanel id="downloadGrid" width="530" stripeRows="true" height="369" dataset="downloadDataSet" >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeDownload"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="附件名称"  field="attachName" width="280" editable="false" renderer="winDownloadHref" ><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>