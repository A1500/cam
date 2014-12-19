<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>城市社区基础设施情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcFacilitiesReportEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="fReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFacilitiesReport"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R06'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="ownPropertiesDataSet" enumName="CDC.OWN_PROPERTIES" global="true" autoLoad="true"  />
	<model:dataset id="buildPropertiesDataSet" enumName="CDC.BUILD_PROPERTIES" global="true" autoLoad="true"  />
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:36%">填报单位：</td>
			<td class="FieldInput" style="width:25%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:15%">填报日期：</td>
			<td class="FieldInput" ><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区基础设施情况</legend>
		<table border="1"  width="100%" >
	   		<tr>
	   			<td class="FieldLabel" rowspan="2" colspan="2">社区工作用房</td>
				<td class="FieldLabel" style="width:18%" colspan="2">社区工作用房数量：</td>
				<td class="FieldInput"><input type="text" name="社区工作用房数量" id="offNum" field="offNum" onchange="forcheck(this)"/>&nbsp;间 <font color="red">*</font></td>
				<td class="FieldLabel">社区工作用房建筑面积：</td>
				<td class="FieldInput"><input type="text" name="社区工作用房建筑面积" id="offArea" field="offArea" onchange="fordeccheck(this)" />&nbsp;平方米 <font color="red">*</font></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="投入使用年份" id="offYear" maxlength="4" field="offYear"/><font color="red">*</font></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" style="width:9%" rowspan="13">社区<br>服务<br>设施<br>用房</td>
	   			<td class="FieldLabel" style="width:9%" rowspan="2">社区服务大厅</td>
				<td class="FieldLabel" style="width:18%" colspan="2">社区服务大厅数量：</td>
				<td class="FieldInput"><input type="text" name="社区服务大厅数量" id="serviceNum" field="serviceNum" onchange="forcheck(this)"/>&nbsp;个 <font color="red">*</font></td>
				<td class="FieldLabel">社区服务大厅建筑面积：</td>
				<td class="FieldInput"><input type="text" name="社区服务大厅建筑面积" id="serviceArea" field="serviceArea" onchange="fordeccheck(this)" />&nbsp;平方米 <font color="red">*</font></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="投入使用年份" maxlength="4" id="serviceYear" field="serviceYear"/><font color="red">*</font></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区警务室</td>
				<td class="FieldLabel" colspan="2">社区警务室数量：</td>
				<td class="FieldInput"><input type="text" name="社区警务室数量" id="policeNum" field="policeNum" onchange="forcheck(this)"/>&nbsp;个 <font color="red">*</font></td>
				<td class="FieldLabel">社区警务室建筑面积：</td>
				<td class="FieldInput"><input type="text" name="社区警务室建筑面积" id="policeArea" field="policeArea" onchange="fordeccheck(this)" />&nbsp;平方米 <font color="red">*</font></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="投入使用年份" maxlength="4" id="policeYear" field="policeYear"/><font color="red">*</font></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区卫生室</td>
				<td class="FieldLabel" colspan="2">社区卫生室数量：</td>
				<td class="FieldInput"><input type="text" name="社区卫生室数量" id="clinicNum" field="clinicNum" onchange="forcheck(this)"/>&nbsp;个 <font color="red">*</font></td>
				<td class="FieldLabel">社区卫生室建筑面积：</td>
				<td class="FieldInput"><input type="text" name="社区卫生室建筑面积" id="clinicArea" field="clinicArea" onchange="fordeccheck(this)" />&nbsp;平方米 <font color="red">*</font></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="投入使用年份" maxlength="4" id="clinicYear" field="clinicYear"/><font color="red">*</font></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区图书室</td>
				<td class="FieldLabel" colspan="2">社区图书室数量：</td>
				<td class="FieldInput"><input type="text" name="社区图书室数量" id="libNum" field="libNum" onchange="forcheck(this)"/>&nbsp;个 <font color="red">*</font></td>
				<td class="FieldLabel">社区图书室建筑面积：</td>
				<td class="FieldInput"><input type="text" name="社区图书室建筑面积" id="libArea" field="libArea" onchange="fordeccheck(this)" />&nbsp;平方米 <font color="red">*</font></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="投入使用年份" maxlength="4" id="libYear" field="libYear"/><font color="red">*</font></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区文娱活动室</td>
				<td class="FieldLabel" colspan="2">社区文娱活动室数量：</td>
				<td class="FieldInput"><input type="text" name="社区文娱活动室数量" id="actionNum" field="actionNum" onchange="forcheck(this)"/>&nbsp;个 <font color="red">*</font></td>
				<td class="FieldLabel">社区文娱活动室建筑面积：</td>
				<td class="FieldInput"><input type="text" name="社区文娱活动室建筑面积" id="actionArea" field="actionArea" onchange="fordeccheck(this)" />&nbsp;平方米 <font color="red">*</font></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="投入使用年份" maxlength="4" id="actionYear" field="actionYear"/><font color="red">*</font></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区残疾人活动室</td>
				<td class="FieldLabel" colspan="2">社区残疾人活动室数量：</td>
				<td class="FieldInput"><input type="text" name="社区残疾人活动室数量" id="handNum" field="handNum" onchange="forcheck(this)"/>&nbsp;个 <font color="red">*</font></td>
				<td class="FieldLabel">社区残疾人活动室建筑面积：</td>
				<td class="FieldInput"><input type="text" name="社区残疾人室建筑面积" id="handArea" field="handArea" onchange="fordeccheck(this)" />&nbsp;平方米 <font color="red">*</font></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="投入使用年份" maxlength="4" id="handYear" field="handYear"/><font color="red">*</font></td>
			</tr>
			<tr>
	   			<td class="FieldLabel">其他</td>
				<td class="FieldLabel" colspan="2">其他用房数量：</td>
				<td class="FieldInput"><input type="text" name="其他用房数量" id="otherNum" field="otherNum" onchange="forcheck(this)"/>&nbsp;处 <font color="red">*</font></td>
				<td class="FieldLabel">其他用房建筑面积：</td>
				<td class="FieldInput"><input type="text" name="其他用房建筑面积" id="otherArea" field="otherArea" onchange="fordeccheck(this)" />&nbsp;平方米 <font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" rowspan="3">社区工作用房、</br>社区服务设施用房 </td>
				<td class="FieldLabel" colspan="2">投入资金：</td>
				<td class="FieldInput" colspan="3"><label id="offMon" field="offMon" renderer="reRender" /></td>
			</tr>
			<tr>	
				<td class="FieldLabel" rowspan="2" >资金来源</td>
				<td class="FieldLabel">财政拨款：</td>
				<td class="FieldInput"><input type="text" name="财政拨款" id="offFinanceMon" field="offFinanceMon" onchange="fordecimalcheck(this)"/>&nbsp;万元<font color="red">*</font></td>
				<td class="FieldLabel" width="15%;">自筹：</td>
				<td class="FieldInput"><input type="text" name="自筹" id="offSelfMon" field="offSelfMon"  onchange="fordecimalcheck(this)"/>&nbsp;万元 <font color="red">*</font></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >社会捐助：</td>
				<td class="FieldInput"><input type="text" name="社会捐助" id="offEndowMon" field="offEndowMon" onchange="fordecimalcheck(this)"/>&nbsp;万元<font color="red">*</font></td>
				<td class="FieldLabel">其他：</td>
				<td class="FieldInput"><input type="text" name="其他" id="offOtherMon" field="offOtherMon" onchange="fordecimalcheck(this)"/>&nbsp;万元<font color="red">*</font></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="4" colspan="2">社区室外活动场地</td>
				<td class="FieldLabel" colspan="2">社区室外活动场地数量：</td>
				<td class="FieldInput"><input type="text" name="社区室外活动场地数量" id="outNum" field="outNum" onchange="forcheck(this)"/>&nbsp;个 <font color="red">*</font></td>
				<td class="FieldLabel">社区室外活动场地建筑面积：</td>
				<td class="FieldInput"><input type="text" name="社区室外活动场地筑面积" id="outArea" field="outArea" onchange="fordeccheck(this)" />&nbsp;平方米 <font color="red">*</font></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">社区室外活动场地投入资金：</td>
				<td class="FieldInput"><label name="社区室外活动场地投入资金" id="outMon" field="outMon" renderer="reRender"/></td>
				<td class="FieldLabel">投入使用年份：</td>
				<td class="FieldInput"><input type="text" name="投入使用年份" maxlength="4" id="outYear" field="outYear"/><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" rowspan="2">资金来源</td>
				<td class="FieldLabel">财政拨款：</td>
				<td class="FieldInput"><input type="text" name="财政拨款" id="outFinanceMon" field="outFinanceMon" onchange="fordecimalcheck(this)"/>&nbsp;万元<font color="red">*</font></td>
				<td class="FieldLabel" width="15%;">自筹：</td>
				<td class="FieldInput"><input type="text" name="自筹" id="outSelfMon" field="outSelfMon"  onchange="fordecimalcheck(this)"/>&nbsp;万元 <font color="red">*</font></td>
			</tr>
	   		<tr>
				<td class="FieldLabel">社会捐助：</td>
				<td class="FieldInput"><input type="text" name="社会捐助" id="outEnbowMon" field="outEnbowMon" onchange="fordecimalcheck(this)"/>&nbsp;万元<font color="red">*</font></td>
				<td class="FieldLabel">其他：</td>
				<td class="FieldInput"><input type="text" name="其他" id="outOtherMon" field="outOtherMon" onchange="fordecimalcheck(this)"/>&nbsp;万元<font color="red">*</font></td>
			</tr>
		</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>