<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<!-- 党员基本情况 -->
<head>
<next:ScriptManager />
<script type="text/javascript" src="../js/somPartyReport.js"></script>
<script>
	function showDesc(){
		var win = L5.getCmp("descWin");
		win.show();
	}
	function winClose(){
		var win=L5.getCmp("descWin");
		win.hide();
	}
	function exportPrint(){
	
	}
	function query(){
		ds.load();
		ds.on('load',countSum);
		document.getElementById("reDiv").style.display="block";
	}
	function countSum(ds){
		var sum2 = parseInt(nullToZero(ds.get("PROVINCE_S")))+parseInt(nullToZero(ds.get("PROVINCE_J")))+parseInt(nullToZero(ds.get("PROVINCE_M")));
		var sum3 = parseInt(nullToZero(ds.get("CITY_S")))+parseInt(nullToZero(ds.get("CITY_J")))+parseInt(nullToZero(ds.get("CITY_M")));
		var sum4 = parseInt(nullToZero(ds.get("COUNTRY_S")))+parseInt(nullToZero(ds.get("COUNTRY_J")))+parseInt(nullToZero(ds.get("COUNTRY_M")));
		var sum1 = parseInt(sum2)+ parseInt(sum3)+ parseInt(sum4);
		var sumS = parseInt(nullToZero(ds.get("PROVINCE_S")))+parseInt(nullToZero(ds.get("CITY_S")))+parseInt(nullToZero(ds.get("COUNTRY_S")));
		var sumJ = parseInt(nullToZero(ds.get("PROVINCE_J")))+parseInt(nullToZero(ds.get("CITY_J")))+parseInt(nullToZero(ds.get("COUNTRY_J")));
		var sumM = parseInt(nullToZero(ds.get("PROVINCE_M")))+parseInt(nullToZero(ds.get("CITY_M")))+parseInt(nullToZero(ds.get("COUNTRY_M")));
		document.getElementById("sum1").innerHTML=sum1;
		document.getElementById("sum2").innerHTML=sum2;
		document.getElementById("sum3").innerHTML=sum3;
		document.getElementById("sum4").innerHTML=sum4;
		document.getElementById("sumS").innerHTML=sumS;
		document.getElementById("sumJ").innerHTML=sumJ;
		document.getElementById("sumM").innerHTML=sumM;
	}
</script>
<style>
body {
	background-color: #EAF4FD;
}

#showTable table{
	border-collapse: collapse;
}

#showTable input {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}

#showTable tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}
#showTable btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

#showTable tdBottom {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-top-style: none;
	border-left-style: none;
	border-right-style: none;
    border-bottom-style: none;
    FONT-SIZE: 10pt;
}

#showTable tr{   
	yexj00:expression(this.style.background=(rowIndex%1==1)? 'white ': '#EAF4FD ')
} 

#showTable td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
	height:20px; 
	line-height:20px; 
	overflow:hidden; 
}
#showTable tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>
</head>
<body>
<model:datasets> 
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.report.cmd.SomPartyReportCmd" global="true" method="queryBaseCase" autoLoad="false">
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel name="form" width="100%" border="0"
		bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="10%">
		<next:Html>
			<fieldset style="overflow: visible;" class="GroupBox"><legend
				class="GroupBoxTitle">查询条件 <img
				class="GroupBoxExpandButton"
				src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>"
				onclick="collapse(this)" /> </legend>
			<div>
			<form style="width: 95%; height: 100%;" class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldButton">
					<button onclick="query()" id="queryButton">查 询</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="reset()">重 置</button>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button onclick="showDesc()">指标解释与表内关系</button>
					</td>
				</tr>
			</table>
			</form>
			</div>
			</fieldset>
		</next:Html>
	</next:Panel>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center"><span 
				style="font-size: large;font-weight:bold;">党员基本情况</span></div>
			<div align="right" class="L5form">
			<button onclick="tableToExcel('showTable')" >打印</button>&nbsp;&nbsp;
			</div>
			<br/>
			<table id="showTable" style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0" >
			   <tr>
					<td colspan="4" style="border-width: 0px">
						 <div align="left"><span class= "btTitle"></span></div>
					 <td colspan="4" style="border-width: 0px">
						 <div align="right"><span class= "btTitle">单位：人</span></div>
					</td>			
			   </tr>
				<tr >
					<td colspan="8" style="border-width: 0px">
						<table width="99.9%" align="center" dataset="ds" >
						<tr>
							<td class="tdTitle" width="10%" align="center">项目</td>
							<td class="tdTitle" width="10%" align="center" colspan="2">总数</td>
							<td class="tdTitle" width="10%"  align="center"  >省级</td>
							<td class="tdTitle" width="10%"  align="center"  >市级</td>
							<td class="tdTitle" width="10%"  align="center"  >县级</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">甲</td>
							<td class="tdTitle" width="10%" align="center" colspan="2">A</td>
							<td class="tdTitle" width="10%"  align="center"  >B</td>
							<td class="tdTitle" width="10%"  align="center"  >C</td>
							<td class="tdTitle" width="10%"  align="center"  >D</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">总计</td>
							<td class="tdTitle" width="10%" align="center">1</td>
							<td width="10%" align="center" >
								<label id="sum1" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label id="sum2" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label id="sum3" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label id="sum4" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">社会团体</td>
							<td class="tdTitle" width="10%" align="center">2</td>
							<td width="10%" align="center" >
								<label id="sumS" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="PROVINCE_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="CITY_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="COUNTRY_S" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">民办非企业</td>
							<td class="tdTitle" width="10%" align="center">3</td>
							<td width="10%" align="center" >
								<label id="sumM" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="PROVINCE_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="CITY_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="COUNTRY_M" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">基金会</td>
							<td class="tdTitle" width="10%" align="center">4</td>
							<td  width="10%"  align="center" >
								<label id="sumJ" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="PROVINCE_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td  width="10%" align="center" >
								<label field="CITY_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="COUNTRY_J" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						</table>
					</td>
					</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
	<next:Window id="descWin" title="指标解释与表内关系" closeAction="hide" width="800" modal='true'>
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="winClose"></next:ToolBarItem>
		</next:TopBar>
		<next:Html>
			<p style="font-weight:bold;">一、指标解释</p>
			<p>1．本表统计各职业党员的性别、民族、年龄情况。</p>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;职业系指党员所从事的社会工作类别。同时从事两种及以上职业的党员，以其从业时间较长的认定其职业，
			如不能确定从业时间长短，则以经济收入较多的认定其职业。在同一工作场所，从事两种及以上职业的党员，
			按其技术性较高、工作程度较复杂、工作责任较重的工作认定其职业。</p>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;机关、企事业单位派往其他单位挂职及临时性帮助工作的党员，虽转出正式组织关系，亦按其原职业统计。</p>		
	
			<p>2．社团系指中国公民自愿组成，为实现会员共同意愿，按照其章程开展活动的非营利性社会组织。</p>
			<p>3．民办非企业单位系指在民政部门登记注册，领取了登记证书，利用非国有资产举办的、 从事非盈利性社会服务活动的社会组织。</p>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;民办非企业单位所属行业类型分为十种：⑴教育，如民办幼儿园，民办小学、中学、学校、学院、大学、民办专修（进修）学院或学校，民办培训（补习）学校或中心等；⑵卫生，如民办门诊部（所）、医院、民办康复、保健、卫生、疗养院（所）等；⑶文化，如民办艺术表演团体、文化馆（活动中心）、
图书馆（室）、美术馆、画院、名人纪念馆、收藏馆、艺术研究院（所）等；⑷科技，如民办科学研究院（所、中心），民办科技传播或普及中心、科技服务中心、技术评估所（中心）等；⑸体育，如民办体育俱乐部，民办体育场、馆、院、社、学校等；⑹劳动，如民办职业培训学校或中心，民办职业介绍所等；⑺民政，如民办福利院、敬老院、托老所、老年公寓，民办婚姻介绍所，民办社区服务中心（站）等；⑻社会中介服务业，如民办评估咨询服务中心（所），民办人才交流中心等；⑼法律服务业（不包括律师事务所）；⑽其他。
			</p>
			<p>4． 基金会系指利用自然人、法人或者其他组织捐赠的财产，以从事公益事业为目的，成立的非营利性法人。</p>
			<p style="margin-top:30px;font-weight:bold;">二、表内关系</p>
			<p>1．1栏=2栏至6栏之和</p>
			<p>2． A列=B列至D列之和</p>
	   </next:Html>
	</next:Window>
<p height="50px"></p>
</body>
</html>
