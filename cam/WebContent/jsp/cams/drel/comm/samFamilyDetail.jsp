<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>低保家庭页面</title>
<next:ScriptManager />
<script type="text/javascript">
	var familyId='<%=request.getParameter("familyId")%>';
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
</script>
<script type="text/javascript" src="samFamilyDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<model:datasets>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet"cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd"  method="getSamFamily"global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="peopleListDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="AssistanceDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyAssistanceCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyAssistance"></model:record>
	</model:dataset>
	<!-- 残疾类别 -->
	<model:dataset id="disabilityTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与户主关系 -->
	 <model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
   <model:dataset id="employmentCodeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭房产信息 -->
	<model:dataset id="houseListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyHouseQueryCmd" global="true"   >
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamFamilyHouse"></model:record>
	</model:dataset>
	<!-- 家庭财产信息 -->
	<model:dataset id="estateListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyEstateQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyEstate">
		</model:record>
	</model:dataset>
	<!-- 赡（抚、扶）养人信息 -->
	<model:dataset id="supportListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilySupportQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilySupport"></model:record>
	</model:dataset>
	<!-- 职业状况-->
   <model:dataset id="employmentCodeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住房类型 -->
	 <model:dataset id="houseQualityDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_QUALITY'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别代码-->
	<model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与被赡（抚、扶）养人关系 -->
	<model:dataset id="supportedRelationDataset" enumName="SAM_SUPPORTED_RELATION" autoLoad="true" global="true"></model:dataset>
	<!-- 救助方式 -->
	<model:dataset id="assistanceModeDataset" enumName="SAM_ASSISTANCE_MODE" autoLoad="true" global="true"></model:dataset>
	<!-- 财产类型 -->
	<model:dataset id="estateTypeDataset" enumName="SAM_ESTATE_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 主要致贫原因 -->
	<model:dataset id="povertyCauseDataset" enumName="SAM_CITY_PROVERTY_CAUSE" autoLoad="true" global="true"></model:dataset>
	<!-- 属别 -->
	<model:dataset id="belongingDataSet" enumName="SAM_BELONGING" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力 -->
	<model:dataset id="laborCapacityDataset" enumName="SAM_LABOR_CAPACITY" autoLoad="true" global="true"></model:dataset>
	<!-- 分类施保类别 -->
	<model:dataset id="assistance" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SAM_ASSISTANCE_ITEM'></model:param>
			<model:param name="value" value='ITEM_CODE'></model:param>
			<model:param name="text" value='ITEM_NAME'></model:param>
			<model:param name="itemType" value='01'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
   <next:Panel width="100%" height="100%" autoScroll="true" id="tab">
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="return" text="关闭" handler="returnBack"/>
		</next:TopBar>
	<next:Panel title="家庭基本信息" titleCollapse="true" collapsible="true"  autoHeight="true" autoScroll="true">
			<next:Html>
				<form  method="post" onsubmit="return false" class="L5form" dataset="familyDataSet">
				<table width="100%">
					<input type="hidden" name="familyId" field="familyId" value="1"/>
					<tr>						
						<td class="FieldLabel" style="width: 15%">户主姓名</td>
						<td class="FieldInput" style="width: 18%"><label
							name="户主姓名" title="户主姓名" field="familyName"  style="width:80%" ></label>		</td>				
						<td class="FieldLabel" style="width: 15%">身份证号</td>
						<td class="FieldInput" style="width: 18%"><label
							name="身份证号" title="身份证号" field="familyCardNo" style="width:80%" /></label></td>
						
						<td class="FieldLabel" style="width: 15%" rowspan="4">照片</td>
						<td class="FieldInput" style="width: 18%" rowspan="4">
							<div id="photoDiv">
								<img id="img" name="FAMILY_IMG"  width=140 height=90  src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
									align="top" 
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
								<input type="hidden" id="familyPhotoId" name="familyPhotoId"/>
							</div>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" >主要致贫原因</td>
						<td class="FieldInput" style="width: 18%">
						<label field="povertyCause" dataset="povertyCauseDataset"></label>
						</td>
						<td class="FieldLabel" style="width: 15%">保障人口数</td>
						<td class="FieldInput" style="width: 18%"><label
							name="保障人口数" title="保障人口数" field="assistancePeopleNum" style="width:80%" ></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">家庭月均收入（元）</td>
						<td class="FieldInput" style="width: 18%"><label
							name="家庭月均收入" title="家庭月均收入" field="monthAverageIncome" style="width:80%" ></label></td>
						<td class="FieldLabel" style="width: 15%">家庭月总收入（元）</td>
						<td class="FieldInput" style="width: 18%"><label
							name="家庭月总收入" title="家庭月总收入" field="monthIncome" style="width:80%" ></label></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">地区</td>
						<td class="FieldInput" style="width: 18%">
						 <label style="width:60%"name="地区" title="地区"  field="domicileName" readonly id="lrdwmc" ></label>
						<input style="display: none;"  name="lrdwId" id="lrdwIdquery" field="domicileCode" />
						</td>
						<td class="FieldLabel" style="width: 15%">联系电话</td>
						<td class="FieldInput" style="width: 18%"><label
							name="联系电话" title="联系电话" field="familyMobile" style="width:80%" ></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">居住地址</td>
						<td class="FieldInput" style="width: 18%" colspan="3"><label
							name="居住地址" title="居住地址" field="address" style="width:90%" ></label></td>
						<td class="FieldLabel" style="width: 15%">居住地邮编</td>
						<td class="FieldInput" style="width: 18%"><label
							name="居住地邮编" title="居住地邮编" field="familyPostcode" style="width:80%" ></label></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">属别</td>
						<td class="FieldInput" style="width: 18%">
						<label field="belonging" dataset="belongingDataSet"></label>
						</td>	
						<td class="FieldLabel" style="width: 15%">分类施保类别</td>
						<td class="FieldInput" style="width: 18%">
						<label field="assistanceClass" dataset="assistance"></label></td>
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">其他救助类型</td>
						<td class="FieldInput" style="width: 18%" colspan="5">
							<input type="checkbox" disabled="disabled" name="assistanceType" id='25' value="25"></input>
							<label>低保家庭应届大学本科新生</label>
							<input type="checkbox" disabled="disabled" name="assistanceType"id='05' value="05"></input>
							<label>困难优抚对象</label>
							<input type="checkbox" disabled="disabled" name="assistanceType" id='06'value="06"></input>
							<label>残疾人</label>
							<input type="checkbox" disabled="disabled" name="assistanceType"id='07' value="07"></input>
							<label>单亲特困母亲</label>
							<input type="checkbox" disabled="disabled" name="assistanceType"id='08' value="08"></input>
							<label>困难学生</label>
							<input type="checkbox" disabled="disabled" name="assistanceType"id='09' value="09"></input>
							<label>城市“三无”对象</label>
							<input type="checkbox" disabled="disabled" name="assistanceType"id='10' value="10"></input>
							<label>特困职工及子女</label>
							<input type="checkbox" disabled="disabled" name="assistanceType"id='11' value="11"></input>
							<label>其他</label>
						</td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		
		<next:EditGridPanel id="peoplePanel" titleCollapse="true" collapsible="true"  stripeRows="true" autoHeight="true" dataset="peopleListDataSet" title="家庭成员基本信息" >
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="查看" handler="peopleDetail" />
			</next:TopBar>
			
			<next:Columns>
				<next:RowNumberColumn/>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column  id="name" field="name" header="姓名" width="140">
					<next:TextField editable="false"/>
				</next:Column>
				
				<next:Column field="relationshipType" header="与户主关系" width="140">
					<next:ComboBox editable="false" dataset="relationshipTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column   field="healthCode" header="健康状况" width="140" >
					<next:ComboBox editable="false" dataset="healthCodeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column   field="disabilityType" header="残疾类别" width="140" >
					<next:ComboBox editable="false" dataset="disabilityTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column   field="employmentCode" header="就业状况" width="140">
					<next:ComboBox editable="false" dataset="employmentCodeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column  field="laborCapacity" header="劳动能力" width="140">
					<next:ComboBox editable="false" dataset="laborCapacityDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
		<next:EditGridPanel id="housePanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="houseListDataset" title="家庭房产信息">
			<next:Columns>
				<next:RowNumberColumn/>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="住房性质" field="houseQuality" width="140" >
					<next:ComboBox  editable="false" dataset="houseQualityDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="房产（建房）证号" field="propertyCertificate" width="140" >
					<next:TextField  editable="false"/>
				</next:Column>
				<next:Column header="住房地址" field="houseAdd" width="140" >
					<next:TextField   editable="false"/>
				</next:Column>
				<next:Column header="建筑面积" field="buildArea" width="140" >
					<next:TextField   editable="false"/>
				</next:Column>
				<next:Column header="使用面积" field="useArea" width="140" >
					<next:TextField   editable="false"/>
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
		
		<next:EditGridPanel id="estatePanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="estateListDataset" title="家庭财产信息">
			<next:Columns>
				<next:RowNumberColumn/>
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="财产类型" field="estateType" width="140" >
					<next:ComboBox  editable="false"  dataset="estateTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="备注" field="remarks" width="340" >
					<next:TextField  editable="false" />
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
		
	<next:EditGridPanel id="supportPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="supportListDataset" title="赡（抚、扶）养义务人员信息">
			<next:Columns>
				<next:RowNumberColumn/>
				<next:RadioBoxColumn></next:RadioBoxColumn>
			    <next:Column header="姓名" field="name" width="100" >
					<next:TextField  editable="false" />
				</next:Column>
				<next:Column header="身份证号" field="idCard" width="200" >
					<next:TextField  editable="false" />
				</next:Column>
				<next:Column header="性别" field="sex" width="80" >
					<next:ComboBox  editable="false" dataset="sexDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="被赡（抚、扶）养人" field="supportedPeople" width="100" >
					<next:TextField  editable="false" />
				</next:Column>
				<next:Column header="与被赡（抚、扶）养人关系" field="relation" width="200" >
					<next:ComboBox editable="false" dataset="supportedRelationDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="月负担赡（抚、扶）养费（元）" field="supportedPay" width="160" >
					<next:TextField  editable="false" />
				</next:Column>
			</next:Columns>
	</next:EditGridPanel>
	</next:Panel>
</body>
</html>
