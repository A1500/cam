<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.sdmz.comm.util.BspUtil"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%
	String familyId = request.getParameter("dataBean");
	String organArea = BspUtil.getCorpOrgan().getOrganCode();
%>
<html>
<head>
<title>家庭成员详细信息</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ygjzjtxx_detail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>

<!-- 家庭信息 -->
	<model:dataset id="YgjzJtxxDataSet" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxQueryCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoFamily"></model:record>
		<model:params>
			<model:param name="familyId" value='<%=familyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭受灾类型信息 -->
	<model:dataset id="YgjzJtxxSzlxDataSet" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxSzlxCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamFamilyAssistance"></model:record>
		<model:params>
			<model:param name="familyId" value='<%=familyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 自然灾害 -->
	<model:dataset id="YgjzJtxxZrzhDataSet" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxZrzhCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamFamilyCalamity"></model:record>
		<model:params>
			<model:param name="familyId" value='<%=familyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助指数 -->
	<model:dataset id="YgjzJzzsDataSet" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJzzsCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamIndex"></model:record>
		<model:params>
			<model:param name="familyId" value='<%=familyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="YgjzJtxxCyxxDataSet" pageSize="-1" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxCyxxCommand" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoPeople"></model:record>
		<model:params>
			<model:param name="familyId" value='<%=familyId%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 人员残疾信息 -->
	<model:dataset id="YgjzCyxxCjxxDataSet" cmd="com.inspur.sdmz.jtxx.cmd.YgjzCyxxCjxxCommand" global="true">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamPeopleDisability"></model:record>
	</model:dataset>
	<!-- 人员教育信息 -->
	<model:dataset id="YgjzCyxxJyxxDataSet" cmd="com.inspur.sdmz.jtxx.cmd.YgjzCyxxJyxxCommand" global="true">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamPeopleEdu"></model:record>
	</model:dataset>
	<!-- 人员患病信息 -->
	<model:dataset id="YgjzCyxxHbxxDataSet" cmd="com.inspur.sdmz.jtxx.cmd.YgjzCyxxHbxxCommand" global="true">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamPeopleDisease"></model:record>
	</model:dataset>
	<!-- 人员事故信息 -->
	<model:dataset id="YgjzCyxxSgxxDataSet" cmd="com.inspur.sdmz.jtxx.cmd.YgjzCyxxSgxxCommand" global="true">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamPeopleAccident"></model:record>
	</model:dataset>

	<!-- 行政区划 -->
	<model:dataset id="DmXzqhDataSetStreet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmXzqhDataSetVillage" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住房状况类型 -->
	 <model:dataset id="DmZfzklxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSESTATUS'></model:param>
		</model:params>
	</model:dataset>
	<!-- 房屋结构类型 -->
    <model:dataset id="DmFwjgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_STRUCTURE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="DmJzlxDataSet" 	cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" 	autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE_EXT'></model:param>
		</model:params>
	</model:dataset>
	<!-- 灾害种类 -->
	<model:dataset id="DmZhzlDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISASTER_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 灾害损失金额 -->
	<model:dataset id="DmZhssjeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISASTER_LOSS'></model:param>
		</model:params>
	</model:dataset>

	<!-- 与户主关系 -->
		<model:dataset id="DmHzgxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾类型 -->
	<model:dataset id="DmCjlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 教育状况 -->
		<model:dataset id="DmJyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
		</model:params>
	</model:dataset>
	<!-- 患病种类-->
	<model:dataset id="DmHbzlDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISEASE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 事故种类-->
	<model:dataset id="DmSgzlDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ACCIDENT_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别代码-->
	<model:dataset id="DmXbDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族代码-->
	<model:dataset id="DmMzDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
		</model:params>
	</model:dataset>
	<!-- 户籍性质-->
	<model:dataset id="DmHjxzDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DOMICILE_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 婚姻状况-->
	<model:dataset id="DmHyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医疗状况-->
	<model:dataset id="DmYlzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MEDICAL_STATUS'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
    <model:dataset id="DmZyDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 抚恤对象类型-->
	<model:dataset id="DmFxdxlxDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>


	</model:datasets>
<next:ViewPort id="dd">
	<next:BorderLayout>
		<next:Center>
			<next:Panel>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem text="保存" iconCls="save" handler="saveClick"></next:ToolBarItem>
					<next:ToolBarItem text="返回" iconCls="undo" handler="Evt_butreturn_onclick"></next:ToolBarItem>
				</next:TopBar>
				<next:TabPanel height="550" activeTab="0">
					<next:Tabs>
						<next:Panel title="家庭基本信息">
							<next:Html>
								<form id="ygjzjtxx_detailform" method="post" dataset="YgjzJtxxDataSet" onsubmit="return false" class="L5form">
								<fieldset style="width: 100%"><legend>困难家庭详细信息</legend>
								<table style="width: 100%" border=0>
									<tr>
										<!-- <td class="FieldLabel" width="18%">家庭编号</td>
										<td class="FieldInput"><input type="text" name="familyId"
											field="familyId" disabled="disabled" /></td>
										 -->
										<td class="FieldLabel" width="15%">户主姓名:</td>
										<td class="FieldInput" width="15%"><input type="text" name="familyName" style="width: 155px" field="familyName" disabled="disabled" /></td>
										<td class="FieldLabel" width="10%">身份证号:</td>
										<td class="FieldInput" width="15%"><input type="text" name="familyCardNo" style="width: 155px" field="familyCardNo" disabled="disabled" style="" /></td>
										<td class="FieldLabel" width="10%">人口数量:</td>
										<td class="FieldInput" width="15%"><input type="text" name="peopleNum" style="width: 155px" field="peopleNum" disabled="disabled" /></td>
										<td class="FieldLabel" width="10%"></td>
										<td class="FieldInput" width="15%"></td>
										<!-- <td class="FieldLabel">地址_县（市、区）:</td>
										<td class="FieldInput"><input type="text" name="dzXian" field="dzXian" disabled="disabled" /></td> -->
									</tr>
									<tr>
										<td class="FieldLabel">地址_镇（街道、办事处）:</td>
										<td class="FieldInput"><input type="text" name="town" style="width: 155px" field="town" disabled="disabled" /></td>
										<td class="FieldLabel">地址_村（居）:</td>
										<td class="FieldInput"><input type="text" name="village" style="width: 155px" field="village" disabled="disabled" /></td>
										<td class="FieldLabel">地址_门牌号:</td>
										<td class="FieldInput"><input type="text" name="address" style="width: 155px" field="address" disabled="disabled" /></td>
										<td class="FieldLabel"></td>
										<td class="FieldInput"></td>
									</tr>

									<tr>
										<td class="FieldLabel">联系电话_宅电:</td>
										<td class="FieldInput"><input type="text" name="familyPhone" style="width: 155px" field="familyPhone" disabled="disabled" /></td>
										<td class="FieldLabel">联系电话_手机:</td>
										<td class="FieldInput"><input type="text" name="familyMobile" style="width: 155px" field="familyMobile" disabled="disabled" /></td>
										<td class="FieldLabel">联系电话_其他:</td>
										<td class="FieldInput"><input type="text" name="familyOtherPhone" style="width: 155px" field="familyOtherPhone" disabled="disabled" /></td>
										<td class="FieldLabel"></td>
										<td class="FieldInput"></td>
									</tr>

									<tr>
										<td class="FieldLabel">家庭年总收入:</td>
										<td class="FieldInput"><input type="text" name="yearIncome" style="width: 155px" field="yearIncome" disabled="disabled" /></td>
										<td class="FieldLabel">家庭年人均收入:</td>
										<td class="FieldInput"><input type="text" name="yearAverageIncome" style="width: 155px" field="yearAverageIncome" disabled="disabled" /></td>
										<td class="FieldLabel">家庭月总收入:</td>
										<td class="FieldInput"><input type="text" name="monthIncome" style="width: 155px" field="monthIncome" disabled="disabled" /></td>
										<td class="FieldLabel">家庭月人居收入:</td>
										<td class="FieldInput"><input type="text" name="monthAverageIncome" style="width: 155px" field="monthAverageIncome" disabled="disabled" /></td>
									</tr>

									<tr>
										<td class="FieldLabel">住房状况类型:</td>
										<td class="FieldInput"><input type="text" name="houseStatus" style="width: 155px" field="houseStatus" disabled="disabled" /></td>
										<td class="FieldLabel">建筑面积:</td>
										<td class="FieldInput"><input type="text" name="buildArea" style="width: 155px" field="buildArea" disabled="disabled" /></td>
										<td class="FieldLabel">人均建筑面积:</td>
										<td class="FieldInput"><input type="text" name="buildAverageArea" style="width: 155px" field="buildAverageArea" disabled="disabled" /></td>
										<td class="FieldLabel">房屋结构:</td>
										<td class="FieldInput"><input type="text" name="buildingStructure" style="width: 155px" field="buildingStructure" disabled="disabled" /></td>
										<!-- <td class="FieldLabel">删除标志:</td>
										<td class="FieldInput"><input type="text" name="scbz" field="scbz" disabled="disabled" /></td>
										 -->
									</tr>
								</table>
								</fieldset>
								<fieldset style="width: 100%"><legend>审核信息</legend>
								<table style="width: 100%" frame="void">
									<tr>
										<td class="FieldLabel" width="15%">审核意见：</td>
										<td><textarea name="advise" cols="150" rows="10" field="checkNote"></textarea></td>
									</tr>
									<tr>
									<td class="FieldLabel">审核状态</td>
									<td><select field="checkFlag"><option dataset="YgjzJtxxDataSet"></option></select></td>
									</tr>
								</table>
								</fieldset>
								</form>
							</next:Html>
						</next:Panel>
						<next:GridPanel id="YgjzJtxxCyxxGridPanel" name="YgjzJtxxCyxxGridPanel" width="100%" stripeRows="true" height="300" dataset="YgjzJtxxCyxxDataSet" title="家庭成员信息">
							<next:Columns>
								<next:RowNumberColumn width="30" />
								<next:Column id="name" header="姓名" field="name" width="80" align="center"><next:TextField /></next:Column>
								<next:Column id="idCard" header="身份证号" field="idCard" width="135"  align="center"><next:TextField /></next:Column>
								<next:Column id="relationshipType" header="与户主关系" field="relationshipType" width="80" align="center"><next:TextField /></next:Column>
								<next:Column id="birthday" header="出生日期" field="birthday" width="80" align="center"><next:TextField /></next:Column>
								<next:Column id="regName" header="录入人" field="regName" width="80" align="center"><next:TextField /></next:Column>
								<next:Column id="regTime" header="录入时间" field="regTime" width="80" align="center"><next:TextField /></next:Column>
							</next:Columns>
							<next:BottomBar><next:PagingToolBar dataset="YgjzJtxxCyxxDataSet" /></next:BottomBar>
						</next:GridPanel>
						<next:GridPanel id="YgjzJzzsGridPanel" name="YgjzJzzsGridPanel" width="100%" stripeRows="true" height="300" dataset="YgjzJzzsDataSet" title="救助指数">
							<next:Columns>
								<next:RowNumberColumn width="30" />
								<next:Column id="compositeIndex" header="综合救助指数" field="compositeIndex" width="80" align="center"><next:NumberField allowBlank="false" /></next:Column>
								<next:Column id="medicalIndex" header="医疗救助指数" field="medicalIndex" width="80" align="center"><next:NumberField allowBlank="false" /></next:Column>
								<next:Column id="housingIndex" header="住房救助指数" field="housingIndex" width="80" align="center"><next:NumberField allowBlank="false" /></next:Column>
								<next:Column id="accidentIndex" header="事故救助指数" field="accidentIndex" width="80" align="center"><next:NumberField allowBlank="false" /></next:Column>
								<next:Column id="eduIndex" header="教育救助指数" field="eduIndex" width="80" align="center"><next:NumberField allowBlank="false" /></next:Column>
								<next:Column id="supportIndex" header="养老（老年人）救助指数" field="supportIndex" width="140" align="center"><next:NumberField allowBlank="false" /></next:Column>
								<next:Column id="calamityIndex" header="自然灾害救助指数" field="calamityIndex" width="110" align="center"><next:NumberField allowBlank="false" /></next:Column>
								<next:Column id="unemployedIndex" header="失业救助指数" field="unemployedIndex"  width="80" align="center"><next:NumberField allowBlank="false" /></next:Column>
								<next:Column id="singleIndex" header="单亲救助指数" field="singleIndex" width="80" align="center"><next:NumberField allowBlank="false" /></next:Column>
							</next:Columns>
							<next:BottomBar><next:PagingToolBar dataset="YgjzJzzsDataSet" /></next:BottomBar>
						</next:GridPanel>
						<next:GridPanel id="YgjzJtxxZrzhEditGridPanel" name="YgjzJtxxZrzhGridPanel" width="100%" stripeRows="true" height="300" dataset="YgjzJtxxZrzhDataSet" title="自然灾害">
							<next:Columns>
								<next:RowNumberColumn width="30" />
								<next:Column id="calamityDate" header="受灾时间" field="calamityDate" width="80" align="center"><next:TextField allowBlank="false" /></next:Column>
								<next:Column id="calamityType" header="灾害种类" field="calamityType" width="80" align="center"><next:TextField /></next:Column>
								<next:Column id="lossMon" header="灾害损失" field="lossMon" width="80" align="center"><next:NumberField /></next:Column>
							</next:Columns>
							<next:BottomBar><next:PagingToolBar dataset="YgjzJtxxZrzhDataSet" /></next:BottomBar>
						</next:GridPanel>
						<next:GridPanel id="YgjzJtxxSzlxGridPanel" name="YgjzJtxxSzlxGridPanel" width="100%" stripeRows="true" height="300" dataset="YgjzJtxxSzlxDataSet" title="受助类型">
							<next:Columns>
								<next:RowNumberColumn width="30" />
								<next:Column id="assistanceType" header="受助类型" field="assistanceType" width="150" align="center"><next:TextField allowBlank="false" /></next:Column>
							</next:Columns>
							<next:BottomBar><next:PagingToolBar dataset="YgjzJtxxSzlxDataSet" /></next:BottomBar>
						</next:GridPanel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
<next:Window id="cyxxEdit" title="家庭成员信息" resizable="false" width="950" height="500" autoScroll="true" closeAction="hide">
	<next:Panel name="anchor-div" >
	<next:AnchorLayout>
	<next:Panel height="250">
	<next:Html>
		<form dataset="YgjzJtxxCyxxDataSet" id="test1">
		<table id="gao" cellspacing="10" cellpadding="10"  width="917">
			<tr>
				<td><label>基本信息</label></td>
				<td><label>姓名</label></td>
				<td><input type="text" field="name" disabled="disabled" align="left" /></td>
				<td><label>性别</label></td>
				<td><input type="text" field="sex" align="left" disabled="disabled" /></td>
				<td><label>民族</label></td>
				<td><input type="text" field="nation" disabled="disabled" /></td>
				<td><label>出生日期</label></td>
				<td><input type="text" field="birthday" disabled="disabled" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><label>身份证号</label></td>
				<td><input type="text" field="idCard" align="left" disabled="disabled" /></td>
				<td><label>户主关系</label></td>
				<td><input type="text" field="relationshipType" disabled="disabled" /></td>
				<td><label>户籍性质</label></td>
				<td align=left><input type="text" field="domicileType" disabled="disabled" /></td>
				<td><label>婚姻状况</label></td>
				<td align=left><input type="text" field="marriageCode" disabled="disabled" /></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><label>手机</label></td>
				<td><input type="text" field="telMobile" disabled="disabled" /></td>
				<td><label>其他方式</label></td>
				<td align=left><input type="text" field="telOther" disabled="disabled" /></td>
				<td><label>医疗状况</label></td>
				<td><input type="text" field="safeguardType" disabled="disabled" /></td>
				<td colspan=2></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><label>年收入</label></td>
				<td align=left><input type="text" field="incomeYear" disabled="disabled" /></td>
				<td><label>月收入</label></td>
				<td><input type="text" field="incomeMonth" disabled="disabled" /></td>
				<td colspan=4></td>
			</tr>
			<tr>
				<td><label>工作信息</label></td>
				<td><label>职业状况</label></td>
				<td align=left><input type="text" field="employmentCode" disabled="disabled" /></td>
				<td><label>单位名称</label></td>
				<td><input type="text" field="employmentCode" disabled="disabled" /></td>
				<td><label>单位电话</label></td>
				<td align=left><input type="text" field="workUnitTel" disabled="disabled" /></td>
				<td colspan=2></td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			<td><label>单位地址</label></td>
			<td colspan=7><input type="text" style="width:55%;" field="workUnitAdd" disabled="disabled" /></td>
			</tr>
			<tr>
				<td><label>优抚信息</label></td>
				<td><label>优抚类型</label></td>
				<td align=left><input type="text" field="bptType" disabled="disabled" /></td>
				<td><label>抚恤定补金</label></td>
				<td><input type="text" field="bptNum" disabled="disabled" /></td>
				<td colspan=4></td>
			</tr>
			</table>
			</form>
			</next:Html>
			</next:Panel>
<next:GridPanel id="cyxx" name="OnlineGrid" width="920" height="158" dataset="YgjzCyxxCjxxDataSet" collapsible="true">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:Column id="disabilityType" header='残疾类型' field="disabilityType" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="disabilityLevel" header='残疾等级' field="disabilityLevel" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="YgjzCyxxCjxxDataSet"/>
	</next:BottomBar>
 </next:GridPanel>
<next:GridPanel id="sgxx" name="OnlineGrid" width="920" height="158" dataset="YgjzCyxxSgxxDataSet" collapsible="true">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:Column id="accidentDate" header='事故时间' field="accidentDate" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="accidentType" header='事故种类' field="accidentType" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="YgjzCyxxSgxxDataSet"/>
	</next:BottomBar>
 </next:GridPanel>
<next:GridPanel id="hbxx" name="OnlineGrid" width="920" height="158" dataset="YgjzCyxxHbxxDataSet" collapsible="true">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:Column id="diseaseDate" header='患病时间' field="diseaseDate" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="diseaseType" header='患病种类' field="diseaseType" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="costMon" header='医疗支出_金额' field="costMon" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="YgjzCyxxHbxxDataSet"/>
	</next:BottomBar>
 </next:GridPanel>
<next:GridPanel id="jyxx" name="OnlineGrid" width="920" height="158" dataset="YgjzCyxxJyxxDataSet" collapsible="true">
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:Column id="regDate" header='登记时间' field="regDate" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="education" header='教育状况' field="education" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="grade" header='教育状况年级' field="grade" width="150" sortable="false">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="YgjzCyxxJyxxDataSet"/>
	</next:BottomBar>
 </next:GridPanel>
		</next:AnchorLayout>
	</next:Panel>
</next:Window>
</body>
</html>
