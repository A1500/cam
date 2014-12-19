<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>退役士兵安置地明细表</title>
<next:ScriptManager />

<script>
   	var organName = '<%=BspUtil.getOrganName()%>';
   	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var emplacementflag = '<%=request.getParameter("emplacementflag")%>';
	var employment_type = '<%=request.getParameter("employment_type")%>';
	var resettlement_situation = '<%=request.getParameter("resettlement_situation")%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
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
	<!-- 退役士兵安置地明细表 -->
	<model:dataset id="retiredSoldierDataset"    
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand" method="querySoldiersPlacement" pageSize="15" >
		<model:record>
			<model:field name="FILE_NUM"  type="string" />
			<model:field name="NAME"  type="string" />
			<model:field name="SOLDIERS_ID" type="string" />
			<model:field name="SPECIALTY" type="string" />
			<model:field name="SERVED_ARMY"  type="string" />
			<model:field name="ENLIST_TIME" type="string" />
			<model:field name="ENLIST_PLACE" type="string" />
			<model:field name="SPOUSE_LOCATION"  type="string" />
			<model:field name="SERVICED_TIME"  type="string" />
			<model:field name="RETIRED_TIME"  type="string" />
			<model:field name="PLACEMEN_RENSON"  type="string" />
			<model:field name="SERVED_MILITARY_REGION"  type="string" />
			<model:field name="RESETTLEMENT_SITUATION"type="string" />
			<model:field name="EMPLOYMENT_TIME" type="string" />
			<model:field name="EMPLOYMENT_COMPANY"type="string" />
			<model:field name="GRANT_GRANT"type="string" />
			<model:field name="APPLICATION_DATE"  type="string" />
			<model:field name="GRANT_DATE" type="string" />
			<model:field name="EMPLOYMENT_TYPE" type="string" />
		</model:record>
	</model:dataset>
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
	<!-- 打印 -->
	<model:dataset id="printDataset"    
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand" method="querySoldiersPlacement" pageSize="15" >
		<model:record>
			<model:field name="FILE_NUM"  type="string" />
			<model:field name="NAME"  type="string" />
			<model:field name="SOLDIERS_ID" type="string" />
			<model:field name="SPECIALTY" type="string" />
			<model:field name="SERVED_ARMY"  type="string" />
			<model:field name="ENLIST_TIME" type="string" />
			<model:field name="ENLIST_PLACE" type="string" />
			<model:field name="SPOUSE_LOCATION"  type="string" />
			<model:field name="SERVICED_TIME"  type="string" />
			<model:field name="RETIRED_TIME"  type="string" />
			<model:field name="PLACEMEN_RENSON"  type="string" />
			<model:field name="SERVED_MILITARY_REGION"  type="string" />
			<model:field name="RESETTLEMENT_SITUATION"type="string" />
			<model:field name="EMPLOYMENT_TIME" type="string" />
			<model:field name="EMPLOYMENT_COMPANY"type="string" />
			<model:field name="GRANT_GRANT"type="string" />
			<model:field name="APPLICATION_DATE"  type="string" />
			<model:field name="GRANT_DATE" type="string" />
			<model:field name="EMPLOYMENT_TYPE" type="string" />
			<model:field name="SOLDIERS_ID" type="string" />
		</model:record>
	</model:dataset>
	<!-- 安置理由 -->
	<model:dataset id="PlaceReasonDataset" enumName="PLACEMENREASON.CODE" autoLoad="true"
		global="true">
	</model:dataset>
	
	<!-- 安置方式 -->
	<model:dataset id="RessettlementSituationDataset" enumName="PLACEMENT.TYPE" autoLoad="true"
		global="true">
	</model:dataset>
	
	<!-- 军区代码 -->
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
</model:datasets>
	
<next:GridPanel id="editGridPanel" name="prsretiredsoldiersGrid" clickToSelectedForChkSM="true"
	width="99%" stripeRows="true" height="99%" style="padding: 5px;"
	dataset="retiredSoldierDataset" 
	notSelectFirstRow="true" title="退役士兵安置地明细表">
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
		<next:Column id="RETIRED_TIME" header="退役时间" field="RETIRED_TIME"
			width="90">
			<next:TextField />
		</next:Column>
		<next:Column id="SERVICED_TIME" header="服役年限" field="SERVICED_TIME" renderer="servicedTimeRenderer"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="ENLIST_PLACE" header="入伍户口所在地" field="ENLIST_PLACE"
			width="160">
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
		
		<next:Column id="SERVED_MILITARY_REGION" header="军区大单位"
			field="SERVED_MILITARY_REGION" width="100" dataset="MilitaryRegionCodeDataset">
			<next:TextField />
		</next:Column>
		
		<next:Column id="RESETTLEMENT_SITUATION" header="安置方式"
			field="RESETTLEMENT_SITUATION" width="100" dataset="RessettlementSituationDataset">
			<next:TextField />
		</next:Column>
		
		<next:Column id="EMPLOYMENT_TIME" header="就业时间"
			field="EMPLOYMENT_TIME" width="100" >
			<next:TextField />
		</next:Column>
		
		<next:Column id="EMPLOYMENT_COMPANY" header="就业单位"
			field="EMPLOYMENT_COMPANY" width="100" >
			<next:TextField />
		</next:Column>
		
		<next:Column id="GRANT_GRANT" header="经济补助金（自谋职业金）"
			field="GRANT_GRANT" width="180" >
			<next:TextField />
		</next:Column>
		
		<next:Column id="APPLICATION_DATE" header="申请时间"
			field="APPLICATION_DATE" width="100">
			<next:TextField />
		</next:Column>
		
		<next:Column id="GRANT_DATE" header="发放时间"
			field="GRANT_DATE" width="100">
			<next:TextField />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="retiredSoldierDataset" />
	</next:BottomBar>
</next:GridPanel>


</body>
</html>
	