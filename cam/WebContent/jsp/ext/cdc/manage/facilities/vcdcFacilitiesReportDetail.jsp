<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>城市社区基础设施情况填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="fReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFacilitiesReport"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R06'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="fReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" width="18%">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" width="18%">填报日期：</td>
			<td class="FieldInput" width="18%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" width="18%">上报日期：</td>
			<td class="FieldInput" width="18%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区基础设施情况</legend>
	<table border="1"  width="100%" >
	   		<tr>
	   			<td class="FieldLabel" rowspan="2" colspan="2">社区工作用房</td>
				<td class="FieldLabel" style="width:18%" colspan="2">社区工作用房数量：</td>
				<td class="FieldInput"><label name="社区工作用房数量" id="offNum" field="offNum" renderer="jRender"/></td>
				<td class="FieldLabel">社区工作用房建筑面积：</td>
				<td class="FieldInput"><label name="社区工作用房建筑面积" id="offArea" field="offArea" renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><label name="投入使用年份" id="offYear" field="offYear"/></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" style="width:9%" rowspan="13">社区<br>服务<br>设施<br>用房</td>
	   			<td class="FieldLabel" style="width:9%" rowspan="2">社区服务大厅</td>
				<td class="FieldLabel" style="width:18%" colspan="2">社区服务大厅数量：</td>
				<td class="FieldInput"><label name="社区服务大厅数量" id="serviceNum" field="serviceNum" renderer="gRender"/></td>
				<td class="FieldLabel">社区服务大厅建筑面积：</td>
				<td class="FieldInput"><label name="社区服务大厅建筑面积" id="serviceArea" field="serviceArea" renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><label name="投入使用年份" id="serviceYear" field="serviceYear"/></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区警务室</td>
				<td class="FieldLabel" colspan="2">社区警务室数量：</td>
				<td class="FieldInput"><label name="社区警务室数量" id="policeNum" field="policeNum" renderer="gRender"/></td>
				<td class="FieldLabel">社区警务室建筑面积：</td>
				<td class="FieldInput"><label name="社区警务室建筑面积" id="policeArea" field="policeArea" renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><label name="投入使用年份" id="policeYear" field="policeYear"/></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区卫生室</td>
				<td class="FieldLabel" colspan="2">社区卫生室数量：</td>
				<td class="FieldInput"><label name="社区卫生室数量" id="clinicNum" field="clinicNum" renderer="gRender"/></td>
				<td class="FieldLabel">社区卫生室建筑面积：</td>
				<td class="FieldInput"><label name="社区卫生室建筑面积" id="clinicArea" field="clinicArea" renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><label name="投入使用年份" id="clinicYear" field="clinicYear"/></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区图书室</td>
				<td class="FieldLabel" colspan="2">社区图书室数量：</td>
				<td class="FieldInput"><label name="社区图书室数量" id="libNum" field="libNum" renderer="gRender"/></td>
				<td class="FieldLabel">社区图书室建筑面积：</td>
				<td class="FieldInput"><label name="社区图书室建筑面积" id="libArea" field="libArea" renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><label name="投入使用年份" id="libYear" field="libYear"/></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区文娱活动室</td>
				<td class="FieldLabel" colspan="2">社区文娱活动室数量：</td>
				<td class="FieldInput"><label name="社区文娱活动室数量" id="actionNum" field="actionNum" renderer="gRender"/></td>
				<td class="FieldLabel">社区文娱活动室建筑面积：</td>
				<td class="FieldInput"><label name="社区文娱活动室建筑面积" id="actionArea" field="actionArea" renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><label name="投入使用年份" id="actionYear" field="actionYear"/></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="2">社区残疾人活动室</td>
				<td class="FieldLabel" colspan="2">社区残疾人活动室数量：</td>
				<td class="FieldInput"><label name="社区残疾人活动室数量" id="handNum" field="handNum" renderer="gRender"/></td>
				<td class="FieldLabel">社区残疾人活动室建筑面积：</td>
				<td class="FieldInput"><label name="社区残疾人室建筑面积" id="handArea" field="handArea" renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">投入使用年份：</td>
				<td class="FieldInput" colspan="3"><label name="投入使用年份" id="handYear" field="handYear"/></td>
			</tr>
			<tr>
	   			<td class="FieldLabel">其他</td>
				<td class="FieldLabel" colspan="2">其他用房数量：</td>
				<td class="FieldInput"><label name="其他用房数量" id="otherNum" field="otherNum" renderer="gRender"/> </td>
				<td class="FieldLabel">其他用房建筑面积：</td>
				<td class="FieldInput"><label name="其他用房建筑面积" id="otherArea" field="otherArea" renderer="aRender"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="2" rowspan="3">社区工作用房、</br>社区服务设施用房 </td>
				<td class="FieldLabel" colspan="2">投入资金：</td>
				<td class="FieldInput" colspan="3"><label id="offMon" field="offMon" renderer="reRender" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" rowspan="2" >资金来源</td>
				<td class="FieldLabel">财政拨款：</td>
				<td class="FieldInput"><label name="财政拨款" id="offFinanceMon" field="offFinanceMon" renderer="reRender"/></td>
				<td class="FieldLabel" width="15%;">自筹：</td>
				<td class="FieldInput"><label name="自筹" id="offSelfMon" field="offSelfMon"  renderer="reRender"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" >社会捐助：</td>
				<td class="FieldInput"><label name="社会捐助" id="offEndowMon" field="offEndowMon" renderer="reRender"/></td>
				<td class="FieldLabel">其他：</td>
				<td class="FieldInput"><label name="其他" id="offOtherMon" field="offOtherMon"renderer="reRender"></td>
			</tr>
			<tr>
	   			<td class="FieldLabel" rowspan="4" colspan="2">社区室外活动场地</td>
				<td class="FieldLabel" colspan="2">社区室外活动场地数量：</td>
				<td class="FieldInput"><label name="社区室外活动场地数量" id="outNum" field="outNum" renderer="gRender"/></td>
				<td class="FieldLabel">社区室外活动场地建筑面积：</td>
				<td class="FieldInput"><label name="社区室外活动场地筑面积" id="outArea" field="outArea" renderer="aRender"/></td>
			</tr>
	   		<tr>
				<td class="FieldLabel" colspan="2">社区室外活动场地投入资金：</td>
				<td class="FieldInput"><label name="社区室外活动场地投入资金" id="outMon" field="outMon" renderer="reRender"/></td>
				<td class="FieldLabel">投入使用年份：</td>
				<td class="FieldInput"><label name="投入使用年份" id="outYear" field="outYear"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" rowspan="2">资金来源</td>
				<td class="FieldLabel">财政拨款：</td>
				<td class="FieldInput"><label name="财政拨款" id="outFinanceMon" field="outFinanceMon" renderer="reRender"/></td>
				<td class="FieldLabel" width="15%;">自筹：</td>
				<td class="FieldInput"><label name="自筹" id="outSelfMon" field="outSelfMon" renderer="reRender"/> </td>
			</tr>
	   		<tr>
				<td class="FieldLabel">社会捐助：</td>
				<td class="FieldInput"><label name="社会捐助" id="outEnbowMon" field="outEnbowMon" renderer="reRender"/></td>
				<td class="FieldLabel">其他：</td>
				<td class="FieldInput"><label name="其他" id="outOtherMon" field="outOtherMon" renderer="reRender"/></td>
			</tr>
		</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
	var ds=L5.DatasetMgr.lookup("fReportDataSet");
	ds.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function reRender(val){
	
	if(val==''){
		return "0 万元";
	}
	return val+" 万元";
}
function gRender(val){
	if(val==''){
		return "0 个"
	}
	return val+" 个";
}
function jRender(val){
	if(val==''){
		return "0 间"
	}
	return val+" 间";
}

function aRender(val){
	if(val==''){
		return "0 平方米"
	}
	return val+" 平方米";
}
</script>