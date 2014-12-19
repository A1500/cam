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
<title>社区居委会成员信息</title>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcPeopleInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleInfo"/>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 职务类型 -->
	<model:dataset id="dutyTypeDataSet" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<!-- 政治面貌 -->
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<!-- 文化程度 -->
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
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
	<legend>基本信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">姓名：</td>
			<td class="FieldInput" style="width:36%"><label field="name"/></td>
			<td class="FieldLabel" style="width:18%">身份证件号码：</td>
			<td class="FieldInput" style="width:36%"><label field="idCard"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">性别：</td>
			<td class="FieldInput" style="width:36%"><label field="sex" dataset="sexDataSet"/></td>
			<td class="FieldLabel" style="width:18%">出生日期：</td>
			<td class="FieldInput" style="width:36%"><label field="birthday"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">民族：</td>
			<td class="FieldInput" style="width:36%"><label field="nation" dataset="NationDataset"/></td>
			<td class="FieldLabel" style="width:18%">任职届次：</td>
			<td class="FieldInput" style="width:36%"><label field="season"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">文化程度：</td>
			<td class="FieldInput" style="width:36%"><label field="eduCode" dataset="educationDataSet"/></td>
			<td class="FieldLabel" style="width:18%">政治面貌：</td>
			<td class="FieldInput" style="width:36%"><label field="politicalCode" dataset="politicalDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">职务：</td>
			<td class="FieldInput" style="width:36%"><label field="duty" dataset="dutyTypeDataSet"/></td>
			<td class="FieldLabel" style="width:18%">是否交叉任职：</td>
			<td class="FieldInput" style="width:36%"><label field="ifCross" dataset="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">家庭住址：</td>
			<td class="FieldInput" style="width:36%" colspan="3"><label field="address"/></td>
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
			<td class="FieldInput" style="width:36%"><label field="ifAgedInsurance"  dataset="YorN"/></td>
			<td class="FieldLabel" style="width:18%">是否享有医疗保险：</td>
			<td class="FieldInput" style="width:36%"><label field="ifMedicalInsurance"  dataset="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">是否享有失业保险：</td>
			<td class="FieldInput" style="width:36%"><label field="ifUnemployInsurance" dataset="YorN"/></td>
			<td class="FieldLabel" style="width:18%">是否享有工伤保险：</td>
			<td class="FieldInput" style="width:36%"><label field="ifInjuryInsurance"  dataset="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">是否享有生育保险：</td>
			<td class="FieldInput" style="width:36%"><label field="ifBirthInsurance" dataset="YorN"/></td>
			<td class="FieldLabel" style="width:18%">是否享有住房公积金：</td>
			<td class="FieldInput" style="width:36%"><label field="ifHousingReserve" dataset="YorN"/></td>
		</tr>
		<% } else {%>
		<tr>
			<td class="FieldLabel" style="width:18%">是否连选连任：</td>
			<td class="FieldInput" style="width:36%"><label field="ifReelected" dataset ="YorN" /></td>
			<td class="FieldLabel" style="width:18%">是否在物业服务企业兼职：</td>
			<td class="FieldInput" style="width:36%"><label field="ifPartTime" dataset ="YorN"/></td>
		</tr>
		<% }%>
		<tr>
		<% if(villageFlag) { %>
			<td class="FieldLabel" style="width:18%">是否是大学生村官：</td>
			<td class="FieldInput" style="width:36%"><label name="是否是大学生村官" id="ifOfficial" field="ifOfficial" dataset ="YorN"/></td>
			<td class="FieldLabel" style="width:18%">月报酬：</td>
			<td class="FieldInput" style="width:36%"><label name="月报酬" id="subsidyMon" field="subsidyMon" renderer="yRender" /></td>
		<% } else { %>
			<td class="FieldLabel" style="width:18%">月报酬：</td>
			<td class="FieldInput" style="width:36%" ><label name="月报酬" id="subsidyMon" field="subsidyMon" renderer="yRender" /></td>
			<td class="FieldLabel" style="width:18%">是否在物业服务企业兼职：</td>
			<td class="FieldInput" style="width:36%" ><label field="ifPartTime" dataset ="YorN" /></td>
		<% } %>
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