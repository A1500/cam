<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
</script>
<style>
.label3 {
	text-align:center;
	border-bottom: solid 1px black;
	font-size: 14.0pt;
	font-family: 仿宋;
}
</style>
<model:datasets>
	<model:dataset id="somCheckDataSet"
		cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="dutySelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_UNGOV_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessTypeSelect"
		enumName="JXSOM.UNGOV.BUSINESS_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float_1" class="noprint">

</div>
<div align=center style='page-break-after: always'>
<div align=left style="margin-top: 60px;width: 700px">

<p class=MsoNormal
	><b><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>一、基本情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<form method="post" dataset="somCheckDataSet" onsubmit="return false">
<table style='layout-grid:10.6pt;width: 700px;'>
<tr>
<td>
<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>单位名称
<label field="cnName" style="width: 400" class='label3'></label></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>业务主管单位
<label field="borgName" style="width: 400" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span><o:p></o:p></span></u></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>登记日期
<label field="downDate" style="width: 150" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span></span></u>证书有效期 <label
	field="certUsefulDate" style="width: 150" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span></span>（证书已过期）<span
	lang=EN-US><o:p></o:p></span></u></span></p>

<p class=MsoNormal
	><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 黑体'>*</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 黑体'>凡证书有效期已过期的，请速来我局办理相关手续。</span><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体'><o:p></o:p></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>开办资金
<label field="initialFund" style="width: 300" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'></span></span></u>万元人民币<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>行业类型
<label field="businessType" style="width: 150"
	dataset="businessTypeSelect" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'></span></span></u> <span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>单位性质
<label field="sorgKind" style="width: 150" dataset='sorgKindSelect'
	class='label3'></label> <u><span lang=EN-US><span
	style='mso-spacerun: yes'></span></span></u> <span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>住所
<label field="residence" style="width: 400" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span><o:p></o:p></span></u></span></p>

<p class=MsoNormal
	><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 黑体'>*</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 黑体'>未办理住所变更手续的，请速来我局办理相关手续</span><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体'><o:p></o:p></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>邮编
<label field="sorgPost" style="width: 300" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span></span></u></span><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 10.5pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>联系人
<label field="linkmanName" style="width: 150" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'></span></span></u> <span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;</span></span>职务 
	<label field="linkmanDuty" dataset="dutySelect"  class='label3'></label>
	<u><span lang=EN-US><span style='mso-spacerun: yes'></span></span></u>手机
<label field="linkmanMobile" style="width: 150" class='label3'></label>
<u><span lang=EN-US><span style='mso-spacerun: yes'></span></span></u> <span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>电子邮件
<label field="sorgEmail" style="width: 400" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'> </span></span></u><span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>
联系电话 <label field="sorgPhone" style="width: 150" class='label3'></label>
<u><span lang=EN-US><span style='mso-spacerun: yes'></span></span></u> <span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp;&nbsp;</span></span>
单位传真 <label field="sorgFax" style="width: 150" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'></span><o:p></o:p></span></u></span></p>

<p class=MsoNormal
	><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋; mso-hansi-font-family: 仿宋'>单位网址
<label field="sorgWeb" style="width: 400" class='label3'></label> <u><span
	lang=EN-US><span style='mso-spacerun: yes'></span><o:p></o:p></span></u></span></p>
</td>
</tr>
</table>
</form>
</div>