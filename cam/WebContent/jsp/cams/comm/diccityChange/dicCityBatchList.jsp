<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%
	String organCode = BspUtil.getCorpOrgan().getOrganCode();
	String city=DicUtil.getTextValueFromDic("DIC_CITY","ID",organCode.substring(0, 4)+"00000000","NAME");
	
%>
<html>
<head>
<title>行政区划调整列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var organName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
	var organCode = '<%=organCode%>';
	var city = '<%=city%>';
	var batchId = '<%=IdHelp.getUUID32()%>';
	var attachId = '<%=IdHelp.getUUID32()%>';
	var userName='<%=GetBspInfo.getBspInfo().getUserName()%>';
</script> 
<script type="text/javascript" src="dicCityBatchList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
</head>
<body>
<model:datasets>
	<!-- 批次表 -->
	<model:dataset id="ds" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchQueryCmd" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch"/>
	</model:dataset>
	<!-- 批次表 -->
	<model:dataset id="changeDs" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchQueryCmd" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.diccityChange.data.DicCityChangeBatch"/>
	</model:dataset>
	<!-- 批次表(查询用) -->
	<model:dataset id="queryDs" cmd="com.inspur.cams.comm.diccityChange.cmd.DicCityChangeBatchQueryCmd" global="true" pageSize="20">
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
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">批次日期：</td>
					<td class="FieldInput" style="width:12%"><input type="text" onclick="WdatePicker({dateFmt:'yyyy-MM'})"  readonly id = "pre_date" /></td>
					<td class="FieldLabel" style="width:10%">批次名称：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "pre_name" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:10%">省级审批状态：</td>
					<td class="FieldInput" style="width:12%"><select id = "audit_type" >
						<option >请选择...</option>
						<option value="2">同意</option>
						<option value="3">退回</option>
						<option value="4">已执行</option>
					</select></td>
					<td class="FieldButton" colspan="3" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="ds" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="上传附件" handler="uploadFile"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="新增批次" handler="winShow"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改批次" handler="show"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="提交" handler="submit"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="batchMonth" header="批次日期" width="10%" sortable="false"/>
		<next:Column field="batchName" header="批次名称" width="15%" sortable="false" renderer="editHref"/>
		<next:Column field="applyPeo" header="申请人" width="8%" sortable="false"/>
		<next:Column field="applyPhone" header="联系方式" width="10%" sortable="false"/>
		<next:Column field="batchType" header="市级审核状态" width="9%" dataset="changeResultDataset" sortable="false"/>
		<next:Column field="checkOppion" header="市级审核意见" width="10%" sortable="false"/>
		<next:Column field="auditType" header="省级审批状态" width="9%" sortable="false" dataset="changeResultDataset"/>
		<next:Column field="auditOpinion" header="省级审批意见" width="18%" sortable="false"/>
		<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id ="batchWin" title="编辑批次" expandOnShow="false"
        resizable="false" width="500" height="160"
       closable="false" >
       <next:Panel>
			<next:TopBar>
				<next:ToolBarItem symbol="->" ></next:ToolBarItem>
				<next:ToolBarItem text="确定" iconCls="detail" handler="confirm"/>
				<next:ToolBarItem text="关闭" iconCls="undo" handler="closeWin"/>
			</next:TopBar>
			<next:Html>
				<form id="editForm"  dataset="changeDs" onsubmit="return false"  class="L5form">
				<table border="1"  width="100%" >
			   		<tr>	
						<td  class="FieldLabel" style="width:17%">批次日期</td>
						<td class="FieldInput" style="width:17%"><input id="batchMonth" field="batchMonth"   readonly ></input><font color="red">*</font> </td>
						<td  class="FieldLabel" style="width:17%">批次名称</td>
						<td class="FieldInput" style="width:17%"><input id="batchName" field="batchName" ></input><font color="red">*</font> </td>
					</tr>
					<tr>	
						<td  class="FieldLabel" style="width:17%">申请人</td>
						<td class="FieldInput" style="width:17%"><input id="applyPeo" field="applyPeo" ></input><font color="red">*</font></td>
						<td  class="FieldLabel" style="width:17%">联系电话</td>
						<td class="FieldInput" style="width:17%"><input id="applyPhone" field="applyPhone" ></input><font color="red">*</font></td>
					</tr>
					<tr>
						<td  class="FieldInput" style="width:17%" colspan="4"><label id="tipsLabel" ></label></td>
					</tr>
				</table>
				</form>
		   </next:Html>
		</next:Panel>
</next:Window>
<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="150" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_upload"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:30%">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="files" name="files" style="width:95%;height:40"/></td>
    		</tr>
    		<tr>
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过10M</span></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
</body>
</html>
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
			<next:Column header="删除附件" field="" width="80" editable="false" renderer="delUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>