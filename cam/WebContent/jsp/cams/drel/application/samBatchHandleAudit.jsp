<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<model:datasets>
	<!-- 公示结果 -->
	<model:dataset id="noticeResultDataSet" enumName="NOTICE_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 意见 -->
	<model:dataset id="opinionDataSet" enumName="SAM_OPINION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 审批入户调查 -->
	<model:dataset id="auditSurveyDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey"></model:record>
		<model:params>
			<model:param name="activity_Id" value='audit'></model:param>
		</model:params>
	</model:dataset>
	<!-- 审批公示结果 -->
	<model:dataset id="auditNoticeDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">
		</model:record>
		<model:params>
			<model:param name="activity_Id" value='audit'></model:param>
		</model:params>
	</model:dataset>
	<!-- 调查结果 -->
	<model:dataset id="surveyResultDataSet" enumName="SURVEY_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="applyAuditDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
</model:datasets>	


<next:Window id="batchHandleWin" closeAction="hide" title="批量审批" width="800" height="400" modal="true">
	<next:Html>
		<form  method="post" onsubmit="return false" class="L5form" dataset="auditSurveyDataset">
	<fieldset><legend>入户调查</legend>
		<table width="100%">
			<tr>						
				<td class="FieldLabel" style="width: 10%">调查结果</td>
				<td class="FieldInput" style="width: 10%">
				<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%" onchange="checkOpinionAudit(this.value);"><option dataset="surveyResultDataSet"></option></select>
				</td>				
				<td class="FieldLabel" style="width: 10%">调查日期</td>
				<td class="FieldInput" style="width: 10%"><input type="text"
					name="调查日期" title="调查日期" field="surveyDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/></td>	
				<td class="FieldLabel" style="width: 10%"></td>
				<td class="FieldInput" style="width: 10%"></td>
			</tr>
			<tr>						
				<td class="FieldLabel" style="width: 10%">调查负责人</td>
				<td class="FieldInput" style="width: 10%" colspan="5"><input type="text" maxlength="100"
					name="调查负责人" title="调查负责人" field="surveyPeople" style="width:80%" /></td>
			</tr>
			<tr id="beizhuhangAudit" style="display:none">						
				<td class="FieldLabel" id="beizhu" style="width: 10%">备注</td>
				<td class="FieldInput" style="width: 10%" colspan="5">
					<textarea id="surveyContents" name="备注" title="备注" 
						field="surveyContents" style="width:80%"  /></textarea><font color="red">*</font>
				</td>
			</tr>
			</table>
		</fieldset>
		</form>
		
			<form  method="post" onsubmit="return false" class="L5form" dataset="applyAuditDataSet">
			<fieldset><legend>审批意见</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%" >审批意见</td>
				<td class="FieldInput" style="width: 10%" colspan="5">
					<textarea name="审批意见" title="审批意见" 
								field="auditRemarks" style="width: 97%"   /></textarea>
				</td>
			</tr>
			<tr>						
				<td class="FieldLabel" style="width: 10%">审批结果</td>
				<td class="FieldInput" style="width: 10%">	<select id="auditResult" name="审批结果" title="审批结果" field="auditOpinionId"  style="width:80%" onchange="checkOpinion1(this.value);" ><option dataset="opinionDataSet"></option></select><font color="red">*</font>
				</td>
				<td class="FieldLabel" style="width: 10%">民政局负责人</td>
				<td class="FieldInput" style="width: 10%">
				<input type="text" title="民政局负责人" maxlength="16" name="民政局负责人" style="width:80%" field="auditPrincipal"/>
				<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 10%">审批日期</td>
				<td class="FieldInput" style="width: 10%">
				<input type="text" title="审批日期" name="审批日期" field="auditDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
				<font color="red">*</font></td>
			</tr>
			<tr>						
				<td class="FieldLabel" style="width: 10%">低保证号</td>
				<td class="FieldInput" style="width: 10%">
				<label  field="cardNo"></label>
				</td>
				
				<td class="FieldLabel" style="width: 10%">经办人</td>
			<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
				title="经办人" name="经办人" style="width: 80%" field="auditAgent" /><font color="red">*</font></td>
				<td class="FieldInput" colspan="2"></td>
			</tr>
			</table>
		</fieldset>
		</form>
		<form  method="post" onsubmit="return false" class="L5form" dataset="auditNoticeDataset">
			<fieldset><legend>公示结果</legend>
		<table width="100%">
			<tr>						
				<td class="FieldLabel" style="width: 10%">公示结果</td>
				<td class="FieldInput" style="width: 10%"><select id="noticeResult" name="公示结果" title="公示结果" field="noticeResult"  style="width:80%" onchange="checkOpinion(this.value);" ><option dataset="noticeResultDataSet"></option></select>
				<font color="red">*</font></td>			
				<td class="FieldLabel" style="width: 10%">公示开始日期</td>
				<td class="FieldInput" style="width: 10%"><input type="text" title="公示开始日期" name="公示开始日期" field="beginDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font>
				</td>
				<td class="FieldLabel" style="width: 10%">公示结束日期</td>
				<td class="FieldInput" style="width: 10%">
				<input type="text" title="公示结束日期" name="公示结束日期" field="endDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
				<font color="red">*</font></td>
			</tr>
			<tr>						
				<td class="FieldLabel" style="width: 10%">经办人</td>
				<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16" title="经办人" name="经办人" style="width:80%" field="principal"/><font color="red">*</font></td>
					
				<td class="FieldLabel" style="width: 10%">
				
					<label id="beginDateL" style="display:none">救助截止月份</label>
					<label id="beginDateSL" style="display:none">救助开始月份</label>
				</td>
				<td class="FieldInput" style="width: 10%">
				<input type="text" title="救助开始月份" name="救助开始月份" id="beginDateS" style="width:80%;display:none"  onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly"/>
				<input type="text" title="救助截止月份" name="救助截止月份" id="beginDate" style="width:80%;display:none"  onclick="WdatePicker({dateFmt:'yyyy-MM'})" readonly="readonly"/>
				</td>
				<td class="FieldInput" colspan="2"></td>		
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Window>

<script type="text/javascript">
//审批结果为不同意的时候，显示低保结束日期
function checkOpinion(value){
	if(value == '0'){
		document.getElementById('beginDateL').style.display="none";
		document.getElementById('beginDate').style.display="none";
		document.getElementById('beginDateSL').style.display="none";
		document.getElementById('beginDateS').style.display="none";
	}else if(value == '1'){
		var revalue=document.getElementById('auditResult').value;
		if (revalue=='1'){
			document.getElementById('beginDateSL').style.display="block";
			document.getElementById('beginDateS').style.display="block";
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateS').value=applyDataSet.get("beginDate");
		}else if(revalue=='0'){
			document.getElementById('beginDateL').style.display="block";
			document.getElementById('beginDate').style.display="block";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
			document.getElementById('beginDate').value=applyDataSet.get("beginDate");
		}else{
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
		}
		
	}else{
		document.getElementById('beginDateL').style.display="none";
		document.getElementById('beginDate').style.display="none";
		document.getElementById('beginDateSL').style.display="none";
		document.getElementById('beginDateS').style.display="none";
	}
}

function checkOpinion1(value){
	if(value == '1'){
		var revalue=document.getElementById('noticeResult').value;
		if(revalue=='1'){
			document.getElementById('beginDateSL').style.display="block";
			document.getElementById('beginDateS').style.display="block";
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateS').value=applyDataSet.get("beginDate");
		}else{
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
		}
	}else if(value == '0'){
		var revalue=document.getElementById('noticeResult').value;
		if (revalue=='1'){
			document.getElementById('beginDateL').style.display="block";
			document.getElementById('beginDate').style.display="block";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
			document.getElementById('beginDate').value=applyDataSet.get("beginDate");
		}else{
			document.getElementById('beginDateL').style.display="none";
			document.getElementById('beginDate').style.display="none";
			document.getElementById('beginDateSL').style.display="none";
			document.getElementById('beginDateS').style.display="none";
		}	
	}else{
		document.getElementById('beginDateL').style.display="none";
		document.getElementById('beginDate').style.display="none";
		document.getElementById('beginDateSL').style.display="none";
		document.getElementById('beginDateS').style.display="none";
	}
}
//审批调查结果为不属实，填写备注录入
function checkOpinionAudit(value){
	if(value == '0'){
		document.getElementById('beizhuhangAudit').style.display="block";
	}else{
		document.getElementById('beizhuhangAudit').style.display="none";
		auditSurveyDataset.set('surveyContents','');
	}
}	
</script>