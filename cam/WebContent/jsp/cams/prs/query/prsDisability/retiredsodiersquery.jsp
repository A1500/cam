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


body {
	background-color: #EAF4FD;
}

table {
	border-collapse: collapse;
}

input {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}
tr{   
	yexj00:expression(this.style.background=(rowIndex%2==1)? 'white ': '#EAF4FD ')
} 
td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	font-weight: bold;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
<script>
 	var retiredSoldierDataset ;
   	var organCode = '<%=BspUtil.getOrganCode()%>';
   	var organName = '<%=BspUtil.getOrganName()%>';
   	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var disable = '<%=request.getParameter("disable")%>';
	var grade = '<%=request.getParameter("grade")%>';
	var propertie = '<%=request.getParameter("propertie")%>';
	var total = '<%=request.getParameter("total")%>';
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
	
	var dqsj=document.getElementById("Rtime").innerText;
	
	var xmlStr="<?xml version='1.0' encoding='GBK' standalone='no'?>";
	xmlStr+="<Report ReportName='' Creater='"+dqsj+"' CreateOrgan='"+organName+"' ReportNo='"+cxsjq+"' ReportType='"+cxsjz+"'>";
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
	<model:dataset id="retiredSoldierDataset"    
		cmd="com.inspur.cams.prs.prsretiredsoldiers.cmd.PrsRetiredSoldiersQueryCommand" method="queryDisabilitySoldiers" >
		<model:record>
			<model:field name="REGION" type="string" />
			<model:field name="NAME" type="string" />
			<model:field name="SPEC" type="string" />
			<model:field name="ENTIME" type="string" />
			<model:field name="ENPLACE" type="string" />
			<model:field name="CONTENT" type="string" />
			<model:field name="ID" type="string" />
			<model:field name="SERVEDARMY" type="string" />
			<model:field name="SLOCATION" type="string" />
			<model:field name="PRENSON" type="string" />
			<model:field name="TFILE" type="string" />
			<model:field name="FLAG" type="string" />
			<model:field name="FILENUM" type="string" />
		</model:record>
	</model:dataset>
	<!-- 是否退档 -->
	<model:dataset id="ApprovalDataset" enumName="APPROVALSTATE.CODE"
		autoLoad="true" global="true"></model:dataset>
			<!-- 安置理由 -->
	<model:dataset id="PlaceReasonDataset" enumName="PLACEMENREASON.CODE" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 档案来源 -->
	<model:dataset id="FileResourcesDataset" enumName="FILESRESOURCE.CODE" autoLoad="true" global="true"></model:dataset>
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
<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;" >

				<div align="center" style="width: 80%;">
					<div align="center"><span id="reportTitle"
						style="font-size: large;">退役士兵军区明细表</span></div>
					<br/>
						<div align="right" class="L5form">
			<button onclick="printBill()">打印</button>
			</div>
			<br/>
				</div>
				<table width="80%" dataset="retiredSoldierDataset" align="center" 	>
				
				<tr>
					<td class="tdTitle" align="center" width="10%" >编号</td>
					<td class="tdTitle" align="center" width="10%" >姓名</td>
					<td class="tdTitle" align="center" width="10%" >专业特长</td>
					<td class="tdTitle" align="center" width="10%" >部队单位</td>
					<td class="tdTitle" align="center" width="10%" >入伍时间</td>
					<td class="tdTitle" align="center" width="10%" >入伍户口所在地</td>
					<td class="tdTitle" align="center" width="10%" >军区大单位</td>
					<td class="tdTitle" align="center" width="10%" >配偶户口所在地</td>
					<td class="tdTitle" align="center" width="10%" >安置理由</td>
					<td class="tdTitle" align="center" width="10%" >移交材料</td>
					<td class="tdTitle" align="center" width="10%" >是否退档</td>
					<td class="tdTitle" align="center" width="10%" >备注</td>
					

				</tr>
				<tr repeat="true">
					
					<td width="4%" align="left"><label type="text" field="FILENUM" id="FILENUM" style="width: 20%;height: 20px;line-height:20px;"
						size="20" readonly="true" /></td> 
						<td width="4%" align="left" class="td">
						<label  align="left" field="NAME" id="NAME"  style="cursor: hand;text-align: left;color: blue;text-decoration: underline" 
						 readonly="true" onClick="soldiersDetail(this)"></label><label style="display: none"  field="ID"></label>
						</td>
					<td width="4%" align="left"><label type="text" field="SPEC" id="specialty"
						size="20" readonly="true" /></td>
						<td width="4%" align="left"><label type="text" field="SERVEDARMY" id="SERVEDARMY"
						size="20" readonly="true" /></td>   
					<td width="4%" align="right"><label type="text" field="ENTIME" id="enlistTime"
						size="20" readonly="true" /></td>
					<td width="4%" align="left"><label type="text" field="ENPLACE" id="ENPLACE"
						size="20" readonly="true" /></td>
					
					<td width="4%" align="left"><label type="text" field="REGION" id="servedMilitaryRegion"  dataset="MilitaryRegionCodeDataset"
						size="20" readonly="true" /></td>
					<td width="4%" align="left"><label type="text" field="SLOCATION" id="sLocation"
						size="20" readonly="true" /></td>
					<td width="4%" align="left"><label type="text" field="PRENSON" id="pRenson" dataset = "PlaceReasonDataset"
						size="20" readonly="true" /></td>
					<td width="4%" align="left"><label type="text" field="TFILE" id="tFile"
						size="20" readonly="true" /></td>
					<td width="4%" align="left"><label type="text" field="FLAG" id="flag" dataset="ApprovalDataset"
						size="20" readonly="true" /></td>
					<td width="4%" align="left"><label type="text" field="CONTENT" id="content"
						size="20" readonly="true" /></td>
			</table>
				<div align="center">
					<table width="80%"  align="center">
						<tr>
						
						
						<td class="tdTitle" align="center" width="10%" >合计人数:    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=request.getParameter("total")%>
						</td>
						<td class="tdTitle" align="center" width="10%" >制表时间:<label  id="Rtime"
						size="20"  /></td>
						
				</tr>
					</table></div>
			</div>
		</next:Html>
	</next:Panel>


</body>
</html>
	