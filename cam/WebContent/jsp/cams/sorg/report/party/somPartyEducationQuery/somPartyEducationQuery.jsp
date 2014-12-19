<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<!-- 党员学历情况 -->
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
		var searchWrap=document.getElementById("searchWrap").value;
		ds.setParameter("ifLike", searchWrap);
		ds.load();
		ds.on('load',countSum);
		document.getElementById("reDiv").style.display="block";
	}
	function countSum(ds){
		var sum2 = parseInt(nullToZero(ds.get("YJS_S")))+parseInt(nullToZero(ds.get("YJS_M")))+parseInt(nullToZero(ds.get("YJS_J")));
		var sum3 = parseInt(nullToZero(ds.get("DXBK_S")))+parseInt(nullToZero(ds.get("DXBK_M")))+parseInt(nullToZero(ds.get("DXBK_J")));
		var sum4 = parseInt(nullToZero(ds.get("DXZK_S")))+parseInt(nullToZero(ds.get("DXZK_M")))+parseInt(nullToZero(ds.get("DXZK_J")));
		var sum5 = parseInt(nullToZero(ds.get("ZZ_S")))+parseInt(nullToZero(ds.get("ZZ_M")))+parseInt(nullToZero(ds.get("ZZ_J")));
		var sum6 = parseInt(nullToZero(ds.get("GZ_S")))+parseInt(nullToZero(ds.get("GZ_M")))+parseInt(nullToZero(ds.get("GZ_J")));
		var sum7 = parseInt(nullToZero(ds.get("CZ_S")))+parseInt(nullToZero(ds.get("CZ_M")))+parseInt(nullToZero(ds.get("CZ_J")));
		var sum1 = parseInt(sum2)+ parseInt(sum3)+ parseInt(sum4)+parseInt(sum5)+ parseInt(sum6)+ parseInt(sum7);
		
		var sumS = parseInt(nullToZero(ds.get("YJS_S")))+parseInt(nullToZero(ds.get("DXBK_S")))+parseInt(nullToZero(ds.get("DXZK_S")))+
		parseInt(nullToZero(ds.get("ZZ_S")))+parseInt(nullToZero(ds.get("GZ_S")))+parseInt(nullToZero(ds.get("CZ_S")));
		
		var sumJ = parseInt(nullToZero(ds.get("YJS_M")))+parseInt(nullToZero(ds.get("DXBK_M")))+parseInt(nullToZero(ds.get("DXZK_M")))+
		parseInt(nullToZero(ds.get("ZZ_M")))+parseInt(nullToZero(ds.get("GZ_M")))+parseInt(nullToZero(ds.get("CZ_M")));
		
		var sumM = parseInt(nullToZero(ds.get("YJS_J")))+parseInt(nullToZero(ds.get("DXBK_J")))+parseInt(nullToZero(ds.get("DXZK_J")))+
		parseInt(nullToZero(ds.get("ZZ_J")))+parseInt(nullToZero(ds.get("GZ_J")))+parseInt(nullToZero(ds.get("CZ_J")));
		
		document.getElementById("sum1").innerHTML=sum1;
		document.getElementById("sum2").innerHTML=sum2;
		document.getElementById("sum3").innerHTML=sum3;
		document.getElementById("sum4").innerHTML=sum4;
		document.getElementById("sum5").innerHTML=sum4;
		document.getElementById("sum6").innerHTML=sum4;
		document.getElementById("sum7").innerHTML=sum4;
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.report.cmd.SomPartyReportCmd" global="true" method="queryEducation" autoLoad="false">
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
					<td class="FieldLabel">查询范围:</td>
					<td class="FieldInput" colspan="2" >					
						<select id="searchWrap">
						  <option value ="0">不包含下级</option>
						  <option value ="1">包含下级</option>
						</select>					
					</td>
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
				style="font-size: large;font-weight:bold;">党员学历情况</span></div>
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
							<td class="tdTitle" width="10%"  align="center"  >研究生</td>
							<td class="tdTitle" width="10%"  align="center"  >大学本科</td>
							<td class="tdTitle" width="10%"  align="center"  >大学专科</td>
							<td class="tdTitle" width="10%"  align="center"  >中专</td>
							<td class="tdTitle" width="10%"  align="center"  >高中、中技</td>
							<td class="tdTitle" width="10%"  align="center"  >初中及以下</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">甲</td>
							<td class="tdTitle" width="10%" align="center" colspan="2">A</td>
							<td class="tdTitle" width="10%"  align="center"  >B</td>
							<td class="tdTitle" width="10%"  align="center"  >C</td>
							<td class="tdTitle" width="10%"  align="center"  >D</td>
							<td class="tdTitle" width="10%"  align="center"  >E</td>
							<td class="tdTitle" width="10%"  align="center"  >F</td>
							<td class="tdTitle" width="10%"  align="center"  >G</td>
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
							<td width="10%" align="center" >
								<label id="sum5" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label id="sum6" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label id="sum7" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">社会团体</td>
							<td class="tdTitle" width="10%" align="center">2</td>
							<td width="10%" align="center" >
								<label id="sumS" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="YJS_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="DXBK_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="DXZK_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="ZZ_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="GZ_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="CZ_S" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">民办非企业</td>
							<td class="tdTitle" width="10%" align="center">3</td>
							<td width="10%" align="center" >
								<label id="sumM" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="YJS_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="DXBK_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="DXZK_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="ZZ_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="GZ_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="CZ_M" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">基金会</td>
							<td class="tdTitle" width="10%" align="center">4</td>
							<td  width="10%"  align="center" >
								<label id="sumJ" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="YJS_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td  width="10%" align="center" >
								<label field="DXBK_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="DXZK_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="ZZ_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="GZ_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="CZ_J" style="width: 30px;height: 20px;" /></label>
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
			<p>1．本表统计各职业党员的学历情况。</p>
			<p>2．“学历”系指在教育机构中接受科学、文化知识训练的学习经历，以经教育行政部门批准，有国家认可的文凭颁发权力的学校及其他教育机构所颁发的毕业学历证书为凭证。
凡是根据中共中央办公厅、国务院办公厅《关于转发〈中央组织部、人事部、教育部、国务院学位委员会关于加强和规范干部学历、学位管理工作的意见〉的通知》（厅字〔2002〕4号）和中央组织部办公厅《关于干部学历、学位检查清理实施意见的通知》（组厅字〔2002〕9号）规定进行干部学历清理的，按照清理后认定的学历统计。
取得两个及以上学历的，按接受教育的最高学历统计。取得两个及以上同等学历的，学历仍统计在对应的同等学历栏。
在校学生及参加不脱产的夜校、业余学校、函授、自学考试等成人教育学习的，未取得新的学历之前，按现有学历统计。
仅获得硕士以上学位证书，但未取得学历证书的，仍按原学历统计。
1970年至1976年入学的大学普通班毕业生，统计在“大学专科”栏。</p>
			<p style="margin-top:30px;font-weight:bold;">二、表内关系</p>
			<p>1．1栏=2栏至6栏之和</p>
			<p>2． A列=B列至G列之和</p>
	   </next:Html>
	</next:Window>
<p height="50px"></p>
</body>
</html>
