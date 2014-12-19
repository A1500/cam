<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String ycheckId = (String)request.getParameter("ycheckId");
	if(ycheckId==null){
		ycheckId=IdHelp.getUUID32();
	}
	String method = (String)request.getParameter("method");
%>
<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
		<script type="text/javascript" src="../../js/float.js"></script>
		<link href="../../css/float.css" type="text/css" rel="stylesheet" />
		<script language="javascript">
			var ycheckId='<%=ycheckId%>';
			var method='<%=method%>';
			var flag = "break";
		 	//初始化
			function init(){
				var partyCheckDataSet = L5.DatasetMgr.lookup("partyCheckDataSet");
				partyCheckDataSet.setParameter("YCHECK_ID@=", ycheckId);
				partyCheckDataSet.load(true);
				var borgName = partyCheckDataSet.get('borgName');
				var records = businessOrganSelectDic.query("value",borgName);
				if(records.length>0){
					var borgCode = records.items[0].get("text");
					document.getElementById("borgName").innerHTML = borgName;
					document.getElementById("borgNameDispaly").innerHTML = borgCode;
				}
			}
			function changeSorgType(value){
				switch(value){
					case "S":
						value ="社会团体";break;
					case "J":
						value ="基金会";break;
					case "M":
						value ="民办非企业单位";break;
		    	}
		    	return value;
			}

			function back(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/check/partyCheck/partychecklist.jsp';
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function noPassCheck(){
				var partyCheckDataSet = L5.DatasetMgr.lookup("partyCheckDataSet");
				partyCheckDataSet.setParameter("YCHECK_ID@=", ycheckId);
				partyCheckDataSet.load();
				var recordCheck=partyCheckDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.partycheck.cmd.SomPartyCheckCommand");
				recordCheck.set("checkStatus","2");
				recordCheck.set("checkResult","1");
				recordCheck.set("checkTime",'<%=DateUtil.getTime()%>');
				command.setParameter("record", recordCheck);
				command.execute("update");
				if (!command.error) {
					L5.Msg.alert('提示',"核对成功，该数据已经驳回!",function (){
						back();
					});
				}else{
					L5.Msg.alert('提示',"核对时出现错误！"+command.error);
				}

			}
			function passCheck(){
				var partyCheckDataSet = L5.DatasetMgr.lookup("partyCheckDataSet");
				partyCheckDataSet.setParameter("YCHECK_ID@=", ycheckId);
				partyCheckDataSet.load();
				var recordCheck=partyCheckDataSet.getCurrent();

				var command = new L5.Command("com.inspur.cams.sorg.partycheck.cmd.SomPartyCheckCommand");
				recordCheck.set("checkStatus","3");
				recordCheck.set("checkResult","0");
				recordCheck.set("checkTime",'<%=DateUtil.getTime()%>');
				command.setParameter("record", recordCheck);
				command.execute("update");
				if (!command.error) {
					L5.Msg.alert('提示',"核对成功，该数据年检完成!",function (){
						//通过加载社会组织信息，获得社会组织ID
						var sorgId="";
						var somOrganDataset=L5.DatasetMgr.lookup("somOrganDataset");
						somOrganDataset.setParameter("SORG_CODE@=",recordCheck.get('sorgCode'));
						somOrganDataset.load();
						somOrganDataset.on('load',function(){
							sorgId=somOrganDataset.get("sorgId");
						});
						var somPartyDS=L5.DatasetMgr.lookup("somPartyDS");
						somPartyDS.setParameter("SOM_PARTY.SORG_CODE@=",recordCheck.get('sorgCode'));
						somPartyDS.setParameter("SOM_PARTY.SORG_TYPE@=",recordCheck.get('sorgType'));
						somPartyDS.load();
						somPartyDS.on('load',function(ds){
							var somParty;
							var cmd=new L5.Command("com.inspur.cams.sorg.manage.cmd.SomPartyCmd");
							if(ds.getCount()!=0){
								somParty=ds.getCurrent();
								getSomPratyInfo(somParty,recordCheck);
								cmd.setParameter("somParty", somParty);
								cmd.execute("updateParty");
							}else{
								somParty=ds.newRecord();
								somParty.set("partyId",partyId);
								somParty.set("sorgCode",recordCheck.get('sorgCode'));
								somParty.set("sorgId",sorgId);
								somParty.set("sorgName",recordCheck.get('sorgName'));
								//morgName \morgArea//后台已处理
								getSomPratyInfo(somParty,recordCheck);
								cmd.setParameter("somParty", somParty);
								cmd.execute("insertParty");
							}
							if (!cmd.error) {
							}else{
								L5.Msg.alert("提示","更新原有党建信息出错！");
								return;
							}
						});
						back();
					});
				}else{
					L5.Msg.alert('提示',"核对时出现错误！"+command.error);
				}
			}
			function getSomPratyInfo(somParty,recordCheck){
				somParty.set("sorgType",recordCheck.get('sorgType'));//社会组织类型
				somParty.set("partyStatus",recordCheck.get('partyStatus'));//登记党建情况
				somParty.set("ifBuildParty",recordCheck.get('ifBuildParty'));//是否建立党组织
				somParty.set("legalPeople",recordCheck.get('legalPeople'));//法定代表人
				somParty.set("politics",recordCheck.get('politics'));//政治面貌
				somParty.set("buildDate",recordCheck.get('buildDate'));//党组成立日期
				somParty.set("auditOrgan",recordCheck.get('auditOrgan'));//审批单位
				somParty.set("buildType",recordCheck.get('buildType'));//党组织建制
				somParty.set("belongRel",recordCheck.get('belongRel'));//隶属关系
				somParty.set("partyChief",recordCheck.get('partyChief'));//党组织负责人
				somParty.set("phone",recordCheck.get('phone'));//电话
				somParty.set("sorgDuties",recordCheck.get('sorgDuties'));//社会组织职务
				somParty.set("workName",recordCheck.get('workName'));//工作单位
				somParty.set("birthday",recordCheck.get('birthday'));//出生日期
				somParty.set("sex",recordCheck.get('sex'));//性别
				somParty.set("education",recordCheck.get('education'));//学历
				somParty.set("folk",recordCheck.get('folk'));//民族
				somParty.set("prepareNum",recordCheck.get('prepareNum'));//预备党员人数
				somParty.set("developNum",recordCheck.get('developNum'));//发展对象人数
				somParty.set("energeticNum",recordCheck.get('energeticNum'));//积极分子人数
				somParty.set("appPartyNum",recordCheck.get('appPartyNum'));//申请入党人数
				somParty.set("groupType",recordCheck.get('groupType'));//已建群团组织
				somParty.set("nobuildReason",recordCheck.get('nobuildReason'));//未建立原因
				somParty.set("instructor",recordCheck.get('instructor'));//党建指导员
				somParty.set("instructorWorkName",recordCheck.get('instructorWorkName'));//指导员工作单位
				somParty.set("instructorPhone",recordCheck.get('instructorPhone'));//指导员电话
				somParty.set("memberNum",recordCheck.get('memberNum'));//党员总数
				somParty.set("leaderFulltimeOutNum",recordCheck.get('leaderFulltimeOutNum'));//领导班子专职已转关系党员数
				somParty.set("leaderFulltimeNoNum",recordCheck.get('leaderFulltimeNoNum'));//领导班子专职未转关系党员数
				somParty.set("leaderParttimeNum",recordCheck.get('leaderParttimeNum'));//领导班子兼职党员数
				somParty.set("memFulltimeOutNum",recordCheck.get('memFulltimeOutNum'));//工作人员专职已转关系党员数
				somParty.set("memFulltimeNoNum",recordCheck.get('memFulltimeNoNum'));//工作人员专职未转关系党员数
				somParty.set("memParttimeNum",recordCheck.get('memParttimeNum'));//工作人员兼职党员数
				somParty.set("engagedNum",recordCheck.get('engagedNum'));//从业人员数
				somParty.set("engagedLeaderFulltime",recordCheck.get('engagedLeaderFulltime'));//从业人员数领导成员专职数
				somParty.set("engagedLeaderParttime",recordCheck.get('engagedLeaderParttime'));//从业人员数领导成员兼职数
				somParty.set("engagedMemFulltime",recordCheck.get('engagedMemFulltime'));//从业人员数工作成员专职数
				somParty.set("engagedMemParttime",recordCheck.get('engagedMemParttime'));//从业人员数工作成员兼职数
				somParty.set("memberSomNum",recordCheck.get('memberSomNum'));//在社会组织的党员数
				somParty.set("memberBusinessNum",recordCheck.get('memberBusinessNum'));//在业务主管单位的党员数
				somParty.set("memberAttachedNum",recordCheck.get('memberAttachedNum'));//在挂靠单位的党员数
				somParty.set("memberPosssessionNum",recordCheck.get('memberPosssessionNum'));//在属地党组织的党员数
				somParty.set("memberOrganNum",recordCheck.get('memberOrganNum'));//在原工作单位的党员数
				somParty.set("memberOtherNum",recordCheck.get('memberOtherNum'));//在其他单位的党员数
			}
		</script>
<style>
textarea {
	overflow: hidden;
}
</style>
</head>

<body>
<model:datasets>
	<!-- 党建年检 -->
	<model:dataset id="partyCheckDataSet" cmd="com.inspur.cams.sorg.partycheck.cmd.SomPartyCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.partycheck.data.SomPartyCheck"></model:record>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 组织类别 -->
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 组织类别 -->
	<model:dataset id="politicalDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="buildTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_BUILD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="belongRelDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_RELATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="noBuildReasonDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_NOBUILD_REASON'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织信息 -->
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrganWithAreaCodeSearchCondition">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<!-- 党建信息 -->
	<model:dataset id="somPartyDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty">
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float" >
	<% if("HANDLE".equals(method)){ %>
	<input type="button" value="核对不通过" style="height:25px;width:80px;position:absolute;margin-left:720px;" onclick="noPassCheck();"/>
	<input type="button" value="核对通过" style="height:25px;width:80px;position:absolute;margin-left:820px;" onclick="passCheck();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<% } %>
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:920px;" onclick="back();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
</div>
<div align=center>
<div align=center style="width:800px;">
<div class=WordSection1 style='layout-grid:15.6pt'>

<p class=MsoNormal style='layout-grid-mode:char;mso-layout-grid-align:none'><span
lang=EN-US style='font-size:16.0pt;font-family:黑体;mso-hansi-font-family:\02CE\0325;
mso-bidi-font-family:宋体;color:#333333;mso-font-kerning:0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal align=center style='text-align:center;layout-grid-mode:char;
mso-layout-grid-align:none'><b style='mso-bidi-font-weight:normal'><span
style='font-size:20.0pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
mso-hansi-font-family:"Times New Roman"'>社会组织党建情况年报表</span></b><b
style='mso-bidi-font-weight:normal'><span lang=EN-US style='font-size:20.0pt'><o:p></o:p></span></b></p>

<table class=MsoNormalTable border=1 cellspacing=0 cellpadding=0 align=left dataset="partyCheckDataSet"
 style='border-collapse:collapse;border:none;mso-border-left-alt:solid windowtext .5pt;
 mso-border-bottom-alt:solid windowtext .5pt;mso-border-right-alt:solid windowtext .5pt;
 mso-table-lspace:9.0pt;margin-left:6.75pt;mso-table-rspace:9.0pt;margin-right:
 6.75pt;mso-table-anchor-vertical:page;mso-table-anchor-horizontal:margin;
 mso-table-left:left;mso-table-top:132.8pt;mso-padding-alt:0cm 5.4pt 0cm 5.4pt;
 mso-border-insideh:.5pt solid windowtext;mso-border-insidev:.5pt solid windowtext'>
 <tr style='height:30.85pt'>
  <td width=656 colspan=12 style='width:491.75pt;border:none;border-bottom:
  solid windowtext 1.0pt;mso-border-bottom-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:30.85pt'>
  <p class=MsoNormal style='layout-grid-mode:char;mso-layout-grid-align:none;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>填表单位：（盖章）</span><span lang=EN-US style='mso-bidi-font-size:
  10.5pt'><span  style='mso-spacerun:yes'>
  <label type="text" name='填表单位' field="morgName" style="width:20%"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  填表人：<label type="text" name='填表人' field="linkMan" style="width:15%" ></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  联系电话:<label type="text" name='联系电话' field="linkPhone" style="width:15%" ></label></span></span></p>
  </td>
 </tr>
 <tr style='height:24.35pt'>
  <td width=38 rowspan=6 style='width:28.7pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:24.35pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:5.65pt;
  margin-bottom:0cm;margin-left:5.65pt;margin-bottom:.0001pt;text-align:center;
  layout-grid-mode:char;mso-layout-grid-align:none;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'>基本情况</span><span lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=71 style='width:53.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.35pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>单位名称</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=318 colspan=6 style='width:238.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.35pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='单位名称' field="sorgName" style="width:98%" maxlength="100"/></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.35pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>单位地址</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=156 colspan=3 style='width:117.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:24.35pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='单位地址' field="sorgAddress" style="width:98%" maxlength="20"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:31.0pt'>
  <td width=71 style='width:53.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>业务主管</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>单位</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=318 colspan=6 style='width:238.8pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p>
	<!--<select name="业务主管单位" field="borgName" style="width:98%" ><option dataset="businessOrganSelect"></option></select>
  		-->
		<label type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位" style="width:85%" />
		<label type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
	</o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>登记证号</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=156 colspan=3 style='width:117.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.0pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='登记证号' field="sorgCode" style="width:98%" maxlength="20"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:22.65pt'>
  <td width=71 style='width:53.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.65pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>组织类别</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=547 colspan=10 style='width:409.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.65pt'>
  <p class=MsoNormal style='layout-grid-mode:char;mso-layout-grid-align:none;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'></span><label id="sorgType" name="组织类别" field="sorgType" dataset="sorgTypeSelect"></label></p>
  </td>
 </tr>
 <tr style='height:22.65pt'>
  <td width=71 style='width:53.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.65pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>法定代表人</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=82 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.65pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>姓</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><span style='mso-spacerun:yes'>&nbsp;
  </span></span><span style='mso-bidi-font-size:10.5pt;font-family:宋体;
  mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>名</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=152 colspan=3 style='width:114.1pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.65pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='法定代表人姓名' field="legalPeople" style="width:98%" maxlength="72"/></o:p></span></p>
  </td>
  <td width=84 colspan=2 style='width:63.25pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.65pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>政治面貌</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=228 colspan=4 style='width:171.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.65pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label name='政治面貌' field="politics" style="width:98%" dataset="politicalDataSet"></label></o:p></span></p>
  </td>
 </tr>
 <tr style='height:22.25pt'>
  <td width=71 rowspan=2 style='width:53.1pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>从业人员数</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=82 rowspan=2 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal style='layout-grid-mode:char;mso-layout-grid-align:none;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='从业人员数' field="engagedNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=68 rowspan=2 style='width:51.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>领导</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>成员数</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=84 colspan=2 style='width:62.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>专职</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=84 colspan=2 style='width:63.25pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='专职' field="engagedLeaderFulltime" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=72 rowspan=2 style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>工作</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>人员数</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=60 style='width:45.05pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>专职</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=96 colspan=2 style='width:72.1pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal style='layout-grid-mode:char;mso-layout-grid-align:none;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='专职' field="engagedMemFulltime" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:23.2pt'>
  <td width=84 colspan=2 style='width:62.95pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>兼职</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=84 colspan=2 style='width:63.25pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='专职' field="engagedLeaderParttime" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=60 style='width:45.05pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>兼职</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=96 colspan=2 style='width:72.1pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal style='layout-grid-mode:char;mso-layout-grid-align:none;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='专职' field="engagedMemParttime" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:52.1pt'>
  <td width=38 rowspan=7 style='width:28.7pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:52.1pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:5.65pt;
  margin-bottom:0cm;margin-left:5.65pt;margin-bottom:.0001pt;text-align:center;
  layout-grid-mode:char;mso-layout-grid-align:none;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'>党组织建立情况</span><span lang=EN-US style='mso-bidi-font-size:10.5pt;
  letter-spacing:2.0pt'><o:p></o:p></span></p>
  </td>
  <td width=71 rowspan=5 style='width:53.1pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:52.1pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>已建</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=82 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>组织建制</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=465 colspan=9 style='width:348.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.25pt'>
  <p class=MsoNormal style='layout-grid-mode:char;mso-layout-grid-align:none;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>
 <label name="组织建制" field="buildType" style="width: 98%" dataset="buildTypeDataset"></label>
  <o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='height:25.25pt'>
  <td width=82 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.25pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>成立时间</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=152 colspan=3 style='width:114.1pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" id="buildDate" name='成立日期' field="buildDate" onClick="WdatePicker()" style="width:98%"/></o:p></span></p>
  </td>
  <td width=84 colspan=2 style='width:63.25pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>审批单位</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=228 colspan=4 style='width:171.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" id="auditOrgan" name='审批单位' field="auditOrgan" style="width:98%"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:25.15pt'>
  <td width=82 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.15pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>隶属关系</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=465 colspan=9 style='width:348.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:25.15pt'>
  <p class=MsoNormal style='line-height:18.0pt;mso-line-height-rule:exactly;
  layout-grid-mode:char;mso-layout-grid-align:none;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>
  <label name="隶属关系" field="belongRel" style="width: 98%" dataset="belongRelDataset"></label>
  <o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='height:22.25pt'>
  <td width=82 rowspan=2 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>党组织</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>负责人</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=68 style='width:51.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>姓</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><span style='mso-spacerun:yes'>&nbsp;
  </span></span><span style='mso-bidi-font-size:10.5pt;font-family:宋体;
  mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>名</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=168 colspan=4 style='width:126.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='党组织负责人' field="partyChief" style="width:98%" maxlength="72"/></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>电</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><span style='mso-spacerun:yes'>&nbsp;
  </span></span><span style='mso-bidi-font-size:10.5pt;font-family:宋体;
  mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>话</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=156 colspan=3 style='width:117.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:22.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='电话' field="phone" style="width:98%" maxlength="30"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:23.45pt'>
  <td width=68 style='width:51.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.45pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>社会组织职务</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=168 colspan=4 style='width:126.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.45pt'>
  <p class=MsoNormal style='text-indent:5.25pt;mso-char-indent-count:.5;
  layout-grid-mode:char;mso-layout-grid-align:none;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span lang=EN-US style='mso-bidi-font-size:10.5pt'>
  <o:p><label type="text" field="sorgDuties" name='"社团职务"' style="width:98%" ></label></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.45pt'>
  <p class=MsoNormal style='layout-grid-mode:char;mso-layout-grid-align:none;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>原工作单位及职务</span><span lang=EN-US style='mso-bidi-font-size:
  10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=156 colspan=3 style='width:117.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.45pt'>
  <p class=MsoNormal style='text-indent:5.25pt;mso-char-indent-count:.5;
  layout-grid-mode:char;mso-layout-grid-align:none;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span lang=EN-US style='mso-bidi-font-size:10.5pt'>
  <o:p><label type="text" name='原工作单位及职务' field="workName" style="width:98%" maxlength="100"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:23.2pt'>
  <td width=71 style='width:53.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>未建</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=82 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>未建原因</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=465 colspan=9 style='width:348.5pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal style='line-height:18.0pt;mso-line-height-rule:exactly;
  layout-grid-mode:char;mso-layout-grid-align:none;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>
  <label name="未建原因" field="nobuildReason" style="width: 98%" dataset="noBuildReasonDS"></label>
  <o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='height:23.2pt'>
  <td width=71 style='width:53.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>党建指导员</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=82 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>姓</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><span style='mso-spacerun:yes'>&nbsp;
  </span></span><span style='mso-bidi-font-size:10.5pt;font-family:宋体;
  mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>名</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=68 style='width:51.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal style='line-height:18.0pt;mso-line-height-rule:exactly;
  layout-grid-mode:char;mso-layout-grid-align:none;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='指导员' field="instructor" style="width:98%" maxlength="72"/></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal style='line-height:18.0pt;mso-line-height-rule:exactly;
  layout-grid-mode:char;mso-layout-grid-align:none;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>工作单位</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=168 colspan=4 style='width:126.2pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal style='text-indent:15.75pt;mso-char-indent-count:1.5;
  line-height:18.0pt;mso-line-height-rule:exactly;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='工作单位' field="instructorWorkName" style="width:98%" maxlength="100"/></o:p></span></p>
  </td>
  <td width=60 style='width:45.05pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal align=center style='text-align:center;line-height:18.0pt;
  mso-line-height-rule:exactly;layout-grid-mode:char;mso-layout-grid-align:
  none;mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>电话</span><span lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=96 colspan=2 style='width:72.1pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.2pt'>
  <p class=MsoNormal style='text-indent:15.75pt;mso-char-indent-count:1.5;
  line-height:18.0pt;mso-line-height-rule:exactly;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='电话' field="instructorPhone" style="width:98%" maxlength="30"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:15.75pt'>
  <td width=38 rowspan=6 style='width:28.7pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:5.65pt;
  margin-bottom:0cm;margin-left:5.65pt;margin-bottom:.0001pt;text-align:center;
  layout-grid-mode:char;mso-layout-grid-align:none;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman";letter-spacing:
  2.0pt'>党员情况</span><span lang=EN-US style='mso-bidi-font-size:10.5pt;
  letter-spacing:2.0pt'><o:p></o:p></span></p>
  </td>
  <td width=71 rowspan=3 style='width:53.1pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>党员人数</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=82 rowspan=3 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='党员人数' field="memberNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=68 rowspan=3 style='width:51.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>领导成员</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>党员数</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=72 rowspan=2 style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>专职</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=48 colspan=2 style='width:36.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>已转关系</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=48 style='width:36.2pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>未转关系</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=72 rowspan=3 style='width:54.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>工作人员</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>党员数</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=60 rowspan=2 style='width:45.05pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>专职</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=48 style='width:36.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>已转关系</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=48 style='width:36.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>未转关系</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='height:15.75pt'>
  <td width=48 colspan=2 style='width:36.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='领导专职已转' field="leaderFulltimeOutNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=48 style='width:36.2pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='领导专职未转' field="leaderFulltimeNoNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=48 style='width:36.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='工人专职已转' field="memFulltimeOutNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=48 style='width:36.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='工人专职未转' field="memFulltimeNoNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:28.8pt'>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>兼职</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=96 colspan=3 style='width:72.2pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='领导兼职' field="leaderParttimeNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=60 style='width:45.05pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>兼职</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=96 colspan=2 style='width:72.1pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.8pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='工人兼职' field="memParttimeNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:28.55pt'>
  <td width=71 rowspan=2 style='width:53.1pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.55pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>组织关系</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>（人数）</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=82 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.55pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>社会组织</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=68 style='width:51.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.55pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>业务主管</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>单位</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.55pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-14.7pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -1.4gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><span style='mso-spacerun:yes'>&nbsp;
  </span></span><span style='mso-bidi-font-size:10.5pt;font-family:宋体;
  mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>挂靠单位</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=96 colspan=3 style='width:72.2pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.55pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>属地</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.55pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>原工作</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>单位</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=156 colspan=3 style='width:117.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:28.55pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'>其他</span><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
 </tr>
 <tr style='height:23.25pt'>
  <td width=82 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='在社会组织的党员数' field="memberSomNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=68 style='width:51.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='在业务主管单位的党员数' field="memberBusinessNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:-5.25pt;
  margin-bottom:0cm;margin-left:-5.25pt;margin-bottom:.0001pt;mso-para-margin-top:
  0cm;mso-para-margin-right:-.5gd;mso-para-margin-bottom:0cm;mso-para-margin-left:
  -.5gd;mso-para-margin-bottom:.0001pt;text-align:center;layout-grid-mode:char;
  mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:9.0pt;
  mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='在挂靠单位的党员数' field="memberAttachedNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=96 colspan=3 style='width:72.2pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='在属地党组织的党员数' field="memberPosssessionNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='在原工作单位的党员数' field="memberOrganNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=156 colspan=3 style='width:117.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><label type="text" name='在其他单位的党员数' field="memberOtherNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
 </tr>
 <tr style='height:31.35pt'>
  <td width=71 style='width:53.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>发展党员</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>（人数）</span><span
  lang=EN-US style='font-size:12.0pt'><o:p></o:p></span></p>
  </td>
  <td width=82 style='width:61.45pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>申请入党</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=68 style='width:51.15pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span lang=EN-US style='font-size:12.0pt'><o:p><label type="text" name='申请入党人数' field="appPartyNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>入党</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>积极分子</span><span
  lang=EN-US style='font-size:12.0pt'><o:p></o:p></span></p>
  </td>
  <td width=96 colspan=3 style='width:72.2pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span lang=EN-US style='font-size:12.0pt'><o:p><label type="text" name='积极分子人数' field="energeticNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>发展</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>对象</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:
  "Times New Roman";mso-hansi-font-family:"Times New Roman"'>人数</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p></o:p></span></p>
  </td>
  <td width=156 colspan=3 style='width:117.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:31.35pt'>
  <p class=MsoNormal align=center style='text-align:center;mso-element:frame;
  mso-element-frame-hspace:9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:
  page;mso-element-anchor-horizontal:margin;mso-element-top:132.8pt;mso-height-rule:
  exactly'><span lang=EN-US style='font-size:12.0pt'><o:p><label type="text" name='发展对象人数' field="developNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
 </tr>
 <tr style='mso-yfti-lastrow:yes;page-break-inside:avoid;height:2.0cm'>
  <td width=38 style='width:28.7pt;border:solid windowtext 1.0pt;border-top:
  none;mso-border-top-alt:solid windowtext .5pt;mso-border-alt:solid windowtext .5pt;
  padding:0cm 5.4pt 0cm 5.4pt;height:2.0cm'>
  <p class=MsoNormal align=center style='margin-top:0cm;margin-right:5.65pt;
  margin-bottom:0cm;margin-left:5.65pt;margin-bottom:.0001pt;text-align:center;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'>群团组织</span><span lang=EN-US style='mso-bidi-font-size:
  10.5pt;letter-spacing:-2.0pt'><o:p></o:p></span></p>
  </td>
  <td width=617 colspan=11 style='width:463.05pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:2.0cm'>
  <p class=MsoNormal style='text-indent:21.0pt;mso-char-indent-count:2.0;
  mso-element:frame;mso-element-frame-hspace:9.0pt;mso-element-wrap:around;
  mso-element-anchor-vertical:page;mso-element-anchor-horizontal:margin;
  mso-element-top:132.8pt;mso-height-rule:exactly'><span style='mso-bidi-font-size:
  10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:
  "Times New Roman"'></span><span lang=EN-US style='mso-bidi-font-size:
  10.5pt'><span style='mso-spacerun:yes'>&nbsp;&nbsp;&nbsp; </span></span><span
  style='mso-bidi-font-size:10.5pt;font-family:宋体;mso-ascii-font-family:"Times New Roman";
  mso-hansi-font-family:"Times New Roman"'><input type="checkbox" name="groupType" value="0" field="groupType" label="工会" disabled="disabled"/>工会
						<input type="checkbox" name="groupType" value="1" field="groupType" label="共青团" disabled="disabled"/>共青团
						<input type="checkbox" name="groupType" value="2" field="groupType" label="妇联" disabled="disabled"/>妇联
						<input type="checkbox" name="groupType" value="3" field="groupType" label="其他" disabled="disabled"/>其他</p>
  </td>
 </tr>
 <![if !supportMisalignedColumns]>
 <tr height=0>
  <td width=49 style='border:none'></td>
  <td width=71 style='border:none'></td>
  <td width=82 style='border:none'></td>
  <td width=68 style='border:none'></td>
  <td width=72 style='border:none'></td>
  <td width=12 style='border:none'></td>
  <td width=36 style='border:none'></td>
  <td width=48 style='border:none'></td>
  <td width=72 style='border:none'></td>
  <td width=60 style='border:none'></td>
  <td width=48 style='border:none'></td>
  <td width=48 style='border:none'></td>
 </tr>
 <![endif]>
</table>

<p class=MsoNormal align=left style='text-align:left;line-height:18.0pt;
mso-line-height-rule:exactly;mso-pagination:widow-orphan;layout-grid-mode:char;
mso-layout-grid-align:none'><span lang=EN-US style='mso-bidi-font-size:10.5pt;
font-family:"&#718;&#805;","serif";mso-bidi-font-family:宋体;color:#333333;mso-font-kerning:
0pt'><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</div>

</div>
<jsp:include page="../../comm/borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>
