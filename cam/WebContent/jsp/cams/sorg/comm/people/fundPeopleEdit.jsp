<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<model:datasets>
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="postCode" type="string" rule="length{6}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
			<model:field name="promiseOrgan" type="string" rule="length{100}" />
			<model:field name="promiseCode" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="note" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<model:dataset id="sorgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
<next:Window id="peopleWin" title="负责人信息" resizable="false" width="800" height="430" modal="true" closeAction="hide" closable="false">
	<next:FitLayout>
	<next:TabPanel id="tabSomOrgan">
		<next:Tabs>
			<next:Panel id="peoplePanel" title="基本信息" autoScroll="true" width="770" height="85%">
				<next:Html>
					<form id="peopleFrom" method="post" dataset="somDutyDataSet" onsubmit="return false" class="L5form">
						<input type="hidden" id="peopleId" field="peopleId">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><input type="text" id="idCard" field="idCard" name='"身份证号码"' onblur="checkIdCard()" maxlength="18" style="width:90%"/></td>
								<td class="FieldLabel" style="width:14%">姓名：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="name" field="name" name='"姓名"' style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel" style="width:14%" rowspan="4">照片:</td>
								<td class="FieldInput" style="width:19%" nowrap colspan="1" rowspan="4">
								<div id="photoDiv1">
									<img id="img1" name="RELATIONER_PHOTOC_IMG1" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg"
									align="top" ondblclick="editPhoto(11,'photoId1','RELATIONER_PHOTOC_IMG1');"
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
									<input type="hidden" id="photoId1" name="photoId1"/>
								</div>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">曾用名：</td>
								<td class="FieldInput"><input type="text" field="aliasName" name='"曾用名"' style="width:90%"/></td>
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput"><label id="age" name='年龄'/></td>
							</tr>
							<tr>
								<td class="FieldLabel">性别：</td>
								<td class="FieldInput">
									<select id="sex" field="sex" name='"性别"' style="width:90%">
										<option dataset="sexDataSet"></option>
									</select>
								</td>
								<td class="FieldLabel">出生年月：</td>
								<td class="FieldInput"><input type="text" id="birthday" field="birthday" name='"出生年月"' onblur="showAge()" format="Y-m" onclick="WdatePicker()" style="width:90%"/></td>
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
							</tr>
							<tr>
								<td class="FieldLabel">国籍：</td>
								<td class="FieldInput">
									<input type="text" id="nationDispaly" name="countryNameDispaly"  title="国籍"  onkeyup="findDiv(this,'nation','countryDiv','','countryQueryDic','text@like','value','text','35')" onblur="clearCountryDiv()" onchange="clearCountry(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showCountryWin()"/>
									<div id="countryDiv" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
        								<ul></ul>
   									</div>
   									<input type="hidden" id="nation" name="nation" field="nation" title="国籍"/>
								</td>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput"><input type="text" field="adds" name='"家庭住址"' style="width:90%"/></td>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput"><input type="text" field="populace" name='"户口所在地"' style="width:90%"/></td>

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
										<input type="text" id="sorgDutiesNameDispaly" style="width:60%" name="sorgDutiesNameDispaly"  title="社团职务"  onkeyup="findDiv(this,'sorgDuties','dutyPopup','','dutyQueryDic','text@like','value','text','70')" onblur="cleardutyDiv()" onchange="clearduty(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showdutyWin()"/>
										<div id="dutyPopup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
 	        								<ul></ul>
     									</div>
     							<input type="hidden" id="sorgDuties" name="sorgDuties" field="sorgDuties" title="社团职务代码"/>
     							<span style="color:red">*</span></td>
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
								<td class="FieldInput"><input type="text" id="startDate" field="startDate" name='"任职开始日期"' format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>
								<td class="FieldLabel">任职结束日期：</td>
								<td class="FieldInput"><input type="text" id="peopleEndDate" field="endDate" name='"任职结束日期"' format="Y-m-d" onclick="WdatePicker()" style="width:90%;display:none"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否党政机关领导干部：</td>
								<td class="FieldInput">
									<select id="ifPartyLeader" field="ifPartyLeader" name='"是否党政机关领导干部"' onchange="ifPartyLeaderChange()" style="width:90%">
										<option dataset="yesornoDataSet"></option>
									</select>
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
			<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" stripeRows="true" title="本人简历" width="770" height="85%" autoScroll="true">
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
			<next:EditGridPanel id="uploadPeopleGrid" title="法律要件" stripeRows="true" dataset="somPeopleElectronicDataSet" width="770" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadPeopleFile"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect">
						<next:TextField />
					</next:Column>
					<next:Column header="附件名称" field="fileName" width="30%" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="附件描述" field="fileMess" width="20%" editable="false">
						<next:TextField />
					</next:Column>
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadPeopleHref">
						<next:TextField />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somPeopleElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirm"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../country/countrySelectWindow.jsp" flush="true"/>
<jsp:include page="../../comm/selectWindow/duty/dutySelectWindow.jsp" flush="true"/>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script language="javascript">
function guidePeopleInit(){
	L5.getCmp("gridPeople").on("rowclick",function(grid,rowIndex,e){
		var record=grid.getSelectionModel().getSelected();
		if(record){
			var peopleId=record.get('peopleId');
			var winDutyDataSet=L5.DatasetMgr.lookup("winDutyDataSet");
			winDutyDataSet.setParameter("PEOPLE_ID@=",peopleId);
			winDutyDataSet.load();
			winDutyDataSet.on('load',function(){
				winDutyDataSet.filterBy(function(record, id){
					if("00012".indexOf(record.get('sorgDuties'))==-1){
						return record;
					}
				});
			});
		}
	});
	//过滤负责人职务：法定代表人
	sorgDutiesSelect.filterBy(function(record, id){
		if("00012".indexOf(record.get('value'))==-1){
			return record;
		}
	});
}
// 关闭窗口
var peopleId=0;
var resumeCount=0;
function confirm(){
	var command = new L5.Command("com.inspur.cams.sorg.base.cmd.SomPeopleCmd");
	command.setParameter("ID_CARD",_$("idCard"));
	command.execute("queryRestrictNum");
	var restrictNum = command.getReturn("restrictNum");
	var ifLimit=command.getReturn("ifLimit");
	if(restrictNum > 0){
		if(ifLimit=='1'){
			L5.Msg.alert("提示","此人为受限人员，不能担任负责人！",function(){
				return;
			});
		}else if(ifLimit=='0'){
			var command = new L5.Command("com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailCmd");
			command.setParameter("ID_CARD",_$("idCard"));
			command.execute("queryPeopleNum");
			var peopleNum = command.getReturn("peopleNum");
			if(peopleNum > 0){
				L5.MessageBox.confirm('确定', '此人有'+peopleNum+'条受限记录，确定其担任负责人？',function(sta){
					if(sta=="yes"){
						confirmInfo();
						return;
					}else{
						return;
					}
				});
			}
		}else{
			confirmInfo();
		}
	}else{
		confirmInfo();
	}
}
function confirmInfo(){
	var record=somDutyDataSet.getCurrent();
	record.set('sorgDuties',document.getElementById('sorgDuties').value);
	var IsValidate = somDutyDataSet.isValidate();
	if(IsValidate != true){
		L5.Msg.alert("提示",IsValidate);
		return false;
	}
		var name=record.get('name').trim();
    record.set("name",name);
	//维护照片信息
	if(_$("photoId1")){
		var newPhotoId = savePhoto(_$("photoId1"),"J");//保存照片到数据库并返回photoId
		if(newPhotoId!=null){
			somDutyDataSet.set("photoId",newPhotoId);
		}
	}
	record.set('nation',document.getElementById('nation').value);
	if(record.get('ifServe')=='0'){
		record.set("regStatus","2");
	}
	if(record.get('ifServe') == '1'){
		record.set("regStatus","1");
	}
	if(peopleType == "L"){
		aspForLiShi.insert(aspForLiShi.getCount(),somDutyDataSet.getCurrent().copy());
		toCurrentDataset();
	}else if(peopleType == "S"){
		aspForJianShi.insert(aspForJianShi.getCount(),somDutyDataSet.getCurrent().copy());
	}else if(peopleType == "LU"){
		aspForLiShi.remove(currentPeople);
		aspForLiShi.insert(aspForLiShi.getCount(),somDutyDataSet.getCurrent().copy());
		toCurrentDataset();
	}else if(peopleType == "SU"){
		aspForJianShi.remove(currentPeople);
		aspForJianShi.insert(aspForJianShi.getCount(),somDutyDataSet.getCurrent().copy());
	}
	aspForLiShi.commitChanges();
	aspForJianShi.commitChanges();

	L5.getCmp("peopleWin").setVisible(false);
}

// 增加个人简历
function addResume(){
	somResumeInsertDataSet.newRecord({"dutyId":currentId});
}

// 删除个人简历
function delResume(){
	var grid = L5.getCmp('somResumeGrid');
	var sm = grid.getSelectionModel();
	var records=sm.getSelections();
	if(records&&records.length==1){
		L5.MessageBox.confirm('确定', '你确定要删除吗？',function(sta){
			if(sta=="yes"){
				somResumeInsertDataSet.remove(records[0]);
			}
			else return;
		});
	}else{
		L5.Msg.alert("提示","请选择一条记录！");
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

	var winPeopleDataSet=L5.DatasetMgr.lookup("winPeopleDataSet");
	winPeopleDataSet.setParameter("ID_CARD",_$("idCard"));
	winPeopleDataSet.load();
	winPeopleDataSet.on('load', function(){
		if(winPeopleDataSet.getCount()>0){
			L5.getCmp("win_peopleValidate").show();
		}else{
			record.set("peopleId","");	//未查到人员时peopleId置空
		}
	});

	//如果为身份证号，获取出生年月和性别
	if(_$("idCard").length==18){
		record.set("sex",getSexByCode(_$("idCard")));
		record.set("birthday",getBirthdayByCode(_$("idCard")));
		showAge();
	}
}
function showAge(){
	var birthday=_$("birthday");
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
	if(_$("sex")==""){
		L5.Msg.alert('提示','性别不能为空！');
		return false;
	}
	if(_$("birthday")==""){
		L5.Msg.alert('提示','出生年月不能为空！');
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
//任职信息中新增人员
function addItem(){
	var idCard=document.getElementById("idCard").value;
	var somDutyInsertDataSet = L5.DatasetMgr.lookup("somDutyInsertDataSet");
	var record = somDutyInsertDataSet.getCurrent();
	record.set("idCard",idCard);
	//回填性别
	record.set("sex",getSexByCode(idCard));
	//回填出生年月
	record.set("birthday",getBirthByCode(idCard));
	//回填年龄
	$("age").innerHTML = getAgeByCode(idCard);
	var win = L5.getCmp("win_peopleValidate");
	win.hide();
}
function editItem(){
	var grid=L5.getCmp("gridPeople");
	var record=grid.getSelectionModel().getSelected();
	if(!record){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	var ifLimit=record.get("ifLimit");
	var restrictPeopleId=record.get("restrictPeopleId");
	if(ifLimit=='1'){
		L5.Msg.alert("提示","此人为受限人员，不能担任负责人！",function(){
			return;
		});
	}else if(ifLimit=='0'){
		var command = new L5.Command("com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailCmd");
		command.setParameter("PEOPLE_ID",restrictPeopleId);
		command.execute("getNum");
		var num = command.getReturn("num");
		if(num>0){
			L5.MessageBox.confirm('确定', '此人有'+num+'条受限记录，确定其担任负责人？',function(sta){
				if(sta=="yes"){
					editItemInfo();
					return;
				}else{
					return;
				}
			});
		}
	}else{
		editItemInfo();
	}
}
function editItemInfo(){
	var somDutyDataSet=L5.DatasetMgr.lookup("somDutyDataSet");
	var peopleRecord=somDutyDataSet.getCurrent();
	var grid=L5.getCmp("gridPeople");
	var record=grid.getSelectionModel().getSelected();
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
	peopleRecord.set("photoId",record.get("photoId"));
	synPhoto(peopleRecord.get("photoId"),"1");//同步照片

	//回填简历信息
	var somResumeInsertDataSet=L5.DatasetMgr.lookup("somResumeInsertDataSet");
	var winDutyDataSet=L5.DatasetMgr.lookup("winDutyDataSet");
	var gridDuty=L5.getCmp("gridDuty");
	var dutyRecord=gridDuty.getSelectionModel().getSelected();
	//分两种情况，因为简历时需要根据duty取，所以判断有没有选择职务信息，有的话就用选择的，没有选择的话就用判断有没有职务，有职务就用第一个
	if(!dutyRecord){
		//没有选择
		if(winDutyDataSet.getCount()>0){
			var dutyId = winDutyDataSet.getAt(0).get("dutyId");
			somResumeInsertDataSet.setParameter("DUTY_ID",dutyId);
			somResumeInsertDataSet.load();
		}
	}else{
		//选择了
		somResumeInsertDataSet.setParameter("DUTY_ID",dutyRecord.get("dutyId"));
		somResumeInsertDataSet.load();
	}
	L5.getCmp("win_peopleValidate").setVisible(false);

	L5.getCmp("win_peopleValidate").setVisible(false);
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
	var winDutyDataSet=L5.DatasetMgr.lookup("winDutyDataSet");
	winDutyDataSet.setParameter("SORG_ID@=",sorgId);
	winDutyDataSet.setParameter("PEOPLE_ID@=",peopleId);
	winDutyDataSet.setParameter("SORG_DUTIES@=",sorgDuties);
	winDutyDataSet.setParameter("IF_SERVE@=","1");
	winDutyDataSet.load();
	winDutyDataSet.on('load', function(){
		//alert(winDutyDataSet.getCount());为什么会执行多遍？
		if(winDutyDataSet.getCount()>0){
			var renewNum=winDutyDataSet.get('renewNum');
			var ifRenew=winDutyDataSet.get('ifRenew');
			if(method=="insert"){
				record.set('ifRenew','1');
				record.set('renewNum', parseInt(renewNum)+1);
			}else{
				record.set('ifRenew',ifRenew);
				record.set('renewNum', renewNum);
			}
		}else{
			record.set('ifRenew','0');
			record.set('renewNum','0');
		}
	});
}
//关闭人员索引窗口
function closeItem(){
	L5.getCmp("win_peopleValidate").setVisible(false);
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