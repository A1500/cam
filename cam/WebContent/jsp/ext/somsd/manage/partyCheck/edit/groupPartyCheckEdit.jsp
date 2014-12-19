<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String ycheckId = (String)request.getParameter("ycheckId");
	if(ycheckId==null){
		ycheckId=IdHelp.getUUID32();
	}
	ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
	String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
	String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
	String method = (String)request.getParameter("method");
	String date = DateUtil.getTime();
%>
<next:ScriptManager/>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
		<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
		<script type="text/javascript" src="../../js/float.js"></script>
		<link href="../../css/float.css" type="text/css" rel="stylesheet" />
		<script language="javascript">
			var userId='<%=ExtBspInfo.getUserInfo(request).getUserId()%>';
			var ycheckId='<%=ycheckId%>';
			var taskId='<%=request.getParameter("taskId")%>';
			var sorgType='<%=request.getParameter("sorgType")%>';
			var batch='<%=request.getParameter("batch")%>';
			var batchYear='<%=request.getParameter("batchYear")%>';
			var peopleArea='<%=peopleArea%>';
			var organArea='<%=organArea%>';
			var date='<%=date%>';
			var method='<%=method%>';
			var flag = "break";
		 	//初始化
			function init(){
				var partyCheckDataSet = L5.DatasetMgr.lookup("partyCheckDataSet");
				partyCheckDataSet.setParameter("YCHECK_ID@=", ycheckId);
				partyCheckDataSet.load();
				partyCheckDataSet.on("load",function(ds){
					if(ds.getCount()==0){
						partyCheckDataSet.newRecord({"yearly":batchYear,"taskId":taskId,"ycheckId":ycheckId,"partyStatus":"0","morgArea":organArea,"checkStatus":"0","sorgType":sorgType,"createPeople":userId});
						document.getElementById("sorgType").innerHTML=changeSorgType(sorgType);
					}else{
						var borgName = partyCheckDataSet.get('borgName');
						var records = businessOrganSelectDic.query("value",borgName);
						if(records.length>0){
							var borgCode = records.items[0].get("text");
							document.getElementById("borgName").value = borgName;
							document.getElementById("borgNameDispaly").value = borgCode;
						}
					}
				});
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
			function save(){
				var partyCheckDataSet = L5.DatasetMgr.lookup("partyCheckDataSet");
				var partyCheckRecord=partyCheckDataSet.getCurrent();
				if(document.getElementById("buildDate").value==""){
					partyCheckRecord.set("ifBuildParty","0");
				}else{
					partyCheckRecord.set("ifBuildParty","1");
				}
				var partyCheckDataSetIsValidate = partyCheckDataSet.isValidate();
				if(partyCheckDataSetIsValidate!=true){
					L5.Msg.alert("提示",partyCheckDataSetIsValidate);
					return "break";
				}
				if(document.getElementById("borgNameDispaly").value==""){
					L5.Msg.alert("提示","业务主管单位不能为空！");
					return "break";
				}
				/**********************校验开始***********************/
				if( getNum("engagedNum")!=getNum("engagedLeaderFulltime")+getNum("engagedMemFulltime")+getNum("engagedLeaderParttime")+getNum("engagedMemParttime")){
					L5.Msg.alert("提示","检查不通过： 从业人员数=领导成员数（专职+兼职）+工作人员数（专职+兼职）");
					return "break";
				}
				if( getNum("memberNum")!=getNum("leaderFulltimeOutNum")+getNum("leaderFulltimeNoNum")+getNum("leaderParttimeNum")+getNum("memFulltimeOutNum")+getNum("memFulltimeNoNum")+getNum("memParttimeNum")){
					L5.Msg.alert("提示","检查不通过： 党员人数=领导成员党员数+工作人员党员数");
					return "break";
				}
				if( getNum("memberNum")!=getNum("memberSomNum")+getNum("memberBusinessNum")+getNum("memberAttachedNum")+getNum("memberPosssessionNum")+getNum("memberOrganNum")+getNum("memberOtherNum")){
					L5.Msg.alert("提示","检查不通过： 党员人数=组织关系总人数");
					return "break";
				}
				if( getNum("engagedLeaderFulltime")<getNum("leaderFulltimeOutNum")+getNum("leaderFulltimeNoNum")){
					L5.Msg.alert("提示","检查不通过： 从业领导成员专职数>=领导成员党员专职数（已转关系+未转关系）");
					return "break";
				}
				if( getNum("engagedLeaderParttime")<getNum("leaderParttimeNum")){
					L5.Msg.alert("提示","检查不通过： 从业领导成员兼职数>=领导成员党员兼职数");
					return "break";
				}
				if( getNum("engagedMemFulltime")<getNum("memFulltimeOutNum")+getNum("memFulltimeNoNum")){
					L5.Msg.alert("提示","检查不通过： 从业工作人员专职数>=工作人员党员专职数（已转关系+未转关系）");
					return "break";
				}
				if( getNum("engagedMemParttime")<getNum("memParttimeNum")){
					L5.Msg.alert("提示","检查不通过： 从业工作人员兼职数>=工作人员党员兼职数");
					return "break";
				}
				if( getNum("memberSomNum")!=getNum("leaderFulltimeOutNum")+getNum("memFulltimeOutNum")){
					L5.Msg.alert("提示","检查不通过： 在社会组织中组织关系人数=领导成员党员专职数（已转关系）+工作人员党员专职数（已转关系）");
					return "break";
				}
				if( getNum("engagedNum")<getNum("memberNum")+getNum("appPartyNum")+getNum("energeticNum")+getNum("developNum")){
					L5.Msg.alert("提示","检查不通过： 从业人员数>=党员人数+申请入党人数+入党积极分子人数+发展对象人数");
					return "break";
				}
				/**********************校验结束***********************/
				partyCheckRecord.set("borgName",document.getElementById("borgName").value);
				partyCheckRecord.set("createTime",'<%=DateUtil.getTime()%>');
				var command = new L5.Command("com.inspur.cams.sorg.partycheck.cmd.SomPartyCheckCommand");
				if(method=="UPDATE"){
					command.setParameter("record",partyCheckRecord);
					command.execute("update");
					if (!command.error) {
						alert("保存成功！");
					}else{
						L5.Msg.alert('提示',"保存时出现错误！"+command.error);
					}
				}else{
					command.setParameter("record",partyCheckRecord);
					command.execute("insert");
					if (!command.error) {
						alert("保存成功！");
						method="UPDATE";
					}else{
						L5.Msg.alert('提示',"保存时出现错误！"+command.error);
					}
				}

			}
			function back(){
				var data = new L5.Map();
				var url='jsp/ext/somsd/manage/partyCheck/partychecktask/partychecktask_list.jsp';
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function operDesc(){
				L5.getCmp('winOperDesc').show();
			}
			function closeOperDesc(){
				L5.getCmp('winOperDesc').hide();
			}
			function getNum(o){
				var num=document.getElementById(o).value;
				return num*1;
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
		<model:record fromBean="com.inspur.cams.sorg.partycheck.data.SomPartyCheck">
		<model:field name="linkMan" type="string" rule="require"/>
		<model:field name="linkPhone" type="string" rule="require"/>
		<model:field name="sorgName" type="string" rule="require"/>
		<model:field name="sorgAddress" type="string" rule="require"/>
		<model:field name="sorgCode" type="string" rule="require"/>
		<model:field name="legalPeople" type="string" rule="require"/>
		<model:field name="politics" type="string" rule="require"/>
		<model:field name="engagedNum" type="string" rule="require"/>
		</model:record>
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
</model:datasets>
<div id="float" >
	<!--[if lte IE 7]><div></div><![endif]-->
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="back();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="填写说明" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="operDesc()"/>
	<!--[if lte IE 7]><div></div><![endif]-->
</div>
<div align=center>
<div align=left style="width:800px;">
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
  10.5pt'><span
  style='mso-spacerun:yes'><input type="text" name='填表单位' field="morgName" style="width:25%" maxlength="100"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='mso-bidi-font-size:10.5pt;font-family:宋体;
  mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>填表人：</span><span
  lang=EN-US style='mso-bidi-font-size:10.5pt'><span><input type="text" name='填表人' field="linkMan" style="width:15%" maxlength="72"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='mso-bidi-font-size:10.5pt;font-family:宋体;
  mso-ascii-font-family:"Times New Roman";mso-hansi-font-family:"Times New Roman"'>联系电话：</span><span
  style='mso-bidi-font-size:10.5pt'> <span lang=EN-US><o:p><input type="text" name='联系电话' field="linkPhone" style="width:15%" maxlength="30"/></o:p></span></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='单位名称' field="sorgName" style="width:98%" maxlength="100"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='单位地址' field="sorgAddress" style="width:98%" maxlength="20"/></o:p></span></p>
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
		<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位" style="width:85%"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','-20')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
		<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
						<ul></ul>
		</div>
		<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='登记证号' field="sorgCode" onkeyup="value=value.replace(/[^\-\w\.\/]/ig,'').toUpperCase()" style="width:98%" maxlength="20"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='法定代表人姓名' field="legalPeople" style="width:98%" maxlength="72"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><select name='政治面貌' field="politics" style="width:98%">
  <option  value=''>请选择...</option>
  <option  value='01'>中国共产党党员</option>
  <option  value='02'>中国共产党预备党员</option>
  <option  value='03'>中国共产主义青年团团员</option>
  <option  value='04'>中国国民党革命委员会会员</option>
  <option  value='05'>中国民主同盟盟员</option>
  <option  value='06'>中国民主建国会会员</option>
  <option  value='07'>中国民主促进会会员</option>
  <option  value='08'>中国农工民主党党员</option>
  <option  value='09'>中国致公党党员</option>
  <option  value='10'>九三学社社员</option>
  <option  value='11'>台湾民主自治同盟盟员</option>
  <option  value='12'>无党派民主人士</option>
  <option  value='13'>群众</option></select></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='从业人员数' id="engagedNum" field="engagedNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='专职' id="engagedLeaderFulltime" field="engagedLeaderFulltime" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='专职' id="engagedMemFulltime" field="engagedMemFulltime" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='专职' id="engagedLeaderParttime"  field="engagedLeaderParttime" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='专职' id="engagedMemParttime" field="engagedMemParttime" style="width:98%" maxlength="6"/></o:p></span></p>
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
  "Times New Roman"'> <select name="组织建制" field="buildType" style="width: 98%">
  <option dataset="buildTypeDataset"></option></select><o:p></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" id="buildDate" name='成立日期' field="buildDate" onClick="WdatePicker()" style="width:98%"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" id="auditOrgan" name='审批单位' field="auditOrgan" style="width:98%"/></o:p></span></p>
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
  <select name="隶属关系" field="belongRel" style="width: 98%">
  <option dataset="belongRelDataset"></option></select></span><o:p></o:p></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='党组织负责人' field="partyChief" style="width:98%" maxlength="72"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='电话' field="phone" style="width:98%" maxlength="30"/></o:p></span></p>
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
  <o:p>
  <input type="text" name='社会组织职务' field="sorgDuties" style="width:98%" maxlength="50"/></o:p></span></p>
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
  <o:p><input type="text" name='原工作单位及职务' field="workName" style="width:98%" maxlength="100"/></o:p></span></p>
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
  <select name="未建原因" field="nobuildReason" style="width: 98%">
  <option dataset="noBuildReasonDS"></option></select>
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
  exactly'><span lang=EN-US style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='指导员' field="instructor" style="width:98%" maxlength="72"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='工作单位' field="instructorWorkName" style="width:98%" maxlength="100"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='电话' field="instructorPhone" style="width:98%" maxlength="30"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='党员人数' id="memberNum" field="memberNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='领导专职已转' id="leaderFulltimeOutNum"  field="leaderFulltimeOutNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=48 style='width:36.2pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='领导专职未转' id="leaderFulltimeNoNum" field="leaderFulltimeNoNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=48 style='width:36.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='工人专职已转' id="memFulltimeOutNum" field="memFulltimeOutNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=48 style='width:36.1pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:15.75pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='工人专职未转' id="memFulltimeNoNum" field="memFulltimeNoNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='领导兼职' id="leaderParttimeNum" field="leaderParttimeNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='工人兼职' id="memParttimeNum" field="memParttimeNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='在社会组织的党员数' id="memberSomNum" field="memberSomNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='在业务主管单位的党员数' id="memberBusinessNum" field="memberBusinessNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='在挂靠单位的党员数' id="memberAttachedNum" field="memberAttachedNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=96 colspan=3 style='width:72.2pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='在属地党组织的党员数' id="memberPosssessionNum" field="memberPosssessionNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=72 style='width:54.0pt;border-top:none;border-left:none;border-bottom:
  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;mso-border-top-alt:
  solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;mso-border-alt:
  solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='在原工作单位的党员数' id="memberOrganNum" field="memberOrganNum" style="width:98%" maxlength="6"/></o:p></span></p>
  </td>
  <td width=156 colspan=3 style='width:117.15pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext .5pt;mso-border-left-alt:solid windowtext .5pt;
  mso-border-alt:solid windowtext .5pt;padding:0cm 5.4pt 0cm 5.4pt;height:23.25pt'>
  <p class=MsoNormal align=center style='text-align:center;layout-grid-mode:
  char;mso-layout-grid-align:none;mso-element:frame;mso-element-frame-hspace:
  9.0pt;mso-element-wrap:around;mso-element-anchor-vertical:page;mso-element-anchor-horizontal:
  margin;mso-element-top:132.8pt;mso-height-rule:exactly'><span lang=EN-US
  style='mso-bidi-font-size:10.5pt'><o:p><input type="text" name='在其他单位的党员数' id="memberOtherNum" field="memberOtherNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  exactly'><span lang=EN-US style='font-size:12.0pt'><o:p><input type="text" name='申请入党人数' id="appPartyNum" field="appPartyNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  exactly'><span lang=EN-US style='font-size:12.0pt'><o:p><input type="text" name='积极分子人数' id="energeticNum" field="energeticNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  exactly'><span lang=EN-US style='font-size:12.0pt'><o:p><input type="text" name='发展对象人数' id="developNum" field="developNum" style="width:98%" maxlength="6"/></o:p></span></p>
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
  mso-hansi-font-family:"Times New Roman"'><input type="checkbox" name="groupType" value="0" field="groupType" label="工会" />工会
						<input type="checkbox" name="groupType" value="1" field="groupType" label="共青团" />共青团
						<input type="checkbox" name="groupType" value="2" field="groupType" label="妇联" />妇联
						<input type="checkbox" name="groupType" value="3" field="groupType" label="其他" />其他</p>
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
<next:Window id="winOperDesc" closeAction="hide" title="填表说明" width="700"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeOperDesc"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<div>
	<span style="font-size:14px;color:red">
				填表说明：<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、本报表由社会组织填写，与其他年检资料一并报送民政部门。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、无论是否有党员、是否建立党组织均需填写本表。没有党员的填写“基本情况”、“群团组织”等内容。未建立党组织的填写“基本情况”、“未建原因”、“党建指导员”、“党员情况”、“群团组织”等内容。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、“从业人员”指从事社会组织工作的各类人员，包括领导成员和工作人员。会员不列入统计范围。
				“从业人员数”=“领导成员数”+“工作人员数”。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、如果一个社会组织内部同时存在多个层级的党组织，只需填写其最高层级的党组织。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5、“应建未建”是指按照我省建立“兼合式”党组织的要求，有1名以上正式党员（包括兼职人员党员）、但未单独或联合建立党组织； “无党员”中的党员是指专职、兼职人员中的正式党员。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6、“党员人数”=“领导成员党员数”+“工作人员党员数”。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7、“已转关系”是指已经将党组织关系转入社会组织的党员人数。<br>
				“未转关系”是指尚未将党组织关系转入社会组织的党员人数。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8、表中“领导成员”是指社会组织负责人，包括社会团体、基金会中担任秘书长及以上领导职务的人员，民办非企业单位担任领导职务的人员。
				“专职人员”是指专门从事社会组织（含分支机构、代表机构、内设机构）工作的人员，包括在社会组织长期（6个月以上）工作的社会聘用人员、借用人员、离退休返聘人员。
				“兼职人员”是指兼做社会组织（含分支机构、代表机构、内设机构）工作的人员。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;9、本表统计数据截止到2012年12月31日。
 <br>
	</span>
	</div>
	</next:Html>
</next:Window>
<jsp:include page="../../borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>
