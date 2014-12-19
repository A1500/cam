<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<!-- 预备党员情况 -->
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
		var sum2 = parseInt(nullToZero(ds.get("NV_S")))+parseInt(nullToZero(ds.get("NV_M")))+parseInt(nullToZero(ds.get("NV_J")));
		var sum3 = parseInt(nullToZero(ds.get("SSMZ_S")))+parseInt(nullToZero(ds.get("SSMZ_M")))+parseInt(nullToZero(ds.get("SSMZ_J")));
		var sum4 = parseInt(nullToZero(ds.get("AGE35_S")))+parseInt(nullToZero(ds.get("AGE35_M")))+parseInt(nullToZero(ds.get("AGE35_J")));
		var sum5 = parseInt(nullToZero(ds.get("AGE35TO59_S")))+parseInt(nullToZero(ds.get("AGE35TO59_M")))+parseInt(nullToZero(ds.get("AGE35TO59_J")));
		var sum6 = parseInt(nullToZero(ds.get("AGE60_S")))+parseInt(nullToZero(ds.get("AGE60_M")))+parseInt(nullToZero(ds.get("AGE60_J")));
		var sum7 = parseInt(nullToZero(ds.get("YJS_S")))+parseInt(nullToZero(ds.get("YJS_M")))+parseInt(nullToZero(ds.get("YJS_J")));
		var sum8 = parseInt(nullToZero(ds.get("DXBK_S")))+parseInt(nullToZero(ds.get("DXBK_M")))+parseInt(nullToZero(ds.get("DXBK_J")));
		var sum9 = parseInt(nullToZero(ds.get("DXZK_S")))+parseInt(nullToZero(ds.get("DXZK_M")))+parseInt(nullToZero(ds.get("DXZK_J")));
		var sum10 = parseInt(nullToZero(ds.get("ZZ_S")))+parseInt(nullToZero(ds.get("ZZ_M")))+parseInt(nullToZero(ds.get("ZZ_J")));
		var sum11 = parseInt(nullToZero(ds.get("GZ_S")))+parseInt(nullToZero(ds.get("GZ_M")))+parseInt(nullToZero(ds.get("GZ_J")));
		var sum12 = parseInt(nullToZero(ds.get("CZ_S")))+parseInt(nullToZero(ds.get("CZ_M")))+parseInt(nullToZero(ds.get("CZ_J")));
		var sum1 = parseInt(sum2)+ parseInt(sum3)+ parseInt(sum4)+ parseInt(sum5)+ parseInt(sum6)
		+parseInt(sum7)+ parseInt(sum8)+ parseInt(sum9)+ parseInt(sum10)+ parseInt(sum11)+ parseInt(sum12);
		
		var sumS = parseInt(nullToZero(ds.get("NV_S")))+parseInt(nullToZero(ds.get("SSMZ_S")))+parseInt(nullToZero(ds.get("AGE35_S")))
		+parseInt(nullToZero(ds.get("AGE35TO59_S")))+parseInt(nullToZero(ds.get("AGE60_S")))+parseInt(nullToZero(ds.get("YJS_S")))+
		parseInt(nullToZero(ds.get("DXBK_S")))+parseInt(nullToZero(ds.get("DXZK_S")))+parseInt(nullToZero(ds.get("ZZ_S")))
		+parseInt(nullToZero(ds.get("GZ_S")))+parseInt(nullToZero(ds.get("CZ_S")));
		
		var sumM = parseInt(nullToZero(ds.get("NV_M")))+parseInt(nullToZero(ds.get("SSMZ_M")))+parseInt(nullToZero(ds.get("AGE35_M")))
		+parseInt(nullToZero(ds.get("AGE35TO59_M")))+parseInt(nullToZero(ds.get("AGE60_M")))+parseInt(nullToZero(ds.get("YJS_M")))+
		parseInt(nullToZero(ds.get("DXBK_M")))+parseInt(nullToZero(ds.get("DXZK_M")))+parseInt(nullToZero(ds.get("ZZ_M")))
		+parseInt(nullToZero(ds.get("GZ_M")))+parseInt(nullToZero(ds.get("CZ_M")));
		
		var sumJ = parseInt(nullToZero(ds.get("NV_J")))+parseInt(nullToZero(ds.get("SSMZ_J")))+parseInt(nullToZero(ds.get("AGE35_J")))
		+parseInt(nullToZero(ds.get("AGE35TO59_J")))+parseInt(nullToZero(ds.get("AGE60_J")))+parseInt(nullToZero(ds.get("YJS_J")))+
		parseInt(nullToZero(ds.get("DXBK_J")))+parseInt(nullToZero(ds.get("DXZK_J")))+parseInt(nullToZero(ds.get("ZZ_J")))
		+parseInt(nullToZero(ds.get("GZ_J")))+parseInt(nullToZero(ds.get("CZ_J")));
		
		
		document.getElementById("sum1").innerHTML=sum1;
		document.getElementById("sum2").innerHTML=sum2;
		document.getElementById("sum3").innerHTML=sum3;
		document.getElementById("sum4").innerHTML=sum4;
		document.getElementById("sum5").innerHTML=sum5;
		document.getElementById("sum6").innerHTML=sum6;
		document.getElementById("sum7").innerHTML=sum7;
		document.getElementById("sum8").innerHTML=sum8;
		document.getElementById("sum9").innerHTML=sum9;
		document.getElementById("sum10").innerHTML=sum10;
		document.getElementById("sum11").innerHTML=sum11;
		document.getElementById("sum12").innerHTML=sum12;
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.report.cmd.SomPartyReportCmd" global="true" method="queryJoin" autoLoad="false">
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
				style="font-size: large;font-weight:bold;">预备党员情况</span></div>
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
							<td class="tdTitle" width="10%" align="center" rowspan=2>项目</td>
							<td class="tdTitle" width="10%" align="center" colspan="4">总数</td>
							<td class="tdTitle" width="10%" align="center" colspan="3">年龄</td>
							<td class="tdTitle" width="10%" align="center" colspan="6">学历</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center" colspan="2">总数</td>
							<td class="tdTitle" width="10%" align="center">女</td>
							<td class="tdTitle" width="10%" align="center">少数民族</td>
							<td class="tdTitle" width="10%" align="center"  >35岁及以下</td>
							<td class="tdTitle" width="10%" align="center"  >36岁至59岁</td>
							<td class="tdTitle" width="10%" align="center"  >60岁及以上</td>
							<td class="tdTitle" width="10%" align="center"  >研究生</td>
							<td class="tdTitle" width="10%" align="center"  >大学本科</td>
							<td class="tdTitle" width="10%" align="center"  >大学专科</td>
							<td class="tdTitle" width="10%" align="center"  >中       专</td>
							<td class="tdTitle" width="10%" align="center"  >高中中技</td>
							<td class="tdTitle" width="10%" align="center"  >初中及以下</td>
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
							<td class="tdTitle" width="10%"  align="center"  >H</td>
							<td class="tdTitle" width="10%"  align="center"  >I</td>
							<td class="tdTitle" width="10%"  align="center"  >J</td>
							<td class="tdTitle" width="10%"  align="center"  >K</td>
							<td class="tdTitle" width="10%"  align="center"  >L</td>
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
							<td width="10%" align="center" >
								<label id="sum8" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label id="sum9" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label id="sum10" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label id="sum11" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label id="sum12" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">社团</td>
							<td class="tdTitle" width="10%" align="center">2</td>
							<td width="10%" align="center" >
								<label id="sumS" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="NV_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="SSMZ_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="AGE35_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="AGE35TO59_S" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="AGE60_S" style="width: 30px;height: 20px;" /></label>
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
								<label field="NV_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="SSMZ_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="AGE35_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="AGE35TO59_M" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="AGE60_M" style="width: 30px;height: 20px;" /></label>
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
								<label field="NV_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="SSMZ_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="AGE35_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="AGE35TO59_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="AGE60_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="YJS_J" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
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
			<p>1．本表统计被各级党组织列为发展对象的人员情况。</p>
			<p>2．发展对象系指入党积极分子经过一年以上的培养、教育，党组织在听取党小组、培养联系人和党内外群众意见的基础上，经支部委员会（不设支委会的支部大会）讨论，基本具备党员条件，准备发展的入党积极分子。</p>
			<p style="margin-top:30px;font-weight:bold;">二、表内关系</p>
			<p>1． 1栏=2栏至6栏之和</p>
			<p>2． A列分别B列、C列</p>
			<p>3． A列=D列至F列之和</p>
			<p>4． A列=G列至L列之和</p>
	   </next:Html>
	</next:Window>
<p height="50px"></p>
</body>
</html>
