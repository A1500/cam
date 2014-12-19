<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>在乡复员军人审批表</title>
	</head>
	<next:ScriptManager/>
	<script type="text/javascript" src="../comm/bptComm.js"></script>	
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.DemobilizedflowQueryCommand" method="query3">
		<model:record fromBean="com.inspur.cams.bpt.base.data.Demobilizedflow"></model:record>
	</model:dataset>
	<!-- 审批条件 -->
	<model:dataset id="ApplyContent" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 上报标示 -->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

 <next:Panel  height="100%" width="100%"  autoScroll="true" id="peopleTabPanel">
 	<next:Html>
		<form id="editForm"   dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
		
			<div id="counties">
			<table border="1"  width="100%" >	
	   		<tr>
				
						<td  class="FieldLabel" width="20%">乡镇审批</td>
						<td class="FieldInput" colspan="3"><label name="townViews" field="townViews" style="width:80%" rows="4" readonly="true"></textarea> </td>
			</tr>
	   		<tr>
	   		<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput" width="20%"><label name="trialName" field="trialName"  readonly="true"/> </td>
				<td  class="FieldLabel" width="20%">审批日期</td>
				<td class="FieldInput"><label name="trialDate" field="trialDate"   readonly="true"/> </td>
			</tr>
			
			<tr>
				<td  class="FieldLabel" >县级审批</td>
				<td class="FieldInput" colspan="3">
					<table width="100%">
						<tr>
							<td class="FieldLabel" width="20%">审批意见：</td>
							<td class="FieldInput" width="82%" id="applyc" >
							<label  name="townFlag" id="townFlaga" field="townFlag"  dataset="ApplyContent"></label>
								<select  name="townFlag" id="townFlag" field="townFlag" onchange="changeDiv()" style="display:none">
									<option dataset="ApplyContent"></option>
								</select>
							</td>
							<td width="17%" id="isReport"  class="FieldLabel" style="display:none">是否上报：</td>
							<td class="FieldInput" id="isReport2" style="display:none">
								<label  name="townReport" id="townReporta" field="townReport"  dataset="ReportFlagEnum"></label>
								<select name="townReport" id="townReport" field="townReport" style="display:none">
									<option dataset="ReportFlagEnum"></option>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="4"><label
								validateName="县区复审意见" name="countiesViews"
								field="countiesViews" style="width: 80%" rows="4" ></textarea></td>
						</tr>
					</table>
				
				 </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >负责人</td>
				<td class="FieldInput" width="20%"><label name="reviewView" field="reviewView"  /> </td>
			
				<td  class="FieldLabel" width="20%">审批日期</td>
				<td class="FieldInput"><label name="reviewDate" field="reviewDate" /> </td>
			</tr>
			</table>
			</div>
			<br/>
			<div id="city">
				<table border="1"  width="100%" >
			   		<tr>
						<td  class="FieldLabel" width="20%">市级审批</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%">审批意见：</td>
									<td class="FieldInput" width="82%" id="applyc" >
									<label  name="cityFlag" id="cityFlaga" field="cityFlag"   dataset="ApplyContent"></label>
										<select  name="cityFlag" id="cityFlag" field="cityFlag" style="display:none">
											<option dataset="ApplyContent"></option>
										</select>
									</td>
									
								</tr>
								<tr>
									<td colspan="4"><label name="citiesViews" field="citiesViews" style="width:80%" rows="4" > </textarea></td>
								</tr>
							</table>
						
						 </td>
					</tr>
					<tr>
						<td  class="FieldLabel" >负责人</td>
						<td class="FieldInput" width="20%"><label name="approvalName" field="approvalName"  /> </td>
						<td  class="FieldLabel" width="20%">审批日期</td>
						<td class="FieldInput"><label name="approvalDate" field="approvalDate" /> </td>
					</tr>
				</table>
			</div>
			<br>
				<div>
					<table>
						<tr border="0"  width="98%">
							<td class="FieldInput"><lable id = "PrHistory" name="PrHistory"><a href="javaScript:Pr()">审批历史记录</a></lable></td>
						</tr>
					</table>
				</div>
				</table>
		</form>
   </next:Html>
 </next:Panel>
</body>
<script type="text/javascript">
		function init() {
			var ds = L5.DatasetMgr.lookup("ds");
				ds.setParameter("apply_Id",'<%=request.getParameter("applyId")%>');
				ds.load();
				
		}
		function changeDiv(){
			var ds = L5.DatasetMgr.lookup("ds");
			var townReport = ds.get("townReport");
			var isReport = document.getElementById("isReport");
			var isReport2 = document.getElementById("isReport2");
			var applyc = document.getElementById("applyc");
			if(townReport == null||townReport == "") {
				isReport.style.display="none";
				isReport2.style.display="none";
				applyc.width="82%";
			} else  {
				isReport.style.display="";
				isReport2.style.display="";
				applyc.width="30%";
			}
		}
		function Pr(){
		return openDetail();
	}
	
	function openDetail(){
		var url = L5.webPath+"/jsp/cams/bpt/flow/demobilized/applydemobilized/demoAppHistory.jsp?applyId=<%=request.getParameter("applyId")%>";
		var width = screen.width-60;
		var height = 580;
		var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
		if (win==null) {
			return;
		}
	}
		</script>
</html>
