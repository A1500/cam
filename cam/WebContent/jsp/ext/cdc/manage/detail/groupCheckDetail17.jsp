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
					document.getElementById("orgCnName"+seq).innerHTML=ds.getAt(i-1).get("orgCnName");
					document.getElementById("orgType"+seq).value=ds.getAt(i-1).get("orgType");
					document.getElementById("joinDate"+seq).innerHTML=ds.getAt(i-1).get("joinDate");
					document.getElementById("fee"+seq).innerHTML=ds.getAt(i-1).get("fee");
					document.getElementById("orgDutyType"+seq).value=ds.getAt(i-1).get("dutyType");
					document.getElementById("dutyPeriod"+seq).innerHTML=ds.getAt(i-1).get("dutyPeriod");
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
					document.getElementById("visitNation"+seq).innerHTML=ds.getAt(i-1).get("visitNation");
					document.getElementById("visitDate"+seq).innerHTML=ds.getAt(i-1).get("visitDate");
					document.getElementById("visitNum"+seq).innerHTML=ds.getAt(i-1).get("visitNum");
					document.getElementById("visitAim"+seq).innerHTML=ds.getAt(i-1).get("visitAim");
					document.getElementById("feeSource"+seq).innerHTML=ds.getAt(i-1).get("feeSource");
					document.getElementById("inviteOrganName"+seq).innerHTML=ds.getAt(i-1).get("inviteOrganName");
					document.getElementById("auditOrganName"+seq).innerHTML=ds.getAt(i-1).get("auditOrganName");
				}
			}
		});
	}
	//返回
	function back(){
		var data = new L5.Map();
		var url='jsp/cams/sorg/check/group/somchecktask/somchecktask_list.jsp';
		var text = '年检列表';
		L5.forward(url,text,data);
	}
	//下一页
	function nextPage(){
		var data = new L5.Map();
		data.put("taskCode",taskCode);
		var url='jsp/cams/sorg/check/group/detail/groupCheckDetail18.jsp';
		var text = '下一页';
		L5.forward(url,text,data);
	}
</script>
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
<div id="float">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPage();"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="back();" />
</div>

<p class=MsoNormal align=center
	style='margin-left: 5.4pt; text-align: center; mso-pagination: widow-orphan'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>3</span><span
	style='font-size: 14.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>．参加国际组织（最主要的五个）<span
	lang=EN-US><o:p></o:p></span></span></p>
	
	
<div align=center>



	<table cellspacing=0 cellpadding=0 width="800">

	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 23.25pt'>

		<td width=127 rowspan=2
			style='width: 95.4pt; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: black; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: black; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>

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

		<td width=84 rowspan=2
			style='width: 63.05pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>国际组织类型</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td width=60 rowspan=2
			style='width: 63.05pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>

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

		<td width=120 rowspan=2
			style='width: 90.0pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-left-alt: solid black .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .25pt; mso-border-color-alt: black; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>缴纳会费数额（单位：人民币元</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'>/</span><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>年）</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td width=220 colspan=2
			style='width: 165.3pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-left-alt: solid black .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .25pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: black; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>担任职务情况</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

	</tr>

	<tr style='mso-yfti-irow: 1; height: 23.25pt'>

		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .25pt; mso-border-left-alt: solid black .5pt; mso-border-top-alt: .25pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .25pt; mso-border-color-alt: black; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>职务类型</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 23.25pt'>

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
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="国际组织名称" id="orgCnName1" style="width: 98%" /></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select name='国际组织类型' id="orgType1" style="width: 90%"  disabled="disabled"/>
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='参加时间' id="joinDate1" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="缴纳会费数额" id="fee1" style="width: 98%" /></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select  disabled="disabled"name='职务类型' id="orgDutyType1" style="width: 90%" />
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="任职起止时间" id="dutyPeriod1" style="width: 98%" /></span></p>
		</td>
	</tr>
<!-- 2 -->
	<tr style='mso-yfti-irow: 2; height: 33.75pt'>

		<td width=127
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="国际组织名称" id="orgCnName2" style="width: 98%" /></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select  disabled="disabled"name='国际组织类型' id="orgType2" style="width: 90%" />
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='参加时间' id="joinDate2" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="缴纳会费数额" id="fee2" style="width: 98%" /></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select  disabled="disabled"name='职务类型' id="orgDutyType2" style="width: 90%" />
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="任职起止时间" id="dutyPeriod2" style="width: 98%" /></span></p>
		</td>
	</tr>
<!-- 3 -->
	<tr style='mso-yfti-irow: 2; height: 33.75pt'>

		<td width=127
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="国际组织名称" id="orgCnName3" style="width: 98%" /></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select  disabled="disabled"name='国际组织类型' id="orgType3" style="width: 90%" />
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='参加时间' id="joinDate3" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="缴纳会费数额" id="fee3" style="width: 98%" /></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select  disabled="disabled"name='职务类型' id="orgDutyType3" style="width: 90%" />
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="任职起止时间" id="dutyPeriod3" style="width: 98%" /></span></p>
		</td>
	</tr>
	<!-- 4 -->
	<tr style='mso-yfti-irow: 2; height: 33.75pt'>

		<td width=127
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="国际组织名称" id="orgCnName4" style="width: 98%" /></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select  disabled="disabled"name='国际组织类型' id="orgType4" style="width: 90%" />
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='参加时间' id="joinDate4" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="缴纳会费数额" id="fee4" style="width: 98%" /></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select  disabled="disabled"name='职务类型' id="orgDutyType4" style="width: 90%" />
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="任职起止时间" id="dutyPeriod4" style="width: 98%" /></span></p>
		</td>
	</tr>
	<!-- 5 -->
	<tr style='mso-yfti-irow: 2; height: 33.75pt'>

		<td width=127
			style='width: 95.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="国际组织名称" id="orgCnName5" style="width: 98%" /></span></p>
		</td>
		<td width=84
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select  disabled="disabled"name='国际组织类型' id="orgType5" style="width: 90%" />
					<option dataset="orgTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=60
			style='width: 63.05pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='参加时间' id="joinDate5" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>
		<td width=120
			style='width: 90.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="缴纳会费数额" id="fee5" style="width: 98%" /></span></p>
		</td>
		<td width=96
			style='width: 72.0pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-right-alt: solid black .25pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<select  disabled="disabled"name='职务类型' id="orgDutyType5" style="width: 90%" />
					<option dataset="orgDutyTypeDataSet"></option>
				</select></span></p>
		</td>
		<td width=124
			style='width: 93.3pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .25pt; mso-border-top-alt: solid black .25pt; mso-border-bottom-alt: solid black .25pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 33.75pt'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="任职起止时间" id="dutyPeriod5" style="width: 98%" /></span></p>
		</td>
	</tr>

	

</table>



<p class=MsoNormal align=center
	style='margin-left: 5.4pt; text-align: center; mso-pagination: widow-orphan'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>4</span><span
	style='font-size: 14.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>．组团出国（境）访问（最主要的五次）<span
	lang=EN-US><o:p></o:p></span></span></p>



	<table cellspacing=0 cellpadding=0 width="800">

	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 2.0cm'>

		<td width=101
			style='width: 75.4pt; border-top: 1.5pt; border-left: 1.5pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: black; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: black; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>出访国家或地<span
			lang=EN-US><span style='mso-spacerun: yes'>&nbsp; </span></span>区</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td width=74
			style='width: 55.25pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>

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

		<td width=64
			style='width: 48.25pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>

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

		<td width=105
			style='width: 78.6pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>

		<p class=MsoNormal align=center
			style='text-align: center; mso-pagination: widow-orphan'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-bidi-font-family: "Times New Roman"; mso-font-kerning: 0pt'>出访目的</span><span
			lang=EN-US
			style='font-size: 12.0pt; font-family: "Times New Roman", "serif"; mso-fareast-font-family: 宋体; mso-font-kerning: 0pt'><o:p></o:p></span></p>

		</td>

		<td width=74
			style='width: 55.25pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>

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

		<td width=124
			style='width: 92.85pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>

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

		<td width=71
			style='width: 53.1pt; border-top: solid black 1.5pt; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black 1.5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>

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
	<tr style='mso-yfti-irow: 1; height: 2.0cm'>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访国家或地区" id="visitNation1" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='出访时间' id="visitDate1" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访人数" id="visitNum1" style="width: 98%" /></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访目的" id="visitAim1" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="经费来源" id="feeSource1" style="width: 98%" /></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="境外邀请单位名称" id="inviteOrganName1" style="width: 98%" /></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="批准机关" id="auditOrganName1" style="width: 98%" /></span></p>
		</td>

	</tr>
	
	<!-- 2 -->
	<tr style='mso-yfti-irow: 1; height: 2.0cm'>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访国家或地区" id="visitNation2" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='出访时间' id="visitDate2" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访人数" id="visitNum2" style="width: 98%" /></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访目的" id="visitAim2" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="经费来源" id="feeSource2" style="width: 98%" /></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="境外邀请单位名称" id="inviteOrganName2" style="width: 98%" /></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="批准机关" id="auditOrganName2" style="width: 98%" /></span></p>
		</td>

	</tr>
	<!-- 3 -->
	<tr style='mso-yfti-irow: 1; height: 2.0cm'>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访国家或地区" id="visitNation3" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='出访时间' id="visitDate3" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访人数" id="visitNum3" style="width: 98%" /></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访目的" id="visitAim3" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="经费来源" id="feeSource3" style="width: 98%" /></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="境外邀请单位名称" id="inviteOrganName3" style="width: 98%" /></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="批准机关" id="auditOrganName3" style="width: 98%" /></span></p>
		</td>

	</tr>
	<!-- 4 -->
	<tr style='mso-yfti-irow: 1; height: 2.0cm'>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访国家或地区" id="visitNation4" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='出访时间' id="visitDate4" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访人数" id="visitNum4" style="width: 98%" /></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访目的" id="visitAim4" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="经费来源" id="feeSource4" style="width: 98%" /></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="境外邀请单位名称" id="inviteOrganName4" style="width: 98%" /></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="批准机关" id="auditOrganName4" style="width: 98%" /></span></p>
		</td>

	</tr>
	<!-- 5 -->
	<tr style='mso-yfti-irow: 1; height: 2.0cm'>

		<td width=101
			style='width: 75.4pt; border-top: none; border-left: solid black 1.5pt; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-alt: solid black .5pt; mso-border-left-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访国家或地区" id="visitNation5" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name='出访时间' id="visitDate5" format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" style="width: 98%"/></span></p>
		</td>

		<td width=64
			style='width: 48.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访人数" id="visitNum5" style="width: 98%" /></span></p>
		</td>

		<td width=105
			style='width: 78.6pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="出访目的" id="visitAim5" style="width: 98%" /></span></p>
		</td>

		<td width=74
			style='width: 55.25pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="经费来源" id="feeSource5" style="width: 98%" /></span></p>
		</td>

		<td width=124
			style='width: 92.85pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.0pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="境外邀请单位名称" id="inviteOrganName5" style="width: 98%" /></span></p>
		</td>

		<td width=71
			style='width: 53.1pt; border-top: none; border-left: none; border-bottom: solid black 1.0pt; border-right: solid black 1.5pt; mso-border-top-alt: solid black .5pt; mso-border-top-alt: solid black .5pt; mso-border-bottom-alt: solid black .5pt; mso-border-right-alt: solid black 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 2.0cm'>
			<p class=MsoNormal align=center
				style='margin-left: 5.4pt; text-align: center; tab-stops: 248.15pt'><span> 
				<label name="批准机关" id="auditOrganName5" style="width: 98%" /></span></p>
		</td>

	</tr>

	
</table>

</div>
</body>
</html>