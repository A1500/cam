<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>

<html>
<!-- 社会组织综合查询列表 -->
<head>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
function borgNameFill(value,cellmeta,record,rowindex,colindex,dataset){
		var borgName = record.get('borgName');
		var nowBorgName = getBorgName(borgName);
		return nowBorgName;
}
function init(){
	var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
	var borgName='<%=request.getParameter("borgName")%>';
	var ifHis='<%=request.getParameter("ifHis")%>';

	if(ifHis=="1"){
		//历史
		somOrganDataset.setParameter("BORG_NAME",borgName);
		doInit(somOrganDataset);
	}else if(ifHis=="0"){
		var command=new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
		command.setParameter("borgCode", borgName);

		command.afterExecute=function(){
			var changeCount=command.getReturn('changeCount');
			if(changeCount<1){
				//没有变更
				somOrganDataset.setParameter("BORG_NAME",borgName);
				doInit(somOrganDataset);
			}else{
				var somBorgChangeHis=L5.DatasetMgr.lookup('somBorgChangeHis');
				somBorgChangeHis.setParameter("borgCode", borgName);
				somBorgChangeHis.on("load",loadSomBorgChangeHis);
				somBorgChangeHis.load();
			}
		};
		command.execute("queryCount");

	}else{
		doInit(somOrganDataset);
	}
}
function loadSomBorgChangeHis(somBorgChangeHis){
	somBorgChangeHis.un("load",loadSomBorgChangeHis);
	var count=somBorgChangeHis.getCount();
	var borgCodes=somBorgChangeHis.getAt(count-1).get("changeAfterId");
	for(var i=0;i<count;i++){
		var record=somBorgChangeHis.getAt(i);
		if(borgCodes){
			borgCodes+=",";
		}
		borgCodes+=record.get("changeBeforeId");
	}
	var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
	somOrganDataset.setParameter("BORG_NAME@IN",borgCodes);
	doInit(somOrganDataset);
}
function doInit(somOrganDataset){
	var sorgIDs='<%=request.getParameter("sorgIDs")%>';
	var borgName='<%=request.getParameter("borgName")%>';
	var sorgName='<%=request.getParameter("sorgName")%>';
	sorgName=decodeURIComponent(sorgName);

	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var sorgType='<%=request.getParameter("sorgType")%>';
	var ifBranch='<%=request.getParameter("ifBranch")%>';

	var sorgKind='<%=request.getParameter("sorgKind")%>';
	var sorgStatus='<%=request.getParameter("sorgStatus")%>';
	var regDate='<%=request.getParameter("regDate")%>';

	var enName='<%=request.getParameter("enName")%>';
	enName=decodeURIComponent(enName);

	var abName='<%=request.getParameter("abName")%>';
	abName=decodeURIComponent(abName);

	var sorgEmail='<%=request.getParameter("sorgEmail")%>';
	var organCode='<%=request.getParameter("organCode")%>';
	var sorgPhone='<%=request.getParameter("sorgPhone")%>';
	var sorgFax='<%=request.getParameter("sorgFax")%>';

	var sorgPost='<%=request.getParameter("sorgPost")%>';
	var sorgAdds='<%=request.getParameter("sorgAdds")%>';
	var sorgWeb='<%=request.getParameter("sorgWeb")%>';

	var morgName='<%=request.getParameter("morgName")%>';
	morgName=decodeURIComponent(morgName);

	var morgArea='<%=request.getParameter("morgArea")%>';

	var actArea='<%=request.getParameter("actArea")%>';
	actArea=decodeURIComponent(actArea);

	var business='<%=request.getParameter("business")%>';
	business=decodeURIComponent(business);

	var busScope='<%=request.getParameter("busScope")%>';

	var regMon='<%=request.getParameter("regMon")%>';

	var legalPeople='<%=request.getParameter("legalPeople")%>';
	legalPeople=decodeURIComponent(legalPeople);

	var memberNum='<%=request.getParameter("memberNum")%>';
	var unitsNum='<%=request.getParameter("unitsNum")%>';
	var peopleNum='<%=request.getParameter("peopleNum")%>';

	var standCouncilNum='<%=request.getParameter("standCouncilNum")%>';
	var councilNum='<%=request.getParameter("councilNum")%>';
	var engagedNum='<%=request.getParameter("engagedNum")%>';
	var cancelDate='<%=request.getParameter("cancelDate")%>';

	var residence='<%=request.getParameter("residence")%>';
	residence=decodeURIComponent(residence);

	if(sorgIDs!=''&&sorgIDs!='null'){
	//alert('sorgIDs');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_id@in",sorgIDs);
	}
	//1
	if(sorgName!=''){
	//alert('sorgName');
		somOrganDataset.setParameter("SOM_ORGAN.cn_name@like",sorgName);
	}
	if(sorgCode!=''){
	//alert('sorgCode');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Code@=",sorgCode);
	}
	if(sorgType!=''){//alert('sorgType');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Type@=",sorgType);
	}
	if(ifBranch!=''){//alert('ifBranch');
		somOrganDataset.setParameter("SOM_ORGAN.if_Branch@=",ifBranch);
	}
	if(sorgKind!=''){//alert('sorgKind');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Kind@=",sorgKind);
	}
	//2
	if(sorgStatus!=''){//alert('sorgStatus');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Status@=",sorgStatus);
	}
	if(regDate!='' && regDate.indexOf('~')==-1){//alert('buildDate');
		somOrganDataset.setParameter("SOM_ORGAN.reg_Date@like",regDate);
	}
	if(regDate!='' && regDate.indexOf('~')!=-1){//alert('buildDate');
		somOrganDataset.setParameter("SOM_ORGAN.reg_Date@between",regDate);
	}
	if(enName!=''){//alert('enName');
		somOrganDataset.setParameter("SOM_ORGAN.en_Name@like",enName);
	}
	//3
	if(abName!=''){
	//alert('abName');
		somOrganDataset.setParameter("SOM_ORGAN.ab_Name@like",abName);
	}
	if(sorgEmail!=''){
	//alert('sorgEmail');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Email@like",sorgEmail);
	}
	if(organCode!=''){
	//alert('organCode');
		somOrganDataset.setParameter("SOM_ORGAN.organ_Code@=",organCode);
	}
	if(borgName!=''){
	//alert('organCode');
		somOrganDataset.setParameter("SOM_ORGAN.borg_Name@=",borgName);
	}
	if(sorgPhone!=''){
	//alert('sorgPhone');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Phone@=",sorgPhone);
	}
	if(sorgFax!=''){
	//alert('sorgFax');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Fax@=",sorgFax);
	}
	//4
	if(sorgPost!=''){//alert('sorgPost');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Post@like",sorgPost);
	}
	if(sorgAdds!=''){//alert('sorgAdds');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Adds@like",sorgAdds);
	}
	if(sorgWeb!=''){//alert('sorgWeb');
		somOrganDataset.setParameter("SOM_ORGAN.sorg_Web@like",sorgWeb);
	}
	if(morgName!=''){//alert('sorgFax');
		somOrganDataset.setParameter("SOM_ORGAN.morg_Name@like",morgName);
	}
	//5
	if(morgArea!=''){//alert(morgArea);
		somOrganDataset.setParameter("MORG_AREA@IN",morgArea);
	}
	if(actArea!=''){//alert('actArea');
		somOrganDataset.setParameter("SOM_ORGAN.act_Area@like",actArea);
	}
	if(business!=''){//alert('business');
		somOrganDataset.setParameter("SOM_ORGAN.business@like",business);
	}
	if(busScope!=''){//alert('busScope');
		somOrganDataset.setParameter("SOM_ORGAN.bus_Scope@=",busScope);
	}
	//6
	if(regMon!=''){//alert('regMon');
		somOrganDataset.setParameter("to_number(SOM_ORGAN.reg_Mon)@>",regMon);
	}
	if(legalPeople!=''){//alert('legalPeople');
		somOrganDataset.setParameter("SOM_ORGAN.legal_People@like",legalPeople);
	}
	if(memberNum!=''){//alert('memberNum');
		somOrganDataset.setParameter("SOM_ORGAN.member_Num@>",memberNum);
	}
	if(unitsNum!=''){//alert('unitsNum');
		somOrganDataset.setParameter("SOM_ORGAN.units_Num@>",unitsNum);
	}
	if(peopleNum!=''){//alert('peopleNum');
		somOrganDataset.setParameter("SOM_ORGAN.people_Num@>",peopleNum);
	}
	//7
	if(standCouncilNum!=''){//alert('standCouncilNum');
		somOrganDataset.setParameter("SOM_ORGAN.stand_Council_Num@>",standCouncilNum);
	}
	if(councilNum!=''){//alert('councilNum');
		somOrganDataset.setParameter("SOM_ORGAN.council_Num@>",councilNum);
	}
	if(engagedNum!=''){//alert('engagedNum');
		somOrganDataset.setParameter("SOM_ORGAN.engaged_Num@>",engagedNum);
	}
	if(cancelDate!=''){//alert('cancelDate');
		if(cancelDate.charAt(10)=="~"){
			somOrganDataset.setParameter("SOM_ORGAN.cancel_Date@between",cancelDate);
		}else{
			somOrganDataset.setParameter("SOM_ORGAN.cancel_Date@=",cancelDate);
		}
	}
	if(residence!=''){//alert('residence');
		somOrganDataset.setParameter("SOM_ORGAN.residence@like",residence);
	}
	somOrganDataset.on("load",loadSomOrganDataset);
	somOrganDataset.load();
}

function loadSomOrganDataset(somOrganDataset){
	somOrganDataset.un("load",loadSomOrganDataset);
	somOrganDataset.each(function(rec,idx){
		var borgName = rec.get('borgName');
		var nowBorgName = getBorgName(borgName);
		rec.set('nowBorgName', nowBorgName);
	});
	somOrganDataset.commitChanges();
}
//返回查询页面
function returnQueryMain(){
	var text="";
	var url='jsp/cams/sorg/query/som/somQueryMain.jsp';
	L5.forward(url,text);
}

function forDetail(value,cellmeta,record,rowindex,colindex,dataset){
	var sorgId=record.get('sorgId');
   	var sorgType=record.get('sorgType');
	var url='';
	if(sorgType=='S'){
		url='jsp/cams/sorg/query/som/somGroupQuery.jsp?sorgId='+sorgId;
	}else if(sorgType=='J'){
		url='jsp/cams/sorg/query/som/somFundQuery.jsp?sorgId='+sorgId;
	}else if(sorgType=='M'){
		url='jsp/cams/sorg/query/som/somUngovQuery.jsp?sorgId='+sorgId;
	}
	return '<a href="javascript:L5.forward(\'' + url + '\')">' + value + '</a>';
}
//点击导出Excel
function ToExcel(){
	var dataset=L5.DatasetMgr.lookup("somOrganDataset");
	L5.dataset2excel(dataset,"/jsp/cams/sorg/query/som/somQueryToExcel.jsp");
}
/** *查询信息* **/
function getBorgName(borgCode){
	var publicCmd = new L5.Command("com.inspur.cams.sorg.base.cmd.SomBorgChangeCmd");
	publicCmd.setParameter("borgCode", borgCode);
	publicCmd.execute("nowBorgName");
	var getReturns = publicCmd.getReturn("borgName");
	if (getReturns == null || getReturns == "" || getReturns == undefined){
		return "";
	}else {
		return getReturns;
	}
}
</script>

</head>
<body>
	<model:datasets>
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"
	 method="queryOrganWithAreaCodeSearchCondition" pageSize="15">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="nowBorgName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 变更历史 -->
	<model:dataset id="somBorgChangeHis"  cmd="com.inspur.cams.sorg.base.cmd.SomBorgChangeQueryCmd" method="showChange">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomBorgChange"></model:record>
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
	<!-- 社会组织状态 -->
	<model:dataset id="sorgStatus" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行（事）业 -->
	<model:dataset id="busScope" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

	<next:EditGridPanel id="hlistPanel" dataset="somOrganDataset" height="100%"  width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem"/>
		<next:ToolBarItem symbol="社会组织信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出Excel" iconCls="detail" handler="ToExcel"></next:ToolBarItem>
		<next:ToolBarItem text="重新查询" iconCls="undo" handler="returnQueryMain"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="社会组织种类" field="sorgType" sortable="true"
			dataset="sorgType" width="15%" editable="false">
			<next:TextField />
		</next:Column>
		<next:Column header="社会组织名称"  field="cnName" sortable="true"
			editable="false"width="15%" renderer="forDetail">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column header="登记证号" field="sorgCode" sortable="true"
			editable="false" width="10%">
			<next:TextField/>
		</next:Column>
		<next:Column header="社会组织状态" field="sorgStatus" sortable="true"
			editable="false" width="12%" dataset="sorgStatus">
			<next:TextField/>
		</next:Column>
		<next:Column header="所属行(事)业" field="busScope" sortable="true"
			 editable="false" width="12%" dataset="busScope">
			<next:TextField />
		</next:Column>
		<next:Column header="业务主管单位" field="nowBorgName" sortable="true"
			editable="false"  width="13%"  renderer="borgNameFill">
			<next:TextField />
		</next:Column>
		<next:Column id="a" header="住所" field="residence" sortable="true"
			editable="false" width="22.7%">
			<next:TextField />
		</next:Column>
		<next:Column header="活动范围" field="actArea" sortable="true"
			editable="false" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column header="法定代表人姓名" field="legalPeople" sortable="true"
			editable="false" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column header="登记管理机关名称" field="morgName" sortable="true"
			editable="false" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column header="社会组织电话" field="sorgPhone" sortable="true"
			editable="false" hidden="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="somOrganDataset" />
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>