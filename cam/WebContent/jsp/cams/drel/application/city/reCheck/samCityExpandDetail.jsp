<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>城市低保家庭详细信息页面</title>
<next:ScriptManager />
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript">
var familyId = '<%=request.getParameter("familyId")%>';
var applyId = '<%=request.getParameter("applyId")%>';
var ifFile = '<%=request.getParameter("ifFile")%>';
function init(){
	if(ifFile=="0"){
		var filesPanel=L5.getCmp("filesPanel");
		filesPanel.hide();
	}
    supportedPeopleDataSet.setParameter("filterSql", "FAMILY_ID='" + familyId + "'");
    supportedPeopleDataSet.load();
    supportedPeopleDataSet.on('load',loadHouseList);
}
function loadHouseList(ds){
	ds.un("load",loadHouseList);
	houseListDataset.setParameter("FAMILY_ID",familyId);
    houseListDataset.load();
    houseListDataset.on('load',loadestateListDataset);
}
function loadestateListDataset(ds){
	ds.un("load",loadestateListDataset);
	estateListDataset.setParameter("FAMILY_ID",familyId);
	estateListDataset.load();
	estateListDataset.on('load',loadesupportListDataset);
}
function loadesupportListDataset(ds){
	ds.un("load",loadesupportListDataset);
	supportListDataset.setParameter("FAMILY_ID",familyId);
	supportListDataset.load();
	supportListDataset.on('load',loadefilesDataset);
}
function loadefilesDataset(ds){
	ds.un("load",loadefilesDataset);
	filesDataset.setParameter("APPLY_ID",applyId);
    filesDataset.setParameter("FILE_TYPE@IN","101,102,201,202,203,204,205,206,207,208,209,210,301,001,000");
	filesDataset.load();
}
function returnBack(){
	window.close();
}
//下载申请证明材料
function downloadFile(value,cellmeta,record,rowindex,colindex,dataset){
	var paths = document.location.pathname.split("/");
	var id = record.get("applyFileId");
	if(record.get('fileName')){
	    var url0=rootPath+"download?table=sam_apply_files&column=file_content&pk=apply_file_id&filename=file_name&apply_file_id='"+id+"'";
		return '<a id="download"  href='+url0+'>'+record.get('fileName')+'</a>';
	}else{
		return '';
	}
}
//赡扶抚养义务人员
function getSupportName(value,cellmeta,record,rowindex,colindex,dataset){
	return '<a href="javascript:detailSupport(\''+record.get("supportId")+'\')">'+value+'</a>';
}
//查看赡扶抚养义务人员
function detailSupport(supportId){
	var width = 850;
    var height = 187;
	var url="../../../comm/supportDetail.jsp?familyId="+familyId+"&supportId="+supportId+"&assistanceType=01";
	window.showModalDialog(url, window, "scroll:0;status:no;dialogWidth:" + width + "px;dialogHeight:" + height + "px;resizable:1");
}
</script>
</head>
<body>
<model:datasets>
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
	<model:dataset id="filesDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" global="true"  pageSize="15">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
		</model:record>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 主要致贫原因 -->
	<model:dataset id="povertyCauseDataset" enumName="SAM_CITY_PROVERTY_CAUSE" autoLoad="true" global="true"></model:dataset>
	<!-- 属别 -->
	<model:dataset id="belongingDataSet" enumName="SAM_BELONGING" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE" autoLoad="true" global="true"></model:dataset>
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
	<!-- 劳动能力 -->
	<model:dataset id="laborCapacityDataset" enumName="SAM_LABOR_CAPACITY" autoLoad="true" global="true"></model:dataset>
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
	<!-- 申请证明材料 -->
	<model:dataset id="fileTypeDataset" enumName="SAM_FILE_NAME" autoLoad="true" global="true"></model:dataset>
</model:datasets>
   <next:Panel height="100%" autoScroll="true">
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="关闭" handler="returnBack"/>
			</next:TopBar>
		<next:EditGridPanel id="housePanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="houseListDataset" title="家庭房产信息">
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
			    <next:Column header="所有权人" field="propertyOwner" dataset="supportedPeopleDataSet" width="140" />
				<next:Column header="住房性质" field="houseQuality" width="140" >
					<next:ComboBox  editable="false" dataset="houseQualityDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="房产（建房）证号" field="propertyCertificate" width="140" >
					<next:TextField  editable="false"/>
				</next:Column>
				<next:Column header="住房地址" field="houseAdd" width="140" >
					<next:TextField   editable="false"/>
				</next:Column>
				<next:Column header="建筑面积（㎡）" field="buildArea" width="140" align='right'>
					<next:TextField   editable="false"/>
				</next:Column>
				<next:Column header="使用面积（㎡）" field="useArea" width="140" align='right'>
					<next:TextField   editable="false"/>
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
		
		<next:EditGridPanel id="estatePanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="estateListDataset" title="家庭财产信息">
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
				<next:Column header="财产类型" field="estateType" width="140" >
					<next:ComboBox  editable="false"  dataset="estateTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="备注" field="remarks" width="340" >
					<next:TextField  editable="false" />
				</next:Column>
			</next:Columns>
		</next:EditGridPanel>
		
	<next:GridPanel id="supportPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="supportListDataset" title="监护人员信息">
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn>  	
			    <next:Column header="姓名" field="name" width="100" renderer="getSupportName">
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
	<next:EditGridPanel id="filesPanel"titleCollapse="true" collapsible="true"  stripeRows="true"  autoHeight="true" dataset="filesDataset" title="申请证明材料">
			<next:Columns>
			    <next:RowNumberColumn />
			    <next:RadioBoxColumn></next:RadioBoxColumn> 	
			    <next:Column header="证明材料名称" field="fileType" width="200" >
					<next:ComboBox editable="false" dataset="fileTypeDataset" displayField="text" valueField="value" typeAhead="true" />
				</next:Column>
				<next:Column header="文件名" field="applyFileId" width="400" renderer="downloadFile">
					<next:TextField editable="false" />
				</next:Column>
				<next:Column header="备注" field="remarks" width="400" >
					<next:TextField editable="false" />
				</next:Column>
				
			</next:Columns>
	</next:EditGridPanel>
	</next:Panel>
</body>
</html>
