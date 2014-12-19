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
	var somCheckOrgDetailDataSet = L5.DatasetMgr.lookup("somCheckOrgDetailDataSet");
	somCheckOrgDetailDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckOrgDetailDataSet.load();
	somCheckOrgDetailDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckOrgDetailDataSet.newRecord();
		}
	});
	var somCheckSuborganDataSet = L5.DatasetMgr.lookup("somCheckSuborganDataSet_9");
	somCheckSuborganDataSet.setParameter("TASK_CODE@=", taskCode);
	somCheckSuborganDataSet.setParameter("ORGAN_TYPE@=", "F");//分支机构
	somCheckSuborganDataSet.load();
	somCheckSuborganDataSet.on("load",function(ds){
		if(ds.getCount()==0){
			somCheckSuborganDataSet.newRecord();
			for(i=0;i<15;i++){
				addTr_9();
			}
		}else{
			for(i=1;i<=ds.getCount();i++){
				addTr_9();
				var sequence = ds.getAt(i-1).get("sequence");
				document.getElementById("organName_9"+sequence).innerHTML=ds.getAt(i-1).get("organName");
				document.getElementById("manager_9"+sequence).innerHTML=ds.getAt(i-1).get("manager");
				document.getElementById("regTime_9"+sequence).innerHTML=ds.getAt(i-1).get("regTime");
				document.getElementById("regNumber_9"+sequence).innerHTML=ds.getAt(i-1).get("regNumber");
				document.getElementById("accounts_9"+sequence).value=ds.getAt(i-1).get("accounts");
				document.getElementById("address_9"+sequence).innerHTML=ds.getAt(i-1).get("address");
			}
		}
	});
	//创建页面导航下拉框
	//createGroupDetailSelect();
	init10();
	init11();
	init12();
	init13();
	init14();
	init15();
	init16();
	init17();
}
	//打印
	function docPrint(){
		document.execCommand("Print", false);
	}
//增加一行方法
function addTr_9(){
	 var tab=document.getElementById("table_9");
    //添加行
    var newTR = tab.insertRow(tab.rows.length);
    //trid++;
    //获取序号=行索引
    var  xuhao=newTR.rowIndex.toString();
    newTR.id = xuhao;
    //添加列:序号
    var newNameTD=newTR.insertCell(0);
    newNameTD.style.textAlign="center";
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = xuhao;
    //添加列:名称
    var newNameTD=newTR.insertCell(1);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><label class='label9'  name='名称' id='organName_9"+xuhao+"' style='width:98%'  maxlength='100'/></o:p></span></p>";
    //添加列:负责人
    var newNameTD=newTR.insertCell(2);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><label class='label9'  name='负责人' id='manager_9"+xuhao+"' style='width:98%'  maxlength='72'/></o:p></span></p>";
    //添加列:登记时间
    var newNameTD=newTR.insertCell(3);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><label class='label9'  name='登记时间' id='regTime_9"+xuhao+"' style='width:98%'/></o:p></span></p>";
    //添加列:登记证号
    var newNameTD=newTR.insertCell(4);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><label class='label9'  name='登记证号' id='regNumber_9"+xuhao+"' style='width:98%' maxlength='30'/></o:p></span></p>";
 	//添加列:账户
    var newNameTD=newTR.insertCell(5);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US style='color: red'><o:p><select name='账户' id='accounts_9"+xuhao+"' style='width:98%' disabled><option  value=''>请选择...</option><option  value='1'>基本账户</option><option  value='2'>普通账户</option><option  value='3'>无</option></select></o:p></span></p>";
	//添加列:住所
    var newNameTD=newTR.insertCell(6);
    newNameTD.style.borderLeft="solid windowtext 1.0pt";
    newNameTD.style.borderBottom=" solid windowtext 1.0pt";
    newNameTD.style.borderRight="solid windowtext 1.0pt";
    newNameTD.style.borderTop="solid windowtext 1.0pt";
    //添加列内容
    newNameTD.innerHTML = "<p class=MsoNormal style='line-height: 13.0pt; mso-line-height-rule: exactly'><span lang=EN-US><o:p><label class='label9'  name='住所' id='address_9"+xuhao+"' style='width:98%'  maxlength='100'/></o:p></span></p>";

}
function back(){
	var data = new L5.Map();
	var url='jsp/cams/sorg/check/group/query/somGroupCheckQueryList.jsp';
	var text = '年检查询';
	L5.forward(url,text,data);
}		
</script>
<style media="print">
	.noprint     { display: none }
</style>
<style>
.label9 {
	text-align:center;
}
</style>
</head>

<body>
<model:datasets>
	<model:dataset id="somCheckSuborganDataSet_9" cmd="com.inspur.cams.sorg.check.checksuborgan.cmd.SomCheckSuborganQueryCommand" global="true" pageSize="300">
		<model:record fromBean="com.inspur.cams.sorg.check.checksuborgan.data.SomCheckSuborgan"></model:record>
	</model:dataset>
	<model:dataset id="somCheckOrgDetailDataSet" cmd="com.inspur.cams.sorg.check.checkorgdetail.cmd.SomCheckOrgDetailQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.check.checkorgdetail.data.SomCheckOrgDetail"></model:record>
	</model:dataset>
	<!-- 帐户 -->
	<model:dataset id="accountsSelect" enumName="SOM.CHECK.ACCOUNTS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<div id="float" class="noprint">
	<input type="button" value="操作说明" style="height: 25px; width: 80px; position: absolute; margin-left: 20px;" onclick="operDesc()"/>
	<input type="button" value="返回" style="height: 25px; width: 80px; position: absolute; margin-left: 120px;" onclick="back();" />
	<input type="button" value="打印" style="height: 25px; width: 80px; position: absolute; margin-left: 220px;" onclick="docPrint();"/>
</div>
<div align=center style='page-break-after:always'>
<div align=center style="margin-top: 20px; width: 800px">

<p class=MsoNormal align=center width=800px
	style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>四、分支机构、代表机构、专项基金管理机构、<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=center width=800px
	style='text-align: center; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	style='font-size: 16.0pt; font-family: 黑体; mso-hansi-font-family: 宋体'>办事机构基本情况<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left width=800px
	style='line-height: 15.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span lang=EN-US
	style='font-size: 16.0pt; font-family: 宋体'><o:p>&nbsp;</o:p></span></b></p>

<p class=MsoNormal align=left width=800px
	style='text-indent: 27.55pt; mso-char-indent-count: 1.96; line-height: 25.0pt; mso-line-height-rule: exactly'><b
	style='mso-bidi-font-weight: normal'><span
	style='font-size: 14.0pt; font-family: 宋体'>（一）分支机构情况<span
	lang=EN-US><o:p></o:p></span></span></b></p>
<form method="post" dataset="somCheckOrgDetailDataSet" onsubmit="return false">
<p class=MsoNormal align=left width=800px
	style='margin-left: 26.0pt; mso-char-indent-count: 2.0; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.5pt'>1</span><span
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.5pt'>．本年度新设立分支机构（
	<label class='label9'  field="branchBuildNum" style="width:50"></label>
	）个，其中已办理成立登记手续的（
	<label class='label9'  field="branchBuildedNum" style="width:50"></label>
	）个；<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left width=800px
	style='margin-left: 26.0pt; mso-char-indent-count: 2.0; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.5pt'>2</span><span
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.5pt'>．本年度注销分支机构（
	<label class='label9'  field="branchCancelNum" style="width:50"></label>
	）个，其中已办理注销登记手续的（
	<label class='label9'  field="branchCanceledNum" style="width:50"></label>
	）个；<span
	lang=EN-US><o:p></o:p></span></span></p>

<p class=MsoNormal align=left width=800px
	style='text-indent: 26.4pt; mso-char-indent-count: 2.0; line-height: 25.0pt; mso-line-height-rule: exactly'><span
	lang=EN-US
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.4pt'>3</span><span
	style='font-size: 14.0pt; font-family: 宋体; letter-spacing: -.4pt'>．目前本社团分支机构设置情况如下：<span
	lang=EN-US><o:p></o:p></span></span></p>
</form>
<form method="post" onsubmit="return false">
<table id="table_9" class=MsoNormalTable border=1 cellspacing=0 cellpadding=0
	width="800px"
	style='width:800px; border-collapse: collapse; border: none; mso-border-alt: solid windowtext .5pt; mso-yfti-tbllook: 480; mso-padding-alt: 0cm 5.4pt 0cm 5.4pt; mso-border-insideh: .5pt solid windowtext; mso-border-insidev: .5pt solid windowtext'>
	<tr style='height: 19.3pt'>
		<td width="5%"
			style='width: 5.02%; border-top: 1.0pt; border-left: 1.0pt; border-bottom: 1.0pt; border-right: 1.0pt; border-color: windowtext; border-style: solid; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='margin-top: 0cm; margin-right: -5.35pt; margin-bottom: 0cm; margin-left: -5.25pt; margin-bottom: .0001pt; mso-para-margin-top: 0cm; mso-para-margin-right: -.51gd; mso-para-margin-bottom: 0cm; mso-para-margin-left: -.5gd; mso-para-margin-bottom: .0001pt; text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>序号</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="19%"
			style='width: 19.34%; border-top: solid windowtext 1.0pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>名</span><span
			lang=EN-US style='font-size: 12.0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>称</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.32%; border-top: solid windowtext 1.0pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='margin-top: 0cm; margin-right: -5.35pt; margin-bottom: 0cm; margin-left: -6.3pt; margin-bottom: .0001pt; mso-para-margin-top: 0cm; mso-para-margin-right: -.51gd; mso-para-margin-bottom: 0cm; mso-para-margin-left: -.6gd; mso-para-margin-bottom: .0001pt; text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>负责人</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="14%"
			style='width: 14.48%; border-top: solid windowtext 1.0pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>登记时间</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="13%"
			style='width: 13.74%; border-top: solid windowtext 1.0pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>登记证号</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
		<td width="11%"
			style='width: 11.8%; border-top: solid windowtext 1.0pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>账</span><span
			style='font-size: 12.0pt'> </span><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>户</span><span
			lang=EN-US style='font-size: 12.0pt; color: red'><o:p></o:p></span></p>
		</td>
		<td width="20%"
			style='width: 20.3%; border-top: solid windowtext 1.0pt; border-left: none; border-bottom: solid windowtext 1.0pt; border-right: solid windowtext 1.0pt; mso-border-left-alt: solid windowtext .5pt; mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt; mso-border-right-alt: 1.5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid; padding: 0cm 5.4pt 0cm 5.4pt; height: 19.3pt'>
		<p class=MsoNormal align=center
			style='text-align: center; line-height: 15.0pt; mso-line-height-rule: exactly'><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>住</span><span
			lang=EN-US style='font-size: 12.0pt'><span
			style='mso-spacerun: yes'>&nbsp;&nbsp;&nbsp; </span></span><span
			style='font-size: 12.0pt; font-family: 宋体; mso-ascii-font-family: "Times New Roman"; mso-hansi-font-family: "Times New Roman"'>所</span><span
			lang=EN-US style='font-size: 12.0pt'><o:p></o:p></span></p>
		</td>
	</tr>
	
</table>
</form>
</div>
<p class=MsoNormal><span lang=EN-US><o:p>&nbsp;</o:p></span></p>
</div>
<next:Window id="winOperDesc" closeAction="hide" title="操作说明" width="800"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeOperDesc"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
	<div>
	<span style="font-size:14px;color:red">
				操作说明：<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;请先点击左上方的“文件”，出现一个下拉菜单，点击下拉菜单中的“页面设置”项（从上数第六个，IE浏览器的“页面设置”），弹出一个“页面设置”的对话框。<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.请设置纸张大小为“A4”; <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.删除掉“页眉“中的字符“&w&b页码，&p/&P”和“页脚“中的字符“&u&b&d”; <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.把方向设置为”纵向”; <br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.把页边距的“上”、“下”、“左”、“右”都设置为“10”；<br> 
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;点击确定按钮，对话框关闭。请单击“打印”按钮进行打印。 <br>
	</span>
	</div>
	</next:Html>
</next:Window>
<jsp:include page="groupCheckPrint10.jsp" flush='true' />
<jsp:include page="groupCheckPrint11.jsp" flush='true' />
<jsp:include page="groupCheckPrint12.jsp" flush='true' />
<jsp:include page="groupCheckPrint13.jsp" flush='true' />
<jsp:include page="groupCheckPrint14.jsp" flush='true' />
<jsp:include page="groupCheckPrint15.jsp" flush='true' />
<jsp:include page="groupCheckPrint16.jsp" flush='true' />
<jsp:include page="groupCheckPrint17.jsp" flush='true' />
<jsp:include page="groupCheckPrint18.jsp" flush='true' />
<jsp:include page="groupCheckPrint19.jsp" flush='true' />
</body>
</html>

