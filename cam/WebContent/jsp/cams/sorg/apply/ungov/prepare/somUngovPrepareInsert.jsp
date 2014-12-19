<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils,com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>民办非企业单位登记立项</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">

var taskCode = '<%=StrUtil.n2b(SomIdHelp.getUngovTaskCode())%>';//生成业务编号
var sorgId = '<%=StrUtil.n2b(SomIdHelp.getUngovSorgId())%>';//生成社会组织ID
var applyType = "104";
function init(){
	//法人
	somOrganDataSet.newRecord();
	//电子档案
	somElectronicDataSet_load();
	//流程意见
	somApplyDataSet.newRecord();
	//电子档案上传窗口关闭事件
	var win=L5.getCmp("uploadList");
	win.on("hide",function(el){
		somElectronicDataSet_load();
	});
	//过滤流程意见
	opinionSelect.filterBy(function(record, id){
		if("0".indexOf(record.get('value'))>-1){
			return record;
		}
		if("1".indexOf(record.get('value'))>-1){
			return record;
		}
	});
}

//全部保存
function saveAll(){
	var somOrganValidate = somOrganDataSet.isValidate();
	var somHeldPeopleValidate = somHeldPeopleDataSet.isValidate();
	var somHeldOrganValidate = somHeldOrganDataSet.isValidate();
	var somAspchiefValidate = somAspchiefDataSet.isValidate();
	if(somOrganValidate != true){
		L5.Msg.alert("提示",somPrepareValidate);
		return false;
	}
	if(somHeldPeopleValidate != true){
		L5.Msg.alert("提示",somHeldPeopleValidate);
		return false;
	}
	if(somHeldOrganValidate != true){
		L5.Msg.alert("提示",somHeldOrganValidate);
		return false;
	}
	if(somAspchiefValidate != true){
		L5.Msg.alert("提示",somAspchiefValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovPrepareCmd");
	//法人
	var organRd=somOrganDataSet.getCurrent();
	command.setParameter("organRd", organRd);
	command.setParameter("sorgId", sorgId);
	//业务意见
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	command.setParameter("taskCode",taskCode);
	command.setParameter("somApplyDataSetRd",somApplyDataSetRd);
	//举办者
	command.setParameter("somHeldPeopleRds", somHeldPeopleDataSet.getAllChangedRecords());
	//举办单位
	command.setParameter("somHeldOrganRds", somHeldOrganDataSet.getAllChangedRecords());
	//拟任负责人
	command.setParameter("somAspchiefRds", somAspchiefDataSet.getAllChangedRecords());
	//保存
	command.execute("insertPrepareInfo");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
			goBack();
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//保存并提交
function saveAndSend(){
	var somOrganValidate = somOrganDataSet.isValidate();
	var somHeldPeopleValidate = somHeldPeopleDataSet.isValidate();
	var somHeldOrganValidate = somHeldOrganDataSet.isValidate();
	var somAspchiefValidate = somAspchiefDataSet.isValidate();
	if(somOrganValidate != true){
		L5.Msg.alert("提示",somPrepareValidate);
		return false;
	}
	if(somHeldPeopleValidate != true){
		L5.Msg.alert("提示",somHeldPeopleValidate);
		return false;
	}
	if(somHeldOrganValidate != true){
		L5.Msg.alert("提示",somHeldOrganValidate);
		return false;
	}
	if(somAspchiefValidate != true){
		L5.Msg.alert("提示",somAspchiefValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.sorg.apply.ungov.cmd.UngovPrepareCmd");
	//法人
	var organRd=somOrganDataSet.getCurrent();
	command.setParameter("organRd", organRd);
	command.setParameter("sorgId", sorgId);
	//业务意见
	var somApplyDataSetRd = somApplyDataSet.getCurrent();
	command.setParameter("taskCode",taskCode);
	command.setParameter("somApplyDataSetRd",somApplyDataSetRd);
	//举办者
	command.setParameter("somHeldPeopleRds", somHeldPeopleDataSet.getAllChangedRecords());
	//举办单位
	command.setParameter("somHeldOrganRds", somHeldOrganDataSet.getAllChangedRecords());
	//拟任负责人
	command.setParameter("somAspchiefRds", somAspchiefDataSet.getAllChangedRecords());
	//保存
	command.execute("saveAndSendPrepare");
	if (!command.error) {
		L5.Msg.alert("提示","成功发送到下一环节！",function(){
		goBack();
	});
	}else{
		L5.Msg.alert('提示',"发送时出现错误！"+command.error);
	}
}
//返回
function goBack(){
	var url = "jsp/cams/sorg/apply/ungov/prepare/somUngovPrepareList.jsp";
	var text = "列表";
	L5.forward(url,text);
}
// 增加举办者（自然人）
function addHeldPeople(){
	somHeldPeopleDataSet.newRecord();
}
// 删除举办者（自然人）
function delHelpPeople(){
	var record=somHeldPeopleDataSet.getCurrent();
	if(record!=null)
		somHeldPeopleDataSet.remove(record);
}
// 增加举办者（单位）
function addHeldOrgan(){
	somHeldOrganDataSet.newRecord();
}
// 删除举办者（单位）
function delHeldOrgan(){
	var record=somHeldOrganDataSet.getCurrent();
	if(record!=null)
		somHeldOrganDataSet.remove(record);
}
// 增加拟任负责人
function addAspchief(){
	somAspchiefDataSet.newRecord();
}
// 删除拟任负责人
function delAspchief(){
	var record=somAspchiefDataSet.getCurrent();
	if(record!=null)
		somAspchiefDataSet.remove(record);
}
//校验社会组织名称是否重复
function cnNameUK(){
	if(_$("cnName").trim() != ""){
		var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomFundCmd");
		command.setParameter("cnName",_$("cnName"));
		command.execute("cnNameUK");
		cnNameNum = command.getReturn("cnNameNum");
		if(cnNameNum != 0){
			L5.Msg.alert("提示","校验未通过："+"输入的机构名称已存在");
			return;
		}
	}
}


</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="regMon" type="string" rule="double|require|length{100}" />
		</model:record>
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
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
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
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="保存并提交" handler="saveAndSend"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>

	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="民办非企业单位申请成立登记立项信息" width="100%" autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel">民办非企业单位名称：</td>
							<td class="FieldInput" colspan="5"><input type="text" id="cnName" name='"民办非企业单位名称"' field="cnName" onblur="cnNameUK()" style="width:98%"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">单位宗旨：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"单位宗旨"' field="purpose" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">业务范围：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"业务范围"' field="business" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟确定业务主管单位：</td>
							<td class="FieldInput" colspan="5">
								<select field="borgName" name='"拟确定业务主管单位"' style="width:30%">
									<option dataset="businessOrganSelect"></option>
								</select><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>拟定开办资金数额：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" id="regMon" name='"拟定开办资金数额"' field="regMon" maxlength="10" style="width:30%"/>万元<span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>出资人：</label></td>
							<td class="FieldInput" colspan="5"><textarea name='"出资人"' field="fundingPeople" style="width:98%" ></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>资金来源：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" name='"资金来源"' field="moneySource" style="width:98%"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>办公地点：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" name='"办公地点"' field="residence" style="width:98%"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">填表人：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"填表人"' field="appPeople" style="width:90%"/><span style="color:red">*</span></td>
							<td class="FieldLabel" style="width:17%">联系人电话：</td>
							<td class="FieldInput" style="width:15%"><input type="text" id="sorgPhone" name='"联系人电话"' field="appPhone" style="width:90%"/><span style="color:red">*</span></td>
							<td class="FieldLabel" style="width:17%">申请日期：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"申请日期"' field="appDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>

			<next:Panel title="举办者情况">
				<next:EditGridPanel id="heldPeopleGrid" dataset="somHeldPeopleDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addHeldPeople"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delHelpPeople"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="5%" editable="true"><next:ComboBox dataset="sexSelect"></next:ComboBox></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="true"><next:DateField format="Y-m-d"/></next:Column>
						<next:Column header="政治面貌" field="politics" width="10%" editable="true"><next:ComboBox dataset="politicsSelect"></next:ComboBox></next:Column>
						<next:Column header="户口所在地" field="populace" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="工作单位" field="workName" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="10%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldPeopleDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="举办单位情况">
				<next:EditGridPanel id="heldOrganGrid" dataset="somHeldOrganDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addHeldOrgan"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delHeldOrgan"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="举办单位名称" field="name" width="40%" editable="true"><next:TextField/></next:Column>
						<next:Column header="主要负责人" field="heldorganPeople" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="20%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldOrganDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="拟任主要负责人">
				<next:EditGridPanel id="aspchiefGrid" dataset="somAspchiefDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addAspchief"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delAspchief"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="true"><next:ComboBox dataset="sexSelect"></next:ComboBox></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="true"><next:DateField format="Y-m-d"/></next:Column>
						<next:Column header="政治面貌" field="politics" width="15%" editable="true"><next:ComboBox dataset="politicsSelect"></next:ComboBox></next:Column>
						<next:Column header="户口所在地" field="populace" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="工作单位" field="workName" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="拟任职务" field="sorgDuties" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="10%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somAspchiefDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名"  field="catalogCode" width="40%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述"    field="fileMess" width="30%" editable="false"><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
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
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230" width="600">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>
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
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过5M</span></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<next:Window id="uploadList" closeAction="hide" title="附件上传列表" width="580" height="300" autoScroll="true">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true" height="88%" dataset="winElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="addUploadFile"></next:ToolBarItem>
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  width="18%" field="catalogCode" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="附件名称" width="18%" field="fileName" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述" width="15%" field="fileMess" editable="false"><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="10%" editable="false" renderer="delUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winElectronicDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>