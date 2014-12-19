<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>查看跨省迁出人员信息</title>
<next:ScriptManager />
<script type="text/javascript" src="demomigrationUpdate.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var peopleId = '<%= (String)request.getParameter("peopleId")%>';
	var familyId = '<%= (String)request.getParameter("familyId")%>';
	var applyId = '<%= (String)request.getParameter("applyId")%>';
		</script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 换证、补证审批信息 -->
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDemobilizedQueryCommand" method="queryDemoUpdateRecord" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability">
			<!-- 人员信息 字段 -->
			<model:field name="familyId" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="idCard" type="string"/>
			<model:field name="nation" type="string"/>
			<model:field name="birthday" type="string"/>
			<model:field name="address" type="string"/>
			<model:field name="demobilizedNo" type="string"/>
			<!-- 行政区划 字段 -->
			<model:field name="apanageName" type="string"/>
			<!-- 在乡复员信息 字段 -->
			<model:field name="conscriptDate" type="string"/>
			<model:field name="veteransDate" type="string"/>
			<model:field name="isKoeanwar" type="string"/>
			<model:field name="position" type="string"/>
			<model:field name="decruitmentDate" type="string"/>
			<model:field name="belongDate" type="string"/>
			<model:field name="townCheckPhone" type="string"/>
			<model:field name="allowanceMonth" type="string"/>
			<model:field name="ingoingAddress" type="string"/>

		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
		
	<!-- 是否抗美援朝 -->
	<model:dataset id="isKoeanwar" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 所属时期 -->
	<model:dataset id="warDate" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel autoHeight="true"  bodyStyle="width:100%" width="100%" >
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="基本信息" width="100%" height="100%">
				<next:Html>
					<iframe id="peopleInfo"
						src="../../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../applydemobilized/demobilizedInfo.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="家庭成员信息" width="100%" height="100%">
				<next:Html>
					<iframe id="member"
						src="../../../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="住房信息" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../../../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="电子档案" width="100%" height="100%" id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../comm/uploadfileDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=4A&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
<next:Panel title="迁出信息" width="100%" height="100%" autoScroll="false">
	<next:Html>
				  <iframe id="upload" src="demomigration_Detail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>	
<next:Panel title="县级审核" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../../comm/emigrationProviTown_detail.jsp?applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
</next:Panel>
	</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
<script type="text/javascript">
	function init(){
		var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
		DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
		DisabilityApproveDataset.setParameter("PEOPLE_ID",peopleId);

		DisabilityApproveDataset.load();
		L5.QuickTips.init();
	}

	
	function back(){
		history.go(-1);
	}
	//查看人员详细链接
	function detail(value){
		if(value!=''){
			var peopleId = DisabilityApproveDataset.getCurrent().get("peopleId");
			var familyId = DisabilityApproveDataset.getCurrent().get("familyId");
			var url='../assessdisability/disabilityDetailManage.jsp?peopleId='+peopleId+'&familyId='+familyId;
			return "<a href='#' style='color:blue' onclick='openWindow(\""+url+"\")'>"+value+"</a>";
		}
	}
	function openWindow(url){
	        var width = 800;
			var height = 500;
			var win =window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
			if (win == null) {
				return;
			}
	}
	function print() {
		var url="../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</html>
