<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区服务设施汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcServiceFacilitiesSum.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var constructionId='<%=request.getParameter("constructionId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceFacilitiesQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceFacilities"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcServiceFacilitiesQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcServiceFacilities"/>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
		<model:params>
			<model:param name="type" value='C'/>
		</model:params>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R21'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 是否 -->
	<model:dataset id="YNDataSet" enumName="COMM.YESORNO" global="true" autoLoad="true"  />
	<!-- 建设状态 -->
	<model:dataset id="offconstatusDataSet" enumName="CDC.OFF_CON_STATUS" global="true" autoLoad="true"  />
	<!-- 建设性质 -->
	<model:dataset id="offconkindDataSet" enumName="CDC.OFF_CON_KIND" global="true" autoLoad="true"  />
	<!-- 建设模式 -->
	<model:dataset id="sercontypeDataSet" enumName="CDC.SER_CON_TYPE" global="true" autoLoad="true"  />
</model:datasets>
<next:Panel width="100%" border="0">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="sumButton" iconCls="save" text="汇总" handler="save"></next:ToolBarItem>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
</next:TopBar>
<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">汇总情况</legend>
		<form id="form1" method="post" dataset="sumDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">填报单位：</td>
					<td class="FieldInput" style="width:36%"><label field="organName"/></td>
					<td class="FieldLabel" style="width:16%">填报日期：</td>
					<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate" onchange="getData()"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</fieldset>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="detailDataSet" width="100%" stripeRows="true" height="99.9%" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem iconCls="return" text="返回上级" handler="getUp"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="auditButton" iconCls="delete" text="驳回" handler="audit"/>
	</next:TopBar>
	<next:Columns>
		<next:RadioBoxColumn/>
		<next:Column id="organName" header="填报单位名称" field="organName" width="90"  renderer="statusRender">
		</next:Column>

		<next:Column id="offConStatus" header="建设状态" field="offConStatus" width="90" dataset="offconstatusDataSet" >
		</next:Column>

		<next:Column id="offConKind" header="建设性质" field="offConKind" width="90" dataset="offconkindDataSet" >
		</next:Column>

		<next:Column id="offYear" header="使用年份" field="offYear" width="90" >
		</next:Column>

		<next:Column id="offConArea" header="建筑面积" field="offConArea" width="90" >
		</next:Column>

		<next:Column id="offHouseArea" header="房间面积" field="offHouseArea" width="90" >
		</next:Column>

		<next:Column id="offComputeNum" header="电脑数量" field="offComputeNum" width="90" >
		</next:Column>

		<next:Column id="serConType" header="建设模式" field="serConType" width="90" dataset="sercontypeDataSet" >
		</next:Column>

		<next:Column id="serConStatus" header="建设状态" field="serConStatus" width="90" dataset="offconstatusDataSet" >
		</next:Column>

		<next:Column id="serPlace" header="所在地" field="serPlace" width="90" >
		</next:Column>

		<next:Column id="serVillageNum" header="覆盖自然村个数" field="serVillageNum" width="90" >
		</next:Column>

		<next:Column id="serTotleArea" header="覆盖面积" field="serTotleArea" width="90" >
		</next:Column>

		<next:Column id="serConArea" header="建筑面积" field="serConArea" width="90" >
		</next:Column>

		<next:Column id="serConKind" header="建设性质" field="serConKind" width="90" dataset="offconkindDataSet" >
		</next:Column>

		<next:Column id="serConFlag" header="是否有标识" field="serConFlag" width="90" dataset="YNDataSet">
		</next:Column>

		<next:Column id="serLen" header="服务半径" field="serLen" width="90" >
		</next:Column>

		<next:Column id="reportDate" header="填报日期" field="reportDate" width="90" align="center" editable="false" sortable="false" ><next:ComboBox dataset="reportWorkDataSet"/></next:Column>

		<next:Column id="status" header="上报状态" field="status" width="90" align="center" editable="false" sortable="false"><next:ComboBox dataset="statusDataSet"/></next:Column>

		<next:Column id="submitDate" header="上报日期" field="submitDate" width="100" align="center" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:0,colspan:3},{header:'办公场所基本情况',start:3,colspan:6},{header:'社区服务设施建设情况',start:9,colspan:9},{header:'',start:18,colspan:3}]
    		]})
	</next:ExtendConfig>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="400" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel height="600">
		<next:Html>
			<form id="form1" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
			<fieldset id="cdcFieldset">
			<legend>填报情况</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel">填报单位：</td>
						<td class="FieldInput" colspan="3"><label field="organName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:18%">填报日期：</td>
						<td class="FieldInput" style="width:35%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
						<td class="FieldLabel" style="width:15%">上报日期：</td>
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
				<td class="FieldInput"><label name="offYear" field="offYear"  /> 年 </td>

				<td  class="FieldLabel" >建筑面积</td>
				<td class="FieldInput"><label name="offConArea" field="offConArea"  /> ㎡ </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">房间面积</td>
				<td class="FieldInput"><label name="offHouseArea" field="offHouseArea"  /> ㎡ </td>

				<td  class="FieldLabel" >电脑数量</td>
				<td class="FieldInput"><label name="offComputeNum" field="offComputeNum"  /> 台 </td>
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
				<td class="FieldInput"><label name="serVillageNum" field="serVillageNum"  /> 个 </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel"  colspan="2">覆盖面积</td>
				<td class="FieldInput"><label name="serTotleArea" field="serTotleArea"  />㎡ </td>

				<td  class="FieldLabel" >建筑面积</td>
				<td class="FieldInput"><label name="serConArea" field="serConArea"  /> ㎡ </td>
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
</next:Window>
</body>
</html>