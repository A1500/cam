<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init12(){
	//创建页面导航下拉框
	//createFundDetailSelect();
				somJxActivityDataSet.setParameter("TASK_CODE", taskCode);
	somJxActivityDataSet.load();
	somJxActivityDataSet.on('load',function (){
		if(somJxActivityDataSet.getCount() == 0){
			somJxActivityDataSet.newRecord();
		}
	});
	//somJxOrganFundsDataSet12.setParameter("TASK_CODE", taskCode);
	//somJxOrganFundsDataSet12.setParameter("ORGAN_TYPE","5");
	///somJxOrganFundsDataSet12.load();
	//somJxOrganFundsDataSet12.on('load',function (){
		//if(somJxOrganFundsDataSet12.getCount() == 0){
			//for(var i = 0;i<15;i++){
				//addFTr12();
			//}
		//}else{
			//var count = 0;
			//var tab = document.getElementById("activitiesF12");
			//for(i=1;i<=somJxOrganFundsDataSet12.getCount();i++){
				//++count;
				//addFTr12();
				// rowLength = tab.rows.length;
				//for(j=1;j<=somJxOrganFundsDataSet12.getCount();j++){
				//	if(somJxOrganFundsDataSet12.getAt(j-1).get("seqNum") == i){
					//tab.rows[rowLength-1].cells[1].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet12.getAt(j-1).get("organName");
						//tab.rows[rowLength-1].cells[2].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet12.getAt(j-1).get("peopleName");
						//tab.rows[rowLength-1].cells[3].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet12.getAt(j-1).get("checkinType");
						//tab.rows[rowLength-1].cells[4].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet12.getAt(j-1).get("moneySum");
						//tab.rows[rowLength-1].cells[5].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet12.getAt(j-1).get("moneyOutSum");
					//}
				//}
			//}
			//for(i=0;i<15-count;i++){
				//addFTr12();
			//}
		//}
		 PROGRESS_BAR++;
	//});
}
function save(){
	somJxOrganFundsDataSet12.removeAll();
	var tab1 = document.getElementById("activitiesF12");
	for(i=1;i<tab1.rows.length;i++){
		var record = somJxOrganFundsDataSet12.newRecord();
		record.set("taskCode",taskCode);
		record.set("organType","5");
		record.set("seqNum",i);
		record.set("organName",tab1.rows[i].cells[1].getElementsByTagName("input")[0].value);
		record.set("peopleName",tab1.rows[i].cells[2].getElementsByTagName("input")[0].value);
		record.set("checkinType",tab1.rows[i].cells[3].getElementsByTagName("select")[0].value);
		record.set("moneySum",tab1.rows[i].cells[4].getElementsByTagName("input")[0].value);
		record.set("moneyOutSum",tab1.rows[i].cells[5].getElementsByTagName("input")[0].value);
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxOrganFundsDataSet12",somJxOrganFundsDataSet12.getAllRecords());
	command.execute("savePageJ12");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//增加一行方法
function addFTr12(){
	 var tab=document.getElementById("activitiesF12");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id = xuhao;
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = xuhao;
    //添加列:名称
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>"
    //添加列:负责人
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>";
    //添加列:登记时间
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label id='checkinTypeJ"+xuhao+"'></label></span></p>";
	//添加列:账户
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>";
	//添加列:开户银行
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 12.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>";

}
</script>
<model:datasets>
	<model:dataset id="somJxOrganFundsDataSet12" cmd="com.inspur.cams.sorg.jxcheck.somjxorganfunds.cmd.SomJxOrganFundsQueryCommand" method="queryNoPage" global="true" sortField="SEQ_NUM">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.SomJxOrganFunds"></model:record>
	</model:dataset>
	 <model:dataset id="somJxActivityDataSet" cmd="com.inspur.cams.sorg.jxcheck.somjxactivity.cmd.SomJxActivityQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxactivity.dao.SomJxActivity"></model:record>
	</model:dataset>
</model:datasets>
<div id="float_1" class="noprint">

</div>
<STYLE>
body {
	background-color: #ffffff;
	color: #000000;
	margin-left: 0;
	margin-top: 0;
	margin-width: 0;
	margin-height: 0;
	margin: 0px;
	font-size: 12px;
	font-family: '宋体 ';
	font-weight: normal;
	line-height: 18px;
}

table {
	color: #000000;
	font-size: 12px;
	font-family: '宋体 ';
	font-weight: normal;
}

textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.text12 {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	line-height: 21px;
}

.text14 {
	font-size: 14px;
	line-height: 25px;
}

.text14-h2 {
	font-size: 16px;
	letter-spacing: 1px;
	line-height: 200%;
}

.text16 {
	font-size: 20px;
	letter-spacing: 1px;
	line-height: 200%;
}

.text16-h30 {
	font-size: 16px;
	line-height: 30px;
	letter-spacing: normal;
}

.f14pt-boder1 {
	border: 1 solid #000000;
	font-size: 13px;
}

.f14pt-boder2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 13px;
}

.f14pt-boder3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 13px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f14pt-boder4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 13px;
}

.f14pt-b1 {
	border: 2 solid #000000;
	font-size: 13px;
}

.f14pt-b3 {
	border-bottom-width: 2px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 13px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f14pt-b2 {
	border-bottom-width: 2px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 13px;
	border-top-style: none;
	border-right-style: solid;
	border-left-style: none;
	border-right-width: 1px;
	border-right-color: #000000;
}

.boder16-0 {
	font-size: 16px;
	border: 0px none;
	vertical-align: middle;
}

.title20 {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
}

.title23 {
	font-family: '宋体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
}

.boder13-0 {
	font-size: 13px;
	border: 0px none;
	vertical-align: middle;
}

.text14-red {
	font-size: 14px;
	line-height: 20px;
	color: #FF0000;
}

.border-b-20 {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}
</STYLE>
&nbsp;&nbsp;&nbsp;&nbsp;


<div align=center>
<div align=left style="margin-top: 60px; width: 800px"  >
<form method="post"onsubmit="return false" dataset="somJxActivityDataSet">
<p class=MsoNormal style='line-height:24.0pt;mso-line-height-rule:exactly'><span
style='font-size:14.0pt;mso-bidi-font-size:12.0pt;font-family:仿宋;
mso-hansi-font-family:仿宋'>（七）其他活动情况<span lang=EN-US><o:p></o:p></span></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1、本组织承接政府转移职能和购买服务情况（填写承接内容）：</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>
	 <textarea field="undertakeCont"  title='本组织承接政府转移职能和购买服务情况' name='"本组织承接政府转移职能和购买服务情况"'  style="width:600;margin-left: 100"  rows="7"  readonly="readonly"></textarea>
	<br>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;资金（填写年度所获资金）:
<input title='资金' onkeyup="value=value.replace(/[^\d]/g,'')"
	type="text" field="capital"  title="年度所获资金" maxlength="6"  readonly="readonly"/>
；</span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、中央及省级党委、政府对本组织工作批示内容（填写批示内容）：</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="instructions"  title='中央及省级党委、政府对本组织工作批示内容' name='"中央及省级党委、政府对本组织工作批示内容"'   style="width:600;margin-left: 100"  rows="7" readonly="readonly"></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>



<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、中央及省级党委、政府对本组织在有关简报、通报情况:</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="bulletin"  title='中央及省级党委、政府对本组织在有关简报、通报情况' name='"中央及省级党委、政府对本组织在有关简报、通报情况"'   style="width:600;margin-left: 100"  rows="7" readonly="readonly"></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p>


<p class=MsoNormal
	style="text-align:left"><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4、本组织在全国及省级党委、政府部门召开会议上的典型发言情况:</span><u><span
	style='font-size: 14.0pt; font-family: 仿宋'></span></u><span
	style='font-size: 14.0pt; font-family: 仿宋; mso-hansi-font-family: 宋体'>


 <textarea field="statement"  title='本组织在全国及省级党委、政府部门召开会议上的典型发言情况' name='"本组织在全国及省级党委、政府部门召开会议上的典型发言情况"'  style="width:600;margin-left: 100"  rows="7" readonly="readonly" ></textarea>
	<br>
 </span><span
	lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><o:p></o:p></span></p></form>
</div></div>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		</td>
	</tr>
</TABLE>
</div>