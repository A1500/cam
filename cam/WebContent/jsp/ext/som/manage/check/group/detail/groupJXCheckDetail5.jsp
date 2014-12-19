<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
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
				somJxActivityDataSet.setParameter("TASK_CODE", taskCode);
				somJxActivityDataSet.load();
				somJxActivityDataSet.on('load',function (){
					if(somJxActivityDataSet.getCount() == 0){
						somJxActivityDataSet.newRecord();
					}
				});
				somJxCheckInMarketDataSet.setParameter("TASK_CODE", taskCode);
				somJxCheckInMarketDataSet.load();
				somJxCheckInMarketDataSet.on('load',function (){
					if(somJxCheckInMarketDataSet.getCount() == 0){
						for(var i = 0;i<3;i++){
							addTr();
						}
					}else{
						for(i=1;i<=somJxCheckInMarketDataSet.getCount();i++){
							addTr();
							document.getElementById("activityName"+i).innerHTML=somJxCheckInMarketDataSet.getAt(i-1).get("activityName");
							document.getElementById("ifCharge"+i).value=somJxCheckInMarketDataSet.getAt(i-1).get("ifCharge");

						}
					}
				});
	var somJxCheckDataSet = L5.DatasetMgr.lookup("somJxCheckDataSet");
	somJxCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somJxCheckDataSet.load();
	somJxCheckDataSet.on("load",function(ds){
		var checkYear=ds.get("checkYear");
		document.getElementById("checkYear").innerHTML=checkYear;
		document.getElementById("checkYear1").innerHTML=checkYear;
	});
				createGroupDetailSelect();
			}
function save(){

}
			//增加一行方法
			function addTr(){
				 var tab=document.getElementById("activities");
			    //添加行
			    var newTR = tab.insertRow(tab.rows.length);
			    //trid++;
			    //获取序号=行索引
			    var  xuhao=newTR.rowIndex.toString();
			    newTR.id = xuhao;
			    //添加列:活动名称
			    var newNameTD=newTR.insertCell(0);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><label id='activityName"+xuhao+"' style='width: 100%; font-size: 14.0pt; font-family: 仿宋;border:none;'></label></span></p>"
			    //添加列:是否收费
			    var newNameTD=newTR.insertCell(1);
			    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
			    newNameTD.style.borderLeft="solid windowtext 1.0pt";
			    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
			    newNameTD.style.borderRight="solid windowtext 1.0pt";
			    newNameTD.style.borderTop="solid windowtext 1.0pt";
			    //添加列内容
			    newNameTD.innerHTML = "<p align=center class=MsoNormalstyle='mso-line-height-alt: 12.0pt'><span align='center' lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><select id='ifCharge"+xuhao+"' style='font-size: 14.0pt; font-family: 仿宋' disabled='disabled'> <option  value=''>请选择...</option><option  value='1'>是</option><option  value='0'>否</option></select></span></p>";

			}
			function deltr(trid){
 				var tab=document.getElementById("activities");
			    var row=document.getElementById(trid);
			    var index=row.rowIndex;//rowIndex属性为tr的索引值，从0开始
			    tab.deleteRow(index);  //从table中删除
			}
		</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
label {
	text-align:center;
	border-bottom: solid 1px black;
	font-size: 14.0pt;
	font-family: 仿宋;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxActivityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxactivity.cmd.SomJxActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivity"></model:record>
	</model:dataset>
	<model:dataset id="somJxCheckInMarketDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.cmd.SomJxCheckInMarketQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheckinmarket.dao.SomJxCheckInMarket"></model:record>
	</model:dataset>
	<model:dataset id="somJxCheckDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckQueryCommand" global="false">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxcheck.dao.SomJxCheck"></model:record>
	</model:dataset>
	<model:dataset id="YorNDataset" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="nextPage1('6')"/>
	<input type="button" value="上一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="lastPage1('4')"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back();"/>
	<input type="button" value="打印" style="height:25px;width:80px;position:absolute;margin-left:320px;" onclick="docPrint();"/>
	</div>
<div style="text-align: center">
<div class=Section1 style=' width: 700px' >
<form method="post"onsubmit="return false" dataset="somJxActivityDataSet">
<p  align="left"><b><span
	style='font-size: 14.0pt; font-family: 黑体; '>四、活动情况</span></b><b><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p></o:p></span></b></p>

<p class=MsoNormal
	style='text-align: left'><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（一）年度基本业务活动</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、会员大会：</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="generalTimes" style='border-bottom: solid 1px;width:100;'></label>次，会员代表大会
	<label field="delegateTimes" style='border-bottom: solid 1px;width:100;'></label>次；
	</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、理事会：</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	 field="councilTimes" style='border-bottom: solid 1px;width:100;'></label>次，
	 常务理事会<label
	 field="gencouncilTimes" style='border-bottom: solid 1px;width:100;'></label>次；</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、学术专业会议</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	 field="learnMeetingTimes" style='border-bottom: solid 1px;width:100;'></label>次；</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、培训</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	 field="trainTimes" style='border-bottom: solid 1px;width:100;'></label>次，参加人数</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="trainNum" style='border-bottom: solid 1px;width:100;'></label>人次；</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5、开展</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	 field="researchNum"style='border-bottom: solid 1px;width:100;' ></label>次调研活动；</span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6、开展</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	 field="askServeNum" style='border-bottom: solid 1px;width:100;'></label>次咨询服务活动；</span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7、向政府及主管单位提出</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	  field="askBorgNum"style='border-bottom: solid 1px;width:100;' ></label>条意见、建议及其被采纳</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	 field="toAcceptNum" style='border-bottom: solid 1px;width:100;'></label>条；</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>
<p class=MsoNormal
	style='text-align:left'><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（二）公益活动情况<span
	lang=EN-US><span style='mso-tab-count: 1'> </span></span></span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、开展公益活动项目</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'><label
	field="commonwealNum" style='border-bottom: solid 1px;width:100;'></label>个</span><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、公益活动<label
	field="commonwealTimes" style='border-bottom: solid 1px;width:100;'></label>次
	（扶老
<label field="cwtFl" style='border-bottom: solid 1px;width:100;'></label>
	 次、助残
<label field="cwtZc" style='border-bottom: solid 1px;width:100;'></label>
	 次、济困
<label field="cwtJj" style='border-bottom: solid 1px;width:100;'></label>
	 次、救孤
<label field="cwtJg" style='border-bottom: solid 1px;width:100;'></label>
	 次、助学
<label field="cwtZx" style='border-bottom: solid 1px;width:100;'></label>
	 次）
	</span><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、公益活动受益<label
	field="beneficiary" style='border-bottom: solid 1px;width:100;'></label>人</span><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>
<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、公益活动支出</span><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><span
	style='mso-spacerun: yes'>&nbsp;</span></span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体; mso-bidi-font-weight: bold'><label
	field="commonwealOut" style='border-bottom: solid 1px;width:150;'></label>万元</span><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（三）涉外活动情况（下列具体情况请在总结中予以说明）</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、开展国际合作项目</span><span
	class=GramE><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="intItemNum" style='border-bottom: solid 1px;width:100;'></label>个</span></span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>，总计</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="intItemMoney" style='border-bottom: solid 1px;width:150;'></label>万元人民币</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、组织或参加国际会议</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="meetingTimes" style='border-bottom: solid 1px;width:100;'></label>次</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、是否参加境外非政府组织的活动</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><span
	style='mso-spacerun: yes'>&nbsp; </span></span> <label field="ifOffForm" dataset="YorNDataset" style='border-bottom: solid 1px;width:100;'></label>
	</p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、出境考察（培训）</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="outToTimes" style='border-bottom: solid 1px;width:100;'></label>批</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="outToNum" style='border-bottom: solid 1px;width:100;'></label>人次，接待境外来访</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-bidi-font-weight: bold'><label
	field="fromOffTimes" style='border-bottom: solid 1px;width:100;'></label>批</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="fromOffNum" style='border-bottom: solid 1px;width:100;'></label>人次</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>、接受境外组织捐赠或赞助</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="acceptOffNum" style='border-bottom: solid 1px;width:100;'></label>次，总计</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="acceptOffMoney" style='border-bottom: solid 1px;width:150;'></label>万元人民币</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>、聘请外籍员工</span><span
	style='font-size: 14.0pt; font-family: 仿宋'><span
	lang=EN-US><span style='mso-spacerun: yes'>&nbsp;</span></span></span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="retainPeopleNum" style='border-bottom: solid 1px;width:100;'></label>人。</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（四）信息公开情况</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><label id=checkYear style='font-size: 14.0pt;border:none;'></label></span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>年度向</span><span
	style='font-size: 14.0pt; font-family: 仿宋'>有关媒体</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>报送信息</span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'><label
	field="sendInfoNum" style='border-bottom: solid 1px;width:100;'></label>条，其中被采用<label
	field="inceptInfoNum" style='border-bottom: solid 1px;width:100;'></label>条</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、是否举办刊物</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><label
	 field="ifPublication" dataset="YorNDataset" style='border-bottom: solid 1px;width:100;'></label>
	</span></p>


	<p class=MsoNormal
	style='text-align:left'><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;（五）政府采购情况</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、本组织承接政府转移职能和购买服务情况</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>
	  <textarea field="undertakeCont"  title='本组织承接政府转移职能和购买服务情况' name='"本组织承接政府转移职能和购买服务情况"' style="width:600;margin-left: 100"  rows="10" readonly="readonly" ></textarea>
	<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;资金（填写年度所获资金）:


	<label
	 field="capital"   style='border-bottom: solid 1px;width:100;'></label>

；</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、中央及省级党委、政府对本组织工作批示内容</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="instructions"   title='中央及省级党委、政府对本组织工作批示内容' name='"中央及省级党委、政府对本组织工作批示内容"' style="width:600;margin-left: 100" rows="10" readonly="readonly"></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>



<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、中央及省级党委、政府对本组织在有关简报、通报情况</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="bulletin"  title='中央及省级党委、政府对本组织在有关简报、通报情况' name='"中央及省级党委、政府对本组织在有关简报、通报情况"'  style="width:600;margin-left: 100"  rows="10" readonly="readonly" ></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、本组织在全国及省级党委、政府部门召开会议上的典型发言情况</span><u><span
	style='font-size: 16.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 16.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="statement"  title='本组织在全国及省级党委、政府部门召开会议上的典型发言情况' name='"本组织在全国及省级党委、政府部门召开会议上的典型发言情况"'  style="width:600;margin-left: 100"  rows="10" readonly="readonly" ></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋'><o:p></o:p></span></p>
</form>
<p class=MsoNormal
	style='text-align:left'><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;（六）</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><label id=checkYear1 style='font-size: 14.0pt; border:none;'></label></span><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体;'>年度组织开展评比达标表彰活动情况</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>
<div class=MsoNormalTable style='width: 80%; margin-left: 47.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
</div>
<table id="activities" class=MsoNormalTable border=1 cellspacing=0
	cellpadding=0
	style='width: 80%; margin-left: 47.25pt; border-collapse: collapse; border: none; mso-border-alt: solid black .5pt; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid black; mso-border-insidev: .5pt solid black'>
	<tr style='mso-yfti-irow: 0; mso-yfti-firstrow: yes; height: 14.2pt'>
		<td width=40% valign=top
			style='border: solid black 1.0pt; mso-border-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 14.2pt'>
		<p class=MsoNormal align=center
			style='text-align: center; mso-line-height-alt: 12.0pt'><span
			style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>活动名称</span><span
			lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>
		</td>
		<td width=20% valign=top
			style='border: solid black 1.0pt; border-left: none; mso-border-left-alt: solid black .5pt; mso-border-alt: solid black .5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 14.2pt'>
		<p class=MsoNormal align="center"
			style='text-align: center; mso-line-height-alt: 12.0pt'><span
			style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>是否收费</span><span
			lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>
		</td>

	</tr>
</table>

<p class=MsoNormal
	style='text-align:left'><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*社会组织开展单位内部考核，或者以内设机构和工作人员为对象的评比达<br>&nbsp;&nbsp;&nbsp;&nbsp;标表彰项目，不属于社会组织评比表彰活动，不列入统计范围。</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>

<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><b><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

</div>
</div>

</body>
</html>
