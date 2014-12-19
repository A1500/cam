<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>退役士兵培训信息表编辑</title>
		<next:ScriptManager/>
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var type='<%=request.getParameter("type")%>';
			var orgCode  ='<%=BspUtil.getOrganCode()%>';
		</script>
		<script type="text/javascript" src="prssoldierstrain_edit.js"></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
		<script type="text/javascript" src="../prsComm.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="prssoldierstrainDataset" cmd="com.inspur.cams.prs.prssoldierstrain.cmd.PrsSoldiersTrainQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.prs.prssoldierstrain.dao.PrsSoldiersTrain">
		<model:field  name="trainingType" mapping="TRAINING_TYPE" type="string"/>
		<model:field  name="whetherVoluntary" mapping="WHETHER_VOLUNTARY" type="string"/>
		<model:field  name="trainingInstitutions" mapping="TRAINING_INSTITUTIONS" type="string"/>
		<model:field  name="trainingStartTime" mapping="TRAINING_START_TIME" type="string"/>
		<model:field  name="trainingEndTime" mapping="TRAINING_END_TIME" type="string"/>
		<model:field  name="trainingMajor" mapping="TRAINING_MAJOR" type="string"/>
		<model:field  name="trainingSkillLevel" mapping="TRAINING_SKILL_LEVEL" type="string"/>
		<model:field  name="archivesPerformanceScores" mapping="ARCHIVES_PERFORMANCE_SCORES" type="string"/>
		<model:field  name="culturalStudiesTestScores" mapping="CULTURAL_STUDIES_TEST_SCORES" type="string"/>
		<model:field  name="totalScore" mapping="TOTAL_SCORE" type="string"/>
		<model:field  name="ranking" mapping="RANKING" type="string"/>
		<model:field  name="remarks" mapping="REMARKS" type="string"/>
		<model:field  name="trainId" mapping="TRAIN_ID" type="string"/>
		<model:field name="soldiersId" mapping="SOLDIERS_ID" type="string"/>
		</model:record>
	</model:dataset>

	<!-- 是否自愿参加 -->
	<model:dataset id="WhetherVoluntaryFlagEnum" enumName="COMM.YESORNO"
             autoLoad="true" global="true"></model:dataset>

	<!-- 培训类型 -->
	<model:dataset id="TrainingType" enumName="TRAINING.TYPE"
             autoLoad="true" global="true"></model:dataset>
    
    <model:dataset id="trainDic"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_prs_train_field'></model:param>
			<model:param name="value" value='NAME'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 就业形式 -->
	<model:dataset id="EmploymentType" enumName="EMPLOYMENT.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 安置形式 -->
	<model:dataset id="PlacementType" enumName="PLACEMENT.TYPE"
		autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="print"  text="打印培训信息" handler="print"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="prssoldierstrainDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="98%" >

	   		<tr>
				<td  class="FieldLabel" >培训类型：</td>
                <td class="FieldInput"><select id="trainingType" name="trainingType" field="trainingType" title="培训类型" >
                <option dataset="TrainingType"></option></td>
                <td  class="FieldLabel" >是否自愿参加：</td>
                <td class="FieldInput"><select id="whetherVoluntary" name="whetherVoluntary" field="whetherVoluntary" title="是否自愿参加" >
                <option dataset="WhetherVoluntaryFlagEnum"></option></td>
           </tr>
	   		<tr>
				<td  class="FieldLabel" >培训机构：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="trainingInstitutions" field="trainingInstitutions" style="width:78%"  /> </td>
			</tr>
	   		<tr>
		       <td class="FieldLabel" nowrap="nowrap">培训开始时间：</td>
		       <td class="FieldInput"><input type="text" name="trainingStartTime" field="trainingStartTime" id="trainingStartTime"
		       title="培训开始时间" format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >
		       <font color="red">*</font></td>

		       <td class="FieldLabel" nowrap="nowrap">培训结束时间：</td>
		       <td class="FieldInput"><input type="text" name="trainingEndTime" field="trainingEndTime" id="trainingEndTime"
		       title="培训结束时间" format="Y-m-d" maxlength="10"onpropertychange="changeDateStyle(this)"/><img  src="../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" >
		       <font color="red">*</font></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >培训专业：</td>
				<td class="FieldInput"><select field="trainingMajor" ><option dataset = "trainDic"></option> </select> </td>

				<td  class="FieldLabel" >培训技能等级：</td>
				<td class="FieldInput"><input type="text" id="trainingSkillLevel" name="trainingSkillLevel" field="trainingSkillLevel" maxlength="2" /> </td>
			</tr>
     		<tr>
				<td class="FieldLabel">备注：</td>
				<td class="FieldInput" colspan="5"><textarea name="remarks"
				field="remarks" style="width: 78%" title="备注"></textarea> </td>
			</tr>
	   		<tr>
				<!--培训信息ID -->
				<input type="hidden" name="trainId" id="trainId" field="trainId" />

				</tr>
		</table>
		</form>
   </next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
