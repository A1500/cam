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
	somJxOrganFundsDataSet.setParameter("ORGAN_TYPE","5");
	somJxOrganFundsDataSet.load();
	somJxOrganFundsDataSet.on('load',function (){
		if(somJxOrganFundsDataSet.getCount() == 0){
			for(var i = 0;i<5;i++){
				addFTr();
			}
		}else{
			var tab = document.getElementById("activitiesF");
			for(i=1;i<=somJxOrganFundsDataSet.getCount();i++){
				addFTr();
				var rowLength = tab.rows.length;
				for(j=1;j<=somJxOrganFundsDataSet.getCount();j++){
					if(somJxOrganFundsDataSet.getAt(j-1).get("sequence") == i){
						tab.rows[rowLength-1].cells[1].getElementsByTagName("input")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("organName");
						tab.rows[rowLength-1].cells[2].getElementsByTagName("input")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("manager");
						tab.rows[rowLength-1].cells[3].getElementsByTagName("select")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("checkinType");
						tab.rows[rowLength-1].cells[4].getElementsByTagName("input")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("moneySum");
						tab.rows[rowLength-1].cells[5].getElementsByTagName("input")[0].value=somJxOrganFundsDataSet.getAt(j-1).get("moneyOutSum");
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
		record.set("organType","5");
		record.set("sequence",i);
		record.set("organName",tab1.rows[i].cells[1].getElementsByTagName("input")[0].value);
		record.set("manager",tab1.rows[i].cells[2].getElementsByTagName("input")[0].value);
		record.set("checkinType",tab1.rows[i].cells[3].getElementsByTagName("select")[0].value);
		record.set("moneySum",tab1.rows[i].cells[4].getElementsByTagName("input")[0].value);
		record.set("moneyOutSum",tab1.rows[i].cells[5].getElementsByTagName("input")[0].value);
		var organName=tab1.rows[i].cells[1].getElementsByTagName("input")[0].value;
		var peopleName=tab1.rows[i].cells[2].getElementsByTagName("input")[0].value;
		var checkinType=tab1.rows[i].cells[3].getElementsByTagName("select")[0].value;
		var moneySum=tab1.rows[i].cells[4].getElementsByTagName("input")[0].value;
		var moneyOutSum=tab1.rows[i].cells[5].getElementsByTagName("input")[0].value;
		if(organName==""||peopleName==""||checkinType==""||moneySum==""||moneyOutSum==""){
			if(i==1){
				L5.Msg.alert("提示","请至少填齐一行经营性实体信息！没有的请填无！");
				return "break";
			}else{
				if(!(organName==""&&peopleName==""&&checkinType==""&&moneySum==""&&moneyOutSum=="")){
					L5.Msg.alert("提示","请至少填齐一行经营性实体信息！");
					return "break";
				}			
			}
		}
	}
	var command = new L5.Command("com.inspur.cams.sorg.check.somcheck.cmd.SomCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxOrganFundsDataSet",somJxOrganFundsDataSet.getAllRecords());
	command.execute("savePageJ12");
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
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><input  type='text' style='width: 100%;' maxlength='100'></span></p>"
    //添加列:负责人
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><input  type='text' style='width: 100%;' maxlength='72'></span></p>";
    //添加列:登记时间
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><select name='工商登记类型'  id='checkinTypeJ"+xuhao+"'><option  value=''>请选择...</option><option  value='1'>有限责任公司</option><option  value='2'>有限责任公司（国有独资）</option><option  value='3'>有限责任公司（自然人独资）</option><option  value='4'>有限责任公司（法人独资）</option><option  value='5'>股份有限公司</option><option  value='6'>股份有限公司（上市）</option><option  value='7'>有限责任公司分公司</option><option  value='8'>股份有限公司分公司 集体所有制（股份合作）企业</option><option  value='9'>集体所有制（股份合作）企业</option><option  value='10'>集体所有制（股份合作）企业设立的非法人分支机构</option><option  value='11'>集体所有制（股份合作）企业设立的法人分支机构</option><option  value='12'>集体所有制（股份合作）企业设立的法人分支机构的营业登记单位</option><option  value='13'>全民所有制企业</option><option  value='14'>全民所有制企业的营业单位</option><option  value='15'>集体所有制企业</option><option  value='16'>集体所有制企业的营业单位</option><option  value='17'>合伙企业（普通合伙、特殊普通合伙、有限合伙）</option><option  value='18'>合伙企业的分支机构</option><option  value='19'>个人独资企业</option><option  value='20'>个人独资企业的分支机构</option><option  value='21'>个体工商户</option><option  value='22'>无</option></select></span></p>";
	//添加列:账户
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 仿宋'><input  type='text' style='width: 100%;' maxlength='15'></span></p>";
	//添加列:开户银行
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 12.0pt; font-family: 仿宋'><input  type='text' style='width: 100%;' maxlength='15'></span></p>";

}
</script>
<style>
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somJxOrganFundsDataSet" cmd="com.inspur.cams.sorg.check.checksuborgan.cmd.SomCheckSuborganQueryCommand" method="queryNoPage" global="true"  sortField="TO_NUMBER(SEQUENCE)">
		<model:record fromBean="com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan"></model:record>
	</model:dataset>
</model:datasets>
<div id="float">
	<input type="button" value="下一页" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="nextPageJ('13')" />
	<input type="button" value="上一页" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="nextPageJ('11')" />
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
&nbsp;&nbsp;&nbsp;&nbsp;
<TABLE cellSpacing=0 cellPadding=0 width=800 align=center border=0>
	<TBODY>
		<TR>
			<TD height=43><strong>（不能完全填写的可复制本页填写）</strong></TD>
		</TR>
		<TR>
			<TD class=text14 height=14>
			<TABLE cellSpacing=0 cellPadding=0 width='97%' align=center border=0>
				<TBODY>
					<TR>
						<TD class=text14><STRONG>经营性实体情况</STRONG></TD>
					</TR>
				</TBODY>
			</TABLE>
			</TD>
		</TR>
		<TR>
			<TD height=14>
			<TABLE class=f14pt-b1 cellSpacing=0 cellPadding=0 width='98%' id="activitiesF"
				align=center border=0>
				<TBODY>
					<TR align=middle>
						<TD class=f14pt-boder2 width=5%>序号</TD>
						<TD class=f14pt-boder2 width=20% height=30>经营性实体名称</TD>
						<TD class=f14pt-boder2 width=15%%>法定代表人<br>
						或负责人</TD>
						<TD class=f14pt-boder2 width=30%>工商登记类型</TD>
						<TD class=f14pt-boder2 width=15%>总资本额<br>
						（万元）</TD>
						<TD class=f14pt-boder2 width=15%>本基金会<br>
						出资额<br>
						（万元）</TD>
					</TR>
						
				</TBODY>
			</TABLE>
			</TD>
		</TR>
	</TBODY>
</TABLE>
<TABLE align='center'>
	<tr valign=bottom align='center'>
		<td width='100%' height='27' align=center valign=bottom><br>
		第12页</td>
	</tr>
</TABLE>


</body>
</html>
