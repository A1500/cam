<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>优抚_申请_伤残申请_审批编辑</title>
		<next:ScriptManager/>
				<script>
					var applyId='<%=request.getParameter("applyId")%>';
					var serviceType='<%=request.getParameter("serviceType")%>';
				</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="queryApplyInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability"></model:record>
	</model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="ServiceTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_SERVICE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 上报标示 -->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 审批条件 -->
	<model:dataset id="ApplyContent" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 取消待遇标志 -->
	<model:dataset id="CancelTreateFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="审批信息" height="100%" width="100%" id="approveTabPanel" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="DisabilityApproveDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="0"  width="99%">
			<div id="TownVerify">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="4" nowrap="nowrap">县级审核</td>
			   			<td  class="FieldLabel">负责人</td>
						<td class="FieldInput" style="width:30%"><label  name="townAduitIncharge" field="townAduitIncharge" readonly="readonly" /> </td>
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label   name="townAduitApproveDate" field="townAduitApproveDate" readonly="readonly"  /> </td>
					</tr>
			   		<tr>
			   			<td  class="FieldLabel" >公示结果</td>
						<td class="FieldInput" colspan="3"><label    name="townAduitBulletinResult" field="townAduitBulletinResult" ></label> </td>
			   		</tr>
			   		<tr>	
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
							<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审核意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;"  name="townFlag"  dataset="ApplyContent" field="townFlag" >
									</label>
								</td>
								<td class="FieldInput">
									<div id="TownVerifyPass">伤残性质：
										<label dataset="DisabilityCaseDataset" name="townAduitDisabilityNature" field="townAduitDisabilityNature">
										</label> 
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label  dataset="DisabilityLevelDataset" name="townAduitDisabilityLevel" field="townAduitDisabilityLevel">
										</label> 
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="townAduitAdvice" field="townAduitAdvice"></label>  
								</td>
							</tr>
						</table>
						</td>
						</tr>
						</table>
			</div>
				<br>
			<div id="CityVerify">
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel" rowspan="2" nowrap="nowrap">市级审核</td>
			   			<td class="FieldLabel" style="width:10%">负责人</td>
						<td class="FieldInput" style="width:30%"><label name="cityAduitIncharge" field="cityAduitIncharge"/></td>
						<td class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label name="cityAduitApproveDate" field="cityAduitApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审核意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;" name="cityFlag" 
									 id="CityVerifyFlag" field="cityFlag" dataset="ApplyContent">
									</label>
								</td>
								<td class="FieldInput">
									<div id="CityVerifyPass">伤残性质： 
										<label dataset="DisabilityCaseDataset" name="cityAduitDisabilityNature"  field="cityAduitDisabilityNature">
										</label>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label dataset="DisabilityLevelDataset" name="cityAduitDisabilityLevel"   field="cityAduitDisabilityLevel">
										</label>	
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="cityAduitAdvice" field="cityAduitAdvice"></label>
								</td>
							</tr>
						</table>
						 </td>
					</tr>
				</table>
			</div>
			 <br/>
			 <div id="cProvinceAccept" style="display:none">
				<table width="99%">
					<tr>
						<td  class="FieldLabel"  rowspan="8" nowrap="nowrap">省级审批</td>
						<td  class="FieldLabel" nowrap="nowrap">假证(取消待遇)</td>	
						<td  class="FieldInput" nowrap="nowrap" colspan="3">
							   <label id="cancelTreateFlag" name="cancelTreateFlag" field="cancelTreateFlag" title="取消待遇标志" onblur="cancelTreate(this.value)" dataset="CancelTreateFlagEnum" />
						</td>
					</tr>
					<tr>
						<td  class="FieldLabel" nowrap="nowrap">业务类型</td>
						<td class="FieldInput" colspan="3" style="width:100%">
							<label id="certType" name="certType" field="certType"></label>
						</td>
					</tr>
					<tr id="disabilityNoTr">
						<td  class="FieldLabel" nowrap="nowrap">原优抚证书编号</td>	
								<td  class="FieldInput" nowrap="nowrap" >
									 <label id="oldDisabilityNo" name="oldDisabilityNo" field="oldDisabilityNo" validateName="原优抚证书编号"/>
						</td>	
						<td  class="FieldLabel" nowrap="nowrap">新优抚证书编号</td>	
								<td  class="FieldInput" nowrap="nowrap" >
									 <label id="newDisabilityNo" name="newDisabilityNo" field="newDisabilityNo" validateName="新优抚证书编号"/>
						</td>
					</tr>
					<tr id="changeContentTr" >
						<td  class="FieldLabel" nowrap="nowrap">变更内容</td>	
						<td  class="FieldInput" nowrap="nowrap" colspan="3">
							 <label id="changeContentArea" name="changeContent" field="changeContent"></label>
						</td>
					</tr>
					
					<tr id="changeContentTr1" >
					<td  class="FieldLabel" nowrap="nowrap">变更项</td>
					<td colspan="3" class="FieldInput">
						<table  style="width:100%">
							<tr >
								<td  class="FieldLabel" nowrap="nowrap">身份证号</td>
								<td  class="FieldInput" nowrap="nowrap" colspan="3">
									 <label id="oldIdCard" name="oldIdCard" field="oldIdCard" style="width:155" maxlength="18" validateName="原身份证号"/>
								</td>
							</tr>
							<tr >
								<td  class="FieldLabel" nowrap="nowrap">姓名</td>	
								<td  class="FieldInput" nowrap="nowrap">
									 <label id="oldName" name="oldName" field="oldName" validateName="原姓名"/>
								</td>
								<td  class="FieldLabel" nowrap="nowrap">优抚证书编号</td>	
								<td  class="FieldInput" nowrap="nowrap" >
									 <label id="oldDisabilityNo" name="oldDisabilityNo" field="oldDisabilityNo" validateName="原优抚证书编号"/>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr id="changeContentTr2" >
					<td  class="FieldLabel" nowrap="nowrap">变更为</td>	
					<td colspan="3" class="FieldInput">
						<table style="width:100%">
							<tr >
								
								<td  class="FieldLabel" nowrap="nowrap">身份证号</td>
								<td  class="FieldInput" nowrap="nowrap" colspan="3">
									 <label id="newIdCard" name="newIdCard" field="newIdCard" style="width:155" maxlength="18"  validateName="新身份证号"/>
								</td>
							</tr>
							<tr >
								<td  class="FieldLabel" nowrap="nowrap">姓名</td>	
								<td  class="FieldInput" nowrap="nowrap">
									 <label id="newName" name="newName" field="newName"  validateName="新姓名"/>
								</td>
								<td  class="FieldLabel" nowrap="nowrap">优抚证书编号</td>	
								<td  class="FieldInput" nowrap="nowrap" >
									 <label id="newDisabilityNo" name="newDisabilityNo" field="newDisabilityNo" validateName="新优抚证书编号"/>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					
						<tr>
			   			<td  class="FieldLabel" style="width:10%" nowrap="nowrap">审核人员</td>
						<td class="FieldInput" style="width:30%"><label validateName="受理人员" name="provinceCheckPeopleId" field="provinceCheckPeopleId" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label validateName="时间" format="Y-m-d" style="width: 100px; name="provinceCheckDate" field="provinceCheckDate"/></td>
					</tr>
					
			   		<tr>
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput"  colspan="3"><label name="provinceCheckAdvice" field="provinceCheckAdvice" style="width:80%" rows="2"></label></td>
					</tr>
					
				</table>
			</div>
			 <br/>
			<div id="ProvinceAccept" style="display:none">
				<table width="99%">
					<tr>
						<td class="FieldLabel" rowspan="5" nowrap="nowrap">省级初审</td>			   			
			   			<td class="FieldLabel" nowrap="nowrap">受理人员</td>
						<td class="FieldInput" style="width:30%"><label name="provinceCheckPeopleId" field="provinceCheckPeopleId"/></td>
						
						<td class="FieldLabel" style="width:20%">受理时间</td>
						<td class="FieldInput" style="width:30%"><label name="provinceCheckDate" field="provinceCheckDate"/></td>
					</tr>
					<tr>
						<td  class="FieldLabel" nowrap="nowrap">负伤时间</td>
						<td class="FieldInput" style="width:30%"><label name="disabilityDate" field="disabilityDate" ></label> </td>
						<td  class="FieldLabel" nowrap="nowrap">负伤地点</td>
						<td class="FieldInput" style="width:30%"><label   name="disabilityAdd" field="disabilityAdd" ></label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" nowrap="nowrap">负伤部位</td>
						<td class="FieldInput" style="width:30%"><label  name="disabilityBody" field="disabilityBody" ></label> </td>
						<td  class="FieldLabel" nowrap="nowrap">负伤原因</td>
						<td class="FieldInput" style="width:30%"><label  name="disabilityReason" field="disabilityReason" ></label> </td>
					</tr>
					<tr>
						<td  class="FieldLabel" nowrap="nowrap">简要残情</td>
						<td class="FieldInput" colspan="3">
							<label  name="briefDisability" field="briefDisability" ></label> 
						</td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">初审意见：
								</td>
								<td class="FieldInput"> 
									<label style="width:90px;"  name="proCheckFlag"  dataset="ApplyContent"
									id="ProvinceAcceptFlag" field="proCheckFlag" >
									</label>
								</td>
								<td class="FieldInput">
									<div id="ProvinceAcceptPass">伤残性质：
										<label name="provinceCheckDisNature" dataset="DisabilityCaseDataset"  field="provinceCheckDisNature">
										</label>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label name="provinceCheckDisLevel" dataset="DisabilityLevelDataset" field="provinceCheckDisLevel">
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="provinceCheckAdvice" field="provinceCheckAdvice"></label> 
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			</div>
				<br>
			<div id="ProvinceVerify" style="display:none">
				<table width="99%">
			   		<tr>
						<td class="FieldLabel" rowspan="2" nowrap="nowrap">省级复审</td>
						<td class="FieldLabel" style="width:10%">负责人</td>  
						<td class="FieldInput" style="width:30%"><label name="provinceAduitIncharge" field="provinceAduitIncharge"/></td>
						<td class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label name="provinceAduitApproveDate" field="provinceAduitApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">复审意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;" name="proAduitFlag"  
									dataset="ApplyContent" id="ProvinceVerifyFlag" field="proAduitFlag" onchange="changeAppDiv('ProvinceVerify')">
									</label>
								</td>
								<td class="FieldInput">
									<div id="ProvinceVerifyPass">伤残性质：
										<label name="provinceAduitDisabilityNatu" dataset="DisabilityCaseDataset"  field="provinceAduitDisabilityNatu">
										</label>
										&nbsp;&nbsp;&nbsp;
										申报等级：
										<label name="provinceAduitDisabilityLeve" dataset="DisabilityLevelDataset" field="provinceAduitDisabilityLeve">
										</label>	
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="provinceAduitAdvice" field="provinceAduitAdvice"></label>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			</div>
				<br>
			<div id="ProvinceApprove" >
				<table width="99%">
			   		<tr>
			   			<td class="FieldLabel"  rowspan="3" nowrap="nowrap">省级审批</td>
			   			<td class="FieldLabel" style="width:10%">负责人</td>
						<td class="FieldInput" style="width:30%"><label name="provinceIncharge" field="provinceIncharge"/></td>
						<td class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label name="provinceApproveDate" field="provinceApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审批意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;" name="proFlag"  
									 id="proFlag" field="proFlag"  dataset="ApplyContent">
									</label>
								</td>
								<td class="FieldInput" >
									<div id="ProvinceApprovePass">伤残性质：
										<label name="provinceVerifyDisabilityNat" dataset="DisabilityCaseDataset"  field="provinceVerifyDisabilityNat">
										</label>
										&nbsp;&nbsp;&nbsp;
										审批等级：
										<label name="provinceLevel" dataset="DisabilityLevelDataset"  field="provinceLevel">
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label name="provinceAdvice" field="provinceAdvice"></label>
								</td>
							</tr>
						</table>
						</td>
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
<script>
function init() {
    if(serviceType=="11"||serviceType=="12"){
    	document.getElementById("ProvinceAccept").style.display = "";
    	document.getElementById("ProvinceVerify").style.display = "";
    }else if(serviceType=="13"){
    	document.getElementById("cProvinceAccept").style.display = "";
    	document.getElementById("ProvinceApprove").style.display = "none";
    }
    
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
	DisabilityApproveDataset.load();
	DisabilityApproveDataset.on("load",changeType);
}
function changeType() { 
	var v = DisabilityApproveDataset.get("certType"); 
	var disabilityNoTr = document.getElementById("disabilityNoTr");
	var changeContent = document.getElementById("changeContentTr");
	var changeContent1 = document.getElementById("changeContentTr1");
	var changeContent2 = document.getElementById("changeContentTr2");
	if(v == "18") {
		changeContent.style.display=""; 
		changeContent1.style.display="";
		changeContent2.style.display="";
		disabilityNoTr.style.display="none";
		DisabilityApproveDataset.set("certType",'证件变更业务');
	} else if(v == "13") {
		changeContent.style.display="none";
		changeContent1.style.display="none";
		changeContent2.style.display="none";
		disabilityNoTr.style.display="";
		DisabilityApproveDataset.set("certType",'换证补证业务');
	}
}
function Pr(){
		return openDetail(applyId);
	}
	
	function openDetail(applyId){
		if(serviceType=="13")
			var url = L5.webPath+"/jsp/cams/bpt/flow/disability/assessdisability/disabilityCert_FlowAppHistory.jsp?applyId="+applyId;
		else
			var url = L5.webPath+"/jsp/cams/bpt/flow/disability/assessdisability/disabilityAppHistory.jsp?applyId="+applyId;
		var width = screen.width-60;
		var height = 580;
		var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
		if (win==null) {
			return;
		}
	}
</script>
</html>
