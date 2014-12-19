<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举选举程序信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var reportDate='<%=request.getParameter("reportDate")%>';
	var organC='<%=request.getParameter("organC")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="electionProgramDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionProgramQueryCmd" method="querySum" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionProgram"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="electionProgramDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>选举程序信息</legend>
	<table width="100%">
		<tr align="left">
			<td class="FieldLabel" style="width:13%">召开选举大会集中投票村委会个数：</td>
			<td class="FieldInput" style="width:14%"><label id="ifMeeting" field ="IFMEETING"/>  </td>
			<td class="FieldLabel" style="width:13%">设投票中心(站)村委会个数：</td>
			<td class="FieldInput" style="width:14%"><label id="ifStation" field ="IFSTATION"/>  </td>
			<td class="FieldLabel" style="width:13%">设秘密写票处村委会个数</td>
			<td class="FieldInput" style="width:15%"><label id="ifSecret" field ="IFSECRET"/>  </td>
		</tr>
		<tr align="left">
			<td class="FieldLabel">设流动投票箱村委会个数：</td>
			<td class="FieldInput"><label id="ifFlow" field ="IFFLOW"/>  </td>
			<td class="FieldLabel">公开唱票、计票村数村委会个数：</td>
			<td class="FieldInput"><label id="ifPublic" field ="IFPUBLIC"/>  </td>
			<td class="FieldLabel">当场公布选举结果村委会个数：</td>
			<td class="FieldInput"><label id="ifPublicResult" field ="IFPUBLICRESULT"/> </td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
 	var electionProgramDataSet=L5.DatasetMgr.lookup("electionProgramDataSet");
	electionProgramDataSet.setParameter("reportDate",reportDate);
	electionProgramDataSet.setParameter("ORGAN_CODE",organC);
	electionProgramDataSet.setParameter("REPORT_TYPE","N");
	electionProgramDataSet.load();
}
function undo(){
	var url = "jsp/ext/cdc/manage/elect/city/cdcElectionList.jsp";
	var data=new L5.Map();
	L5.forward(url,'',data);
}
</script>