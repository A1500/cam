<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>特殊困难户列表</title>
<next:ScriptManager />
<script type="text/javascript" src="specialpoorFamilyInsert.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	   <%
	    String organArea = BspUtil.getCorpOrgan().getOrganCode();
	    String parentOrganCode = BspUtil.getParentOrgan().getOrganCode();
	    if(organArea.endsWith("0000000000")){
	    	parentOrganCode = organArea;
	    }
	    if(parentOrganCode.endsWith("0000000000")){//省370000000000
	    	parentOrganCode = parentOrganCode.substring(0,2);
 		} else if (parentOrganCode.endsWith("00000000")){//市370100000000
 			parentOrganCode = parentOrganCode.substring(0,4);
 		} else if (parentOrganCode.endsWith("000000")){//县370104000000
 			parentOrganCode = parentOrganCode.substring(0,6);
 		} else if (parentOrganCode.endsWith("000")){//乡370104003000
 			parentOrganCode = parentOrganCode.substring(0,9);
 		}
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
	var parentOrganCode='<%=parentOrganCode%>';
	var method='<%=request.getParameter("method")%>';
	var familyId='<%=request.getParameter("familyId")%>';
</script>
</head>
<body>
<model:datasets>
	<!-- 家庭信息 -->
	<model:dataset id="speFamilyDataset" cmd="com.inspur.cams.drel.special.cmd.SpecialpoorFamilyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.special.data.SpecialpoorFamily">
			<model:field name="familyName" type="string" rule="require|length{10}" />
			<model:field name="familyCardNo" type="string" rule="require|length{18}" />
			<model:field name="domicileName" type="string" rule="require" />
			<model:field name="note" type="string" rule="length{200}" />
			<model:field name="assistanceFlag" type="string" rule="require" />
		</model:record>
	</model:dataset>
	
	<!-- 临时表 -->
	<model:dataset id="tempFamilyDataset" cmd="com.inspur.cams.drel.special.cmd.SpecialpoorFamilyTempQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.special.data.SpecialpoorFamilyTemp">
		</model:record>
	</model:dataset>
	<!-- 人员表 -->
	<model:dataset id="peopleListDataSet" cmd="com.inspur.cams.drel.special.cmd.SpecialpoorPeopleQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.special.data.SpecialpoorPeople"> 
			<model:field name="name" type="string" rule="require|length{30}"/>
			<model:field name="idCard" type="string" rule="require|length{18}"/>
			<model:field name="incomeMonth" type="string" rule="regex{^[0-9]{1,16}}" />
			<model:field name="relationshipType" type="string" rule="require"/>
			<model:field name="domicileType" type="string" rule="require" />
			</model:record>
	</model:dataset>
	
	
	<!-- 与户主关系 -->
	<model:dataset id="relationshipTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="assitanceDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_assitance_type'></model:param>
			<model:param name="includeCode" value='01,02,03'></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmMzDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
		</model:params>
	</model:dataset>
	<!-- 婚姻状况-->
	<model:dataset id="DmHyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 就业状况-->
   <model:dataset id="DmZyDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>			
			<model:param name="includeCode" value="10,61,62,40,21,22,99"></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
		</model:params>
	</model:dataset>
	<!-- 劳动能力 -->
	<model:dataset id="laborCapacityDataset" enumName="SAM_LABOR_CAPACITY" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 重病病种 -->
	<model:dataset id="diseaseTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_sam_disease_type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾类别 -->
	<model:dataset id="disabilityTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾等级 -->
	<model:dataset id="DmCjdjDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="CODE">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HANDICAP_LEVEL'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmHjxzDataSet" enumName="SAM_DOMICILE_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度-->
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
		</model:params>
	</model:dataset>
	<!-- 学业状况 -->
	<model:dataset id="eduStatusDataset" enumName="SAM_EDU_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 与户主关系 -->
	 <model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="assistanceTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	
	<!-- 帮包村字典 -->
	<model:dataset id="helpVillage"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SPECIALPOOR_HELP_VILLAGE'></model:param>
			<model:param name="value" value='HELP_VILLAGE_CODE'></model:param>
			<model:param name="text" value='HELP_VILLAGE_NAME'></model:param>
		</model:params>
	</model:dataset>
		
	<model:dataset id="baseinfoPeopleDS"
		cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd"
		method="querySamPeopleList" pageSize="15" global="true">
	</model:dataset>
	
</model:datasets>
<next:Panel height="100%" width="100%"  id="tab">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="saveId" disabled="" iconCls="save" text="保存"
			handler="save" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnBack" />
	</next:TopBar>
	<next:Panel title="家庭信息" titleCollapse="true" collapsible="true"
		autoHeight="true" autoScroll="true">
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form"
				dataset="speFamilyDataset">
			<table width="100%" >
				<tr>
					<td class="FieldLabel" style="width: 15%">户主姓名</td>
					<td class="FieldInput" style="width: 25%"><input type="text" name="户主姓名"
						title="户主姓名" field="familyName" ></input> <font color="red">*</font> 
						&nbsp&nbsp&nbsp<button style="width:100" id="queryId" onclick="showTemp();">历史数据检索</button></td>
					<td class="FieldLabel" style="width: 15%">身份证号码</td>
					<td class="FieldInput" style="width: 25%"><input type="text" name="身份证号码"
						title="身份证号码" field="familyCardNo" maxlength="18" style="width: 80%" onchange="checkCradNo(this);"/></input><font color="red">*</font> </td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">地区</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						style="width: 80%" name="地区" title="地区" field="domicileName"
						readonly id="lrdwmc" /> <input type="text" style="display: none;"
						name="lrdwId" id="lrdwIdquery" field="domicileCode" /> <img
						src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
						style="cursor: hand" onclick="func_ForDomicileSelect()" /><font color="red">*</font> </td>
					<td class="FieldLabel" style="width: 15%">家庭地址</td>
					<td class="FieldInput" style="width: 18%" ><input
						type="text" maxlength="100" style="width: 80%"  name="家庭地址" title="家庭地址"
						field="address" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">省直单位联系困难家庭</td>
					<td class="FieldInput" style="width: 18%" >
						<select   field="ifSupport" onchange="queryVillage(this.value)"><option  dataset="comm_yesorno"></option></select>
					</td>
					<td class="FieldLabel" style="width: 15%">帮包村名称</td>
					<td class="FieldInput" style="width: 18%" >
						<select id="helpVillageCodeID" disabled="" field="helpVillageCode" onchange="querySupport(this.value);"><option  dataset="helpVillage"></option></select>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">省直单位名称</td>
					<td class="FieldInput" style="width: 18%">
						<label  field="supportName" ></label>
					</td>
					<td class="FieldLabel" style="width: 15%">家庭人口数</td>
					<td class="FieldInput" style="width: 18%"><input type="text" name="家庭人口数"
						title="家庭人口数" field="peopleNum"  ></input></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">是否低保或五保</td>
					<td class="FieldInput" style="width: 18%">
						<select field="assistanceFlag" onchange="changeassistanceType(this.value)"><option  dataset="comm_yesorno"></option></select><font color="red">*</font>
					</td>
					<td class="FieldLabel" style="width: 15%">救助类型</td>
					<td class="FieldInput" style="width: 18%">
						<select field="assistanceType" id="assistanceTypeID" disabled="disabled"><option  dataset="assitanceDataset"></option></select>
					</td>
				</tr>
				
				<tr>
					<td class="FieldLabel" style="width: 15%">邮政编码</td>
					<td class="FieldInput" style="width: 18%"><input type="text" maxlength="6"
						name="联系电话" title="邮政编码" field="familyPostcode"  /></td>	
					<td class="FieldLabel" style="width: 15%">联系电话</td>
					<td class="FieldInput" style="width: 18%"><input type="text"
						maxlength="20" name="联系电话" title="联系电话" field="familyPhone"
						  /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width: 15%">致贫原因</td>
					<td class="FieldInput" style="width: 18%" colspan="3">
			    		 <input type="checkbox" name="changeItem"   id="changeItemA" value="A">因病致贫 </input> &nbsp;&nbsp;
                         <input type="checkbox" name="changeItem"  id="changeItemB" value="B">因残致贫 </input>&nbsp;&nbsp;
                         <input type="checkbox" name="changeItem" id="changeItemC" value="C">贫困老人 </input>&nbsp;&nbsp;
                         <input type="checkbox" name="changeItem"  id="changeItemD" value="D">贫困儿童 </input>&nbsp;&nbsp;
                          <input type="checkbox" name="changeItem"   id="changeItemE" value="E">住房困难 </input>&nbsp;&nbsp;
                         <input type="checkbox" name="changeItem"   id="changeItemF" value="F">其他原因 </input>&nbsp;&nbsp;
					</td>
				</tr>
				
				<tr>
					<td class="FieldLabel" style="width: 15%">备注</td>
					<td class="FieldInput" style="width: 18%" colspan="3">
						<textarea  rows="2"
						field = "note" style="width: 90%"   /></textarea></td>
					</td>
				</tr>
				
			</table>
			</form>
		</next:Html>
	</next:Panel>

	<next:EditGridPanel id="peoplePanel" titleCollapse="true" height="100%"  width="100%"
		collapsible="true" stripeRows="true"   dataset="peopleListDataSet" title="家庭成员信息">
		<next:TopBar>		
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" id="addPeople" text="新增" handler="insertPeople"/>
			<next:ToolBarItem iconCls="detail" id="detailPeople" text="修改" handler="updatePeople"/>
			<next:ToolBarItem iconCls="remove" id="removePeople" text="删除" handler="deletePeople"/>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="name" field="name" header="姓名" width="100">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column   field="sex" header="性别" width="100">
				<next:ComboBox editable="false" dataset="sexDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column  field="idCard" header="身份证号码" width="150">
				<next:TextField editable="false" />
			</next:Column>
			<next:Column field="relationshipType" header="与户主关系" width="115">
				<next:ComboBox editable="false" dataset="relationshipTypeDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
			<next:Column field="assistanceType" header="救助类别" width="100">
				<next:ComboBox editable="false" dataset="assitanceDataset"
					displayField="text" valueField="value" typeAhead="true" />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
				<next:PagingToolBar dataset="peopleListDataSet" />
			</next:BottomBar>
	</next:EditGridPanel>
</next:Panel>
<next:Window title="历史数据检索" id="tempWin" height="400" width="800"	closeAction="hide" modal="true">
	<next:Panel  width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
			<next:Html>			
					<form class="L5form">
						<table  border="1" width="100%">
							<tr>
							 	<td class="FieldLabel" style="width:20%">家庭住址</td>
				                <td class="FieldInput" style="width:20%">
				                 <input type="text" id="domicileCodeTemp"  style='width:80%'/>
				               </td>
				                <td class="FieldButton" style="width:20%"><button style="width:100" id="queryId" onclick="queryTemp();">查询</button></td>
							</tr>
							<tr>
							 	<td class="FieldLabel" style="width:20%">户主姓名</td>
				                <td class="FieldInput" style="width:20%"><input type="text"  id="familyNameTemp" style='width:80%'/></td>
				                 <td class="FieldButton" style="width:20%"><button type="reset" style="width:100">重置</button></td>
							</tr>
						</table>
					</form>
			</next:Html>
		</next:Panel>
		 <next:GridPanel  clickToSelectedForChkSM="true"id="queryGridPanel" title="历史数据列表" dataset="tempFamilyDataset" width="99%" height="300" stripeRows="true" notSelectFirstRow="true">
			<next:TopBar>		
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add"  text="确定" handler="chooseTemp"/>
			</next:TopBar>
			<next:Columns>
   				<next:RowNumberColumn/>
   				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column  header="地区" field="domicileName"  width="150"  ></next:Column>							
		        <next:Column header="户主姓名" field="familyName" width="150" ></next:Column>
				<next:Column header="人口数量" field="peopleNum" width="150" ></next:Column>
				<next:Column  header="家庭住址" field="address"  width="200"  ></next:Column>	
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="tempFamilyDataset" />
			</next:BottomBar>
		</next:GridPanel>
</next:Window>	

<next:Window title="社会救助数据检索" id="tempPeopleWin" height="400" width="800"	closeAction="hide" modal="true">
	<next:Panel  width="100%" autoHeight="true" titleCollapse="true" collapsible="true"  >	
			<next:Html>			
					<form class="L5form">
						<table  border="1" width="100%">
							<tr>
							 	<td class="FieldLabel" style="width:20%">身份证号码</td>
				                <td class="FieldInput" style="width:20%">
				                 <input type="text" id="peopleCardTemp"  style='width:80%'/>
				               </td>
				                <td class="FieldButton" style="width:20%"><button style="width:100" id="queryPeopleId" onclick="queryPeopleTemp();">查询</button></td>
							</tr>
							<tr>
							 	<td class="FieldLabel" style="width:20%">姓名</td>
				                <td class="FieldInput" style="width:20%"><input type="text"  id="namePeopleTemp" style='width:80%'/></td>
				                 <td class="FieldButton" style="width:20%"><button type="reset" style="width:100">重置</button></td>
							</tr>
						</table>
					</form>
			</next:Html>
		</next:Panel>
		 <next:GridPanel id="queryGridPeoplePanel"  clickToSelectedForChkSM="true" title="社会救助数据列表" dataset="baseinfoPeopleDS" width="90%" height="300" stripeRows="true" notSelectFirstRow="true">
			<next:TopBar>		
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add"  text="确定" handler="choosePeopleTemp"/>
			</next:TopBar>
			<next:Columns>
   				<next:RowNumberColumn/>
   				<next:CheckBoxColumn></next:CheckBoxColumn>
				<next:Column  header="地区" field="DOMICILE_FULL_NAME"  width="150"  ></next:Column>							
		        <next:Column header="姓名" field="NAME" width="150" ></next:Column>
		          <next:Column header="身份证号" field="ID_CARD" width="150" ></next:Column>
				<next:Column  header="家庭住址" field="ADDRESS"  width="200"  ></next:Column>	
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="baseinfoPeopleDS" />
			</next:BottomBar>
		</next:GridPanel>
</next:Window>	

<next:Window title="家庭成员信息" id="peopleWin" height="300" width="800"	closeAction="hide" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem   iconCls="save" text="保存"
			handler="savePeople" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnPeople" />
	</next:TopBar>
	<next:Html>
		<form id="BaseinfoPeopleForm" method="post" dataset="peopleListDataSet" onsubmit="return false"
			 class="L5form">
		<table border="0" width="100%">
		<tr>
			<td class="FieldLabel" width="10%">姓名</td>
			<td class="FieldInput" width="15%" colspan="3">
			<input type="text" name="姓名"title="姓名" field="name"  maxlength="25"/>
			<font color="red">*</font> &nbsp&nbsp&nbsp
			<button style="width:120" id="queryPeopleId" onclick="showPeopleTemp();">社会救助数据检索</button>
			</td>
			<td class="FieldLabel" width="10%">身份证号码</td>
			<td class="FieldInput" width="15%"><input type="text" id='idCard_people' name="身份证号码"title="身份证号码" field="idCard" style="width:90%" onchange='checkIdCard_people()' maxlength="18"/><font color="red">*</font>
			</tr>
			<tr>
				<td class="FieldLabel" width="10%">性别</td>
				<td class="FieldInput" width="15%"><select name="性别" title="性别" id='sex' field="sex" style="width:90%"> <option dataset="sexDataset"> </select> </td>
				<td class="FieldLabel" width="10%">出生日期</td>
				<td class="FieldInput" width="15%"><input type="text"
							name="出生日期" title="出生日期" field="birthday" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" onblur="getAge(this.value);"/> </td>
				<td class="FieldLabel" width="10%">年龄</td>
				<td class="FieldInput" width="15%"><label id="age"></label></td>
			</tr>
			<tr>
				<td class="FieldLabel">民族</td>
				<td class="FieldInput"><select name="民族" title="民族" field="nation" style="width:90%"><option dataset="DmMzDataSet"></option> </select> </td>
				
				<td class="FieldLabel">婚姻状况</td>
				<td class="FieldInput"><select name="婚姻状况" title="婚姻状况" field="marriageCode" style="width:90%"> <option dataset="DmHyzkDataSet"></option> </select> </td>
				<td class="FieldLabel">就业状况</td>
				<td class="FieldInput"><select name="就业状况" title="就业状况" field="employmentCode" style="width:90%"> <option dataset="DmZyDataSet"></option> </select></td>
				
			</tr>
			<tr>
			<td class="FieldLabel">政治面貌</td>
				<td class="FieldInput"><select name="政治面貌" title="政治面貌" field="politicalCode" style="width:90%"> <option dataset="DmZzmmDataSet"> </option></select></td>
				<td class="FieldLabel">残疾类别</td>
				<td class="FieldInput"><select name="残疾类别" title="残疾类别" field="disabilityCaseCode" style="width:90%"  > <option dataset="disabilityTypeDataset"></option> </select></td>
				<td class="FieldLabel">残疾等级</td>
				<td class="FieldInput"><select name="残疾等级" title="残疾等级" field="disabilityLevelCode" style="width:90%"> <option dataset="DmCjdjDataSet"></option> </select></td>
			</tr>
			<tr>
				<td class="FieldLabel">救助类型</td>
				<td class="FieldInput"><select name="救助类型" title="救助类型" field="assistanceType" style="width:90%"> <option dataset="assitanceDataset"></option> </select> </td>
				<td class="FieldLabel">文化程度</td>
				<td class="FieldInput" ><select name="文化程度" title="文化程度" field="eduCode" style="width:90%"> <option dataset="eduDataSet"> </option></select> </td>
				<td class="FieldLabel">健康状况</td>
				<td class="FieldInput"><select name="健康状况" title="健康状况" field='healthCode' field="healthCode" style="width:90%" > <option dataset="healthCodeDataset"></option> </select> </td>
			</tr>
			<tr>
				<td class="FieldLabel">户籍类别</td>
                <td class="FieldInput" ><select name="户籍类别" title="户籍类别" id="domicileType" field="domicileType" style="width:90%" > <option dataset="DmHjxzDataSet"> </option></select> <font color="red">*</font></td>
				<td class="FieldLabel">月收入（元）</td>
				<td class="FieldInput"><input name="月收入（元）" id='incomeMonthD' type="text" field='incomeMonth' style="width:90%" maxlength="14" /> </td>
				<td class="FieldLabel">与户主关系</td>
				<td class="FieldInput"><select id="relationshipType" style="width:90%" name="与户主关系"  title="与户主关系" field="relationshipType" style="width:90%"  > <option dataset="relationshipTypeDataset"></option> </select><font color="red">*</font></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>	



<jsp:include page="povertyCauseType.jsp" flush="true">   
	<jsp:param name= "ifPeople" value= "1"/>  
</jsp:include>	
</body>
</html>
