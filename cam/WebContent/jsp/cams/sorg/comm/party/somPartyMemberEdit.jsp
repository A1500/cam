<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<model:datasets>
	<model:dataset id="borgNameDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="belongOrgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_PARTY_BELONG_ORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="winPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" global='true'>
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember">
			<model:field name="sorgId" type="string" rule="require"/>
		    <model:field name="peopleType" type="string" rule="require"/>
		    <model:field name="name" type="string" rule="length{72}"/>
		    <model:field name="birthplace" type="string" rule="length{100}"/>
		    <model:field name="profession" type="string" rule="length{50}"/>
		    <model:field name="sorgDuties" type="string" rule="length{30}"/>
		    <model:field name="workName" type="string" rule="length{100}"/>
		   	<model:field name="workDuties" type="string" rule="length{50}"/>
		   	<model:field name="partyDuties" type="string" rule="length{50}"/>
		   	<model:field name="training" type="string" rule="length{500}"/>
		   	<model:field name="partyPraise" type="string" rule="length{500}"/>
		   	<model:field name="praise" type="string" rule="length{500}"/>
			<model:field name="idCard" type="string" rule="require"/>
		   	<model:field name="name" type="string" rule="require"/>
		   	<model:field name="sex" type="string" rule="require"/>
		   	<model:field name="birthday" type="string" rule="require"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somPartyPraiseInsertDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyPraiseQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyPraise"></model:record>
	</model:dataset>
	<model:dataset id="somPartyPraiseDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyPraiseQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyPraise"></model:record>
	</model:dataset>
	<model:dataset id="praiseOrPunnishSelect" enumName="SOM.PARTY.PRAISE_OR_PUNNISH" autoLoad="true" global="true"></model:dataset>
 	<model:dataset id="praiseTypeSelect" enumName="SOM.PARTY.PRAISE_TYPE" autoLoad="true" global="true"></model:dataset>
 	<model:dataset id="grantedTitleSelect" enumName="SOM.PARTY.GRANTED_TITLE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Window id="partyMemberWin" title="社会组织党员情况调查表" closeAction="hide"  width="800" height='430' modal="true" >
	<next:TabPanel id="tabPartyMember">
		<next:Tabs>
	<next:Panel id="panelPartyMember" width="770" height="85%" autoScroll="true" title='基本信息'>
		<next:Html>
			<form dataset="winPartyMemberDataSet"  onsubmit="return false"  class="L5form">
		<fieldset>
		<legend>基本信息</legend>
		<table width="100%">
						<tr>
							<td class="FieldLabel" width='14%'><label>身份证号：</label></td>
							<td class="FieldInput" width='21%'><input type="text" name="身份证号" id="idCard_partyMember" field="idCard" onchange='checkIdCard_partyMember()' style="width:90%"/><span style='color:red'>*</span></td>
							<td class="FieldLabel" width='14%'><label>姓名：</label></td>
							<td class="FieldInput" width='18%'><input type="text" name="姓名" id="name_partyMember" field="name" style="width:90%" /><span style='color:red'>*</span></td>
							<td class="FieldLabel" width='14%'><label>人员类别:</label></td>
							<td class="FieldInput" width='19%'><select name="人员类别" id="peopleType" field="peopleType" style="width: 90%" onblur='showOtherInfo(this)'><option dataset="peopleTypeSelect"></option></select><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>性别:</label></td>
							<td class="FieldInput"><select name='性别' id="sex" field="sex" style="width: 90%"><option dataset="sexSelect"></option></select><span style='color:red'>*</span></td>
							<td class="FieldLabel"><label>出生日期:</label></td>
							<td class="FieldInput"><input name='出生日期' field="birthday" type="text" id="birthday" format="Y-m-d" onclick="WdatePicker();"  style="width: 90%"/><span style='color:red'>*</span></td>
							<td class="FieldLabel"><label>民族:</label></td>
							<td class="FieldInput"><select name='民族' id="folk" field="folk"  style="width: 90%"><option dataset="folkSelect"></option></select></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>最高学历:</label></td>
							<td class="FieldInput"><select name="最高学历" id="education" field="education" style="width: 90%"><option dataset="educationSelect" ></option></select></td>
							<td class="FieldLabel"><label>电话:</label></td>
							<td class="FieldInput"><input type="text" name="电话" id="phone" field="phone"  style="width: 90%"/></td>
							<td class="FieldLabel"><label>社会组织职务:</label></td>
							<td class="FieldInput"><select name="社会组织职务" id="sorgDuties" field="sorgDuties" style="width: 90%"><option dataset="sorgDutiesSelect"  ></option></select></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>主要任职单位:</label></td>
							<td class="FieldInput" colspan='3'><input type="text" name="主要任职单位" id="workName" field="workName" style="width: 97%" /></td>
							<td class="FieldLabel"><label>主要任职单位职务:</label></td>
							<td class="FieldInput"><input type="text" name="主要任职单位工作职务" id="workDuties" field="workDuties" style="width: 90%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="14%"><label>专业技术职称:</label></td>
							<td class="FieldInput" width="21%"><input name="专业技术职称" id="profession" field="profession" type="text" style="width: 90%" /></td>
							<td class="FieldLabel" width="14%"><label>专职/兼职:</label></td>
							<td class="FieldInput" width="18%"><select name='专职/兼职' id="ifFulltime" field="ifFulltime" style="width: 90%"><option dataset="ifPartyMemberFulltimeSelect"></option></select><span style='color:red'>*</span></td>
							<td class="FieldLabel" width="14%"><label>生活困难标识:</label></td>
							<td class="FieldInput" width="19%"><select name="生活困难标识" id="ifPoor" field="ifPoor"  style="width: 90%"><option dataset='comm_yesorno'></option></select></td>
						</tr>
		</table>
		</fieldset>
				<div id="dangyuanDiv" style="display:block">
				<fieldset>
					<legend>相关信息</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" width="14%"><label>社会组织党内职务:</label></td>
							<td class="FieldInput" width="21%"><input type="text" name="社会组织党内职务" id="partyDuties" field="partyDuties" style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"><label>党建指导员标识:</label></td>
							<td class="FieldInput" width="18%"><select name="党建指导员标识" id="ifInstrctor" field="ifInstrctor" style="width: 90%"><option dataset='comm_yesorno'/></select></td>
							<td class="FieldLabel" width="14%"><label>跨支部党员标识:</label></td>
							<td class="FieldInput" width="19%"><select name="跨支部党员标识" id="ifOtherBranch" field="ifOtherBranch" style="width: 90%" disabled><option dataset='comm_yesorno'/></select></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>隶属组织分类:</label></td>
							<td class="FieldInput"><select name='隶属组织分类' id="belongOrgType" field="belongOrgType" onchange="dealBelongOrg(this.value,this.id,'belongOrg')" style="width: 90%"><option dataset="belongOrgTypeSelect"></option></select><span style='color:red'>*</span></td>
							<td class="FieldLabel"><label>隶属组织:</label></td>
							<td class="FieldInput"><input name='隶属组织' id="belongOrg" field="belongOrg" style="width: 90%" onblur='getIfOtherBranch()'/><span style='color:red'>*</span></td>
							<td class="FieldLabel"><label>组织关系是否在服务中心管理:</label></td>
							<td class="FieldInput"><select name='组织关系是否在服务中心管理' id="relation" field="relation" style="width: 90%"><option dataset="comm_yesorno"></option></select></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
							<td class="FieldInput" width="21%"><input name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d" onclick="WdatePicker();"  editable='true'style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"><label>列为入党积极分子日期:</label></td>
							<td class="FieldInput" width="18%"><input name='列为入党积极分子日期' type="text"  id="activistsDate" field="activistsDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"><label>列为发展对象日期:</label></td>
							<td class="FieldInput" width="19%"><input name='列为发展对象日期' type="text" id="developDate" field="developDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>列为预备党员日期:</label></td>
							<td class="FieldInput"><input type="text" name="列为预备党员日期" id="joinDate" field="joinDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
							<td class="FieldLabel"><label>转正日期:</label></td>
							<td class="FieldInput"><input type="text" name="转正日期" id="normalDate" field="normalDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
							<td class="FieldLabel"><label>转正情况:</label></td>
							<td class="FieldInput"><select name='转正情况' id="normalInfo" field="normalInfo" style="width: 90%"><option dataset='normalInfoSelect'></option></select></td>
						</tr>
					</table>
				</fieldset>
				</div>
				<div id="yubeiDiv" style="display:block">
				<fieldset>
					<legend>相关信息</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" width="14%"><label>社会组织党内职务:</label></td>
							<td class="FieldInput" width="21%"><input type="text" name="社会组织党内职务" id="partyDuties" field="partyDuties" style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"><label>党建指导员标识:</label></td>
							<td class="FieldInput" width="18%"><select name="党建指导员标识" id="ifInstrctor" field="ifInstrctor" style="width: 90%"><option dataset='comm_yesorno'/></select></td>
							<td class="FieldLabel" width="14%"><label>跨支部党员标识:</label></td>
							<td class="FieldInput" width="19%"><select name="跨支部党员标识" id="ifOtherBranch" field="ifOtherBranch" style="width: 90%" disabled><option dataset='comm_yesorno'/></select></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>隶属组织分类:</label></td>
							<td class="FieldInput"><select name='隶属组织分类' id="belongOrgTypeYubei" field="belongOrgType" onchange="dealBelongOrg(this.value,this.id,'belongOrgYubei')" style="width: 90%"><option dataset="belongOrgTypeSelect"></option></select><span style='color:red'>*</span></td>
							<td class="FieldLabel"><label>隶属组织:</label></td>
							<td class="FieldInput"><input name='隶属组织' id="belongOrgYubei" field="belongOrg" style="width: 90%" onblur='getIfOtherBranch()'/><span style='color:red'>*</span></td>
							<td class="FieldLabel"><label>组织关系是否在服务中心管理:</label></td>
							<td class="FieldInput"><select name='组织关系是否在服务中心管理' id="relation" field="relation" style="width: 90%"><option dataset="comm_yesorno"></option></select></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
							<td class="FieldInput" width="21%"><input name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d" onclick="WdatePicker();"  editable='true'style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"><label>列为入党积极分子日期:</label></td>
							<td class="FieldInput" width="18%"><input name='列为入党积极分子日期' type="text"  id="activistsDate" field="activistsDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"><label>列为发展对象日期:</label></td>
							<td class="FieldInput" width="19%"><input name='列为发展对象日期' type="text" id="developDate" field="developDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>列为预备党员日期:</label></td>
							<td class="FieldInput"><input type="text" name="列为预备党员日期" id="joinDate" field="joinDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
							<td class="FieldLabel"></td>
							<td class="FieldInput"></td>
							<td class="FieldLabel"></td>
							<td class="FieldInput"></td>
						</tr>
					</table>
				</fieldset>
				</div>
				<div id="fazhanDiv" style="display:none">
				<fieldset>
					<legend>相关信息</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
							<td class="FieldInput" width="21%"><input name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d" onclick="WdatePicker();"  editable='true'style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"><label>列为入党积极分子日期:</label></td>
							<td class="FieldInput" width="18%"><input name='列为入党积极分子日期' type="text"  id="activistsDate" field="activistsDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"><label>列为发展对象日期:</label></td>
							<td class="FieldInput" width="19%"><input name='列为发展对象日期' type="text" id="developDate" field="developDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
						</tr>
					</table>
				</fieldset>
				</div>
				<div id="jijifenziDiv" style="display:none">
				<fieldset>
					<legend>相关信息</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
							<td class="FieldInput" width="21%"><input name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d" onclick="WdatePicker();"  editable='true'style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"><label>列为入党积极分子日期:</label></td>
							<td class="FieldInput" width="18%"><input name='列为入党积极分子日期' type="text"  id="activistsDate" field="activistsDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"></td>
							<td class="FieldInput" width="19%"></td>
						</tr>
					</table>
				</fieldset>
				</div>
				<div id="shenqingrenDiv" style="display:none">
				<fieldset>
					<legend>相关信息</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" width="14%"><label>申请入党日期:</label></td>
							<td class="FieldInput" width="21%"><input name='申请入党日期' type="text" id="applicationDate" field="applicationDate" format="Y-m-d" onclick="WdatePicker();"  editable='true'style="width: 90%"/></td>
							<td class="FieldLabel" width="14%"></td>
							<td class="FieldInput" width="18%"></td>
							<td class="FieldLabel" width="14%"></td>
							<td class="FieldInput" width="19%"></td>
						</tr>
					</table>
				</fieldset>
				</div>
			</form>
		</next:Html>
	</next:Panel>
			<next:EditGridPanel id="partyPraiseGrid" dataset="somPartyPraiseInsertDataSet" stripeRows="true" title="奖惩情况" width="770" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加" handler="addPraise"></next:ToolBarItem>
					<next:ToolBarItem iconCls="delete" text="删除" handler="delPraise"></next:ToolBarItem>
					<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="uploadFile_praise"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="内码" field="praiseId" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="奖惩批准日期" field="praiseDate" width="10%" editable="true"><next:DateTimeField allowBlank="true" format="Y-m-d"/></next:Column>
					<next:Column header="奖惩类型" field="praiseOrPunnish" width="10%" editable="true"><next:ComboBox dataset="praiseOrPunnishSelect" typeAble="false"></next:ComboBox></next:Column>
					<next:Column header="奖惩事项分类" field="praiseItemType" width="20%" editable="true"><next:ComboBox dataset="praiseTypeSelect" typeAble="false"></next:ComboBox></next:Column>
					<next:Column header="奖惩名称" field="praiseName" width="30%" editable="true" ><next:TextField/></next:Column>
					<next:Column header="表彰授予称号" field="grantedTitle" width="10%" editable="true"><next:ComboBox id="grantedTitleComboBox" dataset="grantedTitleSelect" typeAble="false"></next:ComboBox></next:Column>
					<next:Column header="奖惩批准单位名称" field="praiseOrg" width="30%" editable="true"><next:TextField/></next:Column>
					<next:Column header="文件号" field="fileNo" width="15%" editable="true"><next:TextField/></next:Column>
					<next:Column header="相关文件" field="fileName" width="25%" editable="true"><next:TextField/></next:Column>
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="download_praise"><next:TextField /></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somPartyPraiseInsertDataSet"/>
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirmPartyMember"></next:ToolButton>
		<next:ToolButton text="关闭" handler="winClosePartyMember"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="printPartyWin" closeAction="hide" title="社会组织筹建党组织告知书" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="confirmPrint"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closePrintWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%"><label>联系人：</label></td>
					<td class="FieldInput" style="width:15%"><input id="linkmanName" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%"><label>联系电话：</label></td>
					<td class="FieldInput" style="width:15%"><input id="linkmanPhone" style="width:90%"/></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script language="javascript">
//处理editgridpanel中枚举值的过滤
function grantedTitleComboBoxFilter(){
	var grantedTitleComboBox=L5.getCmp("grantedTitleComboBox");
	grantedTitleComboBox.on("expand",onSelectGrantedTitleCode);
}
function onSelectGrantedTitleCode(){
	var grantedTitleSelect=L5.DatasetMgr.lookup("grantedTitleSelect");
	grantedTitleSelect.load();
	grantedTitleSelect.on("load",function(ds){
		//过滤授予称号，保留先进党组织
		ds.filterBy(function(record,id){
			if("1".indexOf(record.get('value'))>-1){
				return record;
			}
			if("2".indexOf(record.get('value'))>-1){
				return record;
			}
		});
	});
	grantedTitleComboBox.un("expand",onSelectGrantedTitleCode);
}
function showOtherInfo(obj){
 	var peopleType=obj.value;
 	var dangyuan=$("dangyuanDiv");
 	var yubei=$("yubeiDiv");
 	var fazhan=$("fazhanDiv");
 	var jijifenzi=$("jijifenziDiv");
 	var shenqingren=$("shenqingrenDiv");
 	if(peopleType==5){
 		dangyuan.style.display="none";
 		yubei.style.display="none";
 		fazhan.style.display="none";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="block";
 	}else if(peopleType==4){
 		dangyuan.style.display="none";
 		yubei.style.display="none";
 		fazhan.style.display="none";
 		jijifenzi.style.display="block";
 		shenqingren.style.display="none";
 	}else if(peopleType==3){
 		dangyuan.style.display="none";
 		yubei.style.display="none";
 		fazhan.style.display="block";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="none";

 		//清空党员div中的隶属组织信息
 		$("belongOrg").value = "";
 		$("belongOrgType").value = "";
 		$("belongOrg").disabled = "";
 		winPartyMemberDataSet.set("belongOrg","");

 		//清空预备党员div中的隶属组织信息
 		$("belongOrgYubei").value = "";
 		$("belongOrgTypeYubei").value = "";
 		$("belongOrgYubei").disabled = "";
 		clearwinPartyMemberDataSetInDiv();
 	}else if(peopleType==2){
 		dangyuan.style.display="none";
 		yubei.style.display="block";
 		fazhan.style.display="none";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="none";

 		$("belongOrg").disabled = "";
 		clearwinPartyMemberDataSetInDiv();
 	}else{
 		dangyuan.style.display="block";
 		yubei.style.display="none";
 		fazhan.style.display="none";
 		jijifenzi.style.display="none";
 		shenqingren.style.display="none";

 		$("belongOrgYubei").disabled = "";
 		clearwinPartyMemberDataSetInDiv();
 	}

 	if(peopleType==1){
 		$('ifFulltime').disabled=false;
 	}else{
 		$('ifFulltime').disabled=true;
 		winPartyMemberDataSet.set('ifFulltime','');
 	}
}
function getIfOtherBranch(){
	var cnName=$("cnName").value;
	var belongOrg=_$('belongOrg');
	if(belongOrg==cnName){
		winPartyMemberDataSet.set('ifOtherBranch','0');
	}else{
		winPartyMemberDataSet.set('ifOtherBranch','1');
	}
}

/**
 * 根据隶属组织类型来处理隶属组织输入域
 * 选择社会组织和业务主管单位类别的“隶属组织”字段自动回填并不可修改，其他类别的手工填写
 * 由于党员与预备党员在页面所引用的div不同，字段取值的id得区分开，所以此处多加了两个参数，用来出来党员与预备党员两种情况
 * @param {} value 隶属组织类型值
 * @param {} typeid 隶属组织类型输入域的id
 * @param {} belongOrgId 隶属组织输入域的id
 */
function dealBelongOrg(value,typeid,belongOrgId){
	var organRecord=somOrganDataSet.getCurrent();
	var sorgName = organRecord.get("cnName");
	var borgName = organRecord.get("borgName");
	var winPartyMemberDataSet=L5.DatasetMgr.lookup("winPartyMemberDataSet");
	if(value == "0"){
		winPartyMemberDataSet.set("belongOrg",sorgName);
		$(belongOrgId).value = sorgName;
		$(belongOrgId).disabled = "disabled";
		return;
	}
	if(value == "1"){
		var borgNameDs=L5.DatasetMgr.lookup("borgNameDs");
		borgNameDs.setParameter("value@=",borgName);
		borgNameDs.load();
		borgNameDs.on('load',function (ds){
			winPartyMemberDataSet.set("belongOrg",ds.get("text"));
			$(belongOrgId).value = ds.get("text");
			$(belongOrgId).disabled = "disabled";
			return;
		});

	}
	$(belongOrgId).value = "";
	$(belongOrgId).disabled = "";
}

function clearwinPartyMemberDataSetInDiv(){
 	var winPartyMemberDataSet=L5.DatasetMgr.lookup("winPartyMemberDataSet");
 	winPartyMemberDataSet.set("partyDuties","");
 	winPartyMemberDataSet.set("ifInstrctor","");
 	winPartyMemberDataSet.set("ifOtherBranch","");
 	winPartyMemberDataSet.set("belongOrgType","");
 	winPartyMemberDataSet.set("belongOrg","");
 	winPartyMemberDataSet.set("relation","");
 	winPartyMemberDataSet.set("applicationDate","");
 	winPartyMemberDataSet.set("activistsDate","");
 	winPartyMemberDataSet.set("developDate","");
 	winPartyMemberDataSet.set("joinDate","");
 	winPartyMemberDataSet.set("normalDate","");
 	winPartyMemberDataSet.set("normalInfo","");
 }

 // 增加
function addPraise(){
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	somPartyPraiseInsertDataSet.newRecord({"memberId":memberId,'praiseType':'M','praiseOrPunnish':'0'});
}
// 删除
function delPraise(){
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	var record=somPartyPraiseInsertDataSet.getCurrent();
	if(record!=null){
		somPartyPraiseInsertDataSet.remove(record);
		somPartyPraiseDataSet.remove(record);
	}
}

var partyMemberRecord = '';
var memberId='';
//增加
function addPartyMember(){
	partyMemberRecord = '';
	var command = new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyMemberCmd");
	command.afterExecute=function(){
		memberId = command.getReturn('memberId');
		winPartyMemberDataSet.removeAll();
		winPartyMemberDataSet.newRecord({"memberId":memberId,"sorgId":sorgId,'belongOrg':_$('cnName'),'ifOtherBranch':'0'});
		var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
		somPartyPraiseInsertDataSet.removeAll();
		var win = L5.getCmp("partyMemberWin");
		win.show();

	 	var dangyuan=$("dangyuanDiv");
	 	var yubei=$("yubeiDiv");
	 	var fazhan=$("fazhanDiv");
	 	var jijifenzi=$("jijifenziDiv");
	 	var shenqingren=$("shenqingrenDiv");
		dangyuan.style.display="block";
		yubei.style.display="none";
		fazhan.style.display="none";
		jijifenzi.style.display="none";
		shenqingren.style.display="none";
	}
	command.execute('getMemberId');
}
function editPartyMember(){
	var grid = L5.getCmp("partyMemberGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	partyMemberRecord = record;
	memberId=record.get('memberId');
	winPartyMemberDataSet.removeAll();
	winPartyMemberDataSet.insert(0,record.copy());
	//处理奖惩
	var somPartyPraiseInsertDataSet=L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	var somPartyPraiseDataSet=L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	somPartyPraiseInsertDataSet.removeAll();
	var j=0;
	for(var i=somPartyPraiseDataSet.getCount()-1;i>=0;i--){
		var somPartyPraiseRecord =somPartyPraiseDataSet.getAt(i);
		if(partyMemberRecord.get('memberId')==somPartyPraiseRecord.get('memberId')){
			somPartyPraiseInsertDataSet.insert(j,somPartyPraiseRecord);
			j++;
		}
	}
	var win = L5.getCmp("partyMemberWin");
	win.show();

	var peopleType=record.get('peopleType');
	var dangyuan=$("dangyuanDiv");
	var yubei=$("yubeiDiv");
	var fazhan=$("fazhanDiv");
	var jijifenzi=$("jijifenziDiv");
	var shenqingren=$("shenqingrenDiv");
	if(peopleType==5){
		dangyuan.style.display="none";
		yubei.style.display="none";
		fazhan.style.display="none";
		jijifenzi.style.display="none";
		shenqingren.style.display="block";
	}else if(peopleType==4){
		dangyuan.style.display="none";
		yubei.style.display="none";
		fazhan.style.display="none";
		jijifenzi.style.display="block";
		shenqingren.style.display="none";
	}else if(peopleType==3){
		dangyuan.style.display="none";
		yubei.style.display="none";
		fazhan.style.display="block";
		jijifenzi.style.display="none";
		shenqingren.style.display="none";
	}else if(peopleType==2){
		dangyuan.style.display="none";
		yubei.style.display="block";
		fazhan.style.display="none";
		jijifenzi.style.display="none";
		shenqingren.style.display="none";
	}else{
		dangyuan.style.display="block";
		yubei.style.display="none";
		fazhan.style.display="none";
		jijifenzi.style.display="none";
		shenqingren.style.display="none";
	}
}
function delPartyMember(){
	var grid = L5.getCmp("partyMemberGrid");
	var sm = grid.getSelectionModel();
	var record = sm.getSelected();
	if(!record){
		L5.Msg.alert("提示","请选择一条记录!");
		return;
	}
	somPartyMemberDataSet.remove(record);
}
var praiseCount=0;
//窗口确定
function confirmPartyMember(){
//校验-------------------------------------------
	var isValidate = winPartyMemberDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var peopleType=winPartyMemberDataSet.get('peopleType');
	var ifFulltime=winPartyMemberDataSet.get('ifFulltime');
	if(peopleType==1&&ifFulltime==''){
		L5.Msg.alert("提示","校验未通过："+'请选择专职/兼职！');
		return;
	}
	var belongOrg=winPartyMemberDataSet.get('belongOrg');
	if((peopleType==1||peopleType==2) &&belongOrg==''){
		L5.Msg.alert("提示","校验未通过："+'请输入隶属组织！');
		return;
	}
	var belongOrgType=_$('belongOrgType');
	var belongOrgTypeYubei=_$('belongOrgTypeYubei');
	if(peopleType==1 &&belongOrgType==''){
		L5.Msg.alert("提示","校验未通过："+'请输入隶属组织分类！');
		return;
	}
	if(peopleType==2 &&belongOrgTypeYubei==''){
		L5.Msg.alert("提示","校验未通过："+'请输入隶属组织分类！');
		return;
	}
	var idCard = _$('idCard_partyMember');
	if(idCard==''){
		L5.Msg.alert("提示","校验未通过："+'请输入身份证号！');
		return;
	}
	if(partyMemberRecord != ''){
		somPartyMemberDataSet.remove(partyMemberRecord);
	}
	somPartyMemberDataSet.insert(somPartyMemberDataSet.getCount(),winPartyMemberDataSet.getCurrent());

	//处理
	var somPartyPraiseDataSet = L5.DatasetMgr.lookup("somPartyPraiseDataSet");
	var somPartyPraiseInsertDataSet = L5.DatasetMgr.lookup("somPartyPraiseInsertDataSet");
	for(var i=somPartyPraiseInsertDataSet.getCount()-1;i>=0;i--){
		var somPartyPraiseInsertRecord =somPartyPraiseInsertDataSet.getAt(i);
		if(somPartyPraiseDataSet.indexOf(somPartyPraiseInsertRecord)==-1){
			somPartyPraiseDataSet.insert(praiseCount,somPartyPraiseInsertRecord);
			praiseCount++;
		    somPartyPraiseDataSet.commitChanges();
		}
	}
	var win = L5.getCmp("partyMemberWin");
	win.setVisible(false);
}
//窗口关闭
function winClosePartyMember(){
	var win = L5.getCmp("partyMemberWin");
	win.setVisible(false);
}
function checkIdCard_partyMember(){
	if(_$("idCard_partyMember")!=''){
		//身份证号
		if(checkIDCard($("idCard_partyMember")) != true){
			L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
			return;
		}else{
			var have_idCard=false;
			somPartyMemberDataSet.each(function(record, index){
				if(record.get('idCard') == _$('idCard_partyMember')){
					L5.Msg.alert("提示","已录入人员信息，不能重复录入！");
					have_idCard=true;
					return;
				}
			});
			if(!have_idCard){
			// 根据证件号码索引人员
			var ifGetPartyInfo=false;
			somDutyDataSet.each(function(record, index){
				if(record.get('idCard') == _$('idCard_partyMember')){
					winPartyMemberDataSet.set('name',record.get("name"));
					winPartyMemberDataSet.set('sex',record.get("sex"));
					winPartyMemberDataSet.set('birthday',record.get("birthday"));
					winPartyMemberDataSet.set('folk',record.get("folk"));
					winPartyMemberDataSet.set('education',record.get("education"));
					winPartyMemberDataSet.set('phone',record.get("phone"));
					winPartyMemberDataSet.set('sorgDuties',record.get("sorgDuties"));
					winPartyMemberDataSet.set('workName',record.get("workName"));
					winPartyMemberDataSet.set('workDuties',record.get("workDuties"));
					winPartyMemberDataSet.set('profession',record.get("profession"));
					winPartyMemberDataSet.set('ifFulltime',record.get("ifFulltime"));
					ifGetPartyInfo=true;
					return;
				}
			});
			if(!ifGetPartyInfo){
				var somDutyDataSet2 = L5.DatasetMgr.lookup("somDutyDataSet2");
				somDutyDataSet2.setParameter("ID_CARD",_$('idCard_partyMember'));
				somDutyDataSet2.setParameter("SORG_ID",sorgId);
				somDutyDataSet2.load();
				somDutyDataSet2.on('load', function(ds){
					if(ds.getCount()>0){
						winPartyMemberDataSet.set('name',ds.get("name"));
						winPartyMemberDataSet.set('sex',ds.get("sex"));
						winPartyMemberDataSet.set('birthday',ds.get("birthday"));
						winPartyMemberDataSet.set('folk',ds.get("folk"));
						winPartyMemberDataSet.set('education',ds.get("education"));
						winPartyMemberDataSet.set('phone',ds.get("phone"));
						winPartyMemberDataSet.set('sorgDuties',ds.get("sorgDuties"));
						winPartyMemberDataSet.set('workName',ds.get("workName"));
						winPartyMemberDataSet.set('workDuties',ds.get("workDuties"));
						winPartyMemberDataSet.set('profession',ds.get("profession"));
						winPartyMemberDataSet.set('ifFulltime',ds.get("ifFulltime"));
					}
				});
			}
			}
		}
	}
}
function printParty(){
	partyNum='';
	var partyMemberNum=somPartyMemberDataSet.getCount();
	for(var i=0;i<partyMemberNum;i++){
		if(somPartyMemberDataSet.getAt(i).get("peopleType")=='1'){
			partyNum++;
		}
	}
	if(partyNum<3){
		L5.Msg.alert('提示','正式党员不足三人，不需建立党组织！');
		return;
	}
	var win = L5.getCmp("printPartyWin");
	win.show();
}
var partyNum='';
function confirmPrint(){
	var linkmanName=encodeURIComponent(encodeURIComponent(_$('linkmanName')));
	var linkmanPhone=_$('linkmanPhone');
	if(linkmanName==''||linkmanPhone==''){
		L5.Msg.alert('提示','请先填写完整的联系人信息！');
		return;
	}
	var url=rootPath+"jsp/cams/sorg/comm/print/partyBuildInformForPrint.jsp?cnName="+encodeURIComponent(encodeURIComponent(_$('cnName')))
	+'&linkmanName='+linkmanName+'&linkmanPhone='+linkmanPhone+'&taskCode='+taskCode+'&partyNum='+partyNum;
	window.open(url);
}
function closePrintWin(){
	var win = L5.getCmp("printPartyWin");
	win.setVisible(false);
}
</script>