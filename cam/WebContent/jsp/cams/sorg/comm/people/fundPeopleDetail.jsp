<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<model:datasets>
	<model:dataset id="somDutyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<model:dataset id="guidePeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<model:dataset id="guideDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
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
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="countrySelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SORT_NO">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
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
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<!-- 人员信息 -->
<next:Window id="peopleWin" title="负责人信息" resizable="false" width="800" height="430" modal="true" closeAction="hide" >
	<next:TabPanel id="tabSomPeople">
		<next:Tabs>
			<next:Panel id="peoplePanel"  title="基本信息" autoScroll="true" width="770" height="85%">
				<next:Html>
					<form id="peopleFrom" method="post" dataset="somDutyDataSet" onsubmit="return false" class="L5form">
						<input type="hidden" id="peopleId" field="peopleId">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><label id="idCard" field="idCard"/></td>
								<td class="FieldLabel" style="width:14%">姓名：</td>
								<td class="FieldInput" style="width:17%"><label id="name" field="name"/></td>
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
								<td class="FieldLabel" style="width:14%">曾用名：</td>
								<td class="FieldInput" style="width:19%"><label field="aliasName"/></td>
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput"><label id="age"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">性别：</td>
								<td class="FieldInput"><label field="sex" dataset="sexDataSet"/></td>
								<td class="FieldLabel">出生日期：</td>
								<td class="FieldInput"><label id="birthday" field="birthday"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput"><label field="politics" dataset="politicsDataSet"/></td>
								<td class="FieldLabel">民族：</td>
								<td class="FieldInput"><label field="folk" dataset="folkDataSet"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">国籍：</td>
								<td class="FieldInput"><label field="nation" dataset="countrySelect"/></td>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput"><label field="adds"/></td>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput"><label field="populace"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">邮编：</td>
								<td class="FieldInput"><label id="postCode" field="postCode"/></td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput"><label id="phone" field="phone"/></td>
								<td class="FieldLabel">专/兼职：</td>
								<td class="FieldInput"><label field="ifFulltime" dataset="ifFulltimeDataSet"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">工作单位：</td>
								<td class="FieldInput" colspan="3"><label field="workName"/></td>
								<td class="FieldLabel">工作单位职务：</td>
								<td class="FieldInput"><label field="workDuties"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">担任职务：</td>
								<td class="FieldInput"><label field="sorgDuties" dataset="sorgDutiesDataSet"/></td>
								<td class="FieldLabel">是否连任：</td>
								<td class="FieldInput"><label field="ifRenew" dataset="yesornoDataSet"/></td>
								<td class="FieldLabel">连任届数：</td>
								<td class="FieldInput"><label field="renewNum"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否在任(社会组织中任职状态)：</td>
								<td class="FieldInput"><label field="ifServe" dataset="yesornoDataSet"/></td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><label id="startDate" field="startDate"/></td>
								<td class="FieldLabel">任职结束日期：</td>
								<td class="FieldInput"><label id="endDate" field="endDate"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否党政机关领导干部：</td>
								<td class="FieldInput"><label field="ifPartyLeader" dataset="yesornoDataSet"/></td>
								<td class="FieldLabel">批准机关：</td>
								<td class="FieldInput"><label id="promiseOrgan" field="promiseOrgan"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><label id="promiseCode" field="promiseCode"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">其他社会职务：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3" field="otherDuties" readonly="readonly" style="width:97.7%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" field="workOpinion" readonly="readonly" style="width:97.7%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">审查工作单位：</td>
								<td class="FieldInput" colspan="3"><label field="workName"/></td>
								<td class="FieldLabel">审查日期：</td>
								<td class="FieldInput"><label field="workCheckDate"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">备注：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" field="note" readonly="readonly" style="width:97.7%"></textarea></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" stripeRows="true" title="本人简历" width="770" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="开始年月" field="startDate" width="15%" editable="false"><next:TextField/></next:Column>
					<next:Column header="结束年月" field="endDate" width="15%" editable="false"><next:TextField/></next:Column>
					<next:Column header="在何地区何单位" field="workOrgan" width="35%" editable="false"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="30%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somResumeInsertDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadPeopleGrid" title="法律要件" stripeRows="true" dataset="somPeopleElectronicDataSet" width="770" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
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
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<script language="javascript">
function guidePeopleInit(){
/*	L5.getCmp("guidePeopleGrid").on("rowclick",function(grid,rowIndex,e){
		var record=grid.getSelectionModel().getSelected();
		if(record){
			var peopleId=record.get('peopleId');
			var guideDutyDataSet=L5.DatasetMgr.lookup("guideDutyDataSet");
			guideDutyDataSet.setParameter("PEOPLE_ID@=",peopleId);
			guideDutyDataSet.load();
		}
	});*/
}
// 关闭窗口
function closePeopleWIn(){
	L5.getCmp("peopleWin").setVisible(false);
}
function showAge(){
	var birthday=document.getElementById("birthday").innerHTML;
	if(birthday.length!=10) return;
	var day=new Date();
	var year=day.getYear();
	var birthYear=birthday.substring(0,4);
	document.getElementById("age").innerHTML=parseInt(year)-parseInt(birthYear);
}
</script>