<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区服务设施情况填报</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="sFacilitiesDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceFacilitiesQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceFacilities"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R21'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="YNDataSet" enumName="COMM.YESORNO" global="true" autoLoad="true"  />
	<!-- 建设状态 -->
	<model:dataset id="offconstatusDataSet" enumName="CDC.OFF_CON_STATUS" global="true" autoLoad="true"  />
	<!-- 建设性质 -->
	<model:dataset id="offconkindDataSet" enumName="CDC.OFF_CON_KIND" global="true" autoLoad="true"  />
	<!-- 建设模式 -->
	<model:dataset id="sercontypeDataSet" enumName="CDC.SER_CON_TYPE" global="true" autoLoad="true"  />
</model:datasets>
<next:Panel width="98%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="sFacilitiesDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报日期：</td>
			<td class="FieldInput" style="width:36%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区服务设施情况</legend>
	<table border="1"  width="100%" >
	   		<tr>
				<td class="FieldLabel" rowspan="3" width="20%">办公场所基本情况</td>
			
				<td  class="FieldLabel"  colspan="2" width="20%">建设状态</td>
				<td class="FieldInput" width="20%">
				<label name="offConStatus" field="offConStatus" dataset="offconstatusDataSet" />
				</td>
			
				<td  class="FieldLabel" width="20%">建设性质</td>
				<td class="FieldInput" width="20%">
				<label name="offConKind" field="offConKind" dataset="offconkindDataSet"  />
				 </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">使用年份</td>
				<td class="FieldInput"><label name="offYear" field="offYear" renderer="yRender" />  </td>
			
				<td  class="FieldLabel" >建筑面积</td>
				<td class="FieldInput"><label name="offConArea" field="offConArea" renderer="aRender"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">房间面积</td>
				<td class="FieldInput"><label name="offHouseArea" field="offHouseArea"  renderer="aRender"  /> </td>
			
				<td  class="FieldLabel" >电脑数量</td>
				<td class="FieldInput"><label name="offComputeNum" field="offComputeNum"  renderer="tRender" /> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" rowspan="12">社区服务设施建设情况</td>
				<td  class="FieldLabel"  colspan="2">建设模式</td>
				<td class="FieldInput">
				<label name="serConType" field="serConType" dataset="sercontypeDataSet"  />
				</td>
			
				<td  class="FieldLabel" >建设状态</td>
				<td class="FieldInput"><label name="serConStatus" field="serConStatus"  dataset="offconstatusDataSet" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">所在地</td>
				<td class="FieldInput"><label name="serPlace" field="serPlace"  /> </td>
			
				<td  class="FieldLabel" >覆盖自然村个数</td>
				<td class="FieldInput"><label name="serVillageNum" field="serVillageNum" renderer="gRender" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">覆盖面积</td>
				<td class="FieldInput"><label name="serTotleArea" field="serTotleArea" renderer="aRender" /> </td>
			
				<td  class="FieldLabel" >建筑面积</td>
				<td class="FieldInput"><label name="serConArea" field="serConArea" renderer="aRender" /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">建设性质</td>
				<td class="FieldInput">
				<label name="serConKind" field="serConKind" dataset="offconkindDataSet"  />
				</td>
			
				<td  class="FieldLabel" >是否有标识</td>
				<td class="FieldInput">
				<label name="serConFlag" field="serConFlag" dataset="YNDataSet"  />
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">服务半径</td>
				<td class="FieldInput" colspan="3"><label name="serLen" field="serLen"  /> </td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" rowspan="7">功能设置</td>
				<td  class="FieldLabel" >两委办公室</td>
				<td class="FieldInput">
				<label name="funOfficeFlag" field="funOfficeFlag" dataset="YNDataSet" />
				</td>
			
				<td  class="FieldLabel" >一站式服务厅</td>
				<td class="FieldInput">
				<label name="funServiceFlag" field="funServiceFlag" dataset="YNDataSet" />
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >多功能综合厅</td>
				<td class="FieldInput">
				<label name="funMultiFlag" field="funMultiFlag" dataset="YNDataSet" />
				</td>
			
				<td  class="FieldLabel" >警务室</td>
				<td class="FieldInput">
				<label name="funPoliceFlag" field="funPoliceFlag" dataset="YNDataSet" />
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >卫生室</td>
				<td class="FieldInput">
				<label name="funHealthFlag" field="funHealthFlag" dataset="YNDataSet" />
				</td>
			
				<td  class="FieldLabel" >文体活动室</td>
				<td class="FieldInput">
				<label name="funActivityFlag" field="funActivityFlag" dataset="YNDataSet" />
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >图书室</td>
				<td class="FieldInput">
				<label name="funLibraryFlag" field="funLibraryFlag" dataset="YNDataSet" />
				</td>
			
				<td  class="FieldLabel" >老年人照料中心</td>
				<td class="FieldInput">
				<label name="funOldFlag" field="funOldFlag" dataset="YNDataSet" />
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >幼儿园</td>
				<td class="FieldInput">
				<label name="funKindergartenFlag" field="funKindergartenFlag" dataset="YNDataSet" />
				</td>
			
				<td  class="FieldLabel" >农资超市</td>
				<td class="FieldInput">
				<label name="funAgriculturalFlag" field="funAgriculturalFlag" dataset="YNDataSet" />
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >日用品超市</td>
				<td class="FieldInput">
				<label name="funSupermarkFlag" field="funSupermarkFlag" dataset="YNDataSet" />
				</td>
			
				<td  class="FieldLabel" >银行</td>
				<td class="FieldInput">
				<label name="funBankFlag" field="funBankFlag" dataset="YNDataSet" />
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >邮局</td>
				<td class="FieldInput" colspan="3">
				<label name="funPostFlag" field="funPostFlag" dataset="YNDataSet" />
				 </td>
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
	var ds=L5.DatasetMgr.lookup("sFacilitiesDataSet");
	ds.setParameter("CONSTRUCTION_ID@=",'<%=request.getParameter("constructionId")%>');
	ds.load();
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function gRender(val){
	if(val!="")
	return val+" 个";
}
function peRender(val){
	if(val!="")
	return val+" 元";
}
function aRender(val){
	if(val!="")
	return val+" ㎡";
}
function yRender(val){
	if(val!="")
	return val+" 年";
}
function tRender(val){
	if(val!="")
	return val+" 台";
}
</script>