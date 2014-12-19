<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村社区基础设施情况汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcFacilitiesReportSum.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFacilitiesReport"/>
	</model:dataset>
	<model:dataset id="fReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcFacilitiesReportQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcFacilitiesReport"/>
		<model:params>
			<model:param name="REPORT_TYPE" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R06'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"></model:dataset>
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
<next:EditGridPanel id="grid" dataset="fReportDataSet" width="100%" stripeRows="true" height="99.9%" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem iconCls="return" text="返回上级" handler="getUp"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="auditButton" iconCls="delete" text="驳回" handler="audit"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column id="organName" header="单位名称" field="organName" width="90" renderer="statusRender" />
		<next:Column id="offNum" header="数量(个)" field="offNum" width="90" />
		<next:Column id="offArea" header="建筑面积(m2)" field="offArea" width="90" />
		<next:Column id="offYear" header="投入使用年份(年)" field="offYear" width="110" />
	
		<next:Column id="serviceNum" header="个数(个)" field="serviceNum" width="90" />
		<next:Column id="serviceArea" header="面积(m2)" field="serviceArea" width="90" />
		<next:Column id="serviceYear" header="投入使用年份(年)" field="serviceYear" width="110" />
		
		<next:Column id="policeNum" header="个数(个)" field="policeNum" width="90" />
		<next:Column id="policeArea" header="面积(m2)" field="policeArea" width="90" />
		<next:Column id="policeYear" header="投入使用年份(年)" field="policeYear" width="110" />

		<next:Column id="clinicNum" header="个数(个)" field="clinicNum" width="90" />
		<next:Column id="clinicArea" header="面积(m2)" field="clinicArea" width="90" />
		<next:Column id="clinicYear" header="投入使用年份(年)" field="clinicYear" width="110" />
	
		<next:Column id="libNum" header="个数(个)" field="libNum" width="90" />
		<next:Column id="libArea" header="面积(m2)" field="libArea" width="90" />
		<next:Column id="libYear" header="投入使用年份(年)" field="libYear" width="110" />
	
		<next:Column id="actionNum" header="个数(个)" field="actionNum" width="90" />
		<next:Column id="actionArea" header="面积(m2)" field="actionArea" width="90" />
		<next:Column id="actionYear" header="投入使用年份(年)" field="actionYear" width="110" />
	
		<next:Column id="handNum" header="个数(个)" field="handNum" width="90" />
		<next:Column id="handArea" header="面积(m2)" field="handArea" width="90" />
		<next:Column id="handYear" header="投入使用年份(年)" field="handYear" width="110" />
		
		<next:Column id="offMon" header="投入资金(万元)" field="offMon" width="90" />
		<next:Column id="offFinanceMon" header="财政拨款(万元)" field="offFinanceMon" width="90" />
		<next:Column id="offSelfMon" header="自筹(万元)" field="offSelfMon" width="90" />
		<next:Column id="offEndowMon" header="社会捐助(万元)" field="offEndowMon" width="90" />
		<next:Column id="offOtherMon" header="其他(万元)" field="offOtherMon" width="90" />

		<next:Column id="outNum" header="数量(个)" field="outNum" width="90" />
		<next:Column id="outArea" header="面积(m2)" field="outArea" width="90" />
		<next:Column id="outYear" header="投入使用年份(年)" field="outYear" width="110" />
		<next:Column id="outMon" header="投入资金(万元)" field="outMon" width="90" />
		<next:Column id="outFinanceMon" header="财政拨款(万元)" field="outFinanceMon" width="90" />
		<next:Column id="outSelfMon" header="自筹(万元)" field="outSelfMon" width="90" />
		<next:Column id="outEnbowMon" header="社会捐助(万元)" field="outEnbowMon" width="90" />
		<next:Column id="outOtherMon" header="其他(万元)" field="outOtherMon" width="90" />

		<next:Column id="reportDate" header="填报日期" field="reportDate" sortable="true" width="90" align="center" ><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column id="status" header="上报状态" field="status" width="90" sortable="true" align="center" ><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column id="submitDate" header="上报日期" field="submitDate" sortable="true" width="90" align="center" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fReportDataSet"/>
	</next:BottomBar>
		<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'社区工作用房',start:3,colspan:3},{header:'社区服务设施用房',start:6,colspan:18},
        			  {header:'社区工作用房、社区服务设施用房投入资金',start:24,colspan:5},{header:'社区室外活动场地',start:29,colspan:8},{header:'',start:37,colspan:3}],
        			  [{header:'社区服务大厅',start:6,colspan:3},{header:'社区警务室',start:9,colspan:3},{header:'社区卫生室',start:12,colspan:3},
        			  {header:'社区图书室',start:15,colspan:3},{header:'社区文娱活动室',start:18,colspan:3},{header:'残疾人活动室',start:21,colspan:3},
        			  {header:'',start:24,colspan:1},{header:'资金来源',start:25,colspan:4},{header:'资金来源',start:33,colspan:4},{header:'',start:37,colspan:3}]
    		]})
	</next:ExtendConfig>
</next:EditGridPanel>


<next:Window id="detailWin" title="明细" resizable="false" width="800" height="420" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel height="900">
		<next:Html>
			<form id="form1" method="post" dataset="fReportDataSet" onsubmit="return false" class="L5form">
			<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel"  style="width:10%">填报日期：</td>
			<td class="FieldInput"  style="width:18%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel"  style="width:10%">上报日期：</td>
			<td class="FieldInput"  style="width:18%"><label field="submitDate"/></td>
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
</next:Window>
<next:Window id="rejectWin" title="驳回原因" resizable="false" width="400" height="200" modal="true" closeAction="hide" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="fReportDataSet" onsubmit="return false" class="L5form">
	<fieldset>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:30%">驳回原因：</td>
			<td class="FieldInput" style="width:70%" ><textArea style="height:110;width:100%" id="reason"></textArea></td>
		</tr>
	</table>
	</fieldset>
</form>
</next:Html>
<next:Buttons>
		<next:ToolButton text="确定" handler="confirmReject"></next:ToolButton>
		<next:ToolButton text="取消" handler="closeWin"></next:ToolButton>
</next:Buttons>
</next:Window>
</body>
</html>