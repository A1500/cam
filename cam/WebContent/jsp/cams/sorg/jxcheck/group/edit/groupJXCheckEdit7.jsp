<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
 
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	var somCheckDataSet = L5.DatasetMgr.lookup("somCheckDataSet");
	somCheckDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckDataSet.load();
	somCheckDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckDataSet.newRecord();
		}
	});
	//创建页面导航下拉框
	createGroupEditSelect();
}
function save(){
	var somCheckDataSetIsValidate = somCheckDataSet.isValidate();
	if(somCheckDataSetIsValidate!=true){
		L5.Msg.alert("提示",somCheckDataSetIsValidate);
		return;
	}
	var checkRecord=somCheckDataSet.getCurrent();
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("checkRecord", checkRecord);
	command.setParameter("taskCode", taskCode);
	command.execute("savePage18");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function nextPage(){
	
	var data = new L5.Map();
	var url='jsp/cams/sorg/jxcheck/group/edit/groupJXCheckEdit8.jsp';
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
</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckDataSet" cmd="com.inspur.cams.sorg.check.somcheck.cmd.SomCheckQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.somcheck.data.SomCheck">
			<model:field name="otherDesc" type="string" rule="require|length{3500}"/>
		</model:record>
	</model:dataset>
</model:datasets>
<div id="float">	
<!--[if lte IE 7]><div></div><![endif]-->
	<input type="button" value="下一页" style="height:25px;width:80px;position:absolute;margin-left:20px;" onclick="nextPage()"/>
<!--[if lte IE 7]><div></div><![endif]--> 
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;"	onclick="save();" /> 
<!--[if lte IE 7]><div></div><![endif]--> 
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;"	onclick="back();" />
</div>
<table border=0 >
<tr>
<td>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>

<p class=MsoNormal
	style='text-indent: 32.15pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>六、财务情况</span></b><b><span lang=EN-US
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: "Times New Roman"'><o:p></o:p></span></b></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（一）财务情况<b><span
	lang=EN-US><o:p></o:p></span></b></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>上年度净资产合计：<span
	lang=EN-US>
	<input field="" name='"上年度净资产合计"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>本年度收入合计：<span
	lang=EN-US>
	<input field="" name='"本年度收入合计"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>其中，1、提供服务收入：<span lang=EN-US><span>
	<input field="" name='"提供服务收入"' style="width: 15%; " maxlength="" />
	</span></span>元（其中，政府购买服务收入：<span
	lang=EN-US>
	<input field="" name='"政府购买服务收入"' style="width: 15%; " maxlength="" />
	</span>元）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>2</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、会费收入：<span
	lang=EN-US>
	<input field="" name='"会费收入"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>3</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、接受社会捐赠：<span
	lang=EN-US>
	<input field="" name='"接受社会捐赠"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>4</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、政府补助收入：<span
	lang=EN-US>
	<input field="" name='"政府补助收入"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>5</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、其他收入：<span
	lang=EN-US>
	<input field="" name='"其他收入"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>本年度费用合计：<span
	lang=EN-US>
	<input field="" name='"本年度费用合计"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>其中，<span
	lang=EN-US>1</span>、业务活动成本：<span lang=EN-US><span>
	<input field="" name='"业务活动成本"' style="width: 15%; " maxlength="" />
	</span></span>元<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>2</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、公益事业支出：<span
	lang=EN-US>
	<input field="" name='"公益事业支出"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>3</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、管理费用：<span
	lang=EN-US>
	<input field="" name='"管理费用"' style="width: 15%; " maxlength="" />
	</span>元（其中工资福利
	<input field="" name='"工资福利"' style="width: 15%; " maxlength="" />
	，办公开支
	<input field="" name='"办公开支"' style="width: 15%; " maxlength="" />
	，其它
	<input field="" name='"其它"' style="width: 15%; " maxlength="" />
	）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>4</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>、其他费用：<span
	lang=EN-US>
	<input field="" name='"其他费用"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>本年度净资产合计：<span
	lang=EN-US>
	<input field="" name='"本年度净资产合计"' style="width: 15%; " maxlength="" />
	</span>元<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312;color:red'>*</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（上年度净资产合计<span
	lang=EN-US>+</span>本年度收入合计<span lang=EN-US>-</span>本年度费用合计<span
	lang=EN-US>=</span>本年度净资产合计）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>（二）纳税情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312'>2010</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>年度缴税总额<span
	lang=EN-US>
	<input field="" name='"年度缴税总额"' style="width: 15%; " maxlength="" />
	</span>元（其中缴营业税<span lang=EN-US>
	<input field="" name='"缴营业税"' style="width: 15%; " maxlength="" />
	</span>元，缴所得税<span lang=EN-US>
	<input field="" name='"缴所得税"' style="width: 15%; " maxlength="" />
	</span>元，缴其他税费<span lang=EN-US>
	<input field="" name='"缴其他税费"' style="width: 15%; " maxlength="" />
	</span>元。）<span lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal
	style='text-indent: 32.0pt; mso-char-indent-count: 2.0; mso-line-height-alt: 12.0pt'><span
	lang=EN-US style='font-size: 16.0pt; font-family: 仿宋_GB2312;color:red'>*</span><span
	style='font-size: 16.0pt; font-family: 仿宋_GB2312'>2010年未缴税的可填0<span
	lang=EN-US><o:p></o:p></span></span></p>
</td>
</tr>
</table>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</body>
</html>
