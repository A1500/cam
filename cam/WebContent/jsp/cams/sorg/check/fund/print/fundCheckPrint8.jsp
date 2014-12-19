<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script language="javascript">
//var taskCode='<%=request.getParameter("taskCode")%>';
//初始化
function init8(){
	//创建页面导航下拉框
	//createFundDetailSelect();
	somJxOrganFundsDataSet8.setParameter("TASK_CODE", taskCode);
	somJxOrganFundsDataSet8.setParameter("ORGAN_TYPE","1");
	somJxOrganFundsDataSet8.load();
	somJxOrganFundsDataSet8.on('load',function (){
		if(somJxOrganFundsDataSet8.getCount() == 0){
			for(var i = 0;i<15;i++){
				addFTr8();
			}
		}else{
			var tab = document.getElementById("activitiesF8");
			for(i=1;i<=somJxOrganFundsDataSet8.getCount();i++){
				addFTr8();
				var rowLength = tab.rows.length;
				for(j=1;j<=somJxOrganFundsDataSet8.getCount();j++){
					if(somJxOrganFundsDataSet8.getAt(j-1).get("seqNum") == i){
						tab.rows[rowLength-1].cells[1].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet8.getAt(j-1).get("organName");
						tab.rows[rowLength-1].cells[2].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet8.getAt(j-1).get("peopleName");
						tab.rows[rowLength-1].cells[3].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet8.getAt(j-1).get("organDate");
						tab.rows[rowLength-1].cells[4].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet8.getAt(j-1).get("sorgCode");
						tab.rows[rowLength-1].cells[5].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet8.getAt(j-1).get("place");
						tab.rows[rowLength-1].cells[6].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet8.getAt(j-1).get("accountType");
						tab.rows[rowLength-1].cells[7].getElementsByTagName("label")[0].innerHTML=somJxOrganFundsDataSet8.getAt(j-1).get("openAccount");
					}
				}
				
			}
		}
	});
}
function save(){
	somJxOrganFundsDataSet8.removeAll();
	var tab1 = document.getElementById("activitiesF8");
	for(i=1;i<tab1.rows.length;i++){
		var record = somJxOrganFundsDataSet8.newRecord();
		record.set("taskCode",taskCode);
		record.set("organType","1");
		record.set("seqNum",i);
		record.set("organName",tab1.rows[i].cells[1].getElementsByTagName("textarea")[0].value);
		record.set("peopleName",tab1.rows[i].cells[2].getElementsByTagName("input")[0].value);
		record.set("organDate",tab1.rows[i].cells[3].getElementsByTagName("input")[0].value);
		record.set("sorgCode",tab1.rows[i].cells[4].getElementsByTagName("input")[0].value);
		record.set("place",tab1.rows[i].cells[5].getElementsByTagName("textarea")[0].innerHTML);
		record.set("accountType",tab1.rows[i].cells[6].getElementsByTagName("select")[0].value);
		record.set("openAccount",tab1.rows[i].cells[7].getElementsByTagName("textarea")[0].value);
	}
	var command = new L5.Command("com.inspur.cams.sorg.jxcheck.somjxcheck.cmd.SomJxCheckCommand");
	command.setParameter("taskCode",taskCode);
	command.setParameter("somJxOrganFundsDataSet8",somJxOrganFundsDataSet8.getAllRecords());
	command.execute("savePageJ8");
	if (!command.error) {
		L5.Msg.alert("提示","保存成功！",function(){
		});		
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
//增加一行方法
function addFTr8(){
	 var tab=document.getElementById("activitiesF8");
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
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label id='organName"+xuhao+"'></label></span></p>"
    //添加列:负责人
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label id='peopleName"+xuhao+"'></label></span></p>";
    //添加列:登记时间
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML ="<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label id='organDate"+xuhao+"' type='text' style='width: 100%;'></label></span></p>";
    //添加列:登记证号
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label id='sorgCode"+xuhao+"' style='width: 100%;'></label></span></p>";
	//添加列:住所
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label id='place"+xuhao+"' style='width: 100%;' ></label></span></p>";
	//添加列:账户
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 14.0pt; font-family: 宋体'><label id='accountType"+xuhao+"' style='width:100%;'></label></span></p>";
	//添加列:开户银行
    var newNameTD=newTR.insertCell(7);
    newNameTD.style.padding="0cm 5.4pt 0cm 5.4pt";
    newNameTD.style.borderBottom="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='mso-line-height-alt: 12.0pt'><span lang=EN-US style='font-size: 12.0pt; font-family: 宋体'><label ></label></span></p>";

}
</script>
<model:datasets>
	<model:dataset id="somJxOrganFundsDataSet8" cmd="com.inspur.cams.sorg.jxcheck.somjxorganfunds.cmd.SomJxOrganFundsQueryCommand" method="queryNoPage" global="true"  sortField="SEQ_NUM">
		<model:record fromBean="com.inspur.cams.sorg.jxcheck.somjxorganfunds.dao.SomJxOrganFunds"></model:record>
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
<div style='page-break-after:always'>
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
			<TABLE class=f14pt-b1 cellSpacing=0 cellPadding=0 width='96%' id="activitiesF8"
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
		<td width='100%' height='27' align=center valign=bottom></td>
	</tr>
</TABLE>
</div>
