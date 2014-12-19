<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%
SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
String date=sdf.format(new Date());
%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>民 办 非 企 业 单 位 </title>
<next:ScriptManager/>
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	somJxCheckPartyDataSet.setParameter("TASK_CODE", taskCode);
	somJxCheckPartyDataSet.load();
	somJxCheckPartyDataSet.on('load',function (){
		if(somJxCheckPartyDataSet.getCount() == 0){
			somJxCheckPartyDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createUngovEditSelect();
}
function save(){
	var somJxCheckPartyRecord=somJxCheckPartyDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxCheckPartyRecord",somJxCheckPartyRecord);
	command.execute("savePage6");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
</script>
<style>

</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxCheckPartyDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckparty.cmd.SomJxCheckPartyQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckparty.dao.SomJxCheckParty"></model:record>
	</model:dataset>
	<!-- 党建形式 -->
	<model:dataset id="partyBuildTypeDataset" enumName="SORG.PARTY.BUILDTYPE.CODE" global="true" 
	autoLoad="true">
	</model:dataset>
	<!-- 党组织（党建联络员）隶属关系 -->
	<model:dataset id="partyRelationDataset" enumName="SORG.PARTY.RELATION.CODE" global="true" 
	autoLoad="true">
	</model:dataset>
	<!-- 党组织负责人（党建联络员） -->
	<model:dataset id="partyResponsibleDataset" enumName="SORG.PARTY.RESPONSIBLE.CODE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 未建党组织 -->
	<model:dataset id="noPartyReasonDataset" enumName="SORG.PARTY.NOREASON.CODE" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
<div id="float" >
<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPageM('5')"/>
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPageM('7')"/>
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="save();"/>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="backM();"/>
</div>
<form method="post"onsubmit="return false" dataset="somJxCheckPartyDataSet">	
<div style="width:800;position:absolute;left:expression((body.clientWidth-800)/2);">
<div class=Section1 style='layout-grid: 15.6pt'>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>四、党建情况：<span
	lang=EN-US><o:p></o:p></span></span></b></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（一）从业人员中党员总数<u><span
	lang=EN-US></span></u>
<input type="text" field="practitionerNum" name="从业人员中党员总数"/>
	人，其中专职人员中党员数<u><span lang=EN-US></span></u>
<input type="text" field="fullTimeNum" name="专职人员中党员数"/>	
	人。<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'><span
	style='mso-spacerun: yes'>&nbsp; </span></span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>党组织关系在本社会组织的党员数<u><span
	lang=EN-US></span></u>
<input type="text" field="insideMemberNum" name="党组织关系在本社会组织的党员数"/>	
	人，本年度发展新党员<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><u><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'></span></u><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>
<input type="text" field="newPartyPeople" name="本年度发展新党员"/>	
	人。<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='line-height: 24.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>（二）党组织情况：<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>1</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>、党建形式：
<select  field="partyType"  name="党建形式"><option dataset = "partyBuildTypeDataset" > </select>
	<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>2</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>、党组织（党建联络员）隶属关系：
<select field="partyRelationType" name="党组织（党建联络员）隶属关系"><option dataset = "partyRelationDataset" > </select>
	<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>3</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>、党组织负责人（党建联络员）：
<select field="partyPeopleType" name="党组织负责人（党建联络员）"><option dataset = "partyResponsibleDataset" > </select>
	<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312'>4、未建立党组织原因：
<select field="reason" name='未建立党组织原因'><option dataset = "noPartyReasonDataset" > </select>
	</span></p>

<p class=MsoNormal
	style='text-indent: 42.0pt; mso-char-indent-count: 3.0; line-height: 24.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体'>*</span><span
	style='font-size: 14.0pt; mso-bidi-font-size: 12.0pt; font-family: 黑体'>党建形式选“无”的单位填写问题<span
	lang=EN-US>4</span>，其他单位填写问题<span lang=EN-US>2</span>、<span lang=EN-US>3</span>。<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</div>
</form>
</body>
</html>
