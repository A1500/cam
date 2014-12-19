<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src="samBatchHandleAuditApply.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" >
	var assistanceType='<%=request.getParameter("assistanceType")%>';
	var organArea = '<%=BspUtil.getCorpOrgan().getOrganCode()%>';

</script>
<title>批量审批页面</title>
<model:datasets>
	<!-- 公示结果 -->
	<model:dataset id="noticeResultDataSet" enumName="NOTICE_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 意见 -->
	<model:dataset id="opinionDataSet" enumName="SAM_OPINION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 审批入户调查 -->
	<model:dataset id="auditSurveyDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey">
			<model:field name="surveyPeople" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 审批公示结果 -->
	<model:dataset id="auditNoticeDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">
			<model:field name="noticeResult" type="string" rule="require" />
			<model:field name="beginDate" type="string" rule="require" />
			<model:field name="endDate" type="string" rule="require" />
			<model:field name="principal" type="string" rule="require|length{32}" />
		</model:record>
	</model:dataset>
	<!-- 调查结果 -->
	<model:dataset id="surveyResultDataSet" enumName="SURVEY_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="applyAuditDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
			<model:field name="auditRemarks" type="string" rule="require|length{250}" />
			<model:field name="auditOpinionId" type="string" rule="require" />
			<model:field name="auditPrincipal" type="string" rule="require|length{32}" />
			<model:field name="auditDate" type="string" rule="require" />
			<model:field name="auditAgent" type="string" rule="require" />
		</model:record>
	</model:dataset>
</model:datasets>	

<next:Panel width="100%" height="100%" title="批量审批" autoHeight="true" titleCollapse="true" autoScroll="true" >
	<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="saveId" iconCls="save" text="确定批量提交" disabled="" handler="submitApp"/>
				<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack"/>
	</next:TopBar>
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
				<td class="FieldLabel" style="width: 10%">经办人</td>
			<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
				title="经办人" name="经办人" style="width: 80%" field="auditAgent" /><font color="red">*</font></td>
				<td class="FieldInput" colspan="4"></td>
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
</next:Panel>
