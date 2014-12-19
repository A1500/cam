<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>农村社区服务设施情况填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcServiceFacilitiesEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var constructionId='<%=request.getParameter("constructionId")%>';
	var userStatus = "vcdcServiceFacilitiesEdit.jsp";
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sFacilitiesDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceFacilitiesQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceFacilities"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R21'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<!-- 行政区划 -->
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='AREA_CODE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ownPropertiesDataSet" enumName="CDC.OWN_PROPERTIES" global="true" autoLoad="true"  />
	<model:dataset id="buildPropertiesDataSet" enumName="CDC.BUILD_PROPERTIES" global="true" autoLoad="true"  />
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
	<next:ToolBarItem iconCls="add" text="历史数据回填" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="sFacilitiesDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:36%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:16%">填报日期：</td>
			<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>社区基础设施情况</legend>
		<table border="1"  width="100%" >
	   		<tr>
				<td class="FieldLabel" rowspan="3">办公场所基本情况</td>
			
				<td  class="FieldLabel"  colspan="2">建设状态</td>
				<td class="FieldInput">
				<select id="offConStatus" field="offConStatus"  >
					<option dataset="offconstatusDataSet" />
				</select><font color="red">*</font>
				</td>
			
				<td  class="FieldLabel" >建设性质</td>
				<td class="FieldInput">
				<select id="offConKind" field="offConKind"  >
					<option dataset="offconkindDataSet" />
				</select><font color="red">*</font>
				 </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">使用年份</td>
				<td class="FieldInput"><input type="text" id="offYear" field="offYear"  />&nbsp;年<font color="red">*</font> </td>
			
				<td  class="FieldLabel" >建筑面积</td>
				<td class="FieldInput"><input type="text" id="offConArea" field="offConArea"  />&nbsp;㎡ <font color="red">*</font></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">房间面积</td>
				<td class="FieldInput"><input type="text" name="房间面积" id="offHouseArea" field="offHouseArea"  />&nbsp;㎡ <font color="red">*</font></td>
			
				<td  class="FieldLabel" >电脑数量</td>
				<td class="FieldInput"><input type="text" name="电脑数量" id="offComputeNum" field="offComputeNum"  />&nbsp;台 <font color="red">*</font></td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" rowspan="12">社区服务设施建设情况</td>
				<td  class="FieldLabel"  colspan="2">建设模式</td>
				<td class="FieldInput">
				<select id="serConType" field="serConType"  >
					<option dataset="sercontypeDataSet" />
				</select><font color="red">*</font>
				</td>
			
				<td  class="FieldLabel" >建设状态</td>
				<td class="FieldInput">
				<select id="serConStatus" field="serConStatus"  >
					<option dataset="offconstatusDataSet" />
				</select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">所在地</td>
				<td class="FieldInput"><input type="text" id="serPlace" field="serPlace"  /><font color="red">*</font></td>
			
				<td  class="FieldLabel" >覆盖自然村个数</td>
				<td class="FieldInput"><input type="text" name = "覆盖自然村个数" id="serVillageNum" field="serVillageNum"  />&nbsp;个 <font color="red">*</font></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">覆盖面积</td>
				<td class="FieldInput"><input type="text" id="serTotleArea" name = "覆盖面积" field="serTotleArea"  />&nbsp;㎡ <font color="red">*</font></td>
			
				<td  class="FieldLabel" >建筑面积</td>
				<td class="FieldInput"><input type="text" id="serConArea" name = "建筑面积" field="serConArea"  />&nbsp;㎡<font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">建设性质</td>
				<td class="FieldInput">
				<select id="serConKind" field="serConKind"  >
					<option dataset="offconkindDataSet" />
				</select><font color="red">*</font>
				</td>
			
				<td  class="FieldLabel" >是否有标识</td>
				<td class="FieldInput">
				<select id="serConFlag" field="serConFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">服务半径</td>
				<td class="FieldInput" colspan="3"><input type="text" id="serLen" field="serLen"  /> <font color="red">*</font></td>
			</tr>
	   		<tr>
	   			<td  class="FieldLabel" rowspan="7">功能设置</td>
				<td  class="FieldLabel" >两委办公室</td>
				<td class="FieldInput">
				<select id="funOfficeFlag" field="funOfficeFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			
				<td  class="FieldLabel" >一站式服务厅</td>
				<td class="FieldInput">
				<select id="funServiceFlag" field="funServiceFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >多功能综合厅</td>
				<td class="FieldInput">
				<select id="funMultiFlag" field="funMultiFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			
				<td  class="FieldLabel" >警务室</td>
				<td class="FieldInput">
				<select id="funPoliceFlag" field="funPoliceFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >卫生室</td>
				<td class="FieldInput">
				<select id="funHealthFlag" field="funHealthFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			
				<td  class="FieldLabel" >文体活动室</td>
				<td class="FieldInput">
				<select id="funActivityFlag" field="funActivityFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >图书室</td>
				<td class="FieldInput">
				<select id="funLibraryFlag" field="funLibraryFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			
				<td  class="FieldLabel" >老年人照料中心</td>
				<td class="FieldInput">
				<select id="funOldFlag" field="funOldFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >幼儿园</td>
				<td class="FieldInput">
				<select id="funKindergartenFlag" field="funKindergartenFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			
				<td  class="FieldLabel" >农资超市</td>
				<td class="FieldInput">
				<select id="funAgriculturalFlag" field="funAgriculturalFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >日用品超市</td>
				<td class="FieldInput">
				<select id="funSupermarkFlag" field="funSupermarkFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			
				<td  class="FieldLabel" >银行</td>
				<td class="FieldInput">
				<select id="funBankFlag" field="funBankFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >邮局</td>
				<td class="FieldInput"  colspan="3">
				<select id="funPostFlag" field="funPostFlag"  >
					<option dataset="YNDataSet" />
				</select><font color="red">*</font>
				 </td>
				
				</tr>
		</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>