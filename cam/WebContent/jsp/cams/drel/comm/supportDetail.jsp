<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>赡（抚、扶）养义务人员信息</title>
<%
String assistanceType =request.getParameter("assistanceType");
String supportedPay="";
if("01".equals(assistanceType)){
	supportedPay="月负担赡（抚、扶）养费（元）";
}else if("02".equals(assistanceType)||("03".equals(assistanceType))){
	supportedPay="年负担赡（抚、扶）养费（元）";
}
%>
<next:ScriptManager/>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript">
var supportId = '<%=request.getParameter("supportId")%>' ;
var familyId = '<%=request.getParameter("familyId")%>' ;
var assistanceType = '<%=assistanceType%>' ;
var supportedPay = '<%=supportedPay%>' ;
</script>
</head>
<body>
<model:datasets>
	<!-- 赡（抚、扶）养义务人员信息 -->
	<model:dataset id="supportDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilySupportQueryCmd" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilySupport">
		</model:record>
	</model:dataset>
	<!-- 性别代码-->
	<model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<!-- 被赡（抚、扶）养人 -->
	<model:dataset id="supportedPeopleDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" >
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='BASEINFO_PEOPLE'></model:param>
			<model:param name="value" value='PEOPLE_ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与被赡（抚、扶）养人关系 -->
	<model:dataset id="supportedRelationDataset" enumName="SAM_SUPPORTED_RELATION" autoLoad="true" global="true"></model:dataset>
	<!-- 无赡（抚、扶）养能力原因 -->
	<model:dataset id="noSupportReasonDataset" enumName="SAM_NO_SUPPORT_REASON" autoLoad="true" global="true"></model:dataset>	
</model:datasets>
<next:Panel title="" width="850"  autoScroll="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeSupport"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form" dataset='supportDataset'>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 20%">姓名</td>
				<td class="FieldInput" style="width: 30%"><label field="name" /></td>
				<td class="FieldLabel" style="width: 20%">身份证号</td>
				<td class="FieldInput" style="width: 30%"><label field="idCard" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%">性别</td>
				<td class="FieldInput" style="width: 30%"><label field="sex" dataset='sexDataset' /></td>
				<td class="FieldLabel" style="width: 20%">工作单位</td>
				<td class="FieldInput" style="width: 30%"><label field="unitName" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%">职务</td>
				<td class="FieldInput" style="width: 30%"><label field="position" /></td>
				<td class="FieldLabel" style="width: 20%">月收入（元）</td>
				<td class="FieldInput" style="width: 30%"><label field="monthIncome" /></td>				
			</tr>				
			<tr>
				<td class="FieldLabel" style="width: 20%">被赡（抚、扶）养人</td>
				<td class="FieldInput" style="width: 30%">
					<label field="supportedPeople" dataset='supportedPeopleDataSet' />
				</td>
				<td class="FieldLabel" style="width: 20%">与被赡（抚、扶）养人关系</td>
				<td class="FieldInput" style="width: 30%">
					<label field="relation" dataset='supportedRelationDataset' />
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%"><%=supportedPay %></td>
				<td class="FieldInput" style="width: 30%"><label field="supportedPay" /></td>
				<td class="FieldLabel" style="width: 20%"><label id='noSupportReason_label'>无赡（抚、扶）养能力原因</label></td>
				<td class="FieldInput" style="width: 30%">
					<label id="noSupportReason" field="noSupportReason" dataset='noSupportReasonDataset' />
				</td>
			</tr>	
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>
<script type="text/javascript">
//初始化
function init(){
	//加载被赡（抚、扶）养人
	var supportedPeopleDataSet = L5.DatasetMgr.lookup("supportedPeopleDataSet");
    supportedPeopleDataSet.setParameter("filterSql", "FAMILY_ID='" + familyId + "'");
    supportedPeopleDataSet.load();
	var supportDataset=L5.DatasetMgr.lookup("supportDataset");
	supportDataset.setParameter("SUPPORT_ID",supportId);
	supportDataset.load();
	supportDataset.on('load',function(ds){
		if(ds.getCount()==0){
			supportDataset.newRecord({'familyId':familyId});
		}	
		if(assistanceType=='03'){
			$('noSupportReason_label').style.display='block';
			$('noSupportReason').style.display='block';
		}else{
			$('noSupportReason_label').style.display='none';
			$('noSupportReason').style.display='none';
		}
	});
}
//窗口关闭
function closeSupport(){
	window.close();
}
</script>