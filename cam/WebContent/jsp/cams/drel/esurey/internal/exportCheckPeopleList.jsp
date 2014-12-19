<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<%

	String nameValue=request.getParameter("name");
	String flag=request.getParameter("flag");
	if(flag == null){
		flag="";
	}
	String name="审批";
%>
<title>待核查人员列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
var time1 = '';
    <%
    String organArea=BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organArea,"NAME");
    %>
	var organArea='<%=organArea%>';
	var organName='<%=organName%>';
	var nameValue='<%=nameValue%>';
	var flag='<%=flag%>';
	var assistanceType="01";
	var applyIds ='';
	var assignmentIds='';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src='exportCheckPeopleList.js'></script>
</head>
<body>

<model:datasets>
	<model:dataset id="assistanceTypeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"  autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_ASSISTANT_TYPE'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
	</model:dataset>
	
	<model:dataset id="applyTypeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"  autoLoad="true">
			<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
			<model:params>
				<model:param name="dic" value='DIC_SAM_APPLY_TYPE'></model:param>
				<model:param name="value" value='CODE'></model:param>
				<model:param name="text" value='NAME'></model:param>
			</model:params>
	</model:dataset>

	<!-- 核对家庭信息 -->
	<model:dataset id="esureyFamilyDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily">
		</model:record>
	</model:dataset>
	
	<!-- 业务信息 -->
	<model:dataset id="applyDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryForExportPeople" global="true"  pageSize="10" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	
	<!-- 业务信息 -->
	<model:dataset id="InTheWarrantyDs" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryInTheWarranty" global="true"  pageSize="10" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	
	
	<!-- 在保人员信息 -->
	<model:dataset id="inAssitanceDs" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryInAssitanceDetail" global="true"  pageSize="-1" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	
	
	<!-- 业务信息 -->
	<model:dataset id="applyDetail" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryForPeopleDetail" global="true"  pageSize="-1" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyInfo">
		</model:record>
	</model:dataset>
	<!-- 业务信息 test-->
	<model:dataset id="exportDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamApplyInfoQueryCmd" method="queryExport" global="true"  pageSize="20" >
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:TabPanel width="100%" height="100%">
		<next:Tabs>
	<next:Panel width="100%" height="100%" title="新增人员导出">
		 <next:GridPanel  clickToSelectedForChkSM="true" id="daiBanGridPanel2"  dataset="applyDataSet" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
			<next:TopBar>		
				<next:ToolBarItem symbol="->"></next:ToolBarItem>	
                       <next:ToolBarItem iconCls="export"  text="导出" handler="exportNew"/>
                       <next:ToolBarItem iconCls="export"  text="批量导出" handler="batchExportNew"/>  
                      <next:ToolBarItem iconCls="export"  text="导出XML" handler="exportXML"/>   
			</next:TopBar>
			<next:Columns>
   				<next:RowNumberColumn/>
   				<next:RadioBoxColumn></next:RadioBoxColumn>
   				<next:Column  header="单位" field="TOWM_NAME"  width="200"  ></next:Column>	
   				<next:Column  header="区划代码" field="DOMICILE_CODE" hidden="true"  width="200"  ></next:Column>	
				<next:Column  header="人数" field="PEO_NUM" align="center"  width="200" renderer="editHref"  ></next:Column>							
		        <next:Column header="救助类别" field="APPLY_TYPE" width="150" dataset="applyTypeDs"></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="applyDataSet" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
	<next:Panel width="100%" height="100%" title="在保人员导出">
		 <next:GridPanel  clickToSelectedForChkSM="true" id="daiBanGridPanel"  dataset="InTheWarrantyDs" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
			<next:TopBar>		
				<next:ToolBarItem symbol="->"></next:ToolBarItem>	
                       <next:ToolBarItem iconCls="export"  text="导出" handler="exportDetail"/> 
                        <next:ToolBarItem iconCls="export"  text="批量导出" handler="batchExport"/>
                      <next:ToolBarItem iconCls="export"  text="导出XML" handler="exportXML"/>   
			</next:TopBar>
			<next:Columns>
   				<next:RowNumberColumn/>
   				<next:RadioBoxColumn></next:RadioBoxColumn>
   				<next:Column  header="单位" field="TOWM_NAME"  width="200"  ></next:Column>	
   				<next:Column  header="区划代码" field="DOMICILE_CODE" hidden="true"  width="200"  ></next:Column>	
				<next:Column  header="人数" field="PEO_NUM" align="center"  width="200"  ></next:Column>							
		        <next:Column header="救助类别" field="APPLY_TYPE" width="150" dataset="assistanceTypeDs" ></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="InTheWarrantyDs" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:Tabs>
</next:TabPanel>
</next:ViewPort>
</body>
<next:Window id="ceshi">
	<next:Panel width="100%" height="100%" hidden="true" title="test">
	 <next:GridPanel  clickToSelectedForChkSM="true" id="daiBanGridPanel3"  dataset="inAssitanceDs" width="100%" height="100%" stripeRows="true" notSelectFirstRow="true">
		<next:Columns>
		<next:Column  header="申请唯一号" field="APPLY_ID"  width="200"  ></next:Column>	
		<next:Column  header="受理编号" field="SLBH"  width="200"  ></next:Column>	
		<next:Column  header="主申请人姓名" field="FAMILY_NAME"  width="200"  ></next:Column>	
		<next:Column  header="主申请人证件类型" field="ID_CARD_TYPE"  width="200"  ></next:Column>	
		<next:Column  header="主申请人证件号码" field="FAMILY_CARD_NO"  width="200"  ></next:Column>	
		<next:Column  header="姓名" field="NAME"  width="200"  ></next:Column>	
		<next:Column  header="性别" field="SEX"  width="200"  ></next:Column>	
		<next:Column  header="出生日期" field="BIRTHDAY"  width="200"  ></next:Column>	
		<next:Column  header="证件类型" field="ID_CARD_TYPE"  width="200"  ></next:Column>	
		<next:Column  header="证件号码" field="ID_CARD"  width="200"  ></next:Column>	
		<next:Column  header="与主申请人关系" field="RELATIONSHIP_TYPE"  width="200"  ></next:Column>	
		<next:Column  header="曾用名" field="CYM"   width="200"  ></next:Column>	
		</next:Columns>
	</next:GridPanel>
</next:Panel>
</next:Window>




</html>