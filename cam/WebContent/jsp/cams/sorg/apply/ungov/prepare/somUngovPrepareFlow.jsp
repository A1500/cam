<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.loushang.workflow.api.WfQuery" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>民办非企业单位登记立项流程</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">
<%
	String primaryKey=request.getParameter("primaryKey");
    if(primaryKey==null){
    	primaryKey="";
    }
	String assignmentId=(String)request.getParameter("assignmentId");
	String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
	String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
	String actname=(String)request.getParameter("actname");
	//然调用接口
	List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
	String method = request.getParameter("method");
	Boolean flag = false;
	if("yiban".equals(method) || "jieshu".equals(method)){
		Map<String,String> map = new HashMap<String,String>();	
		map.put("buttonName","返回");
		map.put("buttonFunName","goBack()");
		List<Map> lists = new ArrayList<Map>();	
		lists.add(map);
		list = lists;
		flag = true;
	}
	List<Map> list1=new WfQuery().getActFields(actDefUniqueId); 
	//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
	//如果域是只读的则显示为只读
	//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
	String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
	//boolean isHidden,isReadOnly,isNotNull;
	String processId=(String)request.getParameter("processId");
	if(processId == null){
		processId = new GroupBuildCmd().getProcessId(assignmentId);
	}
	String taskCode = "";
	if(new GroupBuildCmd().getTaskCode(processId) != null){
		taskCode = (new GroupBuildCmd().getTaskCode(processId)).getTaskCode();
	}
	
%>
	var processId = '<%=processId%>';
	var procDefUniqueId = '<%=(String)request.getParameter("procDefUniqueId")%>';
	var assignmentId="<%=assignmentId%>";
	var currentUserName = '<%=GetBspInfo.getBspInfo().getUserName()%>';
	var actDefUniqueId ="<%=actDefUniqueId%>";
	var sorgId='<%=primaryKey%>';
	var taskCode = '<%=taskCode%>';
	var actname='<%=actname%>';
	var flag = <%=flag%>;
	var applyType = "104";
</script>
<script type="text/javascript">
//初始化
function init(){
	//法人
	somOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somOrganDataSet.load();
	//举办者
	somHeldPeopleDataSet.setParameter("SORG_ID@=",sorgId);
	somHeldPeopleDataSet.load();
	//举办单位
	somHeldOrganDataSet.setParameter("SORG_ID@=",sorgId);
	somHeldOrganDataSet.load();
	//拟任负责人
	somAspchiefDataSet.setParameter("SORG_ID@=",sorgId);
	somAspchiefDataSet.load();
	//电子档案
	somElectronicDataSet_load();
	//流程历史意见
	somFlowListDataSet.setParameter("TASK_CODE@=", taskCode);
	somFlowListDataSet.setParameter("SORG_ID@=", sorgId);
	somFlowListDataSet.setParameter("APPLY_TYPE@=", "104");
	somFlowListDataSet.load();
	//流程意见
	somApplyDataSet.setParameter("TASK_CODE@=", taskCode);
	somApplyDataSet.load();
	//过滤流程意见
	if(actname=='accept' || actname=='inform'){
		opinionSelect.filterBy(function(record, id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
			if("0".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	}
	//过滤tab页
	if(flag == true){
		L5.getCmp("tab").remove(6);
	}
}
//保存
function saveApply(){
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("6");
		return false;
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovPrepareCmd");
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	command.setParameter("somApplyDataSetRd",somApplyDataSetRd);
	//保存
	command.execute("updateApply");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function send(){
	var somApplyDataSetIsValidate = somApplyDataSet.isValidate();
	if(somApplyDataSetIsValidate != true){
		L5.Msg.alert("提示",somApplyDataSetIsValidate);
		L5.getCmp("tab").setActiveTab("6");
		return false;
	}
	//业务意见
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovPrepareCmd");
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	command.setParameter("somApplyDataSetRd",somApplyDataSetRd);
	//保存并提交
	command.execute("send");
	if (!command.error) {
		L5.Msg.alert("提示","成功发送到下一环节!",function(){
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"发送时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	history.go(-1);
}
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--举办人情况--%>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople"></model:record>
	</model:dataset>
	<%--举办单位情况--%>
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan"></model:record>
	</model:dataset>
	<%--拟任负责人情况--%>
	<model:dataset id="somAspchiefDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--流程历史意见--%>
	<model:dataset id="somFlowListDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<%--业务意见信息验证--%>
			<model:field name="curOpinionId" type="string" rule="require"/>
		    <model:field name="curOpinion" type="string" rule="length{200}"/>
		</model:record>
	</model:dataset>
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="workFlowOpinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>	
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<% 
			//从后台获取环节按钮权限，显示要显示按钮
			for(int i=0;i<list.size();i++){
				Map map=(Map)list.get(i);
				String buttonName=(String)map.get("buttonName");
				String buttonFunName=(String)map.get("buttonFunName");
				String buttonIcon = "";
				if("saveApply()".equals(buttonFunName)){
					buttonIcon = "save";
				}
				if("send()".equals(buttonFunName)){
					buttonIcon = "select";
				}
				if("goBack()".equals(buttonFunName)){
					buttonIcon = "return";
				}
		%>			
				<next:ToolBarItem iconCls="<%=buttonIcon%>" text="<%=buttonName%>" handler="<%=buttonFunName%>" />
		<%	
			}
		%>
	</next:TopBar>
	
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="民办非企业单位申请成立登记立项信息" width="100%" autoScroll="true">
				<next:Html>
				<fieldset>
				<legend>民办非企业单位申请成立登记立项信息</legend>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel">民办非企业单位名称：</td>
							<td class="FieldInput" colspan="5"><label id="cnName" name='"民办非企业单位名称"' field="cnName" style="width:98%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">单位宗旨：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"单位宗旨"' field="purpose" style="width:98%" readonly="readonly"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">业务范围：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"业务范围"' field="business" style="width:98%" readonly="readonly"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟确定业务主管单位：</td>
							<td class="FieldInput" colspan="5"><label field="borgName" name='"拟确定业务主管单位"' style="width:30%" dataset="businessOrganSelect"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>拟定开办资金数额：</label></td>
							<td class="FieldInput" colspan="5"><label id="regMon" name='"拟定开办资金数额"' field="regMon" maxlength="10" style="width:30%"/>万元</td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>出资人：</label></td>
							<td class="FieldInput" colspan="5"><textarea name='"出资人"' field="fundingPeople" style="width:98%" readonly="readonly"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>资金来源：</label></td>
							<td class="FieldInput" colspan="5"><label name='"资金来源"' field="moneySource" style="width:98%"/></td>
						</tr>
						<tr>	
							<td class="FieldLabel"><label>办公地点：</label></td>
							<td class="FieldInput" colspan="5"><label name='"办公地点"' field="residence" style="width:98%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">填表人：</td>
							<td class="FieldInput" style="width:17%"><label name='"填表人"' field="appPeople" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">联系人电话：</td>
							<td class="FieldInput" style="width:15%"><label id="sorgPhone" name='"联系人电话"' field="appPhone" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">申请日期：</td>
							<td class="FieldInput" style="width:17%"><label name='"申请日期"' field="appDate" readonly="readonly" style="width:90%"/></td>
						</tr>
					</table>
					</form>
					</fieldset>
					<fieldset>
					<legend>历史处理意见</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">初审意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="opinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">初审承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审承办人'  style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">初审时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='初审时间' field="examinTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">初审补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:98%;background-color:#F5FAFA;border:0" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">审核意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="opinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">审核承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核承办人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">审核时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='审核时间' field="checkTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">审核补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%;background-color:#F5FAFA;border:0" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">审批意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="auditOpinionId" name='"审批意见"' style="width:90%" dataset="opinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">审批承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='审批承办人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">审批时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='审批时间' field="auditTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">审批补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='审批补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0" readonly></textarea>
							</td>
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
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="5%" editable="false"><next:ComboBox dataset="sexSelect"></next:ComboBox></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:DateField format="Y-m-d"/></next:Column>
						<next:Column header="政治面貌" field="politics" width="10%" editable="false"><next:ComboBox dataset="politicsSelect"></next:ComboBox></next:Column>
						<next:Column header="户口所在地" field="populace" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="工作单位" field="workName" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="10%" editable="false"><next:TextField/></next:Column>
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
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
						<next:Column header="举办单位名称" field="name" width="40%" editable="false"><next:TextField/></next:Column>
						<next:Column header="主要负责人" field="heldorganPeople" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="20%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldOrganDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			
			<next:Panel title="拟任主要负责人">
				<next:EditGridPanel id="aspchiefGrid" dataset="somAspchiefDataSet" width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"></next:ComboBox></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:DateField format="Y-m-d"/></next:Column>
						<next:Column header="政治面貌" field="politics" width="15%" editable="false"><next:ComboBox dataset="politicsSelect"></next:ComboBox></next:Column>
						<next:Column header="户口所在地" field="populace" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="工作单位" field="workName" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="拟任职务" field="sorgDuties" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="10%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somAspchiefDataSet"/>
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
						<next:Column header="档案目录名"  field="catalogCode" width="40%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
						<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="流程历史意见" width="100%" >
				<next:GridPanel id="flowGrid" width="100%" stripeRows="true" height="100%" dataset="somFlowListDataSet" >
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column id="activity" header="流程环节" field="activity" width="10%" editable="false"></next:Column>
						<next:Column id="organId" header="处理单位" field="organId" width="10%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="deptId" header="处理部门" field="deptId" width="10%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="actorId" header="处理人" field="actorId" width="10%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="commitTime" header="处理时间" field="commitTime" width="13%" editable="false"></next:Column>
						<next:Column id="opinionId" header="处理意见" field="opinionId" width="7%" editable="false" dataset="workFlowOpinionSelect"></next:Column>
						<next:Column id="opinion" header="处理补充意见" field="opinion" width="40%" editable="false"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowListDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel title="请填写流程处理意见" width="100%" >
				<next:Html>
				<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
					<fieldset style="width:100%">
						<legend>处理意见</legend>
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
								<td class="FieldInput" colspan="5">
								<select field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
									<option dataset="opinionSelect"></option>
								</select><span style="color:red">*</span>
								</td>
								
							</tr>
							<tr>
								<td class="FieldLabel"><label>处理补充意见：</label></td>
								<td class="FieldInput" colspan="5">
									<textarea rows="10" name='"处理补充意见"' field="curOpinion" style="width:98%"></textarea>
								</td>
							</tr>
						</table>
					</fieldset>
				</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="downloadWin" closeAction="hide" height="400" width="740">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="winClosedownload"></next:ToolBarItem>
	</next:TopBar>
	<next:EditGridPanel id="downloadGrid" width="725" stripeRows="true" height="360" dataset="downloadDataSet" >
		<next:Columns>
			<next:RowNumberColumn/>
			<next:Column header="电子档案ID" field="electronicId" editable="false" hidden="true"></next:Column>
			<next:Column header="档案目录名"  field="catalogCode" width="335" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
			<next:Column header="附件名称" field="fileName" width="180" editable="false" renderer="winDownloadHref"></next:Column>
			<next:Column header="文件描述" field="fileMess" width="180" editable="false"></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>