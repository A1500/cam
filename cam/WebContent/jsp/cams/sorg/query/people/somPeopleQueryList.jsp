<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<!-- 社会组织人员综合查询列表 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
function init(){
	var somPeopleDataSet=L5.DatasetMgr.lookup("somPeopleDataSet1");
	var name='<%=request.getParameter("name")%>';
	name=decodeURIComponent(name);
	
	var idCard='<%=request.getParameter("idCard")%>';
	var sex='<%=request.getParameter("sex")%>';
	var birthdayQ='<%=request.getParameter("birthdayQ")%>';
	var birthdayZ='<%=request.getParameter("birthdayZ")%>';	
	var folk='<%=request.getParameter("folk")%>';
	var nation='<%=request.getParameter("nation")%>';
	var politics='<%=request.getParameter("politics")%>';
	var education='<%=request.getParameter("education")%>';
	
	var populace='<%=request.getParameter("populace")%>';	
	populace=decodeURIComponent(populace);
	
	var ifRetire='<%=request.getParameter("ifRetire")%>';
	var ifFulltime='<%=request.getParameter("ifFulltime")%>';
	
	var workName='<%=request.getParameter("workName")%>';
	workName=decodeURIComponent(workName);
	
	var workPhone='<%=request.getParameter("workPhone")%>';
	
	var workDuties='<%=request.getParameter("workDuties")%>';	
	workDuties=decodeURIComponent(workDuties);
	
	var adds='<%=request.getParameter("adds")%>';
	adds=decodeURIComponent(adds);
	
	var postCode='<%=request.getParameter("postCode")%>';
	var phone='<%=request.getParameter("phone")%>';

	var cnName='<%=request.getParameter("cnName")%>';
	cnName=decodeURIComponent(cnName);
	
	var sorgType='<%=request.getParameter("sorgType")%>';
	var sorgKind='<%=request.getParameter("sorgKind")%>';
	var ifServe='<%=request.getParameter("ifServe")%>';
	var sorgDuties='<%=request.getParameter("sorgDuties")%>';
	
	var morgName='<%=request.getParameter("morgName")%>';
	morgName=decodeURIComponent(morgName);
	
	var ifPartyLeader='<%=request.getParameter("ifPartyLeader")%>';
	var partyLeaderLevel='<%=request.getParameter("partyLeaderLevel")%>';
	var promiseOrgan='<%=request.getParameter("promiseOrgan")%>';
	promiseOrgan=decodeURIComponent(promiseOrgan);
	
	if(name!=''){
		somPeopleDataSet.setParameter("name",name);
	}
	if(idCard!=''){
		somPeopleDataSet.setParameter("idCard",idCard);
	}
	if(sex!=''){
		somPeopleDataSet.setParameter("sex",sex);
	}
	if(birthdayQ!='' && birthdayQ.indexOf('~')==-1){
		somPeopleDataSet.setParameter("birthdayQ",birthdayQ);
	}
	if(birthdayZ!='' && birthdayZ.indexOf('~')!=-1){
		somPeopleDataSet.setParameter("birthdayZ",birthdayZ);
	}	
	if(folk!=''){
		somPeopleDataSet.setParameter("folk",folk);
	}
	if(nation!=''){
		somPeopleDataSet.setParameter("nation",nation);
	}
	if(politics!=''){
		somPeopleDataSet.setParameter("politics",politics);
	}
	if(education!=''){
		somPeopleDataSet.setParameter("education",education);
	}
	if(populace!=''){
		somPeopleDataSet.setParameter("populace",populace);
	}
	if(ifRetire!=''){
		somPeopleDataSet.setParameter("ifRetire",ifRetire);
	}
	if(ifFulltime!=''){
		somPeopleDataSet.setParameter("ifFulltime",ifFulltime);
	}
	if(workName!=''){
		somPeopleDataSet.setParameter("workName",workName);
	}
	if(workPhone!=''){
		somPeopleDataSet.setParameter("workPhone",workPhone);
	}
	if(workDuties!=''){
		somPeopleDataSet.setParameter("workDuties",workDuties);
	}
	if(adds!=''){
		somPeopleDataSet.setParameter("adds",adds);
	}
	if(postCode!=''){
		somPeopleDataSet.setParameter("postCode",postCode);
	}
	if(phone!=''){
		somPeopleDataSet.setParameter("phone",phone);
	}
	if(cnName!=''){
		somPeopleDataSet.setParameter("cnName",cnName);
	}
	if(sorgType!=''){
		somPeopleDataSet.setParameter("sorgType",sorgType);
	}
	if(sorgKind!=''){
		somPeopleDataSet.setParameter("sorgKind",sorgKind);
	}
	if(ifServe!=''){
		somPeopleDataSet.setParameter("ifServe",ifServe);
	}
	if(sorgDuties!=''){
		somPeopleDataSet.setParameter("sorgDuties",sorgDuties);
	}
	if(morgName!=''){
		somPeopleDataSet.setParameter("morgName",morgName);
	}	
	if(ifPartyLeader!=''){
		somPeopleDataSet.setParameter("ifPartyLeader",ifPartyLeader);
	}	
	if(partyLeaderLevel!=''){
		somPeopleDataSet.setParameter("partyLeaderLevel",partyLeaderLevel);
	}	
	if(promiseOrgan!=''){
		somPeopleDataSet.setParameter("promiseOrgan",promiseOrgan);
	}	
	somPeopleDataSet.load();	
}
//返回查询页面
function back(){
	var text="";
	var url='jsp/cams/sorg/query/people/somPeopleQuery.jsp';
	L5.forward(url,text);
}
//点击导出Excel
function ToExcel(){
	var dataset=L5.DatasetMgr.lookup("somPeopleDataSet1");
	L5.dataset2excel(dataset,"/jsp/cams/sorg/query/people/somPeolpeQueryToExcel.jsp");
} 
//姓名的超级链接
function forDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	var ds=L5.DatasetMgr.lookup("somPeopleDataSet1");
	return '<a href="javascript:forDetail(\'' + ds.indexOf(record) + '\')">' + value + '</a>';
}

//社会组织名称的超级链接
function forSorgDetailHref(value,cellmeta,record,rowindex,colindex,dataset){
	var ds=L5.DatasetMgr.lookup("somPeopleWView");
	var sorgId=record.get('SORG_ID');
	return '<a href="javascript:forSorgDetail(\'' + sorgId + '\')">' + value + '</a>';
}
//超级链接所调用的方法
function forDetail(index){
   	var ds=L5.DatasetMgr.lookup("somPeopleDataSet1");
   	var record= ds.getAt(index);
   	var id=record.get("PEOPLE_ID");
	var somPeopleView=L5.DatasetMgr.lookup("somPeopleView");
	somPeopleView.setParameter("PEOPLE_ID",id);
	somPeopleView.load();
	var somPeopleWView=L5.DatasetMgr.lookup("somPeopleWView");
	somPeopleWView.setParameter("PEOPLE_ID",id);
	somPeopleWView.load();	
	var somPeopleAView=L5.DatasetMgr.lookup("somPeopleAView");
	somPeopleAView.setParameter("PEOPLE_ID",id);
	somPeopleAView.load();	
	var win=L5.getCmp("detilWin");
	win.show();
}
function forSorgDetail(obj){
	var sorgId=obj;
	var url=L5.webPath+'/jsp/cams/sorg/query/som/baseQuery/somBaseQueryDetail.jsp?sorgId='+sorgId+'&showWin=1';
	var width = screen.width-560;
	var height = 330;
	var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
}
//关闭窗口
function closeWin(){
	var win=L5.getCmp("detilWin");
	win.hide();
}
</script>
</head>
<body>
<model:datasets>
	<!-- 主列表 -->
	<model:dataset id="somPeopleDataSet1" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" pageSize="15" method="queryTogether">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 窗口中基本信息 -->
	<model:dataset id="somPeopleView"cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<!--窗口中职务信息 -->
	<model:dataset id="somPeopleWView" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" method="queryDutyInfo" pageSize="10">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
		<model:params>
			<model:param name="IF_SERVE" value='1'></model:param>
		</model:params>
	</model:dataset>
	<!--窗口中历史职务信息 -->
	<model:dataset id="somPeopleAView" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" method="queryDutyInfo" pageSize="10">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
		<model:params>
			<model:param name="IF_SERVE" value='0'></model:param>
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
	<!-- 身份证件种类 -->
	<model:dataset id="cardType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX" autoLoad="true"	global="true"></model:dataset>
	<!-- 国籍 -->
	<model:dataset id="nation" enumName="SORG.NATION" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politics" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 学历 -->
	<model:dataset id="education" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否离退休 -->
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否专兼职 -->
	<model:dataset id="ifFulltime" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织类型 -->
	<model:dataset id="sorgKind" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 人员类型 -->

	<!-- 社会组织职务 -->
	<model:dataset id="sorgDuties" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

</model:datasets>

<next:EditGridPanel id="hlistPanel" dataset="somPeopleDataSet1" height="100%" width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="社会组织人员信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出Excel" iconCls="detail" handler="ToExcel"></next:ToolBarItem>
		<next:ToolBarItem text="返回查询条件" iconCls="undo" handler="back"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn />
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="姓名" field="NAME" sortable="true" editable="false"
			width="10%" renderer="forDetailHref">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column header="身份证号" field="ID_CARD" width="15%" editable="false">
			<next:TextField />
		</next:Column>
		<next:Column header="性别" field="SEX" sortable="true" dataset="sex"
			editable="false" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column header="出生日期" field="BIRTHDAY" sortable="true"
			editable="false" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column header="政治面貌" field="POLITICS" sortable="true"
			editable="false" width="15%" dataset="politics">
			<next:TextField />
		</next:Column>
		<next:Column header="电话" field="PHONE" sortable="true"
			editable="false" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column header="是否离退休" field="IF_RETIRE" sortable="true" dataset="comm_yesorno"
			editable="false" width="10%">
			<next:TextField />
		</next:Column>
		<next:Column header="家庭住址" field="ADDS" sortable="true" 
			editable="false" width="19.7%">
			<next:TextField />
		</next:Column>
		<next:Column field="PEOPLE_ID" header=""></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somPeopleDataSet1" />
	</next:BottomBar>
</next:EditGridPanel>

<next:Window id="detilWin" closeAction="hide" title="社会组织人员明细" width="740" height="400" resizable="false" >
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="detail" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="人员基本信息" height="100%" autoScroll="true">
				<next:Html>
					<form method="post" onsubmit="return false" class="L5form" dataset="somPeopleView">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:13%"><label>姓名：</label></td>
							<td class="FieldInput" style="width:20%"><label id="name" field="name" /></td>
							<td class="FieldLabel" style="width:13%"><label>身份证件种类：</label></td>
							<td class="FieldInput" style="width:20%"><label id="cardType" field="cardType" dataset="cardType"/></td>
							<td class="FieldLabel" style="width:13%"><label>身份证件号码：</label></td>
							<td class="FieldInput" style="width:20%"><label id="idCard" field="idCard" /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>性别：</label></td>
							<td class="FieldInput"><label id="sex" field="sex" dataset="sex"/></td>
							<td class="FieldLabel"><label>出生日期：</label></td>
							<td class="FieldInput"><label id="birthday" field="birthday" /></td>
							<td class="FieldLabel"><label>民族：</label></td>
							<td class="FieldInput"><label id="folk" field="folk" dataset="folkDataSet"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>国籍：</label></td>
							<td class="FieldInput"><label id="nation" field="nation" dataset="nation"/></td>
							<td class="FieldLabel"><label>政治面貌：</label></td>
							<td class="FieldInput"><label id="politics" field="politics" dataset="politics"/></td>
							<td class="FieldLabel"><label>学历：</label></td>
							<td class="FieldInput"><label id="education" field="education" dataset="education"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>户口所在地：</label></td>
							<td class="FieldInput"><label id="populace" field="populace" /></td>
							<td class="FieldLabel"><label>是否离退休：</label></td>
							<td class="FieldInput"><label id="comm_yesorno" field="ifRetire" dataset="comm_yesorno"/></td>
							<td class="FieldLabel"><label>是否专兼职：</label></td>
							<td class="FieldInput"><label id="ifFulltime" field="ifFulltime" dataset="ifFulltime"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>工作单位：</label></td>
							<td class="FieldInput"><label id="workName" field="workName" /></td>
							<td class="FieldLabel"><label>工作单位电话：</label></td>
							<td class="FieldInput"><label id="workPhone" field="workPhone" /></td>
							<td class="FieldLabel"><label>工作单位职务：</label></td>
							<td class="FieldInput"><label id="workDuties" field="workDuties" /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>家庭住址：</label></td>
							<td class="FieldInput"><label id="adds" field="adds" /></td>
							<td class="FieldLabel"><label>家庭住址邮编：</label></td>
							<td class="FieldInput"><label id="postCode" field="postCode" /></td>
							<td class="FieldLabel"><label>电话：</label></td>
							<td class="FieldInput"><label id="phone" field="phone" /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>个人简历信息：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="5" field="resume" readonly="readonly" style="width:100%"></textarea></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="现任社会组织职务" height="100%" autoScroll="true">
				<next:EditGridPanel id="hlistPanel1" dataset="somPeopleWView" height="313">
					<next:Columns>
						<next:RowNumberColumn />
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column header="社会组织名称" field="CN_NAME" sortable="true"
							editable="false" width="20%" renderer="forSorgDetailHref" >
							<next:TextField></next:TextField>
						</next:Column>
						<next:Column header="社会组织类型" field="SORG_TYPE" dataset="sorgType" width="15%"
							editable="false">
							<next:TextField />
						</next:Column>
						
						<next:Column header="担任社会组织职务" field="SORG_DUTIES" sortable="true" dataset="sorgDuties"
							editable="false" width="20%">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somPeopleWView" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="历史社会组织职务" height="100%" autoScroll="true">
				<next:EditGridPanel id="hlistPanel2" dataset="somPeopleAView" height="313">
					<next:Columns>
						<next:RowNumberColumn />
						<next:CheckBoxColumn></next:CheckBoxColumn>
						<next:Column header="社会组织名称" field="CN_NAME" sortable="true"
							editable="false" width="20%" >
							<next:TextField></next:TextField>
						</next:Column>
						<next:Column header="社会组织类型" field="SORG_TYPE" dataset="sorgType" width="15%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="担任社会组织职务" field="SORG_DUTIES" sortable="true" dataset="sorgDuties"
							editable="false" width="20%">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somPeopleAView" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Window>
</body>
</html>
