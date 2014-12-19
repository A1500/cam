<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=gb2312">
<title>基 金 会</title>
<next:ScriptManager />
<script type="text/javascript" src="../../js/float.js"></script>
<link href="../../css/float.css" type="text/css" rel="stylesheet" />
<script language="javascript">
var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init(){
	//创建页面导航下拉框
	createFundEditSelect();
	somJxOrganFundsDataSet.setParameter("TASK_CODE", taskCode);
	somJxOrganFundsDataSet.setParameter("ORGAN_TYPE","1");
	somJxOrganFundsDataSet.load();
	somJxOrganFundsDataSet.on('load',function (){
		if(somJxOrganFundsDataSet.getCount() == 0){
			for(var i = 0;i<6;i++){
				addFTr();
			}
		}else{
			var tab = document.getElementById("activitiesF");
			for(i=1;i<=somJxOrganFundsDataSet.getCount();i++){
				addFTr();
				var rowLength = tab.rows.length;
				for(j=1;j<=somJxOrganFundsDataSet.getCount();j++){
					if(somJxOrganFundsDataSet.getAt(j-1).get("sequence") == i){
						tab.rows[rowLength-1].cells[1].getElementsByTagName("textarea")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("organName");
						tab.rows[rowLength-1].cells[2].getElementsByTagName("input")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("manager");
						tab.rows[rowLength-1].cells[3].getElementsByTagName("input")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("regTime");
						tab.rows[rowLength-1].cells[4].getElementsByTagName("input")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("regNumber");
						tab.rows[rowLength-1].cells[5].getElementsByTagName("textarea")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("address");
						tab.rows[rowLength-1].cells[6].getElementsByTagName("select")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("depositBankAccounts");
						tab.rows[rowLength-1].cells[7].getElementsByTagName("textarea")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("depositBank");
					}
				}
				
			}
		}
	});
}
function save(){
	somJxOrganFundsDataSet.removeAll();
	var tab1 = document.getElementById("activitiesF");
	for(i=1;i<tab1.rows.length;i++){
		var record = somJxOrganFundsDataSet.newRecord();
		record.set("taskCode",taskCode);
		record.set("organType","1");
		record.set("sequence",i);
		record.set("organName",tab1.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("manager",tab1.rows[i].cells[2].getElementsByTagName("input")[0].value);
		record.set("regTime",tab1.rows[i].cells[3].getElementsByTagName("input")[0].value);
		record.set("regNumber",tab1.rows[i].cells[4].getElementsByTagName("input")[0].value);
		record.set("address",tab1.rows[i].cells[5].getElementsByTagName("textarea")[0].innerHTML);
		record.set("depositBankAccounts",tab1.rows[i].cells[6].getElementsByTagName("select")[0].value);
		record.set("depositBank",tab1.rows[i].cells[7].getElementsByTagName("textarea")[0].value);
		var organName=tab1.rows[i].cells[1].getElementsByTagName("textarea")[0].value;
		var peopleName=tab1.rows[i].cells[2].getElementsByTagName("input")[0].value;
		var organDate=tab1.rows[i].cells[3].getElementsByTagName("input")[0].value;
		var sorgCode=tab1.rows[i].cells[4].getElementsByTagName("input")[0].value;
		var place=tab1.rows[i].cells[5].getElementsByTagName("textarea")[0].innerHTML;
		var accountType=tab1.rows[i].cells[6].getElementsByTagName("select")[0].value;
		var openAccount=tab1.rows[i].cells[7].getElementsByTagName("textarea")[0].value;
		if(organName==""||peopleName==""||organDate==""||sorgCode==""||place==""||accountType==""||openAccount==""){
			if(i==1){
				L5.Msg.alert("提示","请至少填齐一行分支机构信息！没有的请填无！");
				return "break";
			}else{
				if(!(organName==""&&peopleName==""&&organDate==""&&sorgCode==""&&place==""&&accountType==""&&openAccount=="")){
					L5.Msg.alert("提示","请至少填齐一行分支机构信息！");
					return "break";
				}			
			}
		}
	}
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxOrganFundsDataSet",somJxOrganFundsDataSet.getAllRecords());
	command.execute("savePageJ8");
	if (!command.error) {
		alert("保存成功！");		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//增加一行方法
function addFTr(){
	 var tab=document.getElementById("activitiesF");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id = xuhao;
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.textAlign="center";
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
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><textarea id='organName"+xuhao+"' onkeyup='this.value = this.value.slice(0,100)' ROWS='3' COLS='20'></textarea></span></p>"
    //添加列:负责人
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><input id='manager"+xuhao+"' type='text' style='width: 100%;' maxlength='30'></span></p>";
    //添加列:登记时间
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><input id='regTime"+xuhao+"' type='text' style='width: 100%;' maxlength='10'></span></p>";
    //添加列:登记证号
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><input id='regNumber"+xuhao+"' type='text' style='width: 100%;' maxlength='20'></span></p>";
	//添加列:住所
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><textarea id='address"+xuhao+"' type='text' style='width: 100%;' onkeyup='this.value = this.value.slice(0,100)' ROWS='3' COLS='20' ></textarea></span></p>";
	//添加列:账户
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><select id='depositBankAccounts"+xuhao+"' style='width:100%;'><option  value=''>请选择...</option><option value='1'>基本账户</option><option value='2'>一般账户</option><option value='0'>无</option></select></span></p>";
	//添加列:开户银行
    var newNameTD=newTR.insertCell(7);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 12.0pt; font-family: 仿宋'><textarea  ROWS='3' COLS='20' onkeyup='this.value = this.value.slice(0,100)' ></textarea></span></p>";

}
</script>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxOrganFundsDataSet" cmd="com.inspur.cams.sorg.check.checksuborgan.cmd.SomCheckSuborganQueryCommand" method="queryNoPage" global="true"  sortField="TO_NUMBER(SEQUENCE)">
		<model:record fromBean="com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ('9')" />
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ('7')" />
	<input type="button" value="保存" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="save();" />
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 320px;" onclick="backJ();" />
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
<TABLE cellSpacing=0 cellPadding=0 width=950 align=center border=0>
	<TBODY>
		<TR>
			<TD height=21>&nbsp;</TD>
		</TR>
		<TR>
			<TD class=text14 height=50>
			<TABLE cellSpacing=0 cellPadding=0 width='97%' align=center border=0>
				<TBODY>
					<TR>
						<TD class=text14><STRONG>分支机构情况</STRONG></TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD height=14>
			<TABLE class=f14pt-b1 cellSpacing=0 cellPadding=0 width='96%' id="activitiesF"
				align=center border=0>
				<TBODY>
					<TR align=middle>
						<TD width='5%' align=center class=f14pt-boder2>序号</TD>
						<TD width='21%' height=50 align=center class=f14pt-boder2>名称</TD>
						<TD width='13%' align=center class=f14pt-boder2>负责人</TD>
						<TD width='10%' align=center class=f14pt-boder2>登记时间</TD>
						<TD width='10%' align=center class=f14pt-boder2>登记证号</TD>
						<TD width='13%' align=center class=f14pt-boder2>住所</TD>
						<TD width='10%' align=center class=f14pt-boder2>账户（分别填写：基本账户、一般账户或无）</TD>
						<TD width='24%' align=center class=f14pt-boder2>开户银行和账号</TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE width='112' height='39' align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom>第8页</td>
	</tr>
</TABLE>

</body>
</html>
