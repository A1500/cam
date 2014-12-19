<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init5(){
	//createFundDetailSelect();
	var somJxFundPeopleDataSet5 = L5.DatasetMgr.lookup("somJxFundPeopleDataSet5");
	somJxFundPeopleDataSet5.setParameter("TASK_CODE", taskCode);
	somJxFundPeopleDataSet5.setParameter("PEOPLE_TYPE","3");
	somJxFundPeopleDataSet5.load();
	somJxFundPeopleDataSet5.on("load",function(ds){
		if(ds.getCount()==0){
			for(i=0;i<35;i++){
				addTr5();
			}
		}else{
			for(i=1;i<=ds.getCount();i++){
				for(j=0;j<ds.getCount();j++){
					var record = ds.getAt(j);
					if( record.get('seqNum') == i ){
						var tab1 = document.getElementById("activities5");
						addTr5();
						var rowLength = tab1.rows.length;
						tab1.rows[rowLength-2].cells[1].getElementsByTagName("label")[0].innerHTML=record.get("name");
						var political = "";
						if(record.get("political")=="01"){
							political = "中国共产党党员";
						}
						if(record.get("political")=="02"){
							political = "中国共产党预备党员";
						}
						if(record.get("political")=="03"){
							political = "中国共产主义青年团团员";
						}
						if(record.get("political")=="04"){
							political = "中国国民党革命委员会会员";
						}
						if(record.get("political")=="05"){
							political = "中国民主同盟盟员";
						}
						if(record.get("political")=="06"){
							political = "中国民主建国会会员";
						}
						if(record.get("political")=="07"){
							political = "中国民主促进会会员";
						}
						if(record.get("political")=="08"){
							political = "中国农工民主党党员";
						}
						if(record.get("political")=="09"){
							political = "中国致公党党员";
						}
						if(record.get("political")=="10"){
							political = "九三学社社员";
						}
						if(record.get("political")=="11"){
							political = "台湾民主自治同盟盟员";
						}
						if(record.get("political")=="12"){
							political = "无党派民主人士";
						}
						if(record.get("political")=="13"){
							political = "群众";
						}
						tab1.rows[rowLength-2].cells[2].getElementsByTagName("label")[0].innerHTML=political;
						tab1.rows[rowLength-2].cells[3].getElementsByTagName("label")[0].innerHTML=record.get("workAndDuty");
					}
				}
			}
			document.getElementById('averageYearlySalary').innerHTML=ds.getCurrent().get('averageYearlySalary');
		}
	});
}
function save(){
	var somJxFundPeopleDataSet5IsValidate = somJxFundPeopleDataSet5.isValidate();
	if(somJxFundPeopleDataSet5IsValidate!=true){
		L5.Msg.alert("提示",somJxFundPeopleDataSet5IsValidate);
		return;
	}
	somJxFundPeopleDataSet5.removeAll();
	var tab1 = document.getElementById("activities5");
	var averageYearlySalary = document.getElementById('averageYearlySalary').value;
	for(i=1;i<tab1.rows.length-1;i++){
		var record = somJxFundPeopleDataSet5.newRecord();
		record.set("peopleType","3");
		record.set("seqNum",i);
		record.set("name",tab1.rows[i].cells[1].getElementsByTagName("input")[0].value);
		record.set("political",tab1.rows[i].cells[2].getElementsByTagName("select")[0].value);
		record.set("workAndDuty",tab1.rows[i].cells[3].getElementsByTagName("input")[0].value);
		record.set("averageYearlySalary",averageYearlySalary);
	}
	var fundPeopleRecords=somJxFundPeopleDataSet5.getAllRecords();
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("fundPeopleRecords", fundPeopleRecords);
	command.setParameter("taskCode", taskCode);
	command.execute("savePageJ5");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//增加一行方法
function addTr5(){
	 var tab=document.getElementById("activities5");
    //添加行
    var newTR = tab.insertRow(tab.rows.length-1);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id = xuhao;
     //获取序号=行索引
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom=" solid windowtext 0.5pt";
    newNameTD.style.borderRight="solid windowtext 0.5pt";
    //添加列内容
    newNameTD.innerHTML = xuhao;
    //添加列:姓名
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>"
    //添加列:政治面貌
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 12.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>";
    //添加列:所在部门及职务
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label style='width: 100%;'></label></span></p>";

}
</script>
<model:datasets>
	<model:dataset id="somJxFundPeopleDataSet5" cmd="com.inspur.cams.sorg.jxcheck.somjxfundpeople.cmd.SomJxFundPeopleQueryCommand" global="true" method="queryNoPage">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxfundpeople.dao.SomJxFundPeople"></model:record>
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
	font-size: 14px;
	font-family: '宋体 ';
	font-weight: normal;
}

textarea {
	overflow-x: hidden;
	overflow-y: hidden;
}

.text {
	font-size: 14px;
	line-height: 20px;
}

.text1 {
	font-size: 16px;
	letter-spacing: normal;
}

.text2 {
	font-size: 16px;
	line-height: 30px;
	letter-spacing: normal;
}

.unnamed1 {
	border: 1 solid #000000;
	font-size: 14px;
}

.unnamed2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 14px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.unnamed4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed5 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.unnamed6 {
	border-right-width: 2px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 14px;
}

.f16ps-size1 {
	border: 1 solid #000000;
	font-size: 16pt;
}

.f16ps-size2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.f16ps-size3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16pt;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.f16ps-size4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16pt;
}

.boder1 {
	border: 1 solid #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder3 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.boder4 {
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 16px;
	line-height: 25px;
}

.table {
	font-size: 14px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder-0 {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
}

.boder16pt-0 {
	font-size: 16pt;
	border: 0px none;
	vertical-align: middle;
}

.boderbgh-0 {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	color: #000000;
	background-color: #CCCCCC;
}

.boder0-color {
	font-size: 14px;
	border: 0px none;
	vertical-align: middle;
	background-color: #D8D8D8;
}

.table-text16 {
	font-size: 16px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.boder16-0 {
	font-size: 16px;
	border: 0px none;
	vertical-align: middle;
}

.title {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
}

.title1 {
	font-family: '宋体';
	font-size: 23px;
	font-weight: bold;
	color: #000000;
}

.text-12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	line-height: 21px;
	word-spacing: 120em;
}

.title2 {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-family: '宋体';
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-size: 23px;
	font-weight: bold;
	color: #000000;
}

.biaoti {
	font-family: '宋体';
	font-size: 15px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt {
	font-family: '黑体';
	font-size: 32px;
	font-weight: bold;
	color: #000000;
}

.minfei-bt1 {
	font-family: '宋体';
	font-size: 22px;
	color: #000000;
}

.minfei-bt2 {
	font-size: 20px;
	font-weight: bold;
	color: #000000;
	letter-spacing: 4pt;
}

.npo-bt {
	font-size: 42px;
	line-height: 25px;
	font-weight: bold;
	color: #000000;
	font-family: '宋体';
	text-indent: 10pt;
}

.npo-zi {
	font-family: '宋体';
	font-size: 20px;
	font-weight: bold;
	color: #000000;
}

.npo-font {
	font-family: '黑体';
	font-size: 22px;
	font-weight: normal;
	color: #000000;
}

.npo-bottomtext {
	font-family: '宋体';
	font-size: 28px;
	line-height: 15px;
	font-weight: bolder;
	color: #000000;
}

.font12s {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
}

.font12size {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	letter-spacing: 4px;
}

.font16pt {
	font-family: '宋体';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.table-text12 {
	font-size: 12px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
}

.font12size1 {
	border: 1 solid #000000;
	font-size: 12px;
	line-height: 22px;
}

.font12size2 {
	line-height: 22px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.font12size3 {
	line-height: 22px;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	font-size: 12px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
}

.font12size4 {
	line-height: 22px;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
	font-size: 12px;
}

.input-line16 {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	font-family: '宋体';
	color: #000000;
}

.font16fpt {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 30pt;
}

.font18pt {
	font-family: '宋体';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 4px;
	line-height: 45px;
}

.input-line16f {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '仿宋_GB2312';
}

.input-line16zc {
	font-size: 16pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '仿宋_GB2312';
	background-position: center center;
	text-align: center;
}

.input-line18 {
	font-size: 18pt;
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #000000;
	border-top-width: 0px;
	border-right-width: 0px;
	border-left-width: 0px;
	border-top-style: none;
	border-right-style: none;
	border-left-style: none;
	vertical-align: middle;
	font-family: '宋体';
	line-height: 40pt;
}

.stb-bt {
	font-family: '黑体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.stb-bt1 {
	font-family: '宋体';
	font-size: 30px;
	font-weight: bold;
	color: #000000;
	line-height: 40pt;
}

.boder18-0 {
	font-size: 18pt;
	border: 0px none;
	vertical-align: middle;
}

.select {
	font-family: '宋体';
	font-size: 12px;
	color: #000000;
	width: 80px;
}

.font16fpt-001 {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.font16pt-001 {
	font-family: '仿宋';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 2px;
	line-height: 24pt;
}

.hw-bt {
	font-family: '华文中宋';
	font-size: 26pt;
	font-weight: bold;
	color: #000000;
	letter-spacing: 2pt;
}

.kt-text {
	font-family: '楷体_GB2312';
	font-size: 16pt;
	color: #000000;
	font-weight: normal;
}

.hw-bt2 {
	font-family: '华文中宋';
	font-size: 18pt;
	font-weight: bold;
	color: #000000;
}

.fs-text {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
	line-height: 160%;
}

.ht-text {
	font-family: '黑体';
	font-size: 16pt;
	line-height: 110%;
	font-weight: normal;
	color: #000000;
	letter-spacing: 1pt;
}

.red {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #FF0000;
	line-height: 160%;
	letter-spacing: 1pt;
}

.textarea01 {
	font-family: '仿宋_GB2312';
	font-size: 16pt;
	color: #000000;
	letter-spacing: 1pt;
	border: 1px solid #000000;
	line-height: 160%;
}
</STYLE>
<div style='page-break-after:always'>
<TABLE height=436 cellSpacing=0 cellPadding=0 width=800 align=center
	border=0>
	<TBODY>
		<br>
		<TR>
			<TD align=middle height=24>&nbsp;</TD>
		</TR>
		<TR>
			<TD align=left height=14><STRONG>(四)工作人员名单</STRONG></TD>
		</TR>
		<TR>
			<TD vAlign=top>
			<TABLE class=unnamed1 cellSpacing=0 cellPadding=0 width='100%' id="activities5"
				border=0>
				<TBODY>
					<TR align=middle>
						<TD class=font12size2 width='5%' height=20>序号</TD>
						<TD class=font12size2 width='16%' height=20>姓名</TD>
						<TD class=font12size2 width='22%' height=20>政治面貌</TD>
						<TD width='57%' height=20 class=font12size3>所在部门及职务</TD>
					</TR>

					<tr align='middle'>
						<td height='20' align='left' colspan='4'>基金会工作人员的平均年工资为：<label
							style='border-bottom: solid 1px;width:100;font-size: 16.0pt; font-family: 宋体'
							ID='averageYearlySalary' ></label> 元</td>
					</tr>

				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		</td>
	</tr>
</TABLE>
</div>