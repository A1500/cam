<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>退役士兵列表</title>
<next:ScriptManager />
<style>
	a {color:#03c;cursor:hand;}
	a:hover{ color:#03c;}
</style>
<script>
	var type='<%=request.getParameter("type")%>';
   	var organCode = '<%=BspUtil.getOrganCode()%>';
   	var orgName = '<%=BspUtil.getOrganName()%>';
   	var organName= decodeURIComponent('<%=request.getParameter("organName")%>');
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
			var xmlStr;
			function getPrintDataByDataSet(reportName,printDataset){
					var dqsj=new Date();
					var cxsjq ="";
					var cxsjz= "";
					var cYear=	document.getElementById("cxsj_q").value;
					var cxsj_z=	document.getElementById("cxsj_z").value;
					if(cxsj_z!=""){
						cYear+="-"+cxsj_z
					}
					var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
					xmlStr+="<Report ReportName='' Creater='" +dqsj+"' CreateOrgan='"+orgName+"' ReportNo='"+cxsjq+"' ReportType='"+cxsjz+"' cYear='"+cYear+"'>";
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
<model:datasets>
	<!-- 是否退档 -->
	<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE"
		autoLoad="true" global="true"></model:dataset>
		<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
		<!-- 退役士兵基本信息 -->
	<model:dataset id="retiredSoldierDataset"    
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand" method="querySoldier" pageSize="15" >
		<model:record>
			<model:field name="SERVEDARMY"  type="string" />
			<model:field name="NAME"  type="string" />
			<model:field name="SPEC" type="string" />
			<model:field name="ENTIME"  type="string" />
			<model:field name="ENPLACE" type="string" />
			<model:field name="WHEREPLACEMENT" type="string" />
			<model:field name="CONTENT"  type="string" />
			<model:field name="SLOCATION"  type="string" />
			<model:field name="ID"  type="string" />
			<model:field name="PRENSON"type="string" />
			<model:field name="REGION" type="string" />
			<model:field name="TFILE"type="string" />
			<model:field name="FLAG"type="string" />
			<model:field name="FILENUM"  type="string" />
			<model:field name="domicileName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 退役士兵基本信息 -->
	<model:dataset id="printDataset"
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand" method="querySoldier" pageSize="0">
		<model:record >
			<model:field name="SERVEDARMY"  type="string" />
			<model:field name="NAME"  type="string" />
			<model:field name="SPEC" type="string" />
			<model:field name="ENTIME"  type="string" />
			<model:field name="ENPLACE" type="string" />
			<model:field name="WHEREPLACEMENT" type="string" />
			<model:field name="CONTENT"  type="string" />
			<model:field name="SLOCATION"  type="string" />
			<model:field name="ID"  type="string" />
			<model:field name="PRENSON"type="string" />
			<model:field name="REGION" type="string" />
			<model:field name="TFILE"type="string" />
			<model:field name="FLAG"type="string" />
			<model:field name="FILENUM"  type="string" />
			<model:field name="domicileName" type="string" />
		</model:record>
	</model:dataset>
	<!-- 安置理由 -->
	<model:dataset id="PlaceReasonDataset" enumName="PLACEMENREASON.CODE" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 是否退档 -->
	<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="peopleNumberdataset" cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand" method="queryPeopleNum" global="true">
	</model:dataset>
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE" autoLoad="true" global="true"></model:dataset>
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
<body>
<next:Panel name="form" width="100%" border="0"
	bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true%">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 95%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel" nowrap="nowrap">安置地：</td>
				<td class="FieldInput" align="left"><input type="text" id="domicileName"  class="TextEditor"  style="text-align: left" title="属地行政区划" onclick="forHelp()" />
				<input type="hidden" id="domicileCode" class="TextEditor" title="属地行政区划" /></td>
				<td class="FieldLabel" nowrap="nowrap">退役年度：</td>
				<td class="FieldInput"><input type="text" id="cxsj_q" maxlength="4"
					class="TextEditor" title="退役年度" /><input type="text" id="cxsj_z" style="display: none;" class="TextEditor" title="退役年度" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">是否退档：</td>
				<td class="FieldInput" colspan="1"><select id="sendback"
					name="是否退档">
					<option dataset="ApprovalDataset"></option>
				</select></td>
				<td class="FieldLabel"></td>
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
	width="98%" stripeRows="true" height="99%"  style="padding: 5px;"
	dataset="retiredSoldierDataset" 
	notSelectFirstRow="true" title="退役士兵信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出Excl" iconCls="export" id="csv" handler="exportCSV"/>
		<next:ToolBarItem symbol="-"></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="print" id="printBill" handler="printBill" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="35" header="序号" />
		
		<next:Column id="FILENUM" header="编号" field="FILENUM" width="90">
			<next:TextField />
		</next:Column>
		
		<next:Column id="name" header="姓名" field="NAME" width="90" renderer="nameRender">
			<next:TextField />
		</next:Column>

		<next:Column id="SPEC" header="专业特长" field="SPEC" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="SERVEDARMY" header="部队单位" field="SERVEDARMY"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="ENTIME" header="入伍时间" field="ENTIME"
			width="90">
			<next:TextField />
		</next:Column>

		<next:Column id="ENPLACE" header="入伍户口所在地" field="ENPLACE"
			width="160">
			<next:TextField />
		</next:Column>

		<next:Column id="REGION" header="军区大单位"
			field="REGION" dataset="MilitaryRegionCodeDataset" width="100">
			<next:TextField />
		</next:Column>
		
		<next:Column id="SLOCATION" header="配偶户口所在地"
			field="SLOCATION" width="100">
			<next:TextField />
		</next:Column>
		
		<next:Column id="PRENSON" header="安置理由"
			field="PRENSON" width="100" dataset="PlaceReasonDataset">
			<next:TextField />
		</next:Column>
		<next:Column id="TFILE" header="移交材料"
			field="TFILE" width="100">
			<next:TextField />
		</next:Column>
		
		<next:Column id="flag" header="是否退档" field="FLAG"
			dataset="ApprovalDataset" width="80">
			<next:TextField />
		</next:Column>
		
		<next:Column id="CONTENT" header="备注"
			field="CONTENT" width="100">
			<next:TextField />
		</next:Column>
			
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="retiredSoldierDataset" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
