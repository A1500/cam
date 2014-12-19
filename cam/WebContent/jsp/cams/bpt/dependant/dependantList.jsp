
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>三属人员信息列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="dependantList.js"></script>
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
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDependantQueryCommand" method="queryDependantPeople" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 

	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
		<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
		<!-- 文化程度 -->
	<model:dataset id="EducationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
		<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
		<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DOMICILE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
		<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 职业 -->
	<model:dataset id="CareerDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CAREER'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox"><legend
					class="GroupBoxTitle">查询条件 <img
					class="GroupBoxExpandButton"
					src="<%=SkinUtils.getImage(request,
									"groupbox_collapse.gif")%>"
					onclick="collapse(this)" /> </legend>
				<div>
					<form style="width: 95%; height: 100%;" class="L5form">
						<table  border="1" width="100%" >
							<tr >
								<td class="FieldLabel">属地行政区划：</td>
								<td class="FieldInput"><input type="text"  id="domicileCode" class="TextEditor" title="属地行政区划"  /></td>	
								<td class="FieldLabel">姓名：</td>
								<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="姓名"  /></td>	
								<td class="FieldLabel">身份证件号码：</td>
								<td class="FieldInput"><input type="text"  id="idCard" class="TextEditor" title="身份证件号码"  /></td>
							</tr>
							<tr>	
								<td class="FieldLabel">民族：</td>
								<td class="FieldInput">
										<select  id="nation" > 
											<option dataset="NationDataset"></option>
										</select>
								</td>	
								<td class="FieldLabel">婚姻状况：</td>
								<td class="FieldInput">
									<select id="marriageCode"> 
											<option dataset="MarriageDataset"></option>
									</select>
								</td>	
								<td class="FieldLabel">职业：</td>
								<td class="FieldInput"><input type="text"  id="careerCode" class="TextEditor" title="职业"  /></td>	
								<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput">
									<select id="politicalCode"> 
											<option dataset="PoliticalDataset" ></option>
									</select>
								</td>	
								<td class="FieldLabel">户籍类别：</td>
								<td class="FieldInput">
									<select id="domicileType"> 
											<option dataset="DomicileDataset" ></option>
									</select>
								</td>	
								<td class="FieldLabel">个人状态：</td>
								<td class="FieldInput"><input type="text"  id="personalStatsTag" class="TextEditor" title="个人状态"  /></td>
								<td class="FieldLabel"><button onclick="reset()">重 置</button> </td>	
							</tr>
						</table>
					</form>
				</div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="100%" dataset="BaseinfoPeopleDataSet" title="遗属人员信息">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem text="修改" iconCls="edit" handler="update"/>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:CheckBoxColumn></next:CheckBoxColumn>

		<next:Column id="name" header="姓名" field="name" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idCard" header="身份证件号码" field="idCard" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="sex" header="性别" field="sex" width="35"  dataset="SexDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="birthday" header="出生日期" field="birthday" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
				
		<next:Column id="domicileCode" header="属地行政区划" field="domicileCode" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="nation" header="民族" field="nation" width="70" dataset="NationDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
		    
		<next:Column id="relationshipType" header="与户主关系" field="relationshipType" width="90" dataset="RelationshipTypeDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="eduCode" header="文化程度" field="eduCode" width="120"  dataset="EducationDataset">
			<next:TextField  />
		</next:Column>
	

		<next:Column id="marriageCode" header="婚姻状况" field="marriageCode" width="90" hidden="true" dataset="MarriageDataset" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="careerCode" header="职业" field="careerCode" width="120" dataset="CareerDataset">
			<next:TextField  />
		</next:Column>

	
		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="90" dataset="DomicileDataset" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="telMobile" header="手机" field="telMobile" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BaseinfoPeopleDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
