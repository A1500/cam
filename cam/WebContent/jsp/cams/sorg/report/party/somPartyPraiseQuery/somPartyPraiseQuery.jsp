<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<!-- 党内表彰情况 -->
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
		var sum2 = parseInt(nullToZero(ds.get("KZJZ_DZ")))+parseInt(dnullToZero(s.get("KZJZ_DY")))+parseInt(nullToZero(ds.get("KZJZ_DW")));
		var sum3 = parseInt(nullToZero(ds.get("S_DZ")))+parseInt(nullToZero(ds.get("S_DY")))+parseInt(nullToZero(ds.get("S_DW")));
		var sum4 = parseInt(nullToZero(ds.get("D_DZ")))+parseInt(nullToZero(ds.get("D_DY")))+parseInt(nullToZero(ds.get("D_DW")));
		var sum5 = parseInt(nullToZero(ds.get("X_DZ")))+parseInt(nullToZero(ds.get("X_DY")))+parseInt(nullToZero(ds.get("X_DW")));
		var sum6 = parseInt(nullToZero(ds.get("QT_DZ")))+parseInt(nullToZero(ds.get("QT_DY")))+parseInt(nullToZero(ds.get("QT_DW")));
		var sum1 = parseInt(sum2)+ parseInt(sum3)+ parseInt(sum4)+ parseInt(sum5)+ parseInt(sum6);
		
		var sumS = parseInt(nullToZero(ds.get("KZJZ_DZ")))+parseInt(nullToZero(ds.get("S_DZ")))+parseInt(nullToZero(ds.get("D_DZ")))
		+parseInt(nullToZero(ds.get("X_DZ")))+parseInt(nullToZero(ds.get("QT_DZ")));
		
		var sumM = parseInt(nullToZero(ds.get("KZJZ_DY")))+parseInt(nullToZero(ds.get("S_DY")))+parseInt(nullToZero(ds.get("D_DY")))+
		parseInt(nullToZero(ds.get("X_DY")))+parseInt(nullToZero(ds.get("QT_DY")));
		
		var sumJ = parseInt(nullToZero(ds.get("KZJZ_DW")))+parseInt(nullToZero(ds.get("S_DW")))+parseInt(nullToZero(ds.get("D_DW")))
		+parseInt(nullToZero(ds.get("X_DW")))+parseInt(nullToZero(ds.get("QT_DW")));
		
		document.getElementById("sum1").innerHTML=sum1;
		document.getElementById("sum2").innerHTML=sum2;
		document.getElementById("sum3").innerHTML=sum3;
		document.getElementById("sum4").innerHTML=sum4;
		document.getElementById("sum5").innerHTML=sum5;
		document.getElementById("sum6").innerHTML=sum6;
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
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.report.cmd.SomPartyReportCmd" global="true" method="queryPraise" autoLoad="false">
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
				style="font-size: large;font-weight:bold;">党内表彰情况</span></div>
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
							<td class="tdTitle" width="10%"  align="center"  >抗灾救灾</td>
							<td class="tdTitle" width="10%"  align="center"  >省（区、市）一级表彰</td>
							<td class="tdTitle" width="10%"  align="center"  >市（地、州、盟）一级表彰</td>
							<td class="tdTitle" width="10%"  align="center"  >县（市、区、旗）一级表彰</td>
							<td class="tdTitle" width="10%"  align="center"  >其他表彰</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">甲</td>
							<td class="tdTitle" width="10%" align="center" colspan="2">A</td>
							<td class="tdTitle" width="10%"  align="center"  >B</td>
							<td class="tdTitle" width="10%"  align="center"  >C</td>
							<td class="tdTitle" width="10%"  align="center"  >D</td>
							<td class="tdTitle" width="10%"  align="center"  >E</td>
							<td class="tdTitle" width="10%"  align="center"  >F</td>
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
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">先进党组织</td>
							<td class="tdTitle" width="10%" align="center">2</td>
							<td width="10%" align="center" >
								<label id="sumS" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="KZJZ_DZ" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="S_DZ" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="D_DZ" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="X_DZ" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="QT_DZ" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">优秀共产党员</td>
							<td class="tdTitle" width="10%" align="center">3</td>
							<td width="10%" align="center" >
								<label id="sumM" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="KZJZ_DY" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="S_DY" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="D_DY" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="X_DY" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="QT_DY" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td class="tdTitle" width="10%" align="center">优秀党务工作者</td>
							<td class="tdTitle" width="10%" align="center">4</td>
							<td  width="10%"  align="center" >
								<label id="sumJ" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="KZJZ_DW" style="width: 30px;height: 20px;" /></label>
							</td>
							<td  width="10%" align="center" >
								<label field="S_DW" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="D_DW" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="X_DW" style="width: 30px;height: 20px;" /></label>
							</td>
							<td width="10%" align="center" >
								<label field="QT_DW" style="width: 30px;height: 20px;" /></label>
							</td>
						</tr>
						<tr>
							<td colspan=8>
								<span>
									补充资料：
									<br>1. 本年度表彰的优秀共产党员中有党委（总支部、支部）书记      
									<label field="DWSJ_DY" style="width: 30px;height: 20px;" /></label>名；
									表彰的优秀党务工作者中有党委（总支部、支部）书记
									<label field="DWSJ_DW" style="width: 30px;height: 20px;" /></label>名。
         							<br>2. 本年度表彰的优秀共产党员中生活困难的
									<label field="SHKN_DW" style="width: 30px;height: 20px;" /></label>名；
									表彰的优秀党务工作者中生活困难的
									<label field="SHKN_DW" style="width: 30px;height: 20px;" /></label>名。
          							<br>3. 本年度追授优秀共产党员
          							<label field="YEAR_DW" style="width: 30px;height: 20px;" /></label>      名，
          							其中抗灾救灾追授
          							<label field="YEAR_KZJZ_DW" style="width: 30px;height: 20px;" /></label>      名。
								</span>
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
			<p>1．本表统计本年各级党组织表彰先进党组织、优秀共产党员和优秀党务工作者情况。</p>
			<p>2．“省（区、市）一级表彰”、“市（地、州、盟）一级表彰”、“县（市、区、旗）一级表彰”系指各级地方党委及其组织部门表彰的先进党组织、优秀共产党员和优秀党务工作者。</p>
			<p>3．“抗灾救灾”表彰系指因抗击各种自然灾害、突发事故等中的突出表现而受到的表彰。</p>
			<p>4．“生活困难”系指年人均纯收入在1196元（国家扶贫办提供的2009年标准）以下的党员。</p>
			<p style="margin-top:30px;font-weight:bold;">二、表内关系</p>
			<p>1． A列>=B列</p>
			<p>2． A列=C列至F列之和</p>
			<p>3． A2分别>=补充资料1第1项、补充资料2第1项</p>
			<p>4． A3分别>=补充资料1第2项、补充资料2第2项</p>
	   </next:Html>
	</next:Window>
<p height="50px"></p>
</body>
</html>
