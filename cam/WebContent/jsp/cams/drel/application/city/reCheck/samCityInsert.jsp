<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<%@page import="com.inspur.cams.comm.util.DicUtil"%>
<%@page import="com.inspur.cams.drel.comm.SamConfig"%>
<html>
<head>
<title>城市低保复查页面</title>
<next:ScriptManager />
<script type="text/javascript">
	<%
		String method=request.getParameter("method");//新增还是修改
		String applyId=request.getParameter("applyId");//业务主键
		String name=request.getParameter("name");//环节代码
		String assignmentId=request.getParameter("assignmentId");//委派实例ID
		String nowTime= DateUtil.getDay();
		String organArea=BspUtil.getCorpOrgan().getOrganCode();
		String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
		
		String address=DicUtil.getTextValueFromDic("dic_city","ID",organArea,"NAME");
		String apanageCode=organArea.substring(0,6)+"000000";
		String apanageName=DicUtil.getTextValueFromDic("dic_city","ID",apanageCode,"NAME");
		String cityCode=organArea.substring(0,4)+"00000000";
		String cityName=DicUtil.getTextValueFromDic("dic_city","ID",cityCode,"NAME");
		
		boolean ifFileCheck = SamConfig.getIfFileCheck();//获取流程里面受理时是否进行文件上传校验
		
	%>
	var ifFileCheck='<%=ifFileCheck%>';
	var method='<%=method%>';
	var applyId='<%=applyId%>';
	var ActivityName='<%=name%>';
	var assignmentId='<%=assignmentId%>';
	var nowTime='<%= DateUtil.getDay()%>';
	var organArea = '<%=organArea%>';
	var organName = '<%=organName%>';
	var regId = '<%=BspUtil.getEmpOrgan().getOrganId()%>';
	var regOrg = '<%=BspUtil.getCorpOrgan().getOrganId()%>';
	var regOrgName = '<%=BspUtil.getCorpOrgan().getOrganName()%>';
	var regPeople = '<%=BspUtil.getEmpOrgan().getOrganName()%>';
	var regTime = '<%=DateUtil.getTime()%>';
	var regOrgType = '<%=BspUtil.getCorpOrgan().getOrganType()%>';
	
	var rootPath='<%=SkinUtils.getRootUrl(request)%>';
	var address='<%=address%>';
	var apanageCode='<%=apanageCode%>';
	var apanageName='<%=apanageName%>';
	var cityCode='<%=cityCode%>';
	var cityName='<%=cityName%>';
	//获取当前时间
	function getCurrent(){
		
		return (new Date()).getTime();
	}
</script>
<script type="text/javascript" src="../../samApplyComm.js"></script>
<script type="text/javascript" src="samCityInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 家庭基本信息 -->
	<model:dataset id="familyDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoFamilyQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
			<model:field name="familyName" type="string" rule="require|length{50}" />
			<model:field name="familyCardNo" type="string" rule="require|length{18}" />
			<model:field name="povertyCause" type="string" rule="require" />
			<%-- <model:field name="belonging" type="string" rule="require" /> --%>
			<%-- <model:field name="assistanceMode" type="string" rule="require" /> --%>
			<model:field name="familyMobile" type="string" rule="length{20}" />
			<model:field name="address" type="string" rule="require|length{200}" />
			<model:field name="familyPostcode" type="string" rule="length{6}" />
			<model:field name="applyReason" type="string" rule="length{500}" />
			<model:field name="applyDate" type="string" rule="require" />
			<model:field name="domicileName" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="peopleListDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true"  method='queryPeopleForSam'>
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 家庭房产信息 -->
	<model:dataset id="houseListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyHouseQueryCmd" global="true"   >
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamFamilyHouse">
			<model:field name="propertyCertificate" type="string" rule="length{50}" />
			<model:field name="houseAdd" type="string" rule="length{100}" />
			<model:field name="buildArea" type="string" rule="regex{^[0-9]{1,14}\.[0-9]{0,2}$}" />
			<model:field name="useArea" type="string" rule="regex{^[0-9]{1,14}\.[0-9]{0,2}$}" />
		</model:record>
	</model:dataset>
	<!-- 家庭财产信息 -->
	<model:dataset id="estateListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyEstateQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyEstate">
			<model:field name="remarks" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 赡（抚、扶）养人信息 -->
	<model:dataset id="supportListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilySupportQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilySupport">
			<model:field name="name" type="string" rule="length{30}" />
			<model:field name="idCard" type="string" rule="length{18}" />
		</model:record>
	</model:dataset>
	<!-- 被赡（抚、扶）养人 -->
	<model:dataset id="supportedPeopleDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='BASEINFO_PEOPLE'></model:param>
			<model:param name="value" value='PEOPLE_ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

	<!-- 申请材料 -->
	<model:dataset id="filesListDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true" pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
			<model:field name="remarks" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>	
	<!-- 字典表测试 -->
	<model:dataset id="DicForDetail" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	
	<model:dataset id="comm_yesorno" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_YES_NO'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 主要致贫原因 -->
	<model:dataset id="povertyCauseDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_PROVERTY_CAUSE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_HEALTH'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾类别  -->
	<model:dataset id="disabilityTypeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业状况-->
	<model:dataset id="employmentCodeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_EMPLOYMENT_CODE'></model:param>
		</model:params>
	</model:dataset>
 
	<!-- 劳动能力 -->
	<model:dataset id="laborCapacityDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_LABOR_CAPACITY'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住房类型 -->
	<model:dataset id="houseQualityDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_HOUSEFRAME'></model:param>
		</model:params>
	</model:dataset>
	 <!-- 性别代码-->
	 <model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度-->
	 <model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_EDUCATION'></model:param>
		</model:params>
	</model:dataset>
	<!-- 财产类型 -->
	 <model:dataset id="estateTypeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_ESTATE_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 申请证明材料 -->
	<model:dataset id="fileTypeDataset" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dicType" value='DIC_FILE_NAME'></model:param>
		</model:params>
	</model:dataset>
	
</model:datasets>
   <next:Panel  height="100%" autoScroll="true" id="tab">
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem id="newIdCard" iconCls="add" text="生成身份代码" disabled="" handler="newIdCard" hidden="false"/>
				<next:ToolBarItem id="saveId" iconCls="save" text="保存" disabled="" handler="save"/>
				<next:ToolBarItem id="submitId" iconCls="select" text="提交" disabled="" handler="submitApply" />
				<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack"/>
			</next:TopBar>
	<next:Panel title="家庭基本信息" titleCollapse="true" collapsible="true"  autoHeight="true" autoScroll="true">
			
			<next:Html>
				<form  method="post" onsubmit="return false" class="L5form" dataset="familyDataSet">
				<table width="100%">
					<input type="hidden" name="familyId" field="familyId" value="1"/>
					<input type="hidden" field="peopleNum" />
					<input type="hidden" field="yearIncome" />
					<input type="hidden" field="yearAverageIncome" />
					<input type="hidden"  id="assistanceModeID"  field="assistanceMode" />
										
					<tr>						
						<td class="FieldLabel" style="width: 15%">户主姓名</td>
						<td class="FieldInput" style="width: 18%"><input type="text" maxlength="25"
							name="户主姓名" title="户主姓名" field="familyName"  style="width:80%" /><font color="red">*</font>		</td>				
						<td class="FieldLabel" style="width: 15%">身份证号</td>
						<td class="FieldInput" style="width: 18%"><input type="text" maxlength="18" id="familyCardNo"
							name="身份证号" title="身份证号" field="familyCardNo" style="width:80%" onchange="checkCradNo(this)" /><font color="red">*</font></td>
						
						<td class="FieldLabel" style="width: 15%" rowspan="4">照片</td>
						<td class="FieldInput" style="width: 18%" rowspan="4">
							<div id="photoDiv">
								<img id="img" name="FAMILY_IMG"  width=140 height=90  src="<%=SkinUtils.getRootUrl(request) %>skins/images/family.png" 
									align="top" ondblclick="editPhoto(4,'familyPhotoId','FAMILY_IMG');"
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>skins/images/family.png'" alt="暂无图片" />
								<input type="hidden" id="familyPhotoId" name="familyPhotoId"/>
							</div>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%" >主要致贫原因</td>
						<td class="FieldInput" style="width: 18%"><select
							name="主要致贫原因" title="主要致贫原因" field="povertyCause" style="width:80%" ><option dataset="povertyCauseDataset"></option></select><font color="red">*</font></td>
						<td class="FieldLabel" style="width: 15%">保障人口数</td>
						<td class="FieldInput" style="width: 18%"><label field="assistancePeopleNum"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">家庭月总收入（元）</td>
						<td class="FieldInput" style="width: 18%"><label field="monthIncome"></label></td>
						<td class="FieldLabel" style="width: 15%">家庭月均收入（元）</td>
						<td class="FieldInput" style="width: 18%"><label field="monthAverageIncome"></label></td>
						
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">邮政编码</td>
						<td class="FieldInput" style="width: 18%"><input type="text" maxlength="20"
							name="联系电话" title="邮政编码" field="familyPostcode" style="width:80%" />
						</td>
						<td class="FieldLabel" style="width: 15%">联系电话</td>
                        <td class="FieldInput" style="width: 18%"><input type="text" maxlength="20"
                            name="联系电话" title="联系电话" field="familyMobile" style="width:80%" /></td>         
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">地区</td>
						<td class="FieldInput" style="width: 18%">
						 <input type="text" style="width:78%"name="地区" title="地区"  field="domicileName" readonly id="lrdwmc" />
						<input type="text" style="display: none;"  name="lrdwId" id="lrdwIdquery" field="domicileCode" />
						 <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForDomicileSelect()" /><font color="red">*</font>
						</td>
						
						<td class="FieldLabel" style="width: 15%">家庭地址</td>
						<td class="FieldInput" style="width: 18%" colspan="3"><input type="text" maxlength="100"
							name="居住地址" title="居住地址" field="address" style="width:93%" /><font color="red">*</font></td>
												
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 15%">申请日期</td>
						<td class="FieldInput" style="width: 18%"><input type="text"
							name="申请日期" title="申请日期" field="applyDate" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly"/>
							<font color="red">*</font>
						</td>
					
						<td class="FieldLabel" width="15%">家庭类型</td>
					    <td class="FieldInput" width="18%">
					    	<input type="text" field="assistanceTypeName" id='assistanceTypeName' style="width:85.8%" readOnly="true" />
							<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="openTypeWin()"/>
							<input type="hidden" field="assistanceType" id='assistanceType'>
					    </td>
					    
					    <td class="FieldLabel" style="width: 15%">户人均居住面积（㎡）</td>
						<td class="FieldInput" style="width: 18%">
							<label id="averageArea"> </label>
						</td>	
					</tr>
					
				    <tr>
						<td class="FieldLabel" style="width: 15%">申请理由</td>
						<td class="FieldInput" style="width: 18%" colspan="5"><textarea name="applyReason"
										field="applyReason" style="width: 95.8%"   /></textarea><font color="red">*</font></td>
					</tr>		
				</table>
				</form>
			</next:Html>
		</next:Panel>
		
		<next:GridPanel id="peoplePanel" titleCollapse="true" collapsible="true"  stripeRows="true" autoHeight="true" dataset="peopleListDataSet" title="家庭成员基本信息" >
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem id="peopleAdd" iconCls="add" text="新增" handler="addPeople"  disabled="" />
					<next:ToolBarItem iconCls="detail" text="修改" handler="changePeople" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removePeople" />
			</next:TopBar>
			
			<next:Columns>
				 <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
				<next:Column  id="name" field="NAME" header="姓名" width="100">
					<next:TextField editable="false"/>
				</next:Column>
				
				<next:Column field="RELATIONSHIP_TYPE" header="与户主关系" width="115">
					<next:ComboBox editable="false" dataset="relationshipTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column   field="HEALTH_CODE" header="健康状况" width="100" >
					<next:ComboBox editable="false" dataset="healthCodeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column   field="IS_ASSISTANCE" header="是否保障对象" width="100">
					<next:ComboBox editable="false" dataset="comm_yesorno" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column   field="DISABILITY_TYPE" header="残疾类别" width="100" >
					<next:ComboBox editable="false" dataset="disabilityTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column   field="EMPLOYMENT_CODE" header="就业状况" width="110">
					<next:ComboBox editable="false" dataset="employmentCodeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				
				<next:Column  field="LABOR_CAPACITY" header="劳动能力" width="100">
					<next:ComboBox editable="false" dataset="laborCapacityDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column   field="EDU_CODE" header="文化程度" width="110">
					<next:ComboBox editable="false" dataset="eduDataSet" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column   field="INCOME_MONTH" header="月收入（元）" width="80" align='right'>
					<next:TextField editable="false"/>
				</next:Column>
			</next:Columns>
		</next:GridPanel>
		<next:GridPanel id="housePanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="houseListDataset" title="家庭房产信息">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem disabled="" id="houseAdd" iconCls="add" text="新增" handler="addHouse" />
					<next:ToolBarItem iconCls="detail" text="修改" handler="changeHouse" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removeHouse" />
			</next:TopBar>
			
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 
			    <next:Column header="所有权人" field="propertyOwner" dataset="supportedPeopleDataSet" width="140" >
                </next:Column>	
				<next:Column header="住房性质" field="houseQuality" width="140" >
					<next:ComboBox dataset="houseQualityDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="房产（建房）证号" field="propertyCertificate" width="140" >
					<next:TextField />
				</next:Column>
				<next:Column header="住房地址" field="houseAdd" width="140" >
					<next:TextField  />
				</next:Column>
				<next:Column header="建筑面积（㎡）" field="buildArea" width="140" align='right'>
					<next:TextField   editable="false"/>
				</next:Column>
				<next:Column header="使用面积（㎡）" field="useArea" width="140" align='right'>
					<next:TextField   editable="false"/>
				</next:Column>
			</next:Columns>
		</next:GridPanel>
		
		<next:GridPanel id="estatePanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="estateListDataset" title="家庭财产信息">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" disabled=""  id="estateAdd" text="新增" handler="addEstate" />
					<next:ToolBarItem iconCls="detail" text="修改" handler="changeEstate" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removeEstate" />
			</next:TopBar>
			
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
				<next:Column header="财产类型" field="estateType" width="140" >
					<next:ComboBox   dataset="estateTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="备注" field="remarks" width="340" >
					<next:TextField  />
				</next:Column>
			</next:Columns>
		</next:GridPanel>
		
	<next:GridPanel id="supportPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="supportListDataset" title="监护人员信息">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem id="supportAdd" iconCls="add" disabled=""  text="新增" handler="addSupport" />
					<next:ToolBarItem iconCls="detail" text="修改" handler="changeSupport" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removeSupport" />
			</next:TopBar>
			
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
			    <next:Column header="姓名" field="name" width="100" >
					<next:TextField  />
				</next:Column>
				<next:Column header="身份证号" field="idCard" width="149" >
					<next:TextField  />
				</next:Column>
				<next:Column header="家庭住址" field="homeAddress" width="140" >
					<next:TextField  />
				</next:Column>
				<next:Column header="联系电话" field="telePhone" width="178" >
					<next:TextField  />
				</next:Column>
			</next:Columns>
	</next:GridPanel>
	<next:GridPanel id="filesPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="filesListDataset" title="申请证明材料">
			<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem id="filesAdd"disabled=""  iconCls="add" text="本地磁盘附件" handler="uploadFiles" />
					<next:ToolBarItem id="filesUpload" disabled=""  iconCls="upload" text="电子扫描" handler="scanFiles" />
					<next:ToolBarItem iconCls="remove" text="删除" handler="removeFiles" />
			</next:TopBar>
			
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
			    <next:Column header="证明材料名称" field="fileType" width="200" dataset="fileTypeDataset">
					<next:TextField  />
				</next:Column>
				<next:Column header="文件名" field="applyFileId" width="400" renderer="downloadFile">
				</next:Column>
				<next:Column header="备注" field="remarks" width="400" >
					<next:TextField  />
				</next:Column>
			</next:Columns>
	
	</next:GridPanel>
</next:Panel>

<jsp:include page="../../../comm/newIdCard.jsp" flush="true"></jsp:include>
<jsp:include page="../../../comm/assistanceType.jsp" flush="true">   
	<jsp:param name= "assistanceType" value= "01"/> 
</jsp:include>
<jsp:include page="../../../comm/uploadListCheck.jsp" flush="true"></jsp:include>
</body>
</html>
