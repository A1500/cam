<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>退役士兵培训统计表</title>
<next:ScriptManager />
<script>
   	var organName = '<%=BspUtil.getOrganName()%>';
   	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var trainingflag = '<%=request.getParameter("trainingflag")%>';
	var training_type = '<%=request.getParameter("training_type")%>';
</script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="../../bpt/comm/bptComm.js"></script>
<script type="text/javascript" src="retiredsodiersquery.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
			var str;
function getPrintDataByDataSet(reportName,printDataset){
	
	var dqsj=new Date();
	var cxsjqz=cxsjq+'至'+cxsjz;
	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='' Creater='"+cxsjqz+"' CreateOrgan='"+organName+"' ReportNo='"+cxsjq+"' ReportType='"+cxsjz+"'>";
	var records=printDataset.getAllRecords();
	var n=records.length;
	if(records.length==0){return}
	for(i=0;i<n;i++){
		xmlStr +="<Info>";
		L5.each(records[i].fields.items,function(item,index){xmlStr+="<"+item.name+">"+records[i].get(item.name)+"</"+item.name+">";});
		xmlStr +="</Info>";
	}
	xmlStr +="</Report>";
	return xmlStr;
}
		</script>
</head>
<body>
<model:datasets>
	<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset" pageSize="20"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="querySoldiersTraining">
		<model:record>
			<model:field name="FILE_NUM" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="SPECIALTY" type="string" />
			<model:field name="SERVED_ARMY" type="string" />
			<model:field name="ENLIST_TIME" type="string" />
			<model:field name="ENLIST_PLACE" type="string" />
			<model:field name="ID" type="string" />
			<model:field name="SERVED_MILITARY_REGION" type="string" />
			<model:field name="SPOUSE_LOCATION" type="string" />
			<model:field name="PLACEMEN_RENSON" type="string" />
			<model:field name="TRAINING_TYPE" type="string" />
			<model:field name="TRAINING_INSTITUTIONS" type="string" />
			<model:field name="TRAINING_START_TIME" type="string" />
			<model:field name="TRAINING_END_TIME" type="string" />
			<model:field name="TRAINING_MAJOR" type="string" />
			<model:field name="TRAINING_SKILL_LEVEL" type="string" />
			<model:field name="TRAININGFLAG" type="string" />
			<model:field name="SOLDIERS_ID" type="string" />
		</model:record>
	</model:dataset>
	<!-- 打印 -->
	<model:dataset id="printDataset" pageSize="0"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand"
		method="querySoldiersTraining">
		<model:record>
			<model:field name="FILE_NUM" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="SPECIALTY" type="string" />
			<model:field name="SERVED_ARMY" type="string" />
			<model:field name="ENLIST_TIME" type="string" />
			<model:field name="ENLIST_PLACE" type="string" />
			<model:field name="ID" type="string" />
			<model:field name="SERVED_MILITARY_REGION" type="string" />
			<model:field name="SPOUSE_LOCATION" type="string" />
			<model:field name="PLACEMEN_RENSON" type="string" />
			<model:field name="TRAINING_TYPE" type="string" />
			<model:field name="TRAINING_INSTITUTIONS" type="string" />
			<model:field name="TRAINING_START_TIME" type="string" />
			<model:field name="TRAINING_END_TIME" type="string" />
			<model:field name="TRAINING_MAJOR" type="string" />
			<model:field name="TRAINING_SKILL_LEVEL" type="string" />
			<model:field name="TRAININGFLAG" type="string" />
		</model:record>
	</model:dataset>
	<!-- organName -->
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='FULL_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 安置理由 -->
	<model:dataset id="PlaceReasonDataset" enumName="PLACEMENREASON.CODE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 军区大单位 -->
	<model:dataset id="MilitaryRegionCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MILITARY_REGION_CODE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 培训类型 -->
	<model:dataset id="TrainingTypeDataset" enumName="TRAINING.TYPE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:GridPanel width="100%"
	bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
	height="100%" autoScroll="true" dataset="retiredSoldierDataset"
	title="退役士兵培训统计表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出Excl" iconCls="export" id="csv" handler="exportCSV"/>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="print" id="printBill" handler="printBill2" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="35" header="序号" />
		
		<next:Column id="FILE_NUM" header="编号" field="FILE_NUM" width="90">
			<next:TextField />
		</next:Column>
		
		<next:Column id="NAME" header="姓名" field="NAME" width="90" renderer="nameRender">
			<next:TextField />
		</next:Column>

		<next:Column id="SPECIALTY" header="专业特长" field="SPECIALTY" width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="SERVED_ARMY" header="部队单位" field="SERVED_ARMY"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="ENLIST_TIME" header="入伍时间" field="ENLIST_TIME"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="ENLIST_PLACE" header="入伍户口所在地" field="ENLIST_PLACE"
			width="140">
			<next:TextField />
		</next:Column>
		
		<next:Column id="SERVED_MILITARY_REGION" header="军区大单位"
			field="SERVED_MILITARY_REGION" width="100" dataset="MilitaryRegionCodeDataset">
			<next:TextField />
		</next:Column>
		
		<next:Column id="SPOUSE_LOCATION" header="配偶户口所在地"
			field="SPOUSE_LOCATION" width="100">
			<next:TextField />
		</next:Column>
		
		<next:Column id="PLACEMEN_RENSON" header="安置理由"
			field="PLACEMEN_RENSON" width="100" dataset="PlaceReasonDataset">
			<next:TextField />
		</next:Column>
		
		<next:Column id="TRAINING_TYPE" header="培训类型"
			field="TRAINING_TYPE" width="100" dataset="TrainingTypeDataset">
			<next:TextField />
		</next:Column>
		
		<next:Column id="TRAINING_INSTITUTIONS" header="培训机构"
			field="TRAINING_INSTITUTIONS" width="100" >
			<next:TextField />
		</next:Column>
		
		<next:Column id="TRAINING_START_TIME" header="培训开始时间"
			field="TRAINING_START_TIME" width="100" >
			<next:TextField />
		</next:Column>
		
		<next:Column id="TRAINING_END_TIME" header="培训结束时间"
			field="TRAINING_END_TIME" width="100" >
			<next:TextField />
		</next:Column>
		
		<next:Column id="TRAINING_MAJOR" header="培训专业"
			field="TRAINING_MAJOR" width="100">
			<next:TextField />
		</next:Column>
		
		<next:Column id="TRAINING_SKILL_LEVEL" header="培训技能等级"
			field="TRAINING_SKILL_LEVEL" width="100">
			<next:TextField />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="retiredSoldierDataset" />
	</next:BottomBar>
</next:GridPanel>