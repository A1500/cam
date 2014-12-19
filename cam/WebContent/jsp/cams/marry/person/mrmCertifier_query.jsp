<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>婚姻颁证员名册</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="mrmCertifier_query.js"></script>
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
			var organType = '<%=BspUtil.getOrganType()%>';
		</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.marry.person.cmd.MarrypersonCommand" method="queryCertifierPersons" global="true"></model:dataset>
	<!-- 考试结果 -->
	<model:dataset id="ksjgDataset" enumName="MRM.KSJG.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 补考结果 -->
	<model:dataset id="bkjgDataset" enumName="MRM.BKJG.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 年度 -->
	<model:dataset id="ndYearDataset" autoLoad="true" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='MRM_QUALIFICATION_EXAM'></model:param>
			<model:param name="value" value='ND_YEAR'></model:param>
			<model:param name="text" value='ND_YEAR'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职务 -->
	<model:dataset id="zwDataset" enumName="MRM.ZW.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 学历 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 编制性质 -->
	<model:dataset id="FormationDataset" enumName="MRM.FORMATION.NATURE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" autoScroll="true" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 100%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel" nowrap>婚姻登记机关:</td>
								<td class="FieldInput"><input type="text"  id="deptName" onclick="forHelp()" readonly="readonly"   title="婚姻登记机关"  />
								<input type="hidden" id="deptId" name="deptId" /></td>	
								<td class="FieldLabel" nowrap>职务:</td>
								<td class="FieldInput"><select  id="technical" name="technical" title="职务" >
									<option dataset="zwDataset" />
								</select></td>	
								<td align="center" nowrap ><button onclick="query()">查 询</button></td>
							</tr>
							<tr>
							<td class="FieldLabel" nowrap>姓名:</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel" nowrap>从事本职工作时间:</td>
								<td class="FieldInput">
								<select  id="startYear" name="startYear" title="从事本职工作时间" >
									<option dataset="ndYearDataset" />
								</select>
								</td>	
								<td align="center"><button onclick="reset()">重 置</button></td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="editGridPanel" name="editGridPanel-grid" width="100%" height="100%" title="婚姻颁证员名册" dataset="ds">
	<next:TopBar>
	<next:ToolBarItem id="qrToolbar" text=""></next:ToolBarItem>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="打印" iconCls="detail" handler="print"/>
		<next:ToolBarItem text="导出台帐" iconCls="edit" handler="forExcel"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn />
		<next:CheckBoxColumn/>
		<next:Column header="人员ID" id="PERSON_ID" field="PERSON_ID" width="50" hidden="true"/>
		<next:Column header="姓名" id="NAME" field="NAME" width="80" renderer="detailHref" align="center"/>
		<next:Column header="性别" id="SEX" field="SEX" width="30" dataset="SexDataset"/>
		<next:Column header="年龄" id="AGE" field="AGE" width="30" />
		<next:Column header="身份证号" id="CARD_NO" field="CARD_NO" width="150" />
		<next:Column header="学历" id="CULTURE" field="CULTURE" width="80" dataset="EducationDataset"/>
		<next:Column header="政治面貌" id="POLITICS" field="POLITICS" width="130" dataset="PoliticalDataset"/>
		<next:Column header="工作单位" id="DEPT" field="DEPT" width="180"/>
		<next:Column header="编制性质" id="ORGANIZATION" field="ORGANIZATION" width="130" dataset="FormationDataset"/>
		<next:Column header="职务" id="technical" field="TECHNICAL" width="80" dataset="zwDataset"/>
		<next:Column header="从事本职工作时间" id="MARRY_START_DATE" field="MARRY_START_DATE" width="130"/>
		<next:Column header="资格证编号" id="CERTIFICATE_ID" field="CERTIFICATE_ID" width="130"/>
		<next:Column header="首次参加考试时间" id="FIRST_TIME" field="FIRST_TIME" width="130"/>
		<next:Column header="考试结果" id="FIRST_JG" field="FIRST_JG" width="130" dataset="ksjgDataset"/>
		<next:Column header="补考结果" id="FIRST_BKJG" field="FIRST_BKJG" width="130" dataset="bkjgDataset"/>
		<next:Column header="最近一次复考时间" id="LAST_TIME" field="LAST_TIME" width="130"/>
		<next:Column header="复考结果" id="LAST_JG" field="LAST_JG" width="130" dataset="ksjgDataset"/>
		<next:Column header="补考结果" id="LAST_BKJG" field="LAST_BKJG" width="130" dataset="bkjgDataset"/>
		<next:Column header="超期未参加考试自动失效时间" id="AUTOMATIC_FAILURE_TIME" field="AUTOMATIC_FAILURE_TIME" width="180"/>
		<next:Column header="上级撤销资格证时间" id="BACKOUT_TIME" field="BACKOUT_TIME" width="130"/>
		<next:Column header="离岗时间" id="DEPARTURE_TIME" field="DEPARTURE_TIME" width="130"/>
		<next:Column header="离岗原因" id="DEPARTURE_REASON" field="DEPARTURE_REASON" width="130"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:1,colspan:12},{header:'资格考试情况',start:13,colspan:8},{header:'',start:21,colspan:1},{header:'',start:22,colspan:1}]]
    		})
	</next:ExtendConfig>
</next:GridPanel>
<input type="hidden" id="docpath" value="" />
<input type="hidden" id="method"  value="printMrmPerson" />
<input type="hidden" id="personId" name="printQuery"
	queryData="queryData" value="" />
<input type="hidden" id="scaconfPath"
	value="mrmBasePerson/mrmBasePersonPrintDao" />
</body>
</html>