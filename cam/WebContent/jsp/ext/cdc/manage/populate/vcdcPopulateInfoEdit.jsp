<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>社区人口状况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcPopulateInfoEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="populateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPopulateInfoQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPopulateInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R01'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="populateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>人口状况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" rowspan="5">人口状况</td>
			<td class="FieldLabel" style="width:13%">总户数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "总户数" id="populateNum" field="populateNum" maxlength="30" onchange="forcheck(this)" />&nbsp;户</td>
			<td class="FieldLabel" style="width:13%">总人口数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "总人口数" id="peopleNum" field="peopleNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel" style="width:13%">其中：女性</td>
			<td class="FieldInput" style="width:15%" ><input type="text" name = "总人口数中女性人口数" id="femaleNum" field="femaleNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">常住人口户数：</td>
			<td class="FieldInput"><input type="text" name = "常住人口户数" id="residePopulateNum" field="residePopulateNum" maxlength="30" onchange="forcheck(this)" />&nbsp;户</td>
			<td class="FieldLabel">常住人口数：</td>
			<td class="FieldInput"><input type="text" name = "常住人口数" id="residePeopleNum" field="residePeopleNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">其中：女性</td>
			<td class="FieldInput"><input type="text" name = "常住人口中女性人口数" id="resideFemaleNum" field="resideFemaleNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">户籍人口数：</td>
			<td class="FieldInput"><input type="text" name = "户籍人口数" id="registeNum" field="registeNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">持居住证人口数：</td>
			<td class="FieldInput"><input type="text" name = "流动人口数" id="floatingNum" field="floatingNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">流动人口数：</td>
			<td class="FieldInput"><input type="text" name = "流动人口数" id="outsideNum" field="outsideNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">农业人口数：</td>
			<td class="FieldInput"><input type="text" name = "农业人口数" id="farmingNum" field="farmingNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">非农业人口数：</td>
			<td class="FieldInput" colspan="3" ><input type="text" name = "非农业人口数" id="nonFarmingNum" field="nonFarmingNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">18岁以下人数：</td>
			<td class="FieldInput"><input type="text" name = "18岁以下人数" id="pipiEgihteenNum" field="pipiEgihteenNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">60岁以上人数：</td>
			<td class="FieldInput" colspan="3" ><input type="text" name = "60岁以上人数" id="pipiSixtyNum" field="pipiSixtyNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
		</tr>
	</table>
</fieldset>
<fieldset name = "" id="cdcFieldset">
<legend>人户情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" >人在户在</td>
			<td class="FieldLabel">总人数：</td>
			<td class="FieldInput"><input type="text" name = "人在户在总人数" id="pipiNum" field="pipiNum" onchange="forcheck(this)" maxlength="30" />&nbsp;人</td>
			<td class="FieldLabel">其中：女性</td>
			<td class="FieldInput" colspan="3" ><input type="text" name = "人在户在女性人数" id="pipiFemaleNum" field="pipiFemaleNum" onchange="forcheck(this)" maxlength="30" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%" >人在户不在</td>
			<td class="FieldLabel">总人数：</td>
			<td class="FieldInput"><input type="text" name = "人在户不在总人数" id="pipoNum" field="pipoNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">其中：女性</td>
			<td class="FieldInput" colspan="3"><input type="text" name = "人在户不在女性人数" id="pipoFemaleNum" field="pipoFemaleNum" onchange="forcheck(this)" maxlength="30" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="text-align:center;width:18%">户在人不在</td>
			<td class="FieldLabel">总人数：</td>
			<td class="FieldInput"><input type="text" name = "户在人不在总人数" id="popiNum" field="popiNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">其中：女性</td>
			<td class="FieldInput" colspan="3"><input type="text" name = "户在人不在女性人数" id="popiFemaleNum" field="popiFemaleNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
		</tr>
	</table>
</fieldset>
<fieldset name = "" id="cdcFieldset">
<legend>其他情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">党员数：</td>
			<td class="FieldInput" colspan="5"><input type="text" name = "党员人数" id="partyNum" field="partyNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:13%">低保户数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "低保户数" id="lowestSafeguardNum" field="lowestSafeguardNum" onchange="forcheck(this)" maxlength="30" />&nbsp;户</td>
			<td class="FieldLabel" style="width:13%">五保户数：</td>
			<td class="FieldInput" style="width:14%"><input type="text" name = "五保户数" id="fiveSafeguardNum" field="fiveSafeguardNum" onchange="forcheck(this)" maxlength="30" />&nbsp;户</td>
			<td class="FieldLabel" style="width:13%">残疾人数：</td>
			<td class="FieldInput" style="width:15%"><input type="text" name = "残疾人数" id="handicappedNum" field="handicappedNum" onchange="forcheck(this)" maxlength="30" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">三无人员数：</td>
			<td class="FieldInput"><input type="text" name = "三无人员数" id="threeNoNum" field="threeNoNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">优抚对象人数：</td>
			<td class="FieldInput"><input type="text" name = "优抚对象人数" id="preferentialNum" field="preferentialNum" onchange="forcheck(this)" maxlength="30" />&nbsp;人</td>
			<td class="FieldLabel">失业人员数：</td>
			<td class="FieldInput"><input type="text" name = "失业人员数" id="loseWorkNum" field="loseWorkNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">在社区交纳养老保险人数：</td>
			<td class="FieldInput"><input type="text" name = "交纳养老保险人数" id="agedInsuranceNum" field="agedInsuranceNum" onchange="forcheck(this)" maxlength="30" />&nbsp;人</td>
			<td class="FieldLabel">离退休人数：</td>
			<td class="FieldInput"><input type="text" name = "离退休人数" id="retireNum" field="retireNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">返乡大学生人数：</td>
			<td class="FieldInput"><input type="text" name = "返乡大学生人数" id="backStudentNum" field="backStudentNum" onchange="forcheck(this)" maxlength="30" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">外籍人员人数：</td>
			<td class="FieldInput"><input type="text" name = "外籍人员人数" id="foreignerNum" field="foreignerNum" onchange="forcheck(this)" maxlength="30" />&nbsp;人</td>
			<td class="FieldLabel">归侨归眷人数：</td>
			<td class="FieldInput"><input type="text" name = "归侨归眷人数" id="backNum" field="backNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">未就业大学生人数：</td>
			<td class="FieldInput"><input type="text" name = "未就业大学生人数" id="nojobStudentNum" field="nojobStudentNum" onchange="forcheck(this)" maxlength="30" />&nbsp;人</td>
		</tr>
		<tr>
			<td class="FieldLabel">社区矫正对象人数：</td>
			<td class="FieldInput"><input type="text" name = "社区矫正对象人数" id="correctNum" field="correctNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">禁毒对象人数：</td>
			<td class="FieldInput"><input type="text" name = "禁毒对象人数" id="drugNum" field="drugNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
			<td class="FieldLabel">反邪教重点对象人数：</td>
			<td class="FieldInput"><input type="text" name = "反邪教重点对象人数" id="heresyNum" field="heresyNum" maxlength="30" onchange="forcheck(this)" />&nbsp;人</td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>