<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>家庭成员基本信息</title>
<next:ScriptManager/>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript">
var peopleId = '<%=request.getParameter("peopleId")%>' ;
function init(){
	baseinfoPeopleDataSet.setParameter("PEOPLE_ID",peopleId);
	baseinfoPeopleDataSet.load();
	baseinfoPeopleDataSet.on('load',loadSamPeopleExtendDataSet);	
}
//加载成员扩展信息
function loadSamPeopleExtendDataSet(ds){
	ds.un("load",loadSamPeopleExtendDataSet);
	var record=ds.getCurrent();		
	//回填年龄
	$("age").innerHTML=getAgeByCode(record.get("idCard"));
	synPhotoDetail(record.get("photoId"),"1");	
	
	samPeopleExtendDataSet.setParameter("PEOPLE_ID",peopleId);
	samPeopleExtendDataSet.load();
	samPeopleExtendDataSet.on('load',loadSamPeopleDiseaseDataSet);
}
//加载疾病信息
function loadSamPeopleDiseaseDataSet(ds){
	ds.un("load",loadSamPeopleDiseaseDataSet);
	if(ds.getCount()>0){
		$('selfCareAbility').innerHTML=getDicText(selfCareAbilityDataset,ds.get('selfCareAbility'));
		$('isAssistance').innerHTML=getDicText(comm_yesorno,ds.get('isAssistance'));
		$('peopleTypeName').innerHTML=ds.get('peopleTypeName');
	}
	
	samPeopleDiseaseDataSet.setParameter("PEOPLE_ID",peopleId);
	samPeopleDiseaseDataSet.load();
	samPeopleDiseaseDataSet.on('load',loadSamPeopleDisabilityDataSet);
}
//加载残疾信息
function loadSamPeopleDisabilityDataSet(ds){
	ds.un("load",loadSamPeopleDisabilityDataSet);
	if(ds.getCount()>0){
		$('diseaseType').innerHTML=getDicText(diseaseTypeDataset,ds.get('diseaseType'));
	}
	
	samPeopleDisabilityDataSet.setParameter("PEOPLE_ID",peopleId);
	samPeopleDisabilityDataSet.load();
	samPeopleDisabilityDataSet.on('load',loadSamPeopleEduDataSet);
}
//加载教育信息
function loadSamPeopleEduDataSet(ds){
	ds.un("load",loadSamPeopleEduDataSet);
	if(ds.getCount()>0){
		$('disabilityType').innerHTML=getDicText(disabilityTypeDataset,samPeopleDisabilityDataSet.get('disabilityType'));
		$('disabilityLevel').innerHTML=getDicText(DmCjdjDataSet,samPeopleDisabilityDataSet.get('disabilityLevel'));
	}
	
	samPeopleEduDataSet.setParameter("PEOPLE_ID",peopleId);
	samPeopleEduDataSet.load();
	samPeopleEduDataSet.on('load',loadDataSet);
}
//加载
function loadDataSet(ds){
	ds.un("load",loadDataSet);
	if(ds.getCount()>0){
		$('eduStatus').innerHTML=getDicText(eduStatusDataset,ds.get('eduStatus'));
	}else{
		ds.newRecord();
	}
}
//关闭窗口
function closePeople(){
	window.close();
}
//字典表解析
function getDicText(dicDataSet,value){
	for (var i=0;i<dicDataSet.getTotalCount();i++){
		var record = dicDataSet.getAt(i);
		if(dicDataSet.getAt(i).get('value')==value){
			return record.get('text');
		}
	}
	return "";
}		
</script>
</head>
<body>
<model:datasets>
	<!-- 家庭成员基本信息 -->
	<model:dataset id="baseinfoPeopleDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		</model:record>
	</model:dataset>
	<!-- 人员类型 -->
	<model:dataset id="peopleTypeDataset" cmd="com.inspur.cams.drel.sam.cmd.SamPeopleTypeQueryCmd"	global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleType"></model:record>
	</model:dataset>	
	<!-- 人员扩展信息（低保用） -->
	<model:dataset id="samPeopleExtendDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamPeopleExtendQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleExtend"></model:record>
	</model:dataset>
	<!-- 家庭成员教育信息 -->
	<model:dataset id="samPeopleEduDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamPeopleEduCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleEdu">
		</model:record>
	</model:dataset>
	<!-- 人员患病信息 -->
	<model:dataset id="samPeopleDiseaseDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamPeopleDiseaseCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleDisease"></model:record>
	</model:dataset>
	<!-- 人员残疾信息 -->
	<model:dataset id="samPeopleDisabilityDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamPeopleDisabilityCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleDisability"></model:record>
	</model:dataset>
	<model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmMzDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
		</model:params>
	</model:dataset>
	<!-- 婚姻状况-->
	<model:dataset id="DmHyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
   <model:dataset id="DmZyDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
		</model:params>
	</model:dataset>
	<!-- 生活自理能力 -->
	<model:dataset id="selfCareAbilityDataset" enumName="SAM_SELF_CARE_ABILITY" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 重病病种 -->
	<model:dataset id="diseaseTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_sam_disease_type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾类别 -->
	<model:dataset id="disabilityTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾等级 -->
	<model:dataset id="DmCjdjDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HANDICAP_LEVEL'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmHjxzDataSet" enumName="SAM_DOMICILE_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度-->
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
		</model:params>
	</model:dataset>
	<!-- 学业状况 -->
	<model:dataset id="eduStatusDataset" enumName="SAM_EDU_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 与户主关系 -->
	 <model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="medicalStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MEDICAL_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="assistanceTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<!-- 人员分类救助类别 -->
	<model:dataset id="traditonTypeDataset" enumName="SAM_TRADITON_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 单位性质 -->
	<model:dataset id="unitNatureDataset" enumName="SAM_UNIT_NATURE" autoLoad="true" global="true"></model:dataset>
	<!-- 隶属关系 -->
	<model:dataset id="affiliationDataset" enumName="SAM_AFFILIATION" autoLoad="true" global="true"></model:dataset>
	<!-- 学校类别 -->
	<model:dataset id="schoolTypeDataset" enumName="SAM_SCHOOL_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<!-- 人员录入窗口 -->
<next:Panel id="peopleWin" title="" height="522" width="1000" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closePeople"></next:ToolBarItem>		
	</next:TopBar>
	<next:Panel title="家庭成员基本信息" titleCollapse="true" collapsible="true">
	<next:Html>
		<form id="BaseinfoPeopleForm" method="post" dataset="baseinfoPeopleDataSet" onsubmit="return false"
			 class="L5form">
		<table border="0" width="100%">
		<tr>
			<td class="FieldLabel" width="10%">姓名</td>
			<td class="FieldInput" width="15%"><label field="name" /></td>
			<td class="FieldLabel" width="10%">身份证号码</td>
			<td class="FieldInput" width="15%"><label field="idCard" /></td>
			<td class="FieldLabel" width="10%">性别</td>
			<td class="FieldInput" width="15%"><label field="sex" dataset="sexDataset" /></td>
			<td class="FieldInput" width="10%" rowspan="4">
				<div id="photoDiv1">
					<img id="img1" name="RELATIONER_PHOTOC_IMG1" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
						align="top" ondblclick="editPhoto(11,'photoId1','RELATIONER_PHOTOC_IMG1');"
						onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
					<input type="hidden" id="photoId1" name="photoId1"/>
				</div>
			</td>
			</tr>
			<tr>
				<td class="FieldLabel">出生日期</td>
				<td class="FieldInput"><label field="birthday"></label></td>
				<td class="FieldLabel">年龄</td>
				<td class="FieldInput"><label id="age"></label></td>
				<td class="FieldLabel">民族</td>
				<td class="FieldInput"><label field="nation" dataset="DmMzDataSet" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">婚姻状况</td>
				<td class="FieldInput"><label field="marriageCode" dataset="DmHyzkDataSet" /></td>
				<td class="FieldLabel">政治面貌</td>
				<td class="FieldInput"><label field="politicalCode" dataset="DmZzmmDataSet" /></td>
				<td class="FieldLabel">户籍类别</td>
				<td class="FieldInput"><label field="domicileType" dataset="DmHjxzDataSet" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">生活自理能力</td>
				<td class="FieldInput"><label id="selfCareAbility" /></td>
				<td class="FieldLabel">健康状况</td>
				<td class="FieldInput"><label field="healthCode" dataset="healthCodeDataset" /></td>
				<td class="FieldLabel">重病病种</td>
				<td class="FieldInput"><label id="diseaseType" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">是否供养对象</td>
				<td class="FieldInput"><label id="isAssistance" /></td>
				<td class="FieldLabel">残疾类别</td>
				<td class="FieldInput"><label id="disabilityType" /></td>
				<td class="FieldLabel">残疾等级</td>
				<td class="FieldInput" colspan="2"><label id="disabilityLevel" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">学业状况</td>
				<td class="FieldInput"><label id="eduStatus" /></td>
				<td class="FieldLabel">文化程度</td>
				<td class="FieldInput"><label field="eduCode" dataset="eduDataSet" /></td>
				<td class="FieldLabel">与户主关系</td>
				<td class="FieldInput" colspan="2"><label field="relationshipType" dataset="relationshipTypeDataset" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">参保类型</td>
				<td class="FieldInput"><label
					field="safeguardType"  dataset="medicalStatusSelect"/> </td>
				<td class="FieldLabel">医疗证号</td>
				<td class="FieldInput"><label field="medicalCode" /></td>
				<td class="FieldLabel">户籍地址</td>
				<td class="FieldInput" colspan='2'><label field="apanageName" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">备注</td>
				<td class="FieldInput" colspan="6"><textarea name="备注" title="备注"  rows="4" style="width:93.5%" field='note' readonly></textarea></td>
			</tr>
			<tr style='display:none'>
				<td class="FieldLabel" style="width: 15%">人员类型</td>
				<td class="FieldInput" style="width: 18%" colspan="6">
					<label id="peopleTypeName" ></label>
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
	</next:Panel>
	<next:Panel title="家庭成员教育信息" titleCollapse="true" collapsible="true"  >
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form" dataset='samPeopleEduDataSet'>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:10%">在读学校名称</td>
						<td class="FieldInput" colspan='3'><label field="school" /></td>
						<td class="FieldLabel" style="width:10%">学校类别</td>
						<td class="FieldInput" style="width:15%"><label field="schoolType" dataset='schoolTypeDataset' /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">联系人</td>
						<td class="FieldInput" style="width:15%"><label field='conectPeople' /></td>
						<td class="FieldLabel" style="width:10%">联系电话</td>
						<td class="FieldInput" style="width:15%"><label field='conectPhone' /></td>
						<td class="FieldLabel" style="width:10%">入学时间</td>
						<td class="FieldInput" style="width:25%"><label field='entranceDate' /></td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Panel>
</body>
</html>