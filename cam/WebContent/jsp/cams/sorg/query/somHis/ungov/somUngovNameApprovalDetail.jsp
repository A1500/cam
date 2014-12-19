<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.sorg.apply.group.cmd.GroupChangeCmd"%>
<html>
<head>
<title>民办非企业单位申请筹备登记</title>
<next:ScriptManager></next:ScriptManager>
<script>
	var taskCode='<%=request.getParameter("taskCode")%>';
	var applyType="100";
</script>
<script type="text/javascript">
function init() {
	var somApplyDataSet=L5.DatasetMgr.lookup("somApplyDataSet");
	somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on('load', loadInfo);
	//电子档案上传窗口关闭事件
	if(L5.getCmp("uploadList")){
		var win=L5.getCmp("uploadList");
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});
	}
}
function loadInfo(){
	sorgId = somApplyDataSet.get('sorgId');
	taskCode = somApplyDataSet.get('taskCode');
	var somOrganDataSet=L5.DatasetMgr.lookup("somOrganDataSet");
	somOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somOrganDataSet.load();
	var somHeldPeopleDataSet=L5.DatasetMgr.lookup("somHeldPeopleDataSet");
	somHeldPeopleDataSet.setParameter("SORG_ID@=", sorgId);
	var somHeldOrganDataSet=L5.DatasetMgr.lookup("somHeldOrganDataSet");
	somHeldOrganDataSet.setParameter("SORG_ID@=", sorgId);
	somHeldPeopleDataSet.load();
	somHeldOrganDataSet.load();
	aspChiefDataset.setParameter("SORG_ID@=", sorgId);
	aspChiefDataset.load();
	aspChiefDataset.on('load',function(){
			if(aspChiefDataset.getCount()==0){
				aspChiefDataset.newRecord({"taskCode":taskCode,"sorgId":sorgId});
			}
		});
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
	somElectronicDataSet_load();
}
//返回
function returnClick(){
	history.go(-1);
}
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require"/>
			<model:field name="curOpinion" type="string" rule="length{200}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople"></model:record>
	</model:dataset>
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan"></model:record>
	</model:dataset>
	<model:dataset id="aspChiefDataset" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief"></model:record>
	</model:dataset>
	<model:dataset id="somFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_UNGOV_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>		
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick"/>
	</next:TopBar>
	
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="民办非企业单位名称预先核准申请表" width="100%" autoScroll="true">
				<next:Html>
					<fieldset>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<input type="hidden" name="sorgId" field="sorgId"/>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">申请设立民办非企业单位名称：</td>
							<td class="FieldInput" colspan="5"><label id="cnName" field="cnName" name='"申请设立民办非企业单位名称"'/></td>
						</tr>
						<tr>
							<td class="FieldLabel">单位宗旨：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" field="purpose" name='"单位宗旨"' style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">业务范围：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" field="business" name='"业务范围"' style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟定业务主管单位：</td>
							<td class="FieldInput" colspan="5"><label field="borgName" name="拟定业务主管单位" dataset="borgDataSet"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>拟定开办资金币种：</label></td>
							<td class="FieldInput" colspan="5"><label field="currency" name='"拟定开办资金币种"' /></td>	
						</tr>
						<tr>						
							<td class="FieldLabel">拟定开办资金数额（万元）：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" field="regMon" name='"拟定开办资金数额（万元）"' style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">出资人：</td>
							<td class="FieldInput" colspan="5"><label name='出资人' field="fundingPeople" style="width:98%" /></td>
						</tr>						
						<tr>
							<td class="FieldLabel">资金来源：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" field="moneySource" name='"资金来源"' style="width:98%"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">办公地点：</td>
							<td class="FieldInput" colspan="5"><label name='办公地点' field="residence" style="width:98%"/></td>
						</tr>
					</table>
					</form>
					</fieldset>
					
					<fieldset>
					<legend>拟任负责人人情况</legend>
					<form method="post" dataset="aspChiefDataset" onsubmit="return false" class="L5form" style="border-width:0px">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">身份证号：</td>
							<td class="FieldInput" style="width:17%"><label field="idCard"/></td>
							<td class="FieldLabel" style="width:17%">姓名：</td>
							<td class="FieldInput" style="width:17%"><label field="name"/></td>
							<td class="FieldLabel" style="width:17%">出生年月：</td>
							<td class="FieldInput" style="width:17%"><label field="birthday"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >工作单位：</td>
							<td class="FieldInput" colspan="3"><label field="workName"/></td>
							<td class="FieldLabel" style="width:17%" >工作单位职务：</td>
							<td class="FieldInput" style="width:17%"><label field="workDuties"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">户口所在地：</td>
							<td class="FieldInput" colspan="3"><label field="populace"/></td>
							<td class="FieldLabel" style="width:17%">联系电话：</td>
							<td class="FieldInput" style="width:17%"><label field="phone"/></td>
						</tr>
					</table>
					</form>
					</fieldset>
					<fieldset>
					
					<fieldset>
					<legend>申请信息</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" style="border-width:0px">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">联系人：</td>
							<td class="FieldInput" style="width:17%"><label field="appPeople" name='"申请人"'/></td>
							<td class="FieldLabel" style="width:17%">联系人电话：</td>
							<td class="FieldInput" style="width:15%"><label id="sorgPhone" field="appPhone" name='"申请人电话"'/></td>
							<td class="FieldLabel" style="width:17%">申请日期：</td>
							<td class="FieldInput" style="width:17%"><label field="appDate" name='"申请日期"'/></td>
						</tr>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="举办者情况">
				<next:EditGridPanel id="heldPeopleGrid" dataset="somHeldPeopleDataSet" width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="户口所在地" field="populace" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="工作单位" field="workName" width="25%" editable="false"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="20%" editable="false"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="是否拟任主要负责人" field="ifChief" width="20%" editable="false"><next:ComboBox dataset="yesornoDataSet"></next:ComboBox></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldPeopleDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			
			<next:Panel title="举办单位情况">
				<next:EditGridPanel id="heldOrganGrid" dataset="somHeldOrganDataSet" width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
						<next:Column header="举办单位名称" field="name" width="40%" editable="false"><next:TextField/></next:Column>
						<next:Column header="举办单位主要负责人" field="heldorganPeople" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="20%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldOrganDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			
			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
						<next:TopBar>
							<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
						</next:TopBar>
		
						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
							<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
							<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
							<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somElectronicDataSet" />
						</next:BottomBar>
					</next:EditGridPanel>
					
			</next:Panel>
			
			<next:Panel title="流程历史意见">
				<next:EditGridPanel id="somFlowGrid" dataset="somFlowDataSet" width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column header="处理环节" field="activity" width="13%" editable="false"><next:TextField/></next:Column>
						<next:Column header="处理单位" field="organId" width="13%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理部门" field="deptId" width="13%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理人" field="actorId" width="10%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理时间" field="commitTime" width="18%" editable="false"><next:TextField/></next:Column>
						<next:Column header="意见" field="opinionId" width="10%" editable="false"><next:ComboBox dataset="hisOpinionDataSet"/></next:Column>
						<next:Column header="补充意见" field="opinion" width="40%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>