<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String) request.getParameter("taskCode");
%>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
	var taskCode='<%=taskCode%>';
	//初始化
	function init(){
		createGroupDetailSelect();
		somCheckInterOrgDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckInterOrgDataSet.load();
		somCheckInterOrgDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				//somCheckInterOrgDataSet.newRecord({"taskCode":taskCode});
			}else{
				for(i=1;i<=ds.getCount();i++){
						var seq=ds.getAt(i-1).get("seq");
					document.getElementById("orgCnName"+seq).value=ds.getAt(i-1).get("orgCnName");
					document.getElementById("orgType"+seq).value=ds.getAt(i-1).get("orgType");
					document.getElementById("joinDate"+seq).innerHTML=ds.getAt(i-1).get("joinDate");
					document.getElementById("fee"+seq).innerHTML=ds.getAt(i-1).get("fee");
					document.getElementById("orgDutyType"+seq).value=ds.getAt(i-1).get("dutyType");
					document.getElementById("dutyPeriod"+seq).value=ds.getAt(i-1).get("dutyPeriod");
				}
			}
		});

		somCheckInterVisitDataSet.setParameter("TASK_CODE@=", taskCode);
		somCheckInterVisitDataSet.load();
		somCheckInterVisitDataSet.on("load",function(ds){
			if(ds.getCount()<1){
				//somCheckInterVisitDataSet.newRecord({"taskCode":taskCode});
			}else{
				for(i=1;i<=ds.getCount();i++){
						var seq=ds.getAt(i-1).get("seq");
					document.getElementById("visitNation"+seq).value=ds.getAt(i-1).get("visitNation");
					document.getElementById("visitDate"+seq).value=ds.getAt(i-1).get("visitDate");
					document.getElementById("visitNum"+seq).innerHTML=ds.getAt(i-1).get("visitNum");
					document.getElementById("visitAim"+seq).value=ds.getAt(i-1).get("visitAim");
					document.getElementById("feeSource"+seq).value=ds.getAt(i-1).get("feeSource");
					document.getElementById("inviteOrganName"+seq).value=ds.getAt(i-1).get("inviteOrganName");
					document.getElementById("visit_auditOrganName"+seq).value=ds.getAt(i-1).get("auditOrganName");
				}
			}
		});
	}
	//打印
	function docPrint(){
		document.execCommand("Print", false);
	}
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
textarea {
	overflow: hidden;
}
label {
	text-align:right;
}
</style>
</head>

<body>
<model:datasets>
	<!-- 国际组织 -->
	<model:dataset id="somCheckInterOrgDataSet"
		cmd="com.inspur.cams.sorg.check.checkinterorg.cmd.SomCheckInterOrgQueryCommand"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkinterorg.data.SomCheckInterOrg"></model:record>
	</model:dataset>
	<!-- 组团出国（境）访问 -->
	<model:dataset id="somCheckInterVisitDataSet"
		cmd="com.inspur.cams.sorg.check.checkintervisit.cmd.SomCheckInterVisitQueryCommand"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkintervisit.data.SomCheckInterVisit"></model:record>
	</model:dataset>
	<!--国际组织类型 -->
	<model:dataset id="orgTypeDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_org_type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--国际组织类型 -->
	<model:dataset id="orgDutyTypeDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_org_duty_type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<!--页面按钮-->
<div id="float" class="noprint">
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="lastPage1('16');"/>
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPage1('18');"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="back();" />
	<input type="button" value="打印" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="docPrint();"/>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal align=center
	style=' text-align: center; mso-pagination: widow-orphan'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>3</span><span
	style='font-size: 14.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>．参加国际组织（最主要的五个）<span
	lang=EN-US><o:p></o:p></span></span></p>


<div align=center>



	<table cellspacing=0 cellpadding=0 width="800">

	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 23.25pt'>

		<td  rowspan=2
			style=' border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: black; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: black; mso-border-style-alt: solid;  height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>国际组织名称</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>（中、英文全称）</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td  rowspan=2
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>国际组织类型</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td  rowspan=2
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>参加<span
			lang=EN-US><o:p></o:p></span></span></p>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>时间</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td  rowspan=2
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .25pt; mso-border-color-alt: black; mso-border-style-alt: solid;  height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>缴纳会费数额（单位：人民币元</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'>/</span><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>年）</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td  colspan=2
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-left-alt: solid black .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .25pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: black; mso-border-style-alt: solid;  height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>担任职务情况</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

	</tr>

	<tr style='mso-yfti-irow: 1; height: 23.25pt'>

		<td
			style=' border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .25pt; mso-border-left-alt: solid black .5pt; mso-border-top-alt: .25pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .25pt; mso-border-color-alt: black; mso-border-style-alt: solid;  height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>职务类型</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td
			style=' border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt;  height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>任职起止时间</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

	</tr>
<!-- 1 -->
	<tr style='mso-yfti-irow: 2; height: 33.75pt'>

		<td width=127
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="国际组织名称" style='width:152;' rows='3' id="orgCnName1"  readonly ></textarea></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='国际组织类型' id="orgType1" style="width: 105" >
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name='参加时间' style='width:103;text-align:center;' id="joinDate1" format="Y-m-d"
				 ></label></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="缴纳会费数额" style='width:143;text-align:left;' onkeyup="value=value.replace(/[^\d.]/g,'')" id="fee1"  ></label></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='职务类型' id="orgDutyType1" style="width: 122" >
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="任职起止时间" style='width:152;' rows='3' id="dutyPeriod1"  readonly ></textarea></span></p>
		</td>
	</tr>
<!-- 2 -->
	<tr style='mso-yfti-irow: 2; height: 33.75pt'>

		<td width=127
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="国际组织名称" style='width:152;' rows='3' id="orgCnName2"  readonly ></textarea></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='国际组织类型' id="orgType2" style="width: 105" >
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name='参加时间' style='width:103;text-align:center;' id="joinDate2"
				format="Y-m-d"  ></label></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="缴纳会费数额" style='width:143;text-align:left;' onkeyup="value=value.replace(/[^\d.]/g,'')" id="fee2"  ></label></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='职务类型' id="orgDutyType2" style="width: 122" >
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="任职起止时间" style='width:152;' rows='3' id="dutyPeriod2"  readonly ></textarea></span></p>
		</td>
	</tr>
<!-- 3 -->
	<tr style='mso-yfti-irow: 2; height: 33.75pt'>

		<td width=127
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="国际组织名称" style='width:152;' rows='3' id="orgCnName3"  readonly ></textarea></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='国际组织类型' id="orgType3" style="width: 105" >
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name='参加时间' style='width:103;text-align:center;' id="joinDate3"
				format="Y-m-d"  ></label></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="缴纳会费数额" style='width:143;text-align:left;' onkeyup="value=value.replace(/[^\d.]/g,'')" id="fee3"  ></label></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='职务类型' id="orgDutyType3" style="width: 122" >
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="任职起止时间" style='width:152;' rows='3' id="dutyPeriod3"  readonly ></textarea></span></p>
		</td>
	</tr>
	<!-- 4 -->
	<tr style='mso-yfti-irow: 2; height: 33.75pt'>

		<td width=127
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="国际组织名称" style='width:152;' rows='3' id="orgCnName4"  readonly ></textarea></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='国际组织类型' id="orgType4" style="width: 105" >
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name='参加时间' style='width:103;text-align:center;' id="joinDate4"
				format="Y-m-d"  ></label></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="缴纳会费数额" style='width:143;text-align:left;' onkeyup="value=value.replace(/[^\d.]/g,'')" id="fee4"  ></label></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='职务类型' id="orgDutyType4" style="width: 122" >
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="任职起止时间" style='width:152;' rows='3' id="dutyPeriod4"  readonly ></textarea></span></p>
		</td>
	</tr>
	<!-- 5 -->
	<tr style='mso-yfti-irow: 2; height: 33.75pt'>

		<td width=127
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="国际组织名称" style='width:152;' rows='3' id="orgCnName5"  readonly ></textarea></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='国际组织类型' id="orgType5" style="width: 105" >
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name='参加时间' style='width:103;text-align:center;' id="joinDate5"
				format="Y-m-d"  ></label></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="缴纳会费数额" style='width:143;text-align:left;' onkeyup="value=value.replace(/[^\d.]/g,'')" id="fee5"  ></label></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<select disabled  name='职务类型' id="orgDutyType5" style="width: 122" >
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt;  height: 33.75pt'>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="任职起止时间" style='width:152;' rows='3' id="dutyPeriod5"  readonly ></textarea></span></p>
		</td>
	</tr>



</table>
<br/>
<br/>


<p class=MsoNormal align=center
	style=' text-align: center; mso-pagination: widow-orphan'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>4</span><span
	style='font-size: 14.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>．组团出国（境）访问（最主要的五次）<span
	lang=EN-US><o:p></o:p></span></span></p>



	<table cellspacing=0 cellpadding=0 width="800">

	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; '>

		<td
			style=' border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: black; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: black; mso-border-style-alt: solid;  '>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>出访国家或地区<span
			lang=EN-US><span style='mso-spacerun: yes'></span></span></span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>出访<span
			lang=EN-US><o:p></o:p></span></span></p>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>时间</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>出访<span
			lang=EN-US><o:p></o:p></span></span></p>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>人数</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>出访目的</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>经费<span
			lang=EN-US><o:p></o:p></span></span></p>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>来源</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>境外邀请单位<span
			lang=EN-US><o:p></o:p></span></span></p>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>名<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>称</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td
			style=' border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt;  '>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>批准<span
			lang=EN-US><o:p></o:p></span></span></p>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>机关</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

	</tr>
<!-- 1 -->
	<tr style='mso-yfti-irow: 1; '>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访国家或地区" style='width:129;' rows='3' id="visitNation1"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name='出访时间' style='width:96;' rows='3' id="visitDate1"  readonly ></textarea></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="出访人数" style='width:86;text-align:center;'
				onkeyup="value=value.replace(/[^\d]/g,'') " id="visitNum1"  ></label></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访目的" style='width:127' rows='3' id="visitAim1"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="经费来源" style='width:93;' rows='3' id="feeSource1"  readonly ></textarea></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="境外邀请单位名称" style='width:151;' rows='3' id="inviteOrganName1"  readonly ></textarea></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="批准机关" style='width:94;' rows='3' id="visit_auditOrganName1"  readonly ></textarea></span></p>
		</td>

	</tr>

	<!-- 2 -->
	<tr style='mso-yfti-irow: 1; '>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访国家或地区" style='width:129;' rows='3' id="visitNation2"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name='出访时间' style='width:96;' rows='3' id="visitDate2"  readonly ></textarea></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="出访人数" style='width:86;text-align:center;' onkeyup="value=value.replace(/[^\d]/g,'') " id="visitNum2"  ></label></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访目的" style='width:127' rows='3' id="visitAim2"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="经费来源" style='width:93;' rows='3' id="feeSource2"  readonly ></textarea></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="境外邀请单位名称" style='width:151;' rows='3' id="inviteOrganName2"  readonly ></textarea></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="批准机关" style='width:94;' rows='3' id="visit_auditOrganName2"  readonly ></textarea></span></p>
		</td>

	</tr>
	<!-- 3 -->
	<tr style='mso-yfti-irow: 1; '>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访国家或地区" style='width:129;' rows='3' id="visitNation3"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name='出访时间' style='width:96;' rows='3' id="visitDate3"  readonly ></textarea></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="出访人数" style='width:86;text-align:center;'
				onkeyup="value=value.replace(/[^\d]/g,'') " id="visitNum3"  ></label></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访目的" style='width:127' rows='3' id="visitAim3"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="经费来源" style='width:93;' rows='3' id="feeSource3"  readonly ></textarea></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="境外邀请单位名称" style='width:151;' rows='3' id="inviteOrganName3"  readonly ></textarea></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="批准机关" style='width:94;' rows='3' id="visit_auditOrganName3"  readonly ></textarea></span></p>
		</td>

	</tr>
	<!-- 4 -->
	<tr style='mso-yfti-irow: 1; '>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访国家或地区" style='width:129;' rows='3' id="visitNation4"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name='出访时间' style='width:96;' rows='3' id="visitDate4"  readonly ></textarea></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="出访人数" style='width:86;text-align:center;' onkeyup="value=value.replace(/[^\d]/g,'') " id="visitNum4"></label></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访目的" style='width:127' rows='3' id="visitAim4"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="经费来源" style='width:93;' rows='3' id="feeSource4"  readonly ></textarea></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="境外邀请单位名称" style='width:151;' rows='3' id="inviteOrganName4"  readonly ></textarea></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="批准机关" style='width:94;' rows='3' id="visit_auditOrganName4"  readonly ></textarea></span></p>
		</td>

	</tr>
	<!-- 5 -->
	<tr style='mso-yfti-irow: 1; '>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访国家或地区" style='width:129;' rows='3' id="visitNation5"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name='出访时间' style='width:96;' rows='3' id="visitDate5"  readonly ></textarea></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<label type="text" name="出访人数" style='width:86;text-align:center;' onkeyup="value=value.replace(/[^\d]/g,'') " id="visitNum5"  ></label></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="出访目的" style='width:127' rows='3' id="visitAim5"  readonly ></textarea></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="经费来源" style='width:93;' rows='3' id="feeSource5"  readonly ></textarea></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="境外邀请单位名称" style='width:151;' rows='3' id="inviteOrganName5"  readonly ></textarea></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.5pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt;  '>
			<p class=MsoNormal align=center
				style=' text-align: center; tab-stops: 248.15pt'><span>
				<textarea type="text" name="批准机关" style='width:94;' rows='3' id="visit_auditOrganName5"  readonly ></textarea></span></p>
		</td>

	</tr>


</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>