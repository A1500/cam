<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
	<head>
		<title>逝者信息</title>
		<next:ScriptManager />
<script type="text/javascript">
    var orgCode ='<%=ExtBspInfo.getUserInfo(request).getAreaCode()%>';
	var orgName ='<%=ExtBspInfo.getUserInfo(request).getAreaName()%>';
</script>
		<script type="text/javascript" src="exchangeFisQuery.js"></script>
		<script type="text/javascript" src="exFisDeadInfoDetailComm.js"></script>
		<script type="text/javascript" src="exTimeControl.js"></script>
		<script type="text/javascript">
			var organId='<%=request.getParameter("organId")%>';
			var unitName='<%=request.getParameter("unitName")%>';
			var qPopulace='<%=request.getParameter("qPopulace")%>';
			var qPopulaceName='<%=request.getParameter("qPopulaceName")%>';
			var qQreferentialTypeName='<%=request.getParameter("qQreferentialTypeName")%>';
			var SCremationTime='<%=request.getParameter("SCremationTime")%>';
			var ECremationTime='<%=request.getParameter("ECremationTime")%>';
			var method='<%=request.getParameter("method")%>';
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
	<!-- 数据上报逝者信息 -->
	<model:dataset id="fisFuneralDeadInfoDS"
		cmd="com.inspur.cams.fis.base.cmd.FisCremationInfoSumQueryCommand" method="queyDeadInfo" pageSize="10">
		<model:record>
			<model:field name="RECORD_ID" type="string"/>
			<model:field name="CREMATION_TYPE" type="string"/>
			<model:field name="STOVE_ID" type="string"/>
			<model:field name="STOVE_PEOPLE" type="string"/>
			<model:field name="STATUS" type="string"/>
			<model:field name="START_TIME" type="string"/>
			<model:field name="END_TIME" type="string"/>
			<model:field name="SERVICE_USE_ID" type="string"/>
			<model:field name="APPLY_ID" type="string"/>
			<model:field name="APPLY_TYPE" type="string"/>
			<model:field name="CUSTOM_ID" type="string"/>
			<model:field name="IF_RECEIVE" type="string"/>
			<model:field name="RECEIVE_TIME" type="string"/>
			<model:field name="CONTRACT_ORGAN" type="string"/>
			<model:field name="CONTRACT_ORGAN_NAME" type="string"/>
			<model:field name="CONTRACT_PEOPLE" type="string"/>
			<model:field name="CONTRACT_DATE" type="string"/>
			<model:field name="IF_FINISH" type="string"/>
			<model:field name="FINISH_TIME" type="string"/>
			<model:field name="IF_TAKEASHES" type="string"/>
			<model:field name="TAKEASHES_TIME" type="string"/>
			<model:field name="IF_FEE_END" type="string"/>
			<model:field name="FEE_END_TIME" type="string"/>
			<model:field name="IF_PRINT" type="string"/>
			<model:field name="PRINT_TIME" type="string"/>
			<model:field name="ASHES_GO" type="string"/>
			<model:field name="IF_BOOK" type="string"/>
			<model:field name="BOOK_CUSTOM" type="string"/>
			<model:field name="BOOK_PEOPLE_NAME" type="string"/>
			<model:field name="BOOK_TIME" type="string"/>
			<model:field name="DEAD_ID" type="string"/>
			<model:field name="IF_NAMELESS" type="string"/>
			<model:field name="NAME" type="string"/>
			<model:field name="SEX" type="string"/>
			<model:field name="CARD_TYPE" type="string"/>
			<model:field name="ID_CARD" type="string"/>
			<model:field name="BIRTHDAY" type="string"/>
			<model:field name="AGE" type="string"/>
			<model:field name="NATION" type="string"/>
			<model:field name="FOLK" type="string"/>
			<model:field name="PROFESSION" type="string"/>
			<model:field name="EDUCATION" type="string"/>
			<model:field name="POLITICAL" type="string"/>
			<model:field name="RELIGION" type="string"/>
			<model:field name="IF_LOCAL" type="string"/>
			<model:field name="POPULACE" type="string"/>
			<model:field name="FAMILY_ADD" type="string"/>
			<model:field name="WORK_NAME" type="string"/>
			<model:field name="DEATH_DATE" type="string"/>
			<model:field name="DEATH_PLACE" type="string"/>
			<model:field name="DEATH_CAUSE" type="string"/>
			<model:field name="DEATH_DISEASE" type="string"/>
			<model:field name="CORPSE_STATUS" type="string"/>
			<model:field name="CORPSE_STATUS_NOTE" type="string"/>
			<model:field name="RELICS" type="string"/>
			<model:field name="DEATH_CERT_ORG" type="string"/>
			<model:field name="GOODBYE_TIME" type="string"/>
			<model:field name="CREMATION_TIME" type="string"/>
			<model:field name="PREFERENTIAL_TYPE" type="string"/>
			<model:field name="PHOTO_ID" type="string"/>
			<model:field name="ACCESSORIES" type="string"/>
			<model:field name="NOTE" type="string"/>
			<model:field name="CREATE_ORGAN" type="string"/>
			<model:field name="CREATE_ORGAN_NAME" type="string"/>
			<model:field name="CREATE_PEOPLE" type="string"/>
			<model:field name="CREATE_PEOPLE_NAME" type="string"/>
			<model:field name="CREATE_TIME" type="string"/>
			<model:field name="DEATH_CERT_ORG_NAME" type="string"/>
			<model:field name="IF_TODUST" type="string"/>
			<model:field name="POPULACE_NAME" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 数据上报逝者信息 -->
	<model:dataset id="fisFuneralDeadInfoDS2"
		cmd="com.inspur.cams.fis.base.cmd.FisCremationInfoSumQueryCommand" method="queyDeadInfo" pageSize="10">
		<model:record>
			<model:field name="RECORD_ID" type="string"/>
			<model:field name="CREMATION_TYPE" type="string"/>
			<model:field name="STOVE_ID" type="string"/>
			<model:field name="STOVE_PEOPLE" type="string"/>
			<model:field name="STATUS" type="string"/>
			<model:field name="START_TIME" type="string"/>
			<model:field name="END_TIME" type="string"/>
			<model:field name="SERVICE_USE_ID" type="string"/>
			<model:field name="APPLY_ID" type="string"/>
			<model:field name="APPLY_TYPE" type="string"/>
			<model:field name="CUSTOM_ID" type="string"/>
			<model:field name="IF_RECEIVE" type="string"/>
			<model:field name="RECEIVE_TIME" type="string"/>
			<model:field name="CONTRACT_ORGAN" type="string"/>
			<model:field name="CONTRACT_ORGAN_NAME" type="string"/>
			<model:field name="CONTRACT_PEOPLE" type="string"/>
			<model:field name="CONTRACT_DATE" type="string"/>
			<model:field name="IF_FINISH" type="string"/>
			<model:field name="FINISH_TIME" type="string"/>
			<model:field name="IF_TAKEASHES" type="string"/>
			<model:field name="TAKEASHES_TIME" type="string"/>
			<model:field name="IF_FEE_END" type="string"/>
			<model:field name="FEE_END_TIME" type="string"/>
			<model:field name="IF_PRINT" type="string"/>
			<model:field name="PRINT_TIME" type="string"/>
			<model:field name="ASHES_GO" type="string"/>
			<model:field name="IF_BOOK" type="string"/>
			<model:field name="BOOK_CUSTOM" type="string"/>
			<model:field name="BOOK_PEOPLE_NAME" type="string"/>
			<model:field name="BOOK_TIME" type="string"/>
			<model:field name="DEAD_ID" type="string"/>
			<model:field name="IF_NAMELESS" type="string"/>
			<model:field name="NAME" type="string"/>
			<model:field name="SEX" type="string"/>
			<model:field name="CARD_TYPE" type="string"/>
			<model:field name="ID_CARD" type="string"/>
			<model:field name="BIRTHDAY" type="string"/>
			<model:field name="AGE" type="string"/>
			<model:field name="NATION" type="string"/>
			<model:field name="FOLK" type="string"/>
			<model:field name="PROFESSION" type="string"/>
			<model:field name="EDUCATION" type="string"/>
			<model:field name="POLITICAL" type="string"/>
			<model:field name="RELIGION" type="string"/>
			<model:field name="IF_LOCAL" type="string"/>
			<model:field name="POPULACE" type="string"/>
			<model:field name="FAMILY_ADD" type="string"/>
			<model:field name="WORK_NAME" type="string"/>
			<model:field name="DEATH_DATE" type="string"/>
			<model:field name="DEATH_PLACE" type="string"/>
			<model:field name="DEATH_CAUSE" type="string"/>
			<model:field name="DEATH_DISEASE" type="string"/>
			<model:field name="CORPSE_STATUS" type="string"/>
			<model:field name="CORPSE_STATUS_NOTE" type="string"/>
			<model:field name="RELICS" type="string"/>
			<model:field name="DEATH_CERT_ORG" type="string"/>
			<model:field name="GOODBYE_TIME" type="string"/>
			<model:field name="CREMATION_TIME" type="string"/>
			<model:field name="PREFERENTIAL_TYPE" type="string"/>
			<model:field name="PHOTO_ID" type="string"/>
			<model:field name="ACCESSORIES" type="string"/>
			<model:field name="NOTE" type="string"/>
			<model:field name="CREATE_ORGAN" type="string"/>
			<model:field name="CREATE_ORGAN_NAME" type="string"/>
			<model:field name="CREATE_PEOPLE" type="string"/>
			<model:field name="CREATE_PEOPLE_NAME" type="string"/>
			<model:field name="CREATE_TIME" type="string"/>
			<model:field name="DEATH_CERT_ORG_NAME" type="string"/>
			<model:field name="IF_TODUST" type="string"/>
			<model:field name="POPULACE_NAME" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 骨灰去向 -->
	<model:dataset id="ashesGoDS" enumName="FIS.ASHES.GO" autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否-->
	<model:dataset id="yesOrNoDs" enumName="COMM.YESORNO" autoLoad="true" global="true">
	</model:dataset>
	<!-- 优惠类型字典-->
	<model:dataset id="preferentialTypeDS"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='FIS_REDUCATION_TYPE'></model:param>
			<model:param name="value" value='REDUCATION_TYPE_ID'></model:param>
			<model:param name="text" value='REDUCATION_TYPE_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 教育状况 -->
	<model:dataset id="DmJyzkDataSet" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族代码-->
	<model:dataset id="DmMzDataSet" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
	<model:dataset id="DmZyDataSet" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 男女-->
	<model:dataset id="commSexDS" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 遗体状态-->
	<model:dataset id="fisCorpseStatusDS" enumName="FIS.CORPSE.STATUS"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 宗教信仰 -->
	<model:dataset id="religionDS" enumName="FIS.RELIGION" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeDS" enumName="FIS.CARD.TYPE" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 病种字典 -->
	<model:dataset id="diseaseDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISEASE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 国籍 -->
	<model:dataset id="nationDS"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="sort" value=""></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="deathCertOrganDS" enumName="FIS.DEATH.CERT.ORGAN"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 死亡原因 FIS.DEATH.CAUSE-->
	<model:dataset id="fisDeathCauseDS" enumName="FIS.DEATH.CAUSE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0">
	<next:Html>	
	<fieldset><legend>查询条件
	<img class="GroupBoxExpandButton"
					src=<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%> onclick="collapse(this)" /> </legend>
				<div>
					<form class="L5form" id="form_content">
						<table width="100%" >
							<tr>
								<td class="FieldLabel" width="8%">户口所在地:</td>
								<td class="FieldInput" width="25%"><input type="text" name="户口所在地"
									id="qPopulaceName" readonly="readonly" style="width: 70%"/><img
									src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
									style="cursor: hand;display: none;" onclick="forHelp(this.id)" />&nbsp;
									<button  style="cursor: hand" onclick="forHelp(this.id)">选择</button>
								<td style="display: none;"><input type="text" id="qPopulace" />
								</td>
						        <td class="FieldLabel" width="8%">逝者姓名:</td>
						        <td class="FieldInput" width="25%">
						        	<input type="text"  id="qName" style="width: 80%"/>
						        </td>
						        <td class="FieldLabel" width="10%">证件号码:</td>
						        <td class="FieldInput" width="23%">
						        	<input type="text"  id="qIdCard" style="width: 80%"/>
						        </td>
						     </tr>
						     <tr>
						     	<td class="FieldLabel" >殡仪馆名称:</td>
						        <td class="FieldInput" ><input type="text" name="殡仪馆"
									id="qOrganName" readonly="readonly" style="width: 70%"/><img
									src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
									style="cursor: hand;display: none;" onclick="forOrganHelp(this.id)" />&nbsp;
									<button  style="cursor: hand" onclick="forOrganHelp(this.id)">选择</button>
								<td style="display: none;"><input type="text" id="qOrganId" />
						        </td>
						        <td class="FieldLabel" >享受惠民政策:</td>
						        <td class="FieldInput" >
						        	<select id="qQreferentialTypeName" style="width: 80%">
						        		<option dataset="preferentialTypeDS"></option>
						        	</select>
						        </td>
						        <td class="FieldLabel" >逝者年龄段:</td>
						        <td class="FieldInput" >
							        <input type="text" id="qAgeBegin" style="width: 35%">
							        &nbsp;至&nbsp;
							        <input type="text" id="qAgeEnd" style="width: 35%">
						        </td>
						     </tr> 
						    <tr>
						    	<td class="FieldLabel" >死亡时间:</td>
						        <td class="FieldInput" >
							        <input type="text" id="SRecieveTime" style="width: 35%" onpropertychange="changeDateStyle(this)" onblur="check(this)"  format="Y-m-d" maxlength="10"/><img src="../../../../skins/images/default/rl.gif" align="middle" onclick="getDay(this);">
							        &nbsp;至&nbsp;
							        <input type="text" id="ERecieveTime" style="width: 35%" onpropertychange="changeDateStyle(this)" onblur="check(this)"  format="Y-m-d" maxlength="10"/><img src="../../../../skins/images/default/rl.gif" align="middle" onclick="getDay(this);">
						        </td>
								<td class="FieldLabel" >火化时间:</td>
						        <td class="FieldInput" >
							        <input type="text" id="SCremationTime" style="width: 35%" onpropertychange="changeDateStyle(this)" onblur="check(this)"  format="Y-m-d" maxlength="10"/><img src="../../../../skins/images/default/rl.gif" align="middle" onclick="getDay(this);">
							        &nbsp;至&nbsp;
							        <input type="text" id="ECremationTime" style="width: 35%" onpropertychange="changeDateStyle(this)" onblur="check(this)"  format="Y-m-d" maxlength="10"/><img src="../../../../skins/images/default/rl.gif" align="middle" onclick="getDay(this);">
						        </td>
						        <td class="FieldLabel" >骨灰去向:</td>
						        <td class="FieldInput" >
						        	<select id="qFisAshesGo" style="width: 80%" >
						        		<option dataset="ashesGoDS" ></option>
						        	</select>
						        </td>
						     </tr>
						     <tr>
						    	<td class="FieldLabel" >死亡原因:</td>
						        <td class="FieldInput" colspan="5">
						        	<input type="text" id="qDeathCaseText" style="width:85%" readonly="readonly"/><img
									src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
									style="cursor: hand;display: none;" onclick="getDeathCase(this.id)" />&nbsp;
									<button  style="cursor: hand" onclick="getDeathCase(this.id)">选择</button>
								<td style="display: none;"><input type="text" id="qDeathCaseValue" />
						        </td>
							</tr>
							<tr>
								<td class="FieldLabel" colspan="3">下载批量导入身份证模版:&nbsp    
								&nbsp&nbsp&nbsp&nbsp&nbsp<button onclick="onLoad()">点击下载</button>
								</td>
								<td class="FieldLabel"  colspan="3">
								    <div align="left">
								    批量身份证导入：&nbsp&nbsp
									<input class="file" type="file" id="excelFile" name="excelFile"/>
									<font color="green">请在导入之前先下载批量导入身份证模版！</font>
									</div>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" colspan="6" >
								<div align="center">
									<button onclick="click_import()">查 询</button>
									&nbsp;&nbsp;
									<button type="reset">重 置</button>
								</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>
<!--逝者信息列表结束 -->
<next:GridPanel id="editDeadPanel" dataset="fisFuneralDeadInfoDS"   width="100%" stripeRows="true" height="100%" >
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar" text="逝者火化信息查询"></next:ToolBarItem>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="明细" iconCls="detail" handler="deadInfo_detail" />
		<next:ToolBarItem text="导出" iconCls="export" handler="exportExcel"/>
	</next:TopBar>
	<next:Columns>					    
	    <next:RowNumberColumn/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    <next:Column id="POPULACE_NAME" header="户口所在地" field="POPULACE_NAME" width="200" align="left" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="CREATE_ORGAN_NAME" header="殡仪馆名称" field="CREATE_ORGAN_NAME" width="130" align="center" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="NAME" header="逝者姓名" field="NAME" width="80"  align="center">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="SEX" header="性别" field="SEX" width="50" dataset="commSexDS" align="center" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="AGE" header="年龄" field="AGE" width="50"  align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="ID_CARD" header="证件号码" field="ID_CARD" width="140"  align="left">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="PREFERENTIAL_TYPE" header="享受惠民政策" field="PREFERENTIAL_TYPE" dataset="preferentialTypeDS" width="125" align="center">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="DEATH_CAUSE" header="死亡原因" field="DEATH_CAUSE" width="90" align="center" dataset="fisDeathCauseDS" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="RECEIVE_TIME" header="死亡时间" field="RECEIVE_TIME" width="80" align="center" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="START_TIME" header="火化时间" field="START_TIME" width="125" align="center" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="ASHES_GO" header="骨灰去向" field="ASHES_GO" width="150" align="center" dataset="ashesGoDS">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fisFuneralDeadInfoDS"/>
	</next:BottomBar>
</next:GridPanel>
</body>
<next:Window id="deathCase_win" height="300" width="240"
	title="死亡原因" resizable="false" closable="close"  >
	<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="确定" iconCls="yes"
				handler="confirmDeathCase()" />
			<next:ToolBarItem text="关闭" iconCls="return"
				handler="closeDeathCase()" />
			<next:ToolBarItem text="清除" iconCls="remove"
				handler="clearDeathCase()" />	
	</next:TopBar>
	<next:GridPanel id="deathCase_panel" width="100%" height="100%"
		notSelectFirstRow="true" dataset="fisDeathCauseDS" autoScroll="true">
		<next:Columns>
			<next:RowNumberColumn width="20" />
			<next:CheckBoxColumn></next:CheckBoxColumn>
			<next:Column header="死亡原因" width="180" field="text">
				<next:TextField />
			</next:Column>
			<next:Column header="死亡原因" width="80" field="value" hidden="true">
				<next:TextField />
			</next:Column>
		</next:Columns>
	</next:GridPanel>
</next:Window>

<next:Window id="deathDetailWin" height="500" width="790"
	modal="true" autoScroll="true" closable="close" >
	<next:TopBar>
			<next:ToolBarItem symbol="逝者信息"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem text="关闭" iconCls="return"
				handler="close_DeadInfo()" />
	</next:TopBar>			
	<next:Panel autoScroll="true">
		<next:Html>
			<form id="dathEditForm" onsubmit="return false"
				class="L5form" dataset="fisFuneralDeadInfoDS2">
				<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" width="15%"><label>姓名:</label></td>
					<td class="FieldInput" width="17%"><label
						maxlength="25" name="逝者姓名" field="NAME" /></td>
					<td class="FieldLabel" width="15%"><label>性别:</label></td>
					<td class="FieldInput" width="17%"><label name="逝者性别"
						style="width: 95%" field="SEX" dataset="commSexDS"/></td>
					<td class="FieldLabel" ><label>证件类型:</label></td>
					<td class="FieldInput"><label name="逝者证件类型" field="CARD_TYPE" dataset="cardTypeDS"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" ><label>证件号码:</label></td>
					<td class="FieldInput"><label name="逝者证件号码"
						maxlength="18" 
						style="width: 95%" field="ID_CARD" /></td>
					<td class="FieldLabel" >出生日期:</td>
					<td class="FieldInput"><label name="出生日期"
						  id="winBirthDay" field="BIRTHDAY" /></td>
					<td class="FieldLabel" >去世时间:</td>
					<td class="FieldInput"><label name="去世时间"
						id="winDeathDate" field="DEATH_DATE" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" >年龄:</td>
					<td class="FieldInput"><label name="年龄"
						maxlength="3" field="AGE" /></td>
					<td class="FieldLabel" >优惠类型:</td>
					<td class="FieldInput"><label name="优惠类型"
						field="PREFERENTIAL_TYPE_NAME" style="width: 95%" /></td>
					<td class="FieldLabel" >国籍:</td>
					<td class="FieldInput"><label name="国籍" field="NATION" dataset="nationDS"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >民族:</td>
					<td class="FieldInput"><label name="民族" field="FOLK"
						style="width: 95%"dataset="DmMzDataSet"/></td>
					<td class="FieldLabel" >文化程度:</td>
					<td class="FieldInput"><label name="文化程度" field="EDUCATION" dataset="DmJyzkDataSet"/></td>
					<td class="FieldLabel" >职业:</td>
					<td class="FieldInput"><label name="职业" field="PROFESSION" dataset="DmZyDataSet"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >政治面貌:</td>
					<td class="FieldInput"><label name="政治面貌" field="POLITICAL"
						style="width: 95%" dataset="DmZzmmDataSet"/></td>
					<td class="FieldLabel" >宗教信仰:</td>
					<td class="FieldInput"><label name="宗教信仰" field="RELIGION" dataset="religionDS"/></td>
					<td class="FieldLabel" >入馆时间:</td>
					<td class="FieldInput"><label  field="RECEIVE_TIME"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >火化时间:</td>
					<td class="FieldInput"><label  field="START_TIME"/></td>
					<td class="FieldLabel" >火化炉:</td>
					<td class="FieldInput"><label field="STOVE_NO"/></td>
					<td class="FieldLabel" >火化工:</td>
					<td class="FieldInput"><label  field="STOVE_PEOPLE"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >领灰时间:</td>
					<td class="FieldInput"><label  field="TAKEASHES_TIME"/></td>
					<td class="FieldLabel" >骨灰去向:</td>
					<td class="FieldInput"><label field="ASHES_GO" dataset="ashesGoDS"/></td>
					<td class="FieldLabel" >殡仪馆名称:</td>
					<td class="FieldInput"><label  field="UNIT_NAME"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" >户口所在地:</td>
					<td class="FieldInput"><label name="户口所在地"
						field="POPULACE_NAME" readonly="readonly" />
					<td style="display: none;"><label
						field="POPULACE" /></td>
					<td class="FieldLabel" >生前住址:</td>
					<td class="FieldInput" colspan="3"><label
						maxlength="50" name="生前住址" style="width: 83%" field="FAMILY_ADD" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" >是否要灰:</td>
					<td class="FieldInput"><label
						maxlength="50" name="是否要灰" style="width: 83%" field=IF_TO_DUST dataset="yesOrNoDs"/></td>
					<td class="FieldLabel" >原工作单位:</td>
					<td class="FieldInput" colspan="5"><label
						maxlength="50" name="工作单位" style="width: 83%" field="WORK_NAME" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" >去世原因:</td>
					<td class="FieldInput"><label name="去世原因" field="DEATH_CAUSE" dataset="fisDeathCauseDS"/></td>
					<td class="FieldLabel" >去世地点:</td>
					<td class="FieldInput" colspan="3"><label
						maxlength="50" style="width: 83%" name="去世地点" field="DEATH_PLACE" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" >病种:</td>
					<td class="FieldInput"><label name="病种" field="DEATH_DISEASE" dataset="diseaseDataset"/></td>
					<td class="FieldLabel" >随身遗物:</td>
					<td class="FieldInput" colspan="3"><label rows="2" readonly="readonly"
						cols="15" name="随身遗物" style="width: 83%" field="RELICS"
						lang="100"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" >遗体状态:</td>
					<td class="FieldInput"><label name="遗体状态"
						field="CORPSE_STATUS" dataset="fisCorpseStatusDS"/></td>
					<td class="FieldLabel" >遗体状态备注:</td>
					<td class="FieldInput" colspan="3"><label rows="2" readonly="readonly"
						cols="15" style="width: 83%" name="遗体状态备注"
						field="CORPSE_STATUS_NOTE" lang="100"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" >是否无名尸:</td>
					<td class="FieldInput"><label field="IF_NAMELESS"
						name="是否无名尸"  dataset="yesOrNoDs"/></td>
					<td class="FieldLabel" >出具死亡证明单位:</td>
					<td class="FieldInput" colspan="3"><label name="出具死亡证明单位"
						field="DEATH_CERT_ORG" dataset="deathCertOrganDS"></label>&nbsp;&nbsp;&nbsp;  
						<label name="出具死亡证明单位名称" field="DEATH_CERT_ORG_NAME"></label></td>

				</tr>
				<tr>
					<td class="FieldLabel" >备注:</td>
					<td class="FieldInput" colspan="5"><label
						lang="100" name="备注" style="width: 75%" field="NOTE" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
</html>