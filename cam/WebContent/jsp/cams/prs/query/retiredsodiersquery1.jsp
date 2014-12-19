<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>

<html>
<head>
<title>退役士兵安置地明细表</title>
<next:ScriptManager />
<style>
	a {color:#03c;cursor:hand;}
	a:hover{ color:#03c;}
</style>
<script>
	var type='<%=request.getParameter("type")%>';
	var struId = '<%=BspUtil.getStruId()%>';
   	var orgCode = '<%=BspUtil.getOrganCode()%>';
   	var organName = '<%=BspUtil.getOrganName()%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="../../bpt/comm/bptComm.js"></script>
<script type="text/javascript" src="retiredsodiersquery1.js"></script>
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
			var xmlStr;
			function getPrintDataByDataSet(reportName,printDataset){
					var cx_servedMilitaryRegion=document.getElementById("cx_servedMilitaryRegion").value;
					var cxsj_year=document.getElementById("cxsj_year").value;
					var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
					xmlStr+="<Report ReportName='' Creater='" +cxsj_year+"' CreateOrgan='"+organName+"' ReportNo='"+cxsj_year+"' ReportType='"+cxsj_year+"' cYear='"+cxsj_year+"'>";
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
			<model:field name="PLACEMEN_RENSON"  type="string" />
			<model:field name="SERVED_MILITARY_REGION"  type="string" />
			<model:field name="RESETTLEMENT_SITUATION"type="string" />
			<model:field name="EMPLOYMENT_TIME" type="string" />
			<model:field name="EMPLOYMENT_COMPANY"type="string" />
			<model:field name="GRANT_GRANT"type="string" />
			<model:field name="APPLICATION_DATE"  type="string" />
			<model:field name="GRANT_DATE" type="string" />
		</model:record>
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
			<model:field name="PLACEMEN_RENSON"  type="string" />
			<model:field name="SERVED_MILITARY_REGION"  type="string" />
			<model:field name="RESETTLEMENT_SITUATION"type="string" />
			<model:field name="EMPLOYMENT_TIME" type="string" />
			<model:field name="EMPLOYMENT_COMPANY"type="string" />
			<model:field name="GRANT_GRANT"type="string" />
			<model:field name="APPLICATION_DATE"  type="string" />
			<model:field name="GRANT_DATE" type="string" />
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

<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="25%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form style="width: 95%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel">军区大单位：</td>
					<td class="FieldInput"><select id="cx_servedMilitaryRegion">
					<option dataset="MilitaryRegionCodeDataset"></option></select>
					<td class="FieldLabel" nowrap="nowrap" >退役年度：</td>
				<td class="FieldInput" ><input type="text" id="cxsj_year" 
					class="TextEditor" title="退役年度" /></td>
					<td class="FieldInput">
					<button onclick="query()" id="queryButton">查 询</button>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="reset()">重 置</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
<next:GridPanel id="editGridPanel" name="prsretiredsoldiersGrid" clickToSelectedForChkSM="true"
	width="99%" stripeRows="true" height="99%" style="padding: 5px;"
	dataset="retiredSoldierDataset" 
	notSelectFirstRow="true" title="退役士兵安置地明细表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出Excl" iconCls="export" id="csv" handler="exportCSV"/>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="print" id="printBill" handler="printBill" />
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
	