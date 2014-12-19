
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>年检历史查询</title>
<next:ScriptManager />
<script type="text/javascript" src="../ep.js"></script>
<script type="text/javascript" src="cemeInspectionHistoryQuery.js"></script>
<script>
        var orgCode ='<%=BspUtil.getParentOrgan().getOrganCode()%>';
		var orgName ='<%=BspUtil.getParentOrgan().getOrganName()%>';
</script>
<script language="javascript">
		 	 //查询条件打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.ep.base.cmd.FisCemeCheckResultQueryCommand"
		global="true" method="cemecheckQuery">
		<model:record>
			<model:field name="APPLY_ID" />
			<model:field name="RECORD_ID" />
			<model:field name="NAME" />
			<model:field name="MANA_LEVEL" />
			<model:field name="CHECK_YEAR" />
			<model:field name="CHECK_NUM" />
			<model:field name="PROP" />
			<model:field name="CHECK_TIME" />
			<model:field name="CHEKC_RESULT" />
			<model:field name="CHECK_SCORE" />
			<model:field name="CHECK_RESULT" />
			<model:field name="CHECK_UNIT" />
		</model:record>
	</model:dataset>
	<!-- 年检打分 -->
	<model:dataset id="scoreDataSet"
		cmd="com.inspur.cams.fis.base.cmd.FisCemeCheckScoreQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.fis.base.data.FisCemeCheckScore">
		</model:record>
	</model:dataset>
		<model:dataset id="fisCemeApplyInfoDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCemeApplyInfoQueryCmd" pageSize="10"  global="true">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeApplyInfo"/>
	</model:dataset>
	<model:dataset id="detailDS" cmd="com.inspur.cams.fis.base.cmd.FisCemeInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCemeInfo"/>
	</model:dataset>
	<model:dataset id="gongmuxingzhiDataSet" enumName="FIS.CEME.PROP"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="inspectionresultDataSet"
		enumName="FIS.CEME.INSPECTION.STATUS" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="timesDataSet" enumName="FIS.CEME.INSPECTION.TIMES"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="resultDataSet" enumName="FIS.CEME.RESULT.QUERY"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="unitPropertiesDataSet"
		enumName="FIS.CEME.UNITPROPERTIES" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel name="form" width="99.9%" border="0" autoHeight="true">
	<next:Html>
		<fieldset style="overflow: visible;" class="GroupBox"><legend
			class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
			src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
			onclick="collapse(this)" /> </legend>
		<div>
		<form style="width: 100%; height: 100%;" class="L5form">
		<table border="1" width="100%">
			<tr>
				<td class="FieldLabel">公墓编号:</td>
				<td class="FieldInput"><input type="text" id="cemeID"
					class="TextEditor" title="公墓编号" /></td>
				<td class="FieldLabel">所属行政区:</td>
				<td class="FieldInput"><input type="text"
					name="deptName" id="deptName" field="deptName"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="areaLevelId" field="areaLevelId" style="display: none;" />
					<button  style="cursor: hand" onclick="selectAreaNoDs()">选择</button></td>
				<td class="FieldLabel">主管单位:</td>
				<td class="FieldInput" colspan="1"><input type="text"
					name="manaLevel" id="manaLevel" field="manaLevel"
					class="TextEditor" readonly="readonly" /> <input type="text"
					id="manaLevelId" field="manaLevelId" style="display: none;" /> 
					<button  style="cursor: hand" onclick="selectOrganNoDs()">选择</button></td>
			</tr>
			<tr>
			    <td class="FieldLabel" >公墓性质:</td>
					<td class="FieldInput" ><select
					         name="cemeProp" id="cemeProp">
				    <option dataset="gongmuxingzhiDataSet" title="公墓性质"></option>
				    </select>
				</td>
				<td class="FieldLabel">年检年份:</td>
				<td class="FieldInput"><input type="text" id="year"
					class="TextEditor" title="年检年份" value="2013" /></td>
				<td class="FieldLabel">年检结果:</td>
				<td class="FieldInput"><select id="result" name="年检结果"
					field="result">
					<option dataset="resultDataSet"></option>
				</select></td>
			</tr>
			<tr>
				<td class="FieldLabel" colspan="6">
				<button onclick="query()">查 询</button>
				&nbsp;
				<button onclick="resetQuery()">重 置</button>
				</td>
			</tr>
		</table>
		</form>
		</div>
		</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="inspectionGrid" width="99.9%"
	stripeRows="true" height="99.9%" dataset="ds">
	<next:TopBar>
		<next:ToolBarItem id="cemeTitle" text="公墓年检信息列表" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detail" />
		<next:ToolBarItem text="导出" iconCls="export" handler="exportExcel" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="cemeId" header="公墓编号" field="ORGAN_ID" width="100"
			hidden="false">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="公墓名称" field="NAME" width="150">
			<next:TextField />
		</next:Column>
		<next:Column header="公墓性质" field="PROP" dataset="gongmuxingzhiDataSet" width="60">
			<next:TextField />
		</next:Column>
		<next:Column header="年检年份" field="CHECK_YEAR" width="60">
			<next:TextField />
		</next:Column>
		<next:Column header="年检类型" field="CHECK_NUM" dataset="timesDataSet"
			width="60" hidden="true">
			<next:TextField />
		</next:Column>
		<next:Column header="年检时间" field="SECOND_TIME" width="80">
			<next:TextField />
		</next:Column>
		<next:Column header="年检结果" field="CHECK_RESULT"
			dataset="resultDataSet" width="80">
			<next:TextField />
		</next:Column>
		<next:Column header="年检得分" field="SECOND_TOTAL_SCORE" align="right" width="60">
			<next:TextField />
		</next:Column>
        <next:Column header="年检单位" field="SECOND_UNIT" width="100">
			<next:TextField />
		</next:Column>
		<next:Column header="主管单位" field="MANA_LEVEL" width="160">
			<next:TextField />
		</next:Column>
		<next:Column header="所属行政区" field="DEPT_NAME" width="100">
			<next:TextField />
		</next:Column>
		<next:Column id="wfId" header="流程编号" field="WF_ID" width="150"
			hidden="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="本年度年检次数" field="CHECK_NUM" width="100" hidden="true">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>

<!--经营性年检明细-->
<next:Window id="CemeDetailWin" height="480" width="720" title="公墓年检明细查询窗口"
	resizable="true" closable="false" modal="false">
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="undoWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel height="100%" width="98%" autoScroll="true">
		<next:Panel autoScroll="false">
			<next:Html>
				<form id="editForm" method="post" dataset="detailDS"
					onsubmit="return false" class="L5form">
				<fieldset><legend>单位信息</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width: 20%">公墓名称</td>
						<td class="FieldInput"><label id="name" name="公墓名称"
							field="name" title="补录公墓的全称" style="width: 200px;" /></td>
						<td class="FieldLabel">主管单位</td>
						<td class="FieldInput"><label name="主管单位" id="manaLevel"
							field="manaLevel" readonly="readonly" /> <input type="text"
							id="manaLevelId" field="manaLevelId" style="display: none;" />
					</tr>
					<tr>
						<td class="FieldLabel">主办单位</td>
						<td class="FieldInput"><label name="主办单位"
							style="width: 200px;" field="organizer" />
						<td class="FieldLabel" style="width: 20%">公墓编号</td>
						<td class="FieldInput" style="width: 31%"><label id="cemeId"
							name="公墓编号" field="cemeId"
							title="省厅民政部门授予的组织编码，全省唯一\n请按主管单位的批准时间编写公墓顺序号" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓负责人</td>
						<td class="FieldInput"><label name="公墓负责人"
							field="legalPerson" /></td>
						<td class="FieldLabel">公墓性质</td>
						<td class="FieldInput"><label title="公墓性质">公益性</label> <input
							type="hidden" name="prop" field="prop" title="公墓性质"></input></td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓负责人手机</td>
						<td class="FieldInput"><label name="公墓负责人手机"
							id="directorMobile" field="directorMobile" /></td>
						<td class="FieldLabel">正式使用时间</td>
						<td class="FieldInput"><label name="正式使用时间"
							field="gestionTime" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 20%">公墓占地面积</td>
						<td class="FieldInput"><label name="公墓占地面积(亩)" renderer="muRender"
							style="text-align: right" field="totalArea" id="totalArea" /><!--&nbsp;&nbsp;<select name="公墓占地面积计量单位" id="totalAreaUnits"
							field="totalAreaUnits" style="width: 80px;">
							<option dataset="AreaUnitsDataSet"></option>
						</select>
						--></td>
						<td class="FieldLabel">资金来源</td>
						<td class="FieldInput"><input type="checkbox" name="资金来源"
							value="1" id="fundSources" field="fundSources"
							disabled="disabled"> <label>财政拨款</label> <input
							type="checkbox" name="资金来源" value="2" id="fundSources"
							field="fundSources" disabled="disabled"> <label>上级部门拨款</label>
						<input type="checkbox" name="资金来源" value="3" id="fundSources"
							field="fundSources" disabled="disabled"> <label>自筹</label>
						<br />
						<input type="checkbox" name="资金来源" value="4" id="fundSources"
							field="fundSources" disabled="disabled"> <label>福彩资助</label>
						<input type="checkbox" name="资金来源" value="5" id="fundSources"
							field="fundSources" disabled="disabled"> <label>其他</label></td>

					</tr>
					<tr>
						<td class="FieldLabel">所属行政区</td>
						<td class="FieldInput"><label name="所属行政区" id="deptName"
							field="deptName" /></td>
						<td class="FieldLabel">公墓所在位置</td>
						<td class="FieldInput"><label name="公墓所在位置" field="address"
							style="width: 300px" /></td>
					</tr>
					<!-- <tr>
						<td class="FieldLabel">服务范围</td>
						<td class="FieldInput" colspan="5"><textarea rows="3"
							name='服务范围' field="serviceScope" style="width: 90%"
							readonly="readonly"></textarea></td>

					</tr> -->
				</table>
				</fieldset>
				</form>
			</next:Html>
		</next:Panel>
		
	</next:Panel>
</next:Window>

<!--经营性年检明细-->
<next:Window id="CheckDetailWin" height="480" width="720" title="经营性公墓年检明细查询窗口"
	resizable="true" closable="false" modal="false">
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="undoWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel height="100%" width="98%" autoScroll="true">
		<next:Panel autoScroll="false">
			<next:Html>
				<form id="editForm" method="post" dataset="detailDS"
					onsubmit="return false" class="L5form">
				<fieldset><legend>单位信息</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width: 20%">公墓名称</td>
						<td class="FieldInput"><label id="name" name="公墓名称"
							field="name" title="补录公墓的全称" style="width: 200px;" /></td>
						<td class="FieldLabel">主管单位</td>
						<td class="FieldInput"><label name="主管单位" id="manaLevel"
							field="manaLevel" readonly="readonly" /> <input type="text"
							id="manaLevelId" field="manaLevelId" style="display: none;" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">单位性质</td>
						<td class="FieldInput"><label name="单位性质" id="unitProperties"
							field="unitProperties" dataset="unitPropertiesDataSet" /></td>
						<td class="FieldLabel" style="width: 20%">公墓编号</td>
						<td class="FieldInput" style="width: 31%"><label id="cemeId"
							name="公墓编号" field="cemeId"
							title="省厅民政部门授予的组织编码，全省唯一\n请按主管单位的批准时间录入公墓信息" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">主办/联办单位</td>
						<td class="FieldInput"><label name="主办单位" field="organizer"
							style="width: 200px;" />
						<td class="FieldLabel">公墓性质</td>
						<td class="FieldInput"><label title="公墓性质">经营性</label> <input
							type="hidden" name="prop" field="prop" title="公墓性质"></input></td>
					</tr>
					<tr>
						<td class="FieldLabel">法人代表</td>
						<td class="FieldInput"><label name="法人代表" field="legalPerson" /></td>
						<td class="FieldLabel">职工总数</td>
						<td class="FieldInput"><label name="职工总数" id="totalStaff"
							field="totalStaff" renderer="renRender"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓负责人</td>
						<td class="FieldInput"><label name="公墓负责人"
							id="directorMobile" field="directorMobile" /></td>
						<td class="FieldLabel">联系电话</td>
						<td class="FieldInput"><label name="联系电话" field="officePhone"
							id="officePhone" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">固定资产</td>
						<td class="FieldInput"><label name="固定资产" renderer="wanRender"
							style="text-align: right" field="fixeDassets" id="fixeDassets" /></td>
						<td class="FieldLabel">总投资额</td>
						<td class="FieldInput"><label name="总投资额" renderer="wanRender"
							style="text-align: right" field="totalInvestment"
							id="totalInvestment" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">正式营业时间</td>
						<td class="FieldInput"><label name="正式营业时间"
							field="gestionTime" /></td>
						<td class="FieldLabel">邮编</td>
						<td class="FieldInput"><label name="邮政编码" field="postalcode"
							id="postalcode" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓占地面积</td>
						<td class="FieldInput"><label style="text-align: right" renderer="muRender"
							name="占地总面积" field="totalArea" id="totalArea" /><!--
					&nbsp; <select name="公墓占地面积计量单位" id="totalAreaUnits"
						field="totalAreaUnits" style="width: 60px">
						<option dataset="AreaUnitsDataSet"></option>
					</select>--></td>
						<td class="FieldLabel">墓区建成面积</td>
						<td class="FieldInput"><label style="text-align: right" renderer="muRender"
							name="墓区建成面积" field="builtArea" id="builtArea" /><!--
					&nbsp; <select name="墓区建成面积计量单位" id="builtAreaUnits"
						field="builtAreaUnits" style="width: 60px">
						<option dataset="AreaUnitsDataSet"></option>
					</select>
					--></td>
					</tr>
					<tr>
						<td class="FieldLabel">建筑面积</td>
						<td class="FieldInput"><label style="text-align: right" renderer="aRender"
							name="建筑总面积" field="builtTotalArea" id="builtTotalArea" /></td>
						<td class="FieldLabel">所属行政区</td>
						<td class="FieldInput"><label name="所属行政区" id="deptName"
							field="deptName" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">公墓所在位置</td>
						<td class="FieldInput" colspan="3"><label name="公墓所在位置"
							field="address" style="width: 300px" /></td>
					</tr>
					<!-- <tr>
						<td class="FieldLabel">服务范围</td>
						<td class="FieldInput" colspan="5"><textarea rows="3"
							name='服务范围' field="serviceScope" style="width: 90%"
							readonly="readonly"></textarea></td>
					</tr> -->
				</table>
				</fieldset>
				</form>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="jingyingGridPanel" name="govAppGridPanel"
			stripeRows="true" height="300" dataset="fisCemeApplyInfoDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="公墓年检情况记录"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="查看" iconCls="detail" handler="forjyDetail" />
			</next:TopBar>
			<next:Columns>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				 <next:Column id="recordId" header="公墓ID" field="recordId" width="160"
					sortable="false" editable="false" hidden="true">
					<next:TextField />
				</next:Column> 
				<next:Column id="wfId" header="流程记录ID" field="wfId" width="160"
					sortable="false" editable="false" hidden="true">
					<next:TextField />
				</next:Column>
				<next:Column id="cemeApplyId" header="年检记录ID" field="cemeApplyId"
					width="160" sortable="false" editable="false" hidden="true">
					<next:TextField />
				</next:Column>
				<next:Column id="checkYear" header="年检年份" field="checkYear"
					width="80" sortable="false" editable="false">
					<next:TextField />
				</next:Column>
				<%-- <next:Column id="name" header="公墓名称" field="name"
					width="200" sortable="false">
					<next:TextField />
				</next:Column> --%>
				<next:Column id="checkNum" header="年检次数" field="checkNum" width="80"
					sortable="false" renderer="proCheckNumRendener">
					<next:TextField />
				</next:Column>
				<%-- <next:Column id="prop" header="公墓性质" field="prop"
					dataset="gongmuxingzhiDataSet" width="80" sortable="false">
					<next:TextField />
				</next:Column> --%>
				<next:Column id="comTime" header="批准时间" field="comTime"
					width="180" sortable="false">
					<next:TextField />
				</next:Column>
			</next:Columns>
		</next:GridPanel>
	</next:Panel>
</next:Window>
</body>
</html>
