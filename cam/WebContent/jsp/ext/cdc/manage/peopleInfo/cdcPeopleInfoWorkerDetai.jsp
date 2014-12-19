<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%
	String username = ExtBspInfo.getUserInfo(request).getUserName();
	String organType = ExtBspInfo.getUserInfo(request).getOrganType();
	String communityType = ExtBspInfo.getUserInfo(request).getCommunityType();
	String ifVillage = ExtBspInfo.getUserInfo(request).getIfVillage();
	boolean cityFlag = true;
	boolean villageFlag = true;
	if ("JD".equals(organType)) {
		cityFlag = true;
		villageFlag = true;
	} else {
		if ("C".equals(communityType)) {
			cityFlag = true;
			villageFlag = false;
		} else if ("N".equals(communityType)) {
			cityFlag = false;
			villageFlag = true;
		}
	}
%>
<html>
<head>
<title>社工组织成员信息</title>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var peopleId='<%=request.getParameter("peopleId")%>';
	function init(){
		var cdcPeopleInfoDataSet=L5.DatasetMgr.lookup("cdcPeopleInfoDataSet");
		cdcPeopleInfoDataSet.setParameter("PEOPLE_ID@=",peopleId);
		cdcPeopleInfoDataSet.load();
	}
	function returnBack(){
		history.go(-1);
	}
	function yRender(val){
		if(val!=""){
			return val+" 元";
		}
    }
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcPeopleInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleInfo"/>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 职务类型 -->
	<model:dataset id="dutyTypeDataSet" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
	<!-- 身份 -->
	<model:dataset id="identityDataSet" enumName="CDC.IDENTITY" autoLoad="true" global="true"/>
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<!-- 政治面貌 -->
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<!-- 文化程度 -->
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<!-- 职业资格等级 -->
	<model:dataset id="career_level" enumName="CDC.CAREER_LEVEL" autoLoad="true" global="true"/>
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
</model:datasets>
<next:Panel width="99%"  autoScroll="true" >
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcPeopleInfoDataSet" onsubmit="return false" class="L5form"  >
<fieldset >
	<legend>社工组织成员信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">姓名：</td>
			<td class="FieldInput" style="width:36%"><label name="姓名" id="name" field="name"  /></td>
			<td class="FieldLabel" style="width:18%">身份证件号码：</td>
			<td class="FieldInput" style="width:36%"><label name="身份证件号码" id="idCard" field="idCard"  /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">性别：</td>
			<td class="FieldInput" style="width:36%"><label name="性别" id="sex" field="sex"  dataset = "sexDataSet"/></td>
			<td class="FieldLabel" style="width:18%">出生日期：</td>
			<td class="FieldInput" style="width:36%"><label name="出生日期" id="birthday" field="birthday" onclick="LoushangDate(this)" format="Y-m-d" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">文化程度：</td>
			<td class="FieldInput" style="width:36%"><label name="文化程度" id="eduCode" field="eduCode"  dataset = "educationDataSet"/></td>
			<td class="FieldLabel" style="width:18%">政治面貌：</td>
			<td class="FieldInput" style="width:36%"><label name="政治面貌" id="politicalCode" field="politicalCode"  dataset = "politicalDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">民族：</td>
			<td class="FieldInput" style="width:36%"><label  name="民族" id="nation" field="nation"  dataset = "NationDataset"/></td>
			<td class="FieldLabel" style="width:18%">身份：</td>
			<td class="FieldInput" style="width:36%"><label  name="身份" id=identity field="identity"  dataset = "identityDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">家庭住址：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><label name="家庭住址" id="address" field="address"  style="width:93%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">联系电话：</td>
			<td class="FieldInput" style="width:36%"><label name="联系电话" id="tel" field="tel"  /></td>
			<td class="FieldLabel" style="width:18%">邮政编码：</td>
			<td class="FieldInput" style="width:36%"><label name="邮政编码" id="postCode" field="postCode"  /></td>
		</tr>
		<% if(cityFlag){ %>
		<tr>
			<td class="FieldLabel" style="width:18%">是否享有养老保险：</td>
			<td class="FieldInput" style="width:36%"><label name="是否享有养老保险" id="ifAgedInsurance" field="ifAgedInsurance"  dataset ="YorN"/>  </td>
			<td class="FieldLabel" style="width:18%">是否享有医疗保险：</td>
			<td class="FieldInput" style="width:36%"><label name="是否享有医疗保险" id="ifMedicalInsurance" field="ifMedicalInsurance"  dataset ="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">是否享有工伤保险：</td>
			<td class="FieldInput" style="width:36%"><label name="是否享有工伤保险" id="ifInjuryInsurance" field="ifInjuryInsurance"  dataset ="YorN"/></td>
			<td class="FieldLabel" style="width:18%">是否享有失业保险：</td>
			<td class="FieldInput" style="width:36%"><label name="是否享有失业保险" id="ifUnemployInsurance" field="ifUnemployInsurance" dataset ="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">是否享有生育保险：</td>
			<td class="FieldInput" style="width:36%"><label name="是否享有生育保险" id="ifBirthInsurance" field="ifBirthInsurance" dataset ="YorN"/></td>
			<td class="FieldLabel" style="width:18%">是否享有住房公积金：</td>
			<td class="FieldInput" style="width:36%"><label name="是否享有住房公积金" id="ifHousingReserve" field="ifHousingReserve" dataset ="YorN"/></td>
		</tr>
		<% } %>
		<tr>
			<td class="FieldLabel" style="width:18%">是否具备社会工作职业资格：</td>
			<td class="FieldInput" style="width:36%"><label id="ifWorker" field="ifWorker" dataset ="YorN"/></td>
			<td class="FieldLabel" style="width:18%">职业资格等级：</td>
			<td class="FieldInput" style="width:36%"><label name="职业资格等级" id="careerLevel" field="careerLevel" dataset="career_level" /></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">月报酬：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><label name="月报酬" id="subsidyMon" field="subsidyMon" renderer="yRender" />&nbsp;元</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">个人简历：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><textarea  rows="3" disabled="disabled" field ="resume" style="width:93%"></textarea> </td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">备注：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><textarea rows="3" disabled="disabled" field ="note" style="width:93%"></textarea> </td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>