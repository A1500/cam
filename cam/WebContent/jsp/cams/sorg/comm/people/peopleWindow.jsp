<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<model:datasets>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd" method="queryRestrict">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<model:dataset id="somRestrictPeopleDetailDataSet" cmd="com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailQueryCmd" sortField="addTime">
		<model:record fromBean="com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail"></model:record>
	</model:dataset>
	<model:dataset id="sorgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_CODE'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
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
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_REG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sourceTypeSelect" enumName="SOM.RESTRICT.SOURCE_TYPE" autoLoad="true" global="true"></model:dataset>		
</model:datasets>
<!-- 调取人员档案 -->
<next:Window id="win_peopleValidate" title="人员身份验证" resizable="false" width="500" height="403" modal="true" closable="false">
	<next:EditGridPanel id="gridPeople" width="486" stripeRows="true" height="170" dataset="winPeopleDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="人员列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="edit" text="回填信息" handler="editItem"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text="关闭窗口" handler="closeItem"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="姓名" field="name" width="100" sortable="true" editable="false"renderer="getName"><next:TextField/></next:Column>
			<next:Column header="出生年月" field="birthday" width="100" sortable="true" editable="false"renderer="getBirthday"><next:TextField/></next:Column>
			<next:Column header="性别" field="sex" width="100" sortable="true" editable="false" dataset="sexDataSet" ><next:TextField/></next:Column>
			<next:Column header="是否受限人员" field="ifLimit" width="120" sortable="true" editable="false"  renderer="getIfLimit"><next:TextField /></next:Column>
			<next:Column header="受限人员id" field="restrictPeopleId" width="142" sortable="true" editable="false"  hidden="true"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winPeopleDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
	<next:EditGridPanel id="gridDuty" width="486" stripeRows="true" height="202" dataset="winDutyDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="担任职务"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="组织名称" field="sorgId" width="165" sortable="false" editable="false" dataset="sorgNameSelect"><next:TextField/></next:Column>
			<next:Column header="职务" field="sorgDuties" width="120" sortable="false" editable="false" dataset="sorgDutiesSelect"><next:TextField/></next:Column>
			<next:Column header="任职状态" field="regStatus" width="80" sortable="false" editable="false" dataset="ifServeSelect"><next:TextField/></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winDutyDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<next:Window id="restrictWin" title="受限人员详情" resizable="false" width="800" height="400" modal="true" closable="false">
	<next:EditGridPanel id="restrictGrid" width="787" stripeRows="true" height="370" dataset="somRestrictPeopleDetailDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="delete" text="关闭" handler="closeRestrictWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="添加原因" field="sourceType" width="150" sortable="false" editable="false" dataset="sourceTypeSelect"><next:TextField/></next:Column>
			<next:Column header="是否法定代表人" field="ifLegal" width="120" sortable="false" editable="false" dataset="comm_yesorno"><next:TextField/></next:Column>			
			<next:Column header="社会组织名称" field="sorgCode" width="200" sortable="false" editable="false" dataset="sorgCodeSelect"><next:TextField/></next:Column>	
			<next:Column header="登记证号" field="sorgCode" width="150" sortable="false" editable="false"><next:TextField/></next:Column>		
			<next:Column header="添加单位" field="addOrganName" width="150" sortable="false" editable="false"><next:TextField/></next:Column>	
			<next:Column header="添加人" field="addPersonName" width="150" sortable="false" editable="false"><next:TextField/></next:Column>
			<next:Column header="添加时间" field="addTime" width="150" sortable="false" editable="false"><next:TextField/></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somRestrictPeopleDetailDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<script language="javascript">
function getName(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var name=record.get('name');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + name + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + name + '</a>';
	}else{
		return name;
	}
}
function getBirthday(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var birthday=record.get('birthday');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + birthday + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + birthday + '</a>';
	}else{
		return birthday;
	}
}
function getSex(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var sex=record.get('sex');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + sex + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + sex + '</a>';
	}else{
		return sex;
	}
}
function getIfLimit(value,cellmeta,record,rowindex,colindex,dataset){
	var ifLimit=record.get('ifLimit');
	var restrictPeopleId=record.get('restrictPeopleId');
	if(ifLimit == '1' ){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:red">' + '是' + '</a>';
	}else if(ifLimit == '0'){
		return '<a href="javascript:showRestrict(\''+restrictPeopleId+'\')" style="color:blue">' + '否' + '</a>';
	}else{
		return "";
	}
}
function showRestrict(restrictPeopleId){
	var somRestrictPeopleDetailDataSet=L5.DatasetMgr.lookup("somRestrictPeopleDetailDataSet");
	somRestrictPeopleDetailDataSet.setParameter("PEOPLE_ID",restrictPeopleId);
	somRestrictPeopleDetailDataSet.load();
	var win = L5.getCmp("restrictWin");
	win.show();
}
function closeRestrictWin(){
	var win = L5.getCmp("restrictWin");
	win.hide();
}
</script>