<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="java.util.Date"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
	if (taskCode == null) {
		taskCode = IdHelp.getUUID32();
	}
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
			var taskCode='<%=taskCode%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var batch='<%=request.getParameter("batch")%>';
			var batchYear='<%=request.getParameter("batchYear")%>';
			var flag = "break";
		 	//初始化
			function init(){
				createGroupEditSelect();
			}
			function save(){
			
			}
			function nextPage(){
				if(save() == "break"){
					return;
				}
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/group/edit/groupJXCheckEdit7.jsp';
				data.put("taskCode",taskCode);
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function back(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/check/group/somchecktask/somchecktask_list.jsp';
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function checkData(){
				var checkRecord=somCheckDataSet.getCurrent();
				if(checkRecord.get('cnName').trim() == ''){
					L5.Msg.alert("提示","社会团体名称不能为空！");
					throw flag;
				}
				if(checkRecord.get('sorgCode').trim() == ''){
					L5.Msg.alert("提示","登记证号不能为空！");
					throw flag;
				}
			}
			function partyBuildTypeChanges(){
				var type = document.getElementById("partyBuildType").value;
				var partyRelation =document.getElementById("partyRelation");
				var partyResponsible =document.getElementById("partyResponsible");
				var noPartyReason =document.getElementById("noPartyReason");
				if(type==9){
					partyRelation.disabled = true;
					partyRelation.value = '';
					partyResponsible.disabled = true;
					partyResponsible.value = '';
					noPartyReason.disabled = false;
					noPartyReason.value = '';
				}else{
					partyRelation.disabled = false;
					partyRelation.value = '';
					partyResponsible.disabled = false;
					partyResponsible.value = '';
					noPartyReason.disabled = true;
					noPartyReason.value = '';
				}
			}
		</script>
<style>
</style>
</head>

<body>
<model:datasets>
	<!-- 是否 -->
	<model:dataset id="YorNDataset" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
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
<div id="float"><!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="下一页"
	style="height: 25px; width: 80px; position: absolute; margin-left: 20px;"
	onclick="nextPage()" /> <!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="保存"
	style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"
	onclick="save();" /> <!--[if lte IE 7]><div></div><![endif]--> <input
	type="button" value="返回"
	style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"
	onclick="back();" /></div>
<div class=Section1 style='layout-grid:15.6pt'>

<p class=MsoNormal style='text-indent:32.15pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt'><b><span style='font-size:16.0pt;font-family:黑体;
mso-hansi-font-family:宋体'>五、党建情况</span></b><b><span lang=EN-US
style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:"Times New Roman"'><o:p></o:p></span></b></p>

<p class=MsoNormal style='text-indent:32.0pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt;tab-stops:53.25pt'><span style='font-size:16.0pt;
font-family:仿宋_GB2312;mso-hansi-font-family:宋体;mso-bidi-font-weight:bold'>（一）从业人员中党员总数</span>
<span style='font-size:16.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:宋体;mso-bidi-font-weight:bold'><input type="text" style='font-size:14.0pt;font-family:
仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>人，其中专职人员中党员数</span>
<span style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'><input type="text" style='font-size:14.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>人。</span><span lang=EN-US style='font-size:16.0pt;
font-family:仿宋_GB2312;mso-bidi-font-weight:bold'><o:p></o:p></span></p>

<p class=MsoNormal style='text-indent:56.0pt;mso-char-indent-count:3.5;
mso-line-height-alt:12.0pt;tab-stops:53.25pt'><span style='font-size:16.0pt;
font-family:仿宋_GB2312;mso-hansi-font-family:宋体;mso-bidi-font-weight:bold'>党组织关系在本社会组织的党员数</span><span
class=GramE></span><span style='font-size:16.0pt;font-family:仿宋_GB2312;
mso-hansi-font-family:宋体;mso-bidi-font-weight:bold'><input type="text" style='font-size:14.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>人，本年度发展新党员</span><span
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'><input type="text" style='font-size:14.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>人。</span><span lang=EN-US style='font-size:16.0pt;
font-family:仿宋_GB2312;mso-bidi-font-weight:bold'><o:p></o:p></span></p>

<p class=MsoNormal style='text-indent:32.0pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt;tab-stops:53.25pt'><span style='font-size:16.0pt;
font-family:仿宋_GB2312;mso-hansi-font-family:宋体;mso-bidi-font-weight:bold'>（二）党组织情况：</span><span
lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312;mso-bidi-font-weight:
bold'><o:p></o:p></span></p>

<p class=MsoNormal style='text-indent:32.0pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt;tab-stops:53.25pt'><span lang=EN-US
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-bidi-font-weight:bold'>1</span><span
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>、党建形式：</span><span>
<select id="partyBuildType" style="font-size:14.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold" onchange="partyBuildTypeChanges()"><option dataset = "partyBuildTypeDataset" > </select></span></p>

<p class=MsoNormal style='text-indent:32.0pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt;tab-stops:53.25pt'><span lang=EN-US
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-bidi-font-weight:bold'>2</span><span
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>、党组织（党建联络员）隶属关系：</span><span>
<select id="partyRelation" style="font-size:14.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold"><option dataset = "partyRelationDataset" > </select></span></p>

<p class=MsoNormal style='text-indent:32.0pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt;tab-stops:53.25pt'><span lang=EN-US
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-bidi-font-weight:bold'>3</span><span
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>、党组织负责人（党建联络员）：</span><span>
<select id ="partyResponsible" style="font-size:14.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold"><option dataset = "partyResponsibleDataset" > </select></span></p>

<p class=MsoNormal style='text-indent:32.0pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt;tab-stops:53.25pt'><span lang=EN-US
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-bidi-font-weight:bold'>4</span><span
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>、未建立党组织原因：</span><span>
<select id ="noPartyReason"  style="font-size:14.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold"><option dataset = "noPartyReasonDataset" > </select></span></p>

<p class=MsoNormal style='text-indent:32.0pt;mso-char-indent-count:2.0;
mso-line-height-alt:12.0pt;tab-stops:53.25pt'><span lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312;
mso-bidi-font-weight:bold'>*</span><span style='font-size:16.0pt;font-family:
仿宋_GB2312;mso-hansi-font-family:宋体;mso-bidi-font-weight:bold'>党建形式选</span><span
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-bidi-font-weight:bold'>“</span><span
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>无</span><span style='font-size:16.0pt;font-family:
仿宋_GB2312;mso-bidi-font-weight:bold'>”</span><span style='font-size:16.0pt;
font-family:仿宋_GB2312;mso-hansi-font-family:宋体;mso-bidi-font-weight:bold'>的单位填写问题</span><span
lang=EN-US style='font-size:16.0pt;font-family:仿宋_GB2312;mso-bidi-font-weight:
bold'>4</span><span style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:
宋体;mso-bidi-font-weight:bold'>，其他单位填写问题</span><span lang=EN-US
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-bidi-font-weight:bold'>2</span><span
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>、</span><span lang=EN-US style='font-size:16.0pt;
font-family:仿宋_GB2312;mso-bidi-font-weight:bold'>3</span><span
style='font-size:16.0pt;font-family:仿宋_GB2312;mso-hansi-font-family:宋体;
mso-bidi-font-weight:bold'>。</span></p>

</div>

</body>
</html>
