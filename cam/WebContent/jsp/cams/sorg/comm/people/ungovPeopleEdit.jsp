<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<model:datasets>
	<model:dataset id="guidePeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<model:dataset id="guideDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<model:dataset id="dicSomOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifFulltimeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="folkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="regStatusDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_REG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<!-- 人员信息 -->
<next:Window id="peopleWin" title="负责人信息" resizable="false" width="800" height="400" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel id="peoplePanel">
		<next:Html>
			<form id="peopleFrom" method="post" dataset="somDutyDataSet" onsubmit="return false" class="L5form">
				<input type="hidden" id="peopleId" field="peopleId">
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:15%">身份证号码：</td>
						<td class="FieldInput" style="width:21%"><input type="text" id="idCard" field="idCard" name='"身份证号码"' onblur="checkIdCard()" maxlength="18" style="width:90%"/><span style="color:red">*</span></td>
						<td class="FieldLabel" style="width:14%">姓名：</td>
						<td class="FieldInput" style="width:17%"><input type="text" id="name" field="name" name='"姓名"' style="width:90%"/><span style="color:red">*</span></td>
						<td class="FieldLabel" style="width:14%">曾用名：</td>
						<td class="FieldInput" style="width:19%"><input type="text" field="aliasName" name='"曾用名"' style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">性别：</td>
						<td class="FieldInput">
							<select id="sex" field="sex" name='"性别"' style="width:90%">
								<option dataset="sexDataSet"></option>
							</select><span style="color:red">*</span>
						</td>
						<td class="FieldLabel">出生日期：</td>
						<td class="FieldInput"><input type="text" id="birthday" field="birthday" name='"出生年月"' onblur="showAge()" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
						<td class="FieldLabel">年龄：</td>
						<td class="FieldInput"><label id="age" name='年龄'/></td>
					</tr>
					<tr>
						<td class="FieldLabel">政治面貌：</td>
						<td class="FieldInput">
							<select field="politics" name='"政治面貌"' style="width:90%">
								<option dataset="politicsDataSet"></option>
							</select>
						</td>
						<td class="FieldLabel">民族：</td>
						<td class="FieldInput">
							<select field="folk" name='"民族"' style="width:90%">
								<option dataset="folkDataSet"></option>
							</select>
						</td>
						<td class="FieldLabel">户口所在地：</td>
						<td class="FieldInput"><input type="text" field="populace" name='"户口所在地"' style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭住址：</td>
						<td class="FieldInput" colspan="5"><input type="text" field="adds" name='"家庭住址"' style="width:97%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">邮编：</td>
						<td class="FieldInput"><input type="text" id="postCode" field="postCode" name='"邮编"' maxlength="6" style="width:90%"/></td>
						<td class="FieldLabel">电话：</td>
						<td class="FieldInput"><input type="text" id="phone" field="phone" name='"电话"' style="width:90%"/></td>
						<td class="FieldLabel">专/兼职：</td>
						<td class="FieldInput">
							<select field="ifFulltime" name='"专/兼职"' style="width:90%">
								<option dataset="ifFulltimeDataSet"></option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">工作单位：</td>
						<td class="FieldInput" colspan="3"><input type="text" field="workName" name='"工作单位"' style="width:90%"/></td>
						<td class="FieldLabel">工作单位职务：</td>
						<td class="FieldInput"><input type="text" field="workDuties" name='"单位职务"' style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">担任职务：</td>
						<td class="FieldInput">
							<select id="sorgDuties" field="sorgDuties" name='"担任职务"' onblur="getRenew()" style="width:90%">
								<option dataset="sorgDutiesDS"></option>
							</select><span style="color:red">*</span>
						</td>
						<td class="FieldLabel">是否连任：</td>
						<td class="FieldInput"><label field="ifRenew" dataset="yesornoDataSet"/></td>
						<td class="FieldLabel">连任届数：</td>
						<td class="FieldInput"><label field="renewNum"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">是否在任(社会组织中任职状态)：</td>
						<td class="FieldInput">
							<select id="ifServe" field="ifServe" name='"是否在任"' onblur="ifServeChange()" style="width:90%">
								<option dataset="yesornoDataSet"></option>
							</select><span style="color:red">*</span>
						</td>
						<td class="FieldLabel">任职开始日期：</td>
						<td class="FieldInput"><input type="text" id="startDate" field="startDate" name='"任职开始日期"' format="Y-m-d" onclick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
						<td class="FieldLabel">任职结束日期：</td>
						<td class="FieldInput"><input type="text" id="peopleEndDate" field="endDate" name='"任职结束日期"' format="Y-m-d" onclick="WdatePicker()" style="width:90%;display:none"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">是否党政机关领导干部：</td>
						<td class="FieldInput">
							<select id="ifPartyLeader" field="ifPartyLeader" name='"是否党政机关领导干部"' onchange="ifPartyLeaderChange()" style="width:90%">
								<option dataset="yesornoDataSet"></option>
							</select><span style="color:red">*</span>
						</td>
						<td class="FieldLabel">批准机关：</td>
						<td class="FieldInput"><input type="text" id="promiseOrgan" field="promiseOrgan" style="width:90%;display:none"/></td>
						<td class="FieldLabel">批准文号：</td>
						<td class="FieldInput"><input type="text" id="promiseCode" field="promiseCode" style="width:90%;display:none"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">其他社会职务：</td>
						<td class="FieldInput" colspan="5"><textarea rows="3" field="otherDuties" name='"其他社会职务"' style="width:97.7%"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
						<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' field="workOpinion" style="width:97.7%"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel">审查工作单位：</td>
						<td class="FieldInput" colspan="3"><input type="text" field="workName" name='"工作单位"' style="width:90%"/></td>
						<td class="FieldLabel">审查日期：</td>
						<td class="FieldInput"><input type="text" field="workCheckDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">备注：</td>
						<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' field="note" style="width:97.7%"></textarea></td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" stripeRows="true" height="250" title="本人简历">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="增加" handler="addResume"></next:ToolBarItem>
			<next:ToolBarItem iconCls="delete" text="删除" handler="delResume"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
			<next:Column header="开始年月" field="startDate" width="15%" editable="true" renderer="renderDate"><next:TextField/></next:Column>
			<next:Column header="结束年月" field="endDate" width="15%" editable="true" renderer="renderDate"><next:TextField/></next:Column>
			<next:Column header="在何地区何单位" field="workOrgan" width="35%" editable="true"><next:TextField/></next:Column>
			<next:Column header="任（兼）何职" field="duty" width="30%" editable="true"><next:TextField/></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somResumeInsertDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirm"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<!-- 调取人员档案 -->
<next:Window id="guidePeopleWin" title="人员档案" resizable="false" width="500" height="403" modal="true" closable="false">
	<next:EditGridPanel id="guidePeopleGrid" width="486" stripeRows="true" height="170" dataset="guidePeopleDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="人员列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="edit" text="确定" handler="editItem"></next:ToolBarItem>
			<next:ToolBarItem iconCls="delete" text="关闭" handler="closeItem"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="姓名" field="name" width="150" sortable="true" editable="false"><next:TextField/></next:Column>
			<next:Column header="出生年月" field="birthday" width="142" sortable="true" editable="false"><next:TextField/></next:Column>
			<next:Column header="性别" field="sex" width="142" sortable="true" editable="false" dataset="sexDataSet"><next:TextField/></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="guidePeopleDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
	<next:EditGridPanel id="gridDuty" width="486" stripeRows="true" height="202" dataset="guideDutyDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="担任职务"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:Column header="组织名称" field="sorgId" width="165" sortable="false" editable="false" dataset="dicSomOrganDataSet"><next:TextField/></next:Column>
			<next:Column header="职务" field="sorgDuties" width="120" sortable="false" editable="false" dataset="sorgDutiesDataSet"><next:TextField/></next:Column>
			<next:Column header="任职状态" field="regStatus" width="10%" editable="false"><next:TextField/><next:ComboBox dataset="regStatusDataSet"/></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="guideDutyDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script language="javascript">
function guidePeopleInit(){
	L5.getCmp("guidePeopleGrid").on("rowclick",function(grid,rowIndex,e){
		var record=grid.getSelectionModel().getSelected();
		if(record){
			var peopleId=record.get('peopleId');
			var guideDutyDataSet=L5.DatasetMgr.lookup("guideDutyDataSet");
			guideDutyDataSet.setParameter("PEOPLE_ID@=",peopleId);
			guideDutyDataSet.load();
			guideDutyDataSet.on('load',function(){
				guideDutyDataSet.filterBy(function(record, id){
					if("00012".indexOf(record.get('sorgDuties'))==-1){
						return record;
					}
				});
			});
		}
	});
	//过滤负责人职务：法定代表人
	sorgDutiesDS.filterBy(function(record, id){
		if("00012".indexOf(record.get('value'))==-1){
			return record;
		}
	});
}
// 关闭窗口
var peopleId=0;
var resumeCount=0;
function confirm(){
	if(!checkData()) return;
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var record=somDutyDataSet.getCurrent();
	if(record.get("startDate") == ""){
		L5.Msg.alert('提示','任职开始日期不能为空！');
		return false;
	}

	//处理个人简历
	var somResumeDataSet = L5.DatasetMgr.lookup("somResumeDataSet");
	var somResumeInsertDataSet = L5.DatasetMgr.lookup("somResumeInsertDataSet");
	for(var i=somResumeInsertDataSet.getCount()-1;i>=0;i--){
		var somResumeInsertRecord =somResumeInsertDataSet.getAt(i);
		somResumeInsertRecord.set("peopleId",record.get("peopleId"));
		if(somResumeDataSet.indexOf(somResumeInsertRecord)==-1){
			somResumeDataSet.insert(resumeCount,somResumeInsertRecord);
			resumeCount++;
		    somResumeDataSet.commitChanges();
		}
	}

	L5.getCmp("peopleWin").setVisible(false);
}

// 增加个人简历
function addResume(){
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	somResumeInsertDataSet.newRecord();
}
// 删除个人简历
function delResume(){
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var somResumeDataSet=L5.DatasetMgr.lookup("somResumeDataSet");
	var record=somResumeInsertDataSet.getCurrent();
	if(record!=null){
		somResumeInsertDataSet.remove(record);
		somResumeDataSet.remove(record);
	}
}

function renderDate(value) {
	if(value.length>8){
		L5.Msg.alert("提示","日期不要超过8位,请检查！");
		return value;
	}
	return value;
}

function checkIdCard(){
	if(_$("idCard")=="") return;
	//身份证号
	if(checkIDCard(document.getElementById("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}
	// 根据证件号码索引人员
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var record=somDutyDataSet.getCurrent();

	var guidePeopleDataSet=L5.DatasetMgr.lookup("guidePeopleDataSet");
	guidePeopleDataSet.setParameter("ID_CARD@=",_$("idCard"));
	guidePeopleDataSet.load();
	guidePeopleDataSet.on('load', function(){
		if(guidePeopleDataSet.getCount()>0){
			L5.getCmp("guidePeopleWin").show();
		}else{
			record.set("peopleId","");	//未查到人员时peopleId置空
		}
	});

	//如果为身份证号，获取出生日期和性别
	if(idCard.length==18){
		record.set("sex",getSexByCode(_$("idCard")));
		record.set("birthday",getBirthByCode(_$("idCard")));
		showAge();
	}
}
function showAge(){
	var birthday=_$("birthday");
	if(birthday.length!=10) return;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
// 数据校验
function checkData(){
	if(_$("idCard")==""){
		L5.Msg.alert('提示','身份证号不能为空！');
		return false;
	}
	if(_$("name")==""){
		L5.Msg.alert('提示','姓名不能为空！');
		return false;
	}
	if(_$("sex")==""){
		L5.Msg.alert('提示','性别不能为空！');
		return false;
	}
	if(_$("birthday")==""){
		L5.Msg.alert('提示','出生日期不能为空！');
		return false;
	}
	if(_$("sorgDuties")==""){
		L5.Msg.alert('提示','担任职务不能为空！');
		return false;
	}
	if(_$("ifPartyLeader")==""){
		L5.Msg.alert('提示','是否党政机关领导干部不能为空！');
		return false;
	}else if(_$("ifPartyLeader")=="1"){
		if(_$("promiseOrgan")==""||_$("promiseCode")==""){
			L5.Msg.alert('提示','批准机关和批准文号不能为空！');
			return false;
		}
	}
	return true;
}
function editItem(){
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var peopleRecord=somDutyDataSet.getCurrent();
	var grid=L5.getCmp("guidePeopleGrid");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	//回填人员基础信息
	peopleRecord.set("peopleId",record.get("peopleId"));
	peopleRecord.set("idCard",record.get("idCard"));
	peopleRecord.set("name",record.get("name"));
	peopleRecord.set("aliasName",record.get("aliasName"));
	peopleRecord.set("sex",record.get("sex"));
	peopleRecord.set("folk",record.get("folk"));
	peopleRecord.set("birthday",record.get("birthday"));
	peopleRecord.set("nation",record.get("nation"));
	peopleRecord.set("politics",record.get("politics"));
	peopleRecord.set("education",record.get("education"));
	peopleRecord.set("populace",record.get("populace"));
	peopleRecord.set("birthplace",record.get("birthplace"));
	peopleRecord.set("adds",record.get("adds"));
	peopleRecord.set("postCode",record.get("postCode"));
	peopleRecord.set("phone",record.get("phone"));
	peopleRecord.set("ifPartyLeader",record.get("ifPartyLeader"));
	peopleRecord.set("ifRetire",record.get("ifRetire"));
	peopleRecord.set("workName",record.get("workName"));
	peopleRecord.set("workPhone",record.get("workPhone"));
	peopleRecord.set("workDuties",record.get("workDuties"));
	peopleRecord.set("profession",record.get("profession"));
	peopleRecord.set("ifFulltime",record.get("ifFulltime"));
	peopleRecord.set("resume",record.get("resume"));

	L5.getCmp("guidePeopleWin").setVisible(false);
}
//获取连任信息
function getRenew(){
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var record=somDutyDataSet.getCurrent();

	var peopleId=_$('peopleId');
	var sorgDuties=_$('sorgDuties');
	if(peopleId==""||sorgDuties==""){
		record.set('ifRenew','0');
		record.set('renewNum','0');
		return;
	}
	var guideDutyDataSet=L5.DatasetMgr.lookup("guideDutyDataSet");
	guideDutyDataSet.setParameter("SORG_ID@=",sorgId);
	guideDutyDataSet.setParameter("PEOPLE_ID@=",peopleId);
	guideDutyDataSet.setParameter("SORG_DUTIES@=",sorgDuties);
	guideDutyDataSet.setParameter("IF_SERVE@=","1");
	guideDutyDataSet.load();
	guideDutyDataSet.on('load', function(){
		//alert(guideDutyDataSet.getCount());为什么会执行多遍？
		if(guideDutyDataSet.getCount()>0){
			var renewNum=guideDutyDataSet.get('renewNum');
			record.set('ifRenew','1');
			record.set('renewNum', parseInt(renewNum)+1);
		}else{
			record.set('ifRenew','0');
			record.set('renewNum','0');
		}
	});
}
//关闭人员索引窗口
function closeItem(){
	L5.getCmp("guidePeopleWin").setVisible(false);
}
function ifPartyLeaderChange(){
	if(_$("ifPartyLeader")=="1"){
		$("promiseOrgan").style.display="block";
		$("promiseCode").style.display="block";
	}else{
		$("promiseOrgan").value="";
		$("promiseCode").value="";
		$("promiseOrgan").style.display="none";
		$("promiseCode").style.display="none";
	}
}
function ifServeChange(){
	if(_$("ifServe")=="0"){
		$("peopleEndDate").style.display="block";
	}else{
		$("peopleEndDate").value="";
		$("peopleEndDate").style.display="none";
	}
}
function closePeopleWIn(){
	var win = L5.getCmp("peopleWin");
	win.hide();
}
</script>