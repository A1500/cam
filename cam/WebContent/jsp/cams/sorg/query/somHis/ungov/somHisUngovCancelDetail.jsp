<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title>民办非企业单位注销登记处理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>	
<script type="text/javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
var sorgId="";
var applyType="103";
function init() {	
	somApplyDataSet.setParameter("TASK_CODE", taskCode);
	somApplyDataSet.load();
	somApplyDataSet.on("load", loadInfo);
	
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	if(win!=null){
		win.on("hide",function(el){
			somElectronicDataSet_load();
		});		
	}
}
function loadInfo(){
	var somApplyRd=somApplyDataSet.getCurrent();
	sorgId = somApplyRd.get("sorgId");
	//社会组织信息
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	//社会组织清算组织人员信息
	somLiqpeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somLiqpeopleDataSet.load();	
	//电子档案
	somElectronicDataSet_load();
	//流程历史意见
	somFlowDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowDataSet.load();
}
//返回
function back(){
	history.go(-1);
}
//查看清算组织人员信息
function detailSomLiqpeople(){
	var grid = L5.getCmp("gridSomLiqpeople");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	var winSomLiqpeopleDataSet = L5.DatasetMgr.lookup("winSomLiqpeopleDataSet");
	winSomLiqpeopleDataSet.removeAll();
	var newRecord = winSomLiqpeopleDataSet.newRecord();
	var win = L5.getCmp("winSomLiqpeople");
	win.show();
	newRecord.set("name",record.get("name"));
	newRecord.set("workName",record.get("workName"));
	newRecord.set("workDuties",record.get("workDuties"));
	newRecord.set("liqDuties",record.get("liqDuties"));
	newRecord.set("ifChief",record.get("ifChief"));
}
//关闭清算组织人员信息窗口
function winCloseSomLiqpeople(){
	var win = L5.getCmp("winSomLiqpeople");
	win.setVisible(false);
}
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">			
			<model:field name="curOpinionId" type="string" rule="require"/>
			<model:field name="curOpinion" type="string" rule="length{200}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somLiqpeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomLiqpeopleQueryCmd" global="true" sortField="IF_CHIEF" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople"></model:record>
	</model:dataset>
	<model:dataset id="winSomLiqpeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomLiqpeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople"></model:record>
	</model:dataset>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryCatalog" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="somFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="somFlowQuery" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="winSomFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_UNGOV_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>		
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_BUS_SCOPE"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_BUSINESS_ORGAN"></model:param>
			<model:param name="value" value="BORG_CODE"></model:param>
			<model:param name="text" value="BORG_NAME"></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="PUB_ORGAN"></model:param>
			<model:param name="value" value="ORGAN_ID"></model:param>
			<model:param name="text" value="ORGAN_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifChiefSelect" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect2" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
</model:datasets>	

<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem  iconCls="return" text="返回" handler="back" ></next:ToolBarItem>			
		</next:TopBar>
		<next:TabPanel id="tab" width="100%" height="100%">
			<next:Tabs>
				<next:Panel id="panelSomOrgan" title="民办非企业单位注销登记表" width="100%" height="100%" autoScroll="true">
					<next:Html>
					<fieldset>
					<legend>民办非企业单位注销登记信息</legend>
						<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" width="20%"><label>登记证号：</label></td>
								<td class="FieldInput" width="30%"><label field="sorgCode" name="'登记证号'" /></td>
								<td class="FieldLabel" width="20%"><label>组织机构代码：</label></td>
								<td class="FieldInput" width="30%"><label id="organCode" field="organCode" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>单位名称：</label></td>
								<td class="FieldInput"><label id="cnName" field="cnName" /></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label id="buildDate" field="buildDate"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>民办非企业单位类型：</label></td>
								<td class="FieldInput"><label id="sorgKind" field="sorgKind" name='"民办非企业单位类型"' dataset="sorgKindSelect" /></td>							
								<td class="FieldLabel"><label>所属行（事）业：</label></td>
								<td class="FieldInput"><label id="busScope" field="busScope" dataset="busScopeSelect" /></td>
							</tr>
							<tr>							
								<td class="FieldLabel"><label>住所：</label></td>
								<td class="FieldInput"><label id="residence" field="residence" /></td>
								<td class="FieldLabel"><label>电话：</label></td>
								<td class="FieldInput"><label id="sorgPhone" field="sorgPhone" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>法定代表人：</label></td>
								<td class="FieldInput"><label field="legalPeople" /></td>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput"><label id="borgName" field="borgName" dataset="businessOrganSelect" /></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>注销日期：</label></td>
								<td class="FieldInput"><label field="cancelDate" /></td>	
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>						
							</tr>
							<tr>
								<td class="FieldLabel"><label>申请注销理由：</label></td>
								<td class="FieldInput" colspan="3" ><textarea rows="3" field="cancelReason" readonly="readonly" name="'申请注销理由'" style="width:93%"style="width:93%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>清算结论：</label></td>
								<td class="FieldInput" colspan="3" ><textarea rows="3" field="liqResult" readonly="readonly" name="'清算结论'" style="width:93%"style="width:93%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea></td>
							</tr>
						</table>
						</form>
						</fieldset>
						<fieldset>
							<legend>业务主管单位意见</legend>
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:17%">审查日期：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='审查日期' field="borgCheckDate" style="width:90%" /></td>
									<td class="FieldLabel" style="width:17%"></td>
									<td class="FieldInput" style="width:17%"></td>
									<td class="FieldLabel" style="width:17%"></td>
									<td class="FieldInput" style="width:17%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">业务主管单位意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='意见' field="borgOpinion" style="width:98%;"style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
									</td>
								</tr>
							</table>
							</form>
						</fieldset>
						<fieldset>
					<legend>历史处理意见</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
					<table width="100%">
					<tr>
							<td class="FieldLabel" style="width:17%">承办人意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="acceptOpinionId" name='"承办人意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">承办时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='承办时间' field="acceptTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">承办补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">初审意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">初审负责人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审负责人'  style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">初审时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='初审时间' field="examinTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">初审补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">审核意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">审核人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">审核时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='审核时间' field="checkTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">审核补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">批准意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">批准人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='批准人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">批准时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='批准时间' field="auditTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">批准补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
					</table>
					</form>
					</fieldset>
					</next:Html>
				</next:Panel>				
			
				<next:GridPanel id="gridSomLiqpeople" dataset="somLiqpeopleDataSet" title="清算组织人员" width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="清算组织主要组成人员列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="detailSomLiqpeople"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" hidden="true" />
						<next:Column header="姓名" field="name" width="10%" />
						<next:Column header="在清算组织中职务" field="liqDuties" width="25%" />
						<next:Column header="清算组织负责人" field="ifChief" dataset="ifChiefSelect" width="15%" />
						<next:Column header="工作单位" field="workName" width="18%" />
						<next:Column header="职务（职称）" field="workDuties" width="18%" />		
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somLiqpeopleDataSet"/>
					</next:BottomBar>
				</next:GridPanel>							
			
				<next:GridPanel id="uploadGrid" dataset="somElectronicDataSet" title="法律要件" width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="附件名称" field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述" field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>					
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:GridPanel>
	
				<next:EditGridPanel id="gridSomFlow" dataset="somFlowDataSet" title="流程历史意见" width="100%" height="100%">
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column header="处理环节" field="activity" width="13%" editable="false"></next:Column>
						<next:Column header="处理单位" field="organId" dataset="pubOrganDataSet" width="13%" editable="false"></next:Column>
						<next:Column header="处理部门" field="deptId" dataset="pubOrganDataSet" width="13%" editable="false"></next:Column>
						<next:Column header="处理人" field="actorId" dataset="pubOrganDataSet" width="10%" editable="false"></next:Column>
						<next:Column header="处理时间" field="commitTime" width="18%" editable="false"></next:Column>
						<next:Column header="意见" field="opinionId" dataset="opinionSelect2" width="10%" editable="false"></next:Column>
						<next:Column header="处理补充意见" field="opinion" width="40%" editable="false"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>							
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>

<next:Window id="winSomLiqpeople" title="查看清算组织成员"  width="650" height="100%" autoHeight="true" resizable="false" closeAction="hide" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="winCloseSomLiqpeople"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel id="panelWinLiqpeople">
		<next:Html>
			<form id="formWinLiqpeople" method="post" dataset="winSomLiqpeopleDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" width="25%"><label>姓名：</label></td>
					<td class="FieldInput" width="25%"><label type="text" name="'姓名'" field="name" style="width:90%"/></td>
					<td class="FieldLabel" width="25%"><label>清算组织负责人：</label></td>
					<td class="FieldInput" width="25%">
						<label type="text" name="'清算组织负责人'" field="ifChief" dataset="ifChiefSelect" style="width:90%"/>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>在清算组织中职务：</label></td>
					<td class="FieldInput" colspan="3"><label type="text" name="'在清算组织中职务'" field="liqDuties" style="width:90%"/></td>
				</tr>
				<tr>	
					<td class="FieldLabel"><label>工作单位：</label></td>
					<td class="FieldInput" colspan="3"><label type="text" name="'工作单位'" field="workName" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>职务（职称）：</label></td>
					<td class="FieldInput" colspan="3"><label type="text" name="'职务（职称）'" field="workDuties" style="width:90%"/></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>