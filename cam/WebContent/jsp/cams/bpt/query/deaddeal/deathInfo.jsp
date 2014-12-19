<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>逝者信息</title>
		<next:ScriptManager />
		<script type="text/javascript">
			var deadId='<%=request.getParameter("deadId")%>';
		</script>
		<script type="text/javascript" src="deathInfo.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 数据上报逝者信息 -->
	<model:dataset id="fisFuneralDeadInfoDS2"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd" method="queyDeadInfo" >
	</model:dataset>
	<!-- 数据上报逝者信息 -->
	<model:dataset id="fisFuneralDeadInfoDS3"
		cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd" method="queyDeadInfo" >
	</model:dataset>
	<!-- 骨灰去向 -->
	<model:dataset id="ashesGoDS" enumName="FIS.ASHES.GO" autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否-->
	<model:dataset id="yesOrNoDs" enumName="COMM.YESORNO" autoLoad="true" global="true">
	</model:dataset>
	<!-- 优惠类型 -->
	<model:dataset id="fisReducationTypeDic" cmd="com.inspur.cams.fis.base.cmd.FisFuneralDeadInfoQueryCmd" method="queryByReductionDic" autoLoad="true">
	 <model:record>
	 		<model:field name="value" mapping="PREFERENTIAL_TYPE_NAME" type="string" />
			<model:field name="text" mapping="PREFERENTIAL_TYPE_NAME" type="string" />
	 </model:record>
	</model:dataset>
	<!-- 教育状况 -->
	<model:dataset id="DmJyzkDataSet" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族代码-->
	<model:dataset id="DmMzDataSet" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
	<model:dataset id="DmZyDataSet" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 男女-->
	<model:dataset id="commSexDS" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 遗体状态-->
	<model:dataset id="fisCorpseStatusDS" enumName="FIS.CORPSE.STATUS"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 宗教信仰 -->
	<model:dataset id="religionDS" enumName="FIS.RELIGION" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeDS" enumName="FIS.CARD.TYPE" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 病种字典 -->
	<model:dataset id="diseaseDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISEASE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 国籍 -->
	<model:dataset id="nationDS"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="sort" value=""></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="deathCertOrganDS" enumName="FIS.DEATH.CERT.ORGAN"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 死亡原因 FIS.DEATH.CAUSE-->
	<model:dataset id="fisDeathCauseDS" enumName="FIS.DEATH.CAUSE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
		<next:Panel autoScroll="true">
		<next:Html>
			<form id="dathEditForm" onsubmit="return false"
				class="L5form" dataset="fisFuneralDeadInfoDS2">
				<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" width="15%"><label>姓名:</label></td>
					<td class="FieldInput" width="17%"><label
						maxlength="25" name="逝者姓名" field="NAME" /></td>
					<td class="FieldLabel" width="15%"><label>性别:</label></td>
					<td class="FieldInput" width="17%"><label name="逝者性别"
						style="width: 95%" field="SEX" dataset="commSexDS"/></td>
					<td class="FieldLabel" ><label>证件类型:</label></td>
					<td class="FieldInput"><label name="逝者证件类型" field="CARD_TYPE" dataset="cardTypeDS"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" ><label>证件号码:</label></td>
					<td class="FieldInput"><label name="逝者证件号码"
						maxlength="18" 
						style="width: 95%" field="ID_CARD" /></td>
					<td class="FieldLabel" >出生日期:</td>
					<td class="FieldInput"><label name="出生日期"
						  id="winBirthDay" field="BIRTHDAY" /></td>
					<td class="FieldLabel" >去世时间:</td>
					<td class="FieldInput"><label name="去世时间"
						id="winDeathDate" field="DEATH_DATE" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" >年龄:</td>
					<td class="FieldInput"><label name="年龄"
						maxlength="3" field="AGE" /></td>
					<td class="FieldLabel" >优惠类型:</td>
					<td class="FieldInput"><label name="优惠类型"
						field="PREFERENTIAL_TYPE_NAME" style="width: 95%" /></td>
					<td class="FieldLabel" >国籍:</td>
					<td class="FieldInput"><label name="国籍" field="NATION" dataset="nationDS"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >民族:</td>
					<td class="FieldInput"><label name="民族" field="FOLK"
						style="width: 95%"dataset="DmMzDataSet"/></td>
					<td class="FieldLabel" >文化程度:</td>
					<td class="FieldInput"><label name="文化程度" field="EDUCATION" dataset="DmJyzkDataSet"/></td>
					<td class="FieldLabel" >职业:</td>
					<td class="FieldInput"><label name="职业" field="PROFESSION" dataset="DmZyDataSet"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >政治面貌:</td>
					<td class="FieldInput"><label name="政治面貌" field="POLITICAL"
						style="width: 95%" dataset="DmZzmmDataSet"/></td>
					<td class="FieldLabel" >宗教信仰:</td>
					<td class="FieldInput"><label name="宗教信仰" field="RELIGION" dataset="religionDS"/></td>
					<td class="FieldLabel" >入馆时间:</td>
					<td class="FieldInput"><label  field="RECEIVE_TIME"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >火化时间:</td>
					<td class="FieldInput"><label  field="START_TIME"/></td>
					<td class="FieldLabel" >火化炉:</td>
					<td class="FieldInput"><label field="STOVE_NO"/></td>
					<td class="FieldLabel" >火化工:</td>
					<td class="FieldInput"><label  field="STOVE_PEOPLE"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >领灰时间:</td>
					<td class="FieldInput"><label  field="TAKEASHES_TIME"/></td>
					<td class="FieldLabel" >骨灰去向:</td>
					<td class="FieldInput"><label field="ASHES_GO" dataset="ashesGoDS"/></td>
					<td class="FieldLabel" >殡仪馆名称:</td>
					<td class="FieldInput"><label  field="UNIT_NAME"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >户口所在地:</td>
					<td class="FieldInput"><label name="户口所在地"
						field="POPULACE_NAME" readonly="readonly" />
					<td style="display: none;"><label
						field="POPULACE" /></td>
					<td class="FieldLabel" >生前住址:</td>
					<td class="FieldInput" colspan="3"><label
						maxlength="50" name="生前住址" style="width: 83%" field="FAMILY_ADD" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" >是否要灰:</td>
					<td class="FieldInput"><label
						maxlength="50" name="是否要灰" style="width: 83%" field=IF_TO_DUST dataset="yesOrNoDs"/></td>
					<td class="FieldLabel" >原工作单位:</td>
					<td class="FieldInput" colspan="5"><label
						maxlength="50" name="工作单位" style="width: 83%" field="WORK_NAME" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" >去世原因:</td>
					<td class="FieldInput"><label name="去世原因" field="DEATH_CAUSE" dataset="fisDeathCauseDS"/></td>
					<td class="FieldLabel" >去世地点:</td>
					<td class="FieldInput" colspan="3"><label
						maxlength="50" style="width: 83%" name="去世地点" field="DEATH_PLACE" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" >病种:</td>
					<td class="FieldInput"><label name="病种" field="DEATH_DISEASE" dataset="diseaseDataset"/></td>
					<td class="FieldLabel" >随身遗物:</td>
					<td class="FieldInput" colspan="3"><label rows="2" readonly="readonly"
						cols="15" name="随身遗物" style="width: 83%" field="RELICS"
						lang="100"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" >遗体状态:</td>
					<td class="FieldInput"><label name="遗体状态"
						field="CORPSE_STATUS" dataset="fisCorpseStatusDS"/></td>
					<td class="FieldLabel" >遗体状态备注:</td>
					<td class="FieldInput" colspan="3"><label rows="2" readonly="readonly"
						cols="15" style="width: 83%" name="遗体状态备注"
						field="CORPSE_STATUS_NOTE" lang="100"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" >是否无名尸:</td>
					<td class="FieldInput"><label field="IF_NAMELESS"
						name="是否无名尸"  dataset="yesOrNoDs"/></td>
					<td class="FieldLabel" >出具死亡证明单位:</td>
					<td class="FieldInput" colspan="3"><label name="出具死亡证明单位"
						field="DEATH_CERT_ORG" dataset="deathCertOrganDS"></label>&nbsp;&nbsp;&nbsp;  
						<label name="出具死亡证明单位名称" field="DEATH_CERT_ORG_NAME"></label></td>

				</tr>
				<tr>
					<td class="FieldLabel" >备注:</td>
					<td class="FieldInput" colspan="5"><label
						lang="100" name="备注" style="width: 75%" field="NOTE" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>

</html>