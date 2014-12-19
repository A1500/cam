<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src="samBatchInsertNotNull.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" >
	var assistanceType='<%=request.getParameter("assistanceType")%>';
	var organArea = '<%=BspUtil.getCorpOrgan().getOrganCode()%>';

</script>
<title>批量审批页面</title>
<model:datasets>
 
	<model:dataset id="applyListDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true" pageSize="10">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo"></model:record>
	</model:dataset>
		<!-- 入户调查 -->
	<model:dataset id="acceptSurveyDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey">
			<model:field name="surveyResult" type="string" rule="length{200}|require" />
			<model:field name="surveyDate" type="string" rule="require" />
			<model:field name="surveyPeople" type="string" rule="length{100}|require" />
			<model:field name="surveyContents" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 评议结果 -->
	<model:dataset id="acceptDiscussionDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyDiscussionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyDiscussion">
			<model:field name="content" type="string" rule="length{300}|require" />
			<model:field name="principal" type="string" rule="length{50}|require" />
			<model:field name="discussionDate" type="string" rule="require" />
			<model:field name="total" type="string" rule="regex{^[0-9]+$}|length{2}|require" />
			<model:field name="agreeNum" type="string" rule="regex{^[0-9]+$}|length{2}|require" />
			<model:field name="disagreeNum" type="string" rule="regex{^[0-9]+$}|length{2}|require" />
		</model:record>
	</model:dataset>
	<!-- 公示结果 -->
	<model:dataset id="acceptNoticeDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">
			<model:field name="principal" type="string" rule="length{32}|require" />
			<model:field name="noticeResult" type="string" rule="require" />
			<model:field name="beginDate" type="string" rule="require" />
			<model:field name="endDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 审核入户调查 -->
	<model:dataset id="checkSurveyDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplySurveyQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplySurvey">
			<model:field name="surveyResult" type="string" rule="length{200}" />
			<model:field name="surveyPeople" type="string" rule="length{100}" />
			<model:field name="surveyContents" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 审核公示结果 -->
	<model:dataset id="checkNoticeDataset"
		cmd="com.inspur.cams.drel.sam.cmd.SamApplyNoticeQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyNotice">
			<model:field name="principal" type="string" rule="length{32}" />
		</model:record>
	</model:dataset>
	<!-- 调查结果 -->
	<model:dataset id="surveyResultDataSet" enumName="SURVEY_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 评议意见 -->
	<model:dataset id="discussionResultDataSet" enumName="DISCUSSION_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 公示结果 -->
	<model:dataset id="noticeResultDataSet" enumName="NOTICE_RESULT_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 意见 -->
	<model:dataset id="opinionDataSet" enumName="SAM_OPINION_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
			<model:field name="checkOpinionId" type="string" rule="require" />
			<model:field name="checkPrincipal" type="string" rule="require" />
			<model:field name="checkDate" type="string" rule="require" />
			<model:field name="checkAgent" type="string" rule="require" />
		</model:record>
	</model:dataset>
	
</model:datasets>	

<next:Panel width="100%" height="100%" title="批量审批"   autoScroll="true" >
	<next:GridPanel  clickToSelectedForChkSM="true" dataset="applyListDataSet" width="100%" height="260" stripeRows="true" notSelectFirstRow="true">
		<next:Columns>
  			<next:RowNumberColumn/>
	        <next:Column header="户主姓名" field="familyName" align="center" width="150" ></next:Column>
        	<next:Column header="身份证号码" field="familyCardNo" align="center" width="150" ></next:Column>
        	<next:Column header="保障人口数" field="assistancePeopleNum" align="center" width="150" ></next:Column>
        	<next:Column header="户月保障金" field="assistanceMoney" align="center" width="150" ></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="applyListDataSet" />
		</next:BottomBar>
	</next:GridPanel>
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<%
				if( "3701".equals(BspUtil.getCorpOrgan().getOrganCode().substring(0,4))){	%>	
				<next:ToolBarItem id="saveId" iconCls="save" text="批量保存" disabled="" handler="saveApp"/>
				<%
				}	
				else{
			%>	
				<next:ToolBarItem id="submitID" iconCls="select" text="批量提交" disabled="" handler="submitApp"/>
				<%
					
				}
			%>	
			<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack"/>
	</next:TopBar>
	<next:Panel title="入户调查|评议|公示结果信息" titleCollapse="true" collapsible="true"  autoHeight="true" autoScroll="true">
			<next:Html>
				<form  method="post" onsubmit="return false" class="L5form" dataset="acceptSurveyDataset">
			<fieldset><legend>入户调查</legend>
				<table width="100%">
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查结果</td>
						<td class="FieldInput" style="width: 10%">
						<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%"  ><option dataset="surveyResultDataSet"></option></select>
						<font color="red">*</font></td>				
						<td class="FieldLabel" style="width: 10%">调查日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="调查日期" title="调查日期" field="surveyDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font></td>	
						<td class="FieldLabel" style="width: 10%"></td>
						<td class="FieldInput" style="width: 10%"></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">调查负责人</td>
						<td class="FieldInput" style="width: 10%" colspan="5"><input type="text" maxlength="100"
							name="调查负责人" title="调查负责人" field="surveyPeople" style="width:80%" /><font color="red">*</font></td>
					</tr>
					<tr id="beizhuhang" style="display:none">						
						<td class="FieldLabel" id="beizhu" style="width: 10%">备注</td>
						<td class="FieldInput" style="width: 10%" colspan="5">
							<textarea id="surveyContents" name="备注" title="备注" 
								field="surveyContents" style="width:80%"  /></textarea>
						</td>
					</tr>
					</table>
				</fieldset>
				</form>
				<form  method="post" onsubmit="return false" class="L5form" dataset="acceptDiscussionDataset">
					<fieldset><legend>评议</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width: 10%" >评议内容</td>
						<td class="FieldInput" style="width: 10%" colspan="5">
							<textarea name="评议内容" title="评议内容"
										field="content" style="width: 97%"   /></textarea>
						<font color="red">*</font></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">评议意见</td>
						<td class="FieldInput" style="width: 10%">
						<select name="评议意见" title="评议意见" field="discussionResult"  style="width:80%"  disabled="disabled"><option dataset="discussionResultDataSet"></option></select>
						<font color="red">*</font></td>				
						<td class="FieldLabel" style="width: 10%">乡镇（街道）负责人</td>
						<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
							name="乡镇（街道）负责人" title="乡镇（街道）负责人" field="principal"  style="width:80%" /><font color="red">*</font></td>	
						<td class="FieldLabel" style="width: 10%">评议日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="评议日期" title="评议日期" field="discussionDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/><font color="red">*</font></td>
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">评议人数量</td>
						<td class="FieldInput" style="width: 10%">
						<input type="text"  name="评议人数量" title="评议人数量" field="total"id="total"    maxlength="2" style="width:80%" /><font color="red">*</font></td>				
						<td class="FieldLabel" style="width: 10%">同意人数</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="同意人数" title="同意人数" id="agreeNum" field="agreeNum" maxlength="2"   style="width:80%" /><font color="red">*</font></td>	
						<td class="FieldLabel" style="width: 10%">不同意人数</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="不同意人数" title="不同意人数" field="disagreeNum" maxlength="2" style="width:80%" /><font color="red">*</font></td>
					</tr>
					</table>
				</fieldset>
				</form>
				<form  method="post" onsubmit="return false" class="L5form" dataset="acceptNoticeDataset">
					<fieldset><legend>公示结果</legend>
				<table width="100%">
					<tr>						
						<td class="FieldLabel" style="width: 10%">公示结果</td>
						<td class="FieldInput" style="width: 10%">
						<select name="公示结果" title="公示结果" field="noticeResult"  style="width:80%"  ><option dataset="noticeResultDataSet"></option></select>
					<font color="red">*</font>	</td>				
						<td class="FieldLabel" style="width: 10%">公示开始日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="公示开始日期" title="公示开始日期" field="beginDate" style="width:80%" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /><font color="red">*</font></td>
						<td class="FieldLabel" style="width: 10%">公示结束日期</td>
						<td class="FieldInput" style="width: 10%"><input type="text"
							name="公示结束日期" title="公示结束日期" field="endDate" style="width:80%" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /><font color="red">*</font></td>	
					</tr>
					<tr>						
						<td class="FieldLabel" style="width: 10%">经办人</td>
						<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
							name="经办人" title="经办人"  style="width:80%" field="principal" /><font color="red">*</font></td>	
						<td class="FieldInput" colspan="4"></td>				
					</tr>
				</table>
				</fieldset>
				</form>
			</next:Html>
		</next:Panel>
		
		
	<next:Panel title="审核意见信息" id="checkEditPanel" titleCollapse="true"
		collapsible="true" autoHeight="true" autoScroll="true">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="checkSurveyDataset">
			<fieldset><legend>入户调查</legend>
			<table width="100%">
				<tr>						
						<td class="FieldLabel" style="width: 10%">调查结果</td>
						<td class="FieldInput" style="width: 10%">
						<select name="调查结果" title="调查结果" field="surveyResult" style="width:80%"><option dataset="surveyResultDataSet"></option></select>
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
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="checkNoticeDataset">
			<fieldset><legend>公示结果</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">公示结果</td>
					<td class="FieldInput" style="width: 10%"><select name="公示结果"
						title="公示结果" field="noticeResult" style="width: 80%">
						<option dataset="noticeResultDataSet"></option>
					</select> </td>
					<td class="FieldLabel" style="width: 10%">公示开始日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示开始日期" name="公示开始日期" field="beginDate" style="width: 80%"
						format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" />
					</td>
					<td class="FieldLabel" style="width: 10%">公示结束日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="公示结束日期" name="公示结束日期" field="endDate" style="width: 80%"
						format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
						title="经办人" name="经办人" style="width: 80%" field="principal" /></td>
					<td class="FieldInput" colspan="4"></td>
				</tr>
			</table>
			</fieldset>
			</form>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="applyDataSet">
			<fieldset><legend>审核意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 10%">审核意见</td>
					<td class="FieldInput" style="width: 10%" colspan="5"><textarea
						name="审核意见" title="审核意见" field="checkRemarks" style="width: 97%" /></textarea>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">审核结果</td>
					<td class="FieldInput" style="width: 10%"><select name="审核结果"
						title="审核结果" field="checkOpinionId" style="width: 80%">
						<option dataset="opinionDataSet"></option>
					</select><font color="red">*</font> </td>
					<td class="FieldLabel" style="width: 10%">负责人</td>
					<td class="FieldInput" style="width: 10%"><input type="text" maxlength="16"
						title="负责人" name="负责人" style="width: 80%" field="checkPrincipal" />
					<font color="red">*</font></td>
					<td class="FieldLabel" style="width: 10%">审核日期</td>
					<td class="FieldInput" style="width: 10%"><input type="text"
						title="审核日期" name="审核日期" field="checkDate" style="width: 80%"
						format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" /><font color="red">*</font>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 10%">经办人</td>
					<td class="FieldInput" style="width: 10%">
					<input type="text" maxlength="16"
						title="经办人" name="经办人" style="width: 80%" field="checkAgent" /><font color="red">*</font></td>
					<td class="FieldInput" colspan="4"></td>
				</tr>
			</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel>
