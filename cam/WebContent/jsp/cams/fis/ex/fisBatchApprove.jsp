<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>

<html>
<head>
<title>殡仪馆收费标准录入</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisBatchApprove.js"></script>
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<script type="text/javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>' ;
	var organName = '<%=BspUtil.getOrganName()%>';
	var organId = '<%=BspUtil.getCorpOrganId()%>' ;
	
</script>

<model:datasets>
	<model:dataset id="fisBatchApproveDS" cmd="com.inspur.cams.fis.ex.cmd.FisPriceApplyQueryCommand"  pageSize="10">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceApply"/>
	</model:dataset>
	<model:dataset id="fisBatchDS" cmd="com.inspur.cams.fis.ex.cmd.FisPriceApplyQueryCommand"  pageSize="-1">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceApply"/>
	</model:dataset>
	<model:dataset id="fisFuneralDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="false" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='FIS_FUNERAL_ORGAN_MANAGE'></model:param>
			<model:param name="value" value='UNIT_ID'></model:param>
			<model:param name="text" value='UNIT_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="yesOrNoDs" enumName="COMM.YESORNO" global="true" autoLoad="true" />
	<!-- 审核状态 -->
	<model:dataset id="applyStatusDs" enumName="FIS.APPLY_STATUS" global="true" autoLoad="true" />
	<%--附件表--%>
	<model:dataset id="attachDataSet" cmd="com.inspur.cams.fis.ex.cmd.FisPriceApplyAttachQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceApplyAttach"></model:record>
	</model:dataset>
	<%--附件表--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.fis.ex.cmd.FisPriceApplyAttachQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.fis.ex.data.FisPriceApplyAttach"></model:record>
	</model:dataset>
</model:datasets>
		<next:Panel title="殡仪馆收费标准录入查询" width="100%" border="0" autoHeight="true" titleCollapse="true" collapsible="true" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"/>
				<next:ToolBarItem iconCls="detail" text="下载操作手册" handler="downloadBook"/>
				<next:ToolBarItem iconCls="detail" text="下载省厅发文" handler="downloadWord"/>
			</next:TopBar>
			<next:Html>
			<fieldset style="overflow:visible;" class="GroupBox">
			<legend class="GroupBoxTitle">查询条件</legend>
				<form class="L5form">
					<table border="1" width="100%">
						<tr>
						 	<td class="FieldLabel" style="width:10%">殡仪馆名称：</td>
							<td class="FieldInput" style="width:20%"><input type="text"  id="create_organ_name" class="TextEditor" title="殡仪馆名称" style="width:80%" /></td>	
							<td class="FieldLabel" style="width:10%">审核状态:</td>
							<td class="FieldInput" style="width:20%">
							<select id="apply_status" style="width:90%"><option dataset=applyStatusDs></option></select></td>
							<td class="FieldButton" style="width:30%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
						</tr>

					</table>
				</form>
			</fieldset>
			</next:Html>
		</next:Panel>
		<next:EditGridPanel title="殡仪馆收费标准录入列表" id="grid" dataset="fisBatchApproveDS" width="100%" stripeRows="true" height="99.9%">
            <next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="查看公示表" handler="readPublic"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="上传附件" handler="uploadFile"></next:ToolBarItem>
				<next:ToolBarItem iconCls="select" text="上报" handler="submit" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="增加" handler="insert" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
			</next:TopBar>
				<next:Columns>
				   		<next:RowNumberColumn/>
				   		<next:RadioBoxColumn/>
				   		<next:Column field="priceApplyId" header="审核业务编码" width="10%" sortable="false" hidden="true"/>
						<next:Column field="createOrgan" header="殡仪馆编码" width="10%" sortable="false" />
				   		<next:Column field="createOrganName" header="殡仪馆名称" width="15%" sortable="false" renderer="editHref"/>
						<next:Column field="createPeopleName" header="录入人姓名" width="10%" sortable="false" />
						<next:Column field="itemNums" header="条目总数" width="10%" sortable="false" />
						<next:Column field="applyStatus" header="审核状态" width="10%" sortable="false" renderer="colorRenderer"/>
						<next:Column field="validFlag" header="是否有效" width="10%" sortable="false" dataset="yesOrNoDs" />
						<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
				</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="fisBatchApproveDS"/>
			</next:BottomBar>
		</next:EditGridPanel>
		
		<!-- 弹出殡仪馆选择窗口 -->
<next:Window id="funeraChoice" name="funeraChoice" title="殡仪馆选择"
	resizable="false" width="300" lazyRender="false" height="250"
	closeAction="hide" autoScroll="false">
	<next:Buttons>
		<next:ToolButton text="确定" handler="save_win"></next:ToolButton>
		<next:ToolButton text="关闭" handler="close_win"></next:ToolButton>
	</next:Buttons>

	<next:Html>
		<form id="funeralChoiceform" dataset="fisBatchDS" method="post" onsubmit="return false">
		<table id="table0"  border="0">
		    <tr>
		    	<td  class="FieldLabel" style="width:17%">录入人姓名</td>
				<td class="FieldInput" style="width:17%"><input type="text" id="createPeopleName" field="createPeopleName" ></input><font color="red">*</font></td>	
			</tr>
			<tr>	
				<td  class="FieldLabel" style="width:17%">录入日期</td>
				<td class="FieldInput"><input type="text" field="createTime" name="受理日期" format="Y-m-d" style="width: 100px;" maxlength="10" onclick="LoushangDate(this)"/>
				<font color="red">*</font></td>
			</tr>
			<tr>	
				<td class="FieldLabel" width="100">殡仪馆</td>
				<td class="FieldInput" style="width:30%"><select id="createOrgan" field="createOrgan" style="width:90%"><option dataset="fisFuneralDS"></option></select><font color="red">*</font></td>	
			</tr>
			<tr>	
				
				<td  class="FieldLabel" style="width:17%">备注</td>
				<td class="FieldInput" style="width:17%"><textarea id="note" name="note" field="note" onpropertychange="if(value.length>100) value=value.substr(0,100)" rows="5"></textarea></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>
<next:Window id="funeraChoiceDetail" name="funeraChoiceDetail" title="殡仪馆明细"
	resizable="false" width="300" lazyRender="false" height="200"
	closeAction="hide" autoScroll="false">
	<next:Buttons>
		<next:ToolButton text="关闭" handler="close_win"></next:ToolButton>
	</next:Buttons>

	<next:Html>
		<form id="funeralChoiceform1" dataset="fisBatchDS" method="post" onsubmit="return false">
		<table id="table1"  border="0">
		    <tr>
		    	<td  class="FieldLabel" style="width:17%">录入人姓名</td>
				<td class="FieldInput" style="width:17%"><label id="createPeopleName" field="createPeopleName" ></label></td>	
			</tr>
			<tr>	
				<td  class="FieldLabel" style="width:17%">录入日期</td>
				<td class="FieldInput"><label field="createTime" name="受理日期" ></label></td>
			</tr>
			<tr>	
				<td class="FieldLabel" width="100">殡仪馆</td>
				<td class="FieldInput" style="width:30%"><label id="createOrganName" field="createOrganName"></label></td>	
			</tr>
			<tr>	
				
				<td  class="FieldLabel" style="width:17%">备注</td>
				<td class="FieldInput" style="width:17%"><textarea id="note" name="note" field="note" disabled="disabled" rows="5"></textarea></td>
			</tr>
		</table>
		</form>
	</next:Html>
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
			<next:Column header="附件ID"  field="attachId" width="280" editable="false" hidden="true" ><next:TextField /></next:Column>
			<next:Column header="附件名称"  field="attachName" width="280" editable="false" renderer="winDownloadHref" ><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="80" editable="false" renderer="delUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>