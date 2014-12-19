<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp;"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>社 会 团 体</title>
<%
	String taskCode = (String)request.getParameter("taskCode");
	if(taskCode==null){
		taskCode=IdHelp.getUUID32();
	}
%>
<next:ScriptManager/>
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
				//创建页面导航下拉框
				createGroupEditSelect();
			}
			function save(){
				try{
					checkData();
				}catch(e){
					  if (e=="break")
					  return "break";
				}
				var checkRecord=somCheckDataSet.getCurrent();
				var checkCouncilRecord=somCheckCouncilDataSet.getCurrent();
				var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
				command.setParameter("taskCode", taskCode);
				command.setParameter("checkRecord", checkRecord);
				command.setParameter("checkCouncilRecord", checkCouncilRecord);
				command.execute("savePage1");
				if (!command.error) {
					L5.Msg.alert("提示","保存成功！",function(){
					});		
				}else{
					L5.Msg.alert('提示',"保存时出现错误！"+command.error);
				}
				//return "true";
			}
			function nextPage(){
				
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/group/edit/groupJXCheckEdit5.jsp';
				data.put("taskCode",taskCode);
				var text = '年检列表';
				L5.forward(url,text,data);
			}
			function back(){
				var data = new L5.Map();
				var url='jsp/cams/sorg/jxcheck/group/somchecktask/somjxchecktask_list.jsp';
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
		</script>
<style>

</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck"></model:record>
	</model:dataset>
	<model:dataset id="somCheckCouncilDataSet" cmd="com.inspur.cams.sorg.check.checkcouncil.cmd.SomCheckCouncilQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkcouncil.data.SomCheckCouncil"></model:record>
	</model:dataset>

	<model:dataset id="politicsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="ifFulltimeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" >
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="保存" style="height:25px;width:80px;position:absolute;margin-left:120px;" onclick="save();"/>
	<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="返回" style="height:25px;width:80px;position:absolute;margin-left:220px;" onclick="back();"/>
</div>
<div class=Section1>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent: 32.15pt'><b><span
	style='font-size: 16.0pt; font-family: 黑体'>三、人员情况</span></b></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent: 25.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（一）从业人员</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent: 50pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>1.</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>总数
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='总数' name='"总数"' field="" style="width:10%"  maxlength="50"/>
	<u></u>人。其中，专职人员中签订劳动合同
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='专职人员中签订劳动合同' name='"专职人员中签订劳动合同"' field="" style="width:10%"  maxlength="50"/>
	<u> </u>人，离退休返聘
<input  style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312'type="text" title='离退休返聘' name='"总数"' name='"离退休返聘"' field="" style="width:10%"  maxlength="50"/>
	<u>
	</u>人；</span><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>兼职人员中
	</span></p>
<p class=MsoNormal style='text-indent: 70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>
	在国家机关任职
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='在国家机关任职' name='"在国家机关任职"' field="" style="width:10%"  maxlength="50"/>
	人，在企事业单位任职
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='在企事业单位任职' name='"在企事业单位任职"' field="" style="width:10%"  maxlength="50"/>
	<u></u>人，其他
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='其他' name='"其他"' field="" style="width:10%"  maxlength="50"/>
	<u></u>人。</span></span></p>
<p class=MsoNormal style='text-indent: 50pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; color: black'>2.</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; color: black'>年龄结构</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>：35岁及以下
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='35岁及以下' name='"35岁及以下"' field="" style="width:10%"  maxlength="50"/>
	人，36——50岁
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='36——50岁' name='"36——50岁"' field="" style="width:10%"  maxlength="50"/>
	人，51——60岁
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='51——60岁' name='"51——60岁"' field="" style="width:10%"  maxlength="50"/>
	人，</span></p>
<p class=MsoNormal style='text-indent: 70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>60岁以上
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='60岁以上' name='"60岁以上"' field="" style="width:10%"  maxlength="50"/>
	人</span></span></p>
<p class=MsoNormal style='margin-left: .05pt; text-indent: 50pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>3.</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>学历结构：高中及以下
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='高中及以下学历' name='"高中及以下学历"' field="" style="width:10%"  maxlength="50"/>
	人，大学本科及专科
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='大学本科及专科学历' name='"大学本科及专科学历"' field="" style="width:10%"  maxlength="50"/>
	人，硕士及以上
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='硕士及以上学历' name='"硕士及以上学历"' field="" style="width:10%"  maxlength="50"/>
	人，</span></p>
<p class=MsoNormal style='text-indent: 70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; letter-spacing: -1.4pt'>
	留学半年以上归国人员
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='留学半年以上归国人员' name='"留学半年以上归国人员"' field="" style="width:10%"  maxlength="50"/>
	人。</span></p>
<p class=MsoNormal style='margin-left: .05pt; text-indent: 50pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>4.</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>从业人员中持有“社会工作者”资格证书
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='从业人员中持有“社会工作者”资格证书'name='"从业人员中持有“社会工作者”资格证书"' field="" style="width:10%"  maxlength="50"/>
	<u>
	</u>人，持有从事岗位相应专业技术资格证书
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='持有从事岗位相应专业技术资格证书' name='"持有从事岗位相应专业技术资格证书"' field="" style="width:10%"  maxlength="50"/>
	<u> </u>人。</span></p>
<p class=MsoNormal style='text-indent: 50pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>5.</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>从业人员中担任区县级以上党代表
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='担任区县级以上党代表' name='"担任区县级以上党代表"' field="" style="width:10%"  maxlength="50"/>
	<u></u>人、人大代表
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='人大代表' name='"人大代表"' field="" style="width:10%"  maxlength="50"/>
	<u> </u>人、政协委员
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='政协委员' name='"政协委员"' field="" style="width:10%"  maxlength="50"/>
	<u> </u>人。</span></p>
<p class=MsoNormal style='text-indent: 50pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>6.</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>从业人员中具有行政级别：省部级
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='省部级' name='"省部级"' field="" style="width:10%"  maxlength="50"/>	
	<u></u>人、厅局级
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='厅局级' name='"厅局级"' field="" style="width:10%"  maxlength="50"/>	
	<u></u>人、处级
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='处级' name='"处级"' field="" style="width:10%"  maxlength="50"/>
	<u></u>人。</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent: 25.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（二）负责人总数
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='负责人总数' name='"负责人总数"' field="" style="width:10%"  maxlength="50"/>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>人（其中女性数
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='负责人总数中女性数' name='"负责人总数中女性数"' field="" style="width:10%"  maxlength="50"/>	
	</span><u></u><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'>）。</span></p>
<p class=MsoNormal style='text-indent:50pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>
	<b style="color:red">*</b></span><strong><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312; font-weight: normal'>负责人指法定代表人、会长、副会长和秘书长</span></strong></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent: 25.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（三）法定代表人情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent:70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>姓名
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family: 仿宋_GB2312' type="text" title='法定代表人姓名' name='"法定代表人姓名"' field="" style="width:10%"  maxlength="50"/>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>政治面貌
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' field="politics" name='"法定代表人政治面貌"' title='法定代表人政治面貌'><option dataset="politicsDataSet"></option></select>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>性别
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' id="sex" field="sex"title="法定代表人性别" name='"法定代表人性别"'><option dataset="sexDataSet"></option></select>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>文化程度
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' field="sex" title="文化程度" name='"法定代表人文化程度"'><option dataset="eduDataSet"></option></select>	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span></p>
<p class=MsoNormal style='text-indent:70pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>离退休否
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' id="ifServe" field="ifServe" name='"法定代表人离退休否"' title='法定代表人离退休否'><option dataset="yesornoDataSet"></option></select>
	</span><u></u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>电话
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='法定代表人电话' name='"法定代表人电话"' field="" style="width:15%"  maxlength="50"/>
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>手机
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='法定代表人手机' name='"法定代表人手机"' field="" style="width:15%"  maxlength="50"/>	
	</span><u></u></p>
<p class=MsoNormal style='text-indent:70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>专职</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>/</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>兼职
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' field="ifFulltime" name='"法定代表人专/兼职"' title='法定代表人专/兼职'><option dataset="ifFulltimeDataSet"></option></select>	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>工作单位
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='法定代表人工作单位' name='"法定代表人工作单位"' field="" style="width:15%"  maxlength="50"/>	
	</span><u></u><span lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>&nbsp;</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>其它社会职务
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='法定代表人其它社会职务' name='"法定代表人其它社会职务"' field="" style="width:15%"  maxlength="50"/>	
	</span><u></u></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent: 25.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（四）会长（理事长、主席）情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent:70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>姓名
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='会长（理事长、主席）姓名' name='"会长（理事长、主席）姓名"' field="" style="width:10%"  maxlength="50"/>
	<u></u><span lang=EN-US>&nbsp;</span>政治面貌
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' field="politics" title='会长（理事长、主席）政治面貌' name='"会长（理事长、主席）政治面貌"'><option dataset="politicsDataSet"></option></select>
	<u></u><span lang=EN-US>&nbsp;</span>性别
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' id="sex" field="sex" title='会长（理事长、主席）性别' name='"会长（理事长、主席）性别"'><option dataset="sexDataSet"></option></select>	
	<u></u><span lang=EN-US>&nbsp;</span>文化程度
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' field="sex" title="文化程度" name='"会长（理事长、主席）文化程度"'><option dataset="eduDataSet"></option></select>	
	<u></u><span lang=EN-US>&nbsp;</span></p>
<p class=MsoNormal style='text-indent:70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>离退休否
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' id="ifServe" title='会长（理事长、主席）离退休否' field="ifServe" name='"会长（理事长、主席）离退休否"'><option dataset="yesornoDataSet"></option></select>	
	电话
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" title='会长（理事长、主席）电话' name='"会长（理事长、主席）电话"' field="" style="width:15%"  maxlength="50"/>
	<u></u><span lang=EN-US>&nbsp;</span></span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>手机
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" name='"会长（理事长、主席）手机"' title='会长（理事长、主席）手机' field="" style="width:15%"  maxlength="50"/>	
	</span><u></u></p>
<p class=MsoNormal style='text-indent:70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>专职<span
	lang=EN-US>/</span>兼职
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' field="ifFulltime" title='会长（理事长、主席）专/兼职' name='"会长（理事长、主席）专/兼职"'><option dataset="ifFulltimeDataSet"></option></select>	
	<u></u>工作单位
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" name='"会长（理事长、主席）工作单位"' title='会长（理事长、主席）工作单位' field="" style="width:15%"  maxlength="50"/>
	<u></u>其它社会职务
<input  style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312'type="text" name='"会长（理事长、主席）其它社会职务"' title='会长（理事长、主席）其它社会职务' field="" style="width:15%"  maxlength="50"/>
	<u></u></span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent: 25.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（五）秘书长情况</span></p>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
<p class=MsoNormal style='text-indent:70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>姓名
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" name='"秘书长姓名"' title='秘书长姓名' field="" style="width:10%"  maxlength="50"/>	
	</span><u></u><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>政治面貌
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' field="politics" title='秘书长政治面貌' name='"秘书长政治面貌"'><option dataset="politicsDataSet"></option></select>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>性别
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' id="sex" field="sex" title='"秘书长性别"' name='"秘书长性别"'><option dataset="sexDataSet"></option></select>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>文化程度
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' field="sex" title="文化程度" name='"秘书长文化程度"'><option dataset="eduDataSet"></option></select>		
	</span></p>
<p class=MsoNormal style='text-indent:70pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>离退休否
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' id="ifServe" title='秘书长离退休否' field="秘书长离退休否" name='"秘书长离退休否"'><option dataset="yesornoDataSet"></option></select>	
	</span><u></u><u><span style='font-size: 16.0pt; font-family: 仿宋_GB2312'> <span
	lang=EN-US> </span></span></u><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>电话
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" name='"秘书长电话"' title='秘书长电话' field="" style="width:15%"  maxlength="50"/>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>手机
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" name='"秘书长手机"' title='秘书长手机' field="" style="width:15%"  maxlength="50"/>	
	</span></p>
<p class=MsoNormal style='text-indent:70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>电子邮件
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" name='"秘书长电子邮件"' title='秘书长电子邮件' field="" style="width:15%"  maxlength="50"/>	
	</span></p>
<p class=MsoNormal style='text-indent:70pt'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>专职</span><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>/</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>兼职
<select style='font-size: 12.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' field="ifFulltime" name='"秘书长专/兼职"' title='"秘书长专/兼职"'><option dataset="ifFulltimeDataSet"></option></select>		
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>工作单位
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" name='"秘书长工作单位"' title='秘书长工作单位' field="" style="width:15%"  maxlength="50"/>	
	</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>其它社会职务
<input style='font-size: 14.0pt; font-family: 仿宋_GB2312; mso-hansi-font-family:  仿宋_GB2312' type="text" name='"秘书长其它社会职务"' title='秘书长其它社会职务' field="" style="width:15%"  maxlength="50"/>	
	</span><u></u></p>
</div>
</body>
</html>
