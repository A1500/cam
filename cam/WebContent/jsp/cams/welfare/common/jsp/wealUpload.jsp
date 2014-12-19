<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<model:datasets>
<!-- 业务信息表 -->
<model:dataset id="wealFitInfoDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealFitInfoQueryCommand" global="true" >
	<model:record fromBean="com.inspur.cams.welfare.base.data.WealFitInfo">
	</model:record>
</model:dataset>

<%--电子档案上传窗口--%>
<model:dataset id="ds" cmd="com.inspur.cams.welfare.base.cmd.WealElectronicfileContentQueryCommand" global="true" autoLoad="true">
	<model:record fromBean="com.inspur.cams.welfare.base.data.WealElectronicfileContent">
	</model:record>
</model:dataset>

<%--下载窗口--%>
<model:dataset id="downloadDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealElectronicfileContentQueryCommand" method="queryCatalog">
	<model:record fromBean="com.inspur.cams.welfare.base.data.WealElectronicfileContent"></model:record>
</model:dataset>
</model:datasets>
<!-- 上传附件列表 -->
<next:Window id="uploadList" closeAction="hide"  title="附件上传列表" width="580" height="300" autoScroll="true" modal="true">
	<next:EditGridPanel id="uploadListGrid" width="566" stripeRows="true" height="269" dataset="ds">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="文件上传" handler="addUploadFile"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeUploadFile"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  field="catalogName" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="附件名称" width="220" field="catalogName" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述" width="200" field="catalogNote" editable="false"><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="80" editable="false" renderer="delUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somElectronicDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_upload"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width:80%"><textarea id="fileMess" rows="5" style="width:95%"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">附件上传：</td>
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
<next:Window id="downloadWin" title="附件列表" closeAction="hide" height="400" width="740"modal="true">
	<next:EditGridPanel id="downloadGrid" width="727" stripeRows="true" height="369" dataset="downloadDataSet" >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="winClosedownload"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="电子档案ID" field="contentId" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="档案目录名"  field="catalogId" width="280" editable="false" dataset="catalogDataSet" ><next:TextField /></next:Column>
			<next:Column header="附件名称" field="catalogName" width="190" editable="false" renderer="winDownloadHref"><next:TextField /></next:Column>
			<next:Column header="附件描述" field="catalogNote" width="190" editable="false"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>