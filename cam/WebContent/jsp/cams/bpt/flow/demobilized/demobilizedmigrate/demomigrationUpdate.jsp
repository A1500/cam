<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>修改跨省迁出人员信息</title>
<next:ScriptManager />
<script type="text/javascript" src="demomigrationUpdate.js"></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
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
			<model:field name="ingoingCode" type="string"/>
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
				  <iframe id="upload" src="../../../comm/uploadfile.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=4A&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
<next:Panel title="迁出信息" width="100%" height="100%" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="print"  text="生成" handler="print"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="approveForm" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="DisabilityApproveDataset">
		<table border="1" width="99%">
			<tr>
				<td class="FieldLabel" style="width:15%">姓名：</td>
				<td class="FieldInput" style="width:15%"><label id="name" name="name" field="name"/></td>
				<td class="FieldLabel" style="width:15%">性别：</td>
				<td class="FieldInput" style="width:15%"><label id="sex" name="sex" field="sex" dataset="SexDataset"></label></td>
				<td class="FieldLabel" style="width:15%">身份证号：</td>
				<td class="FieldInput" style="width:15%" nowrap="nowrap"><label name="idCard" field="idCard"/></td>
	   		</tr>
	   		
	   		<tr>
	   			<td class="FieldLabel">民族：</td>
				<td class="FieldInput"><label id="nation" name="nation" field="nation" dataset="NationDataset"></label></td>
	   			<td class="FieldLabel">出生年月：</td>
				<td class="FieldInput" colspan="3"><label id="birthday" name="birthday" field="birthday"/></td>
	   		</tr>
	   		
	   		<tr>
	   			<td class="FieldLabel" nowrap="nowrap">入伍（参加工作）时间：</td>
				<td class="FieldInput"><label id="conscriptDate" name="conscriptDate" field="conscriptDate"/></td>
				<td class="FieldLabel" nowrap="nowrap">退伍（离退休）时间：</td>
				<td class="FieldInput"><label id="decruitmentDate" name="decruitmentDate" field="decruitmentDate"/></td>
				<td class="FieldLabel">是否抗美援朝：</td>
				<td class="FieldInput" nowrap="nowrap"><label id="isKoeanwar" name="isKoeanwar" field="isKoeanwar" dataset="isKoeanwar"/></td>
			</tr>
			
			<tr>
	   			<td class="FieldLabel">职位：</td>
				<td class="FieldInput"><label id="position" name="position" field="position" ></label></td>
				<td class="FieldLabel">所属时期：</td>
				<td class="FieldInput"><label id="belongDate" name="belongDate" field="belongDate" dataset="warDate"></label></td>
				<td class="FieldLabel">原残疾证件编号：</td>
				<td class="FieldInput"><label id="demobilizedNo" name="demobilizedNo" field="demobilizedNo"/></td>
			</tr>
	   		<tr>
	   			<td class="FieldLabel">住址行政区划：</td>
				<td class="FieldInput"><label id="apanageName" name="apanageName" field="apanageName"/></td>
				<td class="FieldLabel">地址：</td>
				<td class="FieldInput" colspan="5"><label id="address" name="address" field="address"/></td>
			</tr>
						<tr>
				<td class="FieldLabel" nowrap="nowrap">迁入地民政局：</td>
				<td class="FieldInput"><input type="hidden" id="ingoingCode" name="ingoingCode" field="ingoingCode"/>
									   <input type="text" id="ingoingAddress" name="ingoingAddress" field="ingoingAddress" onclick="getCodeAndName()"/>
									   <font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">在乡复员抚恤金已发至：</td>
				<td class="FieldInput"><input type="text" id="allowanceMonth" readonly="readonly"  format="Y-12" style="width: 100px;" maxlength="10" name="allowanceMonth" field="allowanceMonth" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">迁出地民政部门联系电话：</td>
				<td class="FieldInput"><input type="text" name="townCheckPhone" field="townCheckPhone"/></td>
			</tr>
			<input type="hidden" id="peopleId" field="peopleId">
			<input type="hidden" id="familyId" field="familyId">
			<!-- 打印相关 -->
			<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/comm/print/e_migration_table1.doc"/>
			<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
			<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
			<input type="hidden" id="scaconfPath" value="migrationApp/migrationAppPrintDao"/>
			<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="4A"/>
		</table>
		</form>
   </next:Html>
</next:Panel>
<next:Panel title="县级审核" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../../comm/emigrationProviTown_edit.jsp?applyId=<%=request.getParameter("applyId")%>"
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
