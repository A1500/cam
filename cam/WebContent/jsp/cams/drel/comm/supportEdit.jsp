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
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
var supportId = '<%=request.getParameter("supportId")%>' ;
var familyId = '<%=request.getParameter("familyId")%>' ;
var applyId = '<%=request.getParameter("applyId")%>' ;
var assistanceType = '<%=assistanceType%>' ; 
var supportedPay = '<%=supportedPay%>' ;
var assistanceModeValue='<%=request.getParameter("assistanceModeValue")%>' ;
var isMod = '<%=request.getParameter("isMod")%>' ;
</script>
</head>
<body>
<model:datasets>
	<!-- 赡（抚、扶）养义务人员信息 -->
	<model:dataset id="supportDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilySupportQueryCmd" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilySupport">
			<model:field name="name" type="string" rule="require|length{30}" />
			<model:field name="idCard" type="string" rule="require|length{18}" />
			<model:field name="unitName" type="string" rule="length{100}" />
			<model:field name="position" type="string" rule="length{30}" />
			<model:field name="monthIncome" type="string" rule="regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}" />
			<model:field name="supportedPeople" type="string" rule="require" />
			<model:field name="supportedPay" type="string" rule="regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}" />
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
		<next:ToolBarItem iconCls="add" text="确定" handler="confirmSupport"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeSupport"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form" dataset='supportDataset'>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 20%">姓名</td>
				<td class="FieldInput" style="width: 30%"><input type='text' field="name" maxlength="30" name='姓名' style="width: 90%"><label style='color:red'>*</label></td>
				<td class="FieldLabel" style="width: 20%">身份证号</td>
				<td class="FieldInput" style="width: 30%"><input type='text' id='idCard' maxlength="18" field="idCard" name='身份证号' style="width: 90%" onblur='checkIdCard()'/><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%">性别</td>
				<td class="FieldInput" style="width: 30%"><select field="sex" id='sex' name='性别' style="width: 90%"><option dataset='sexDataset'></option></select></td>
				<td class="FieldLabel" style="width: 20%">工作单位</td>
				<td class="FieldInput" style="width: 30%"><input type='text' field="unitName" maxlength="100" name='工作单位' style="width: 90%"></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%">职务</td>
				<td class="FieldInput" style="width: 30%"><input type='text' maxlength="30" field="position" name='职务' style="width: 90%" /></td>
				<td class="FieldLabel" style="width: 20%">月收入（元）</td>
				<td class="FieldInput" style="width: 30%"><input type='text' maxlength="14"  id="monthIncomeID"   field="monthIncome" name='月收入（元）' style="width: 90%" /></td>				
			</tr>				
			<tr>
				<td class="FieldLabel" style="width: 20%">被赡（抚、扶）养人</td>
				<td class="FieldInput" style="width: 30%">
					<select field="supportedPeople" name='被赡（抚、扶）养人' style="width: 90%" >
						<option dataset='supportedPeopleDataSet'></option>
					</select><span style='color:red'>*</span>
				</td>
				<td class="FieldLabel" style="width: 20%">与被赡（抚、扶）养人关系</td>
				<td class="FieldInput" style="width: 30%">
					<select field="relation" name='与被赡（抚、扶）养人关系' style="width: 90%" >
						<option dataset='supportedRelationDataset'></option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 20%"><%=supportedPay %></td>
				<td class="FieldInput" style="width: 30%"><input type='text' id="supportedPay" field="supportedPay" name='<%=supportedPay %>' style="width: 90%" /></td>
				<td class="FieldLabel" style="width: 20%"><label id='noSupportReason_label'>无赡（抚、扶）养能力原因</label></td>
				<td class="FieldInput" style="width: 30%">
					<select id='noSupportReason' field="noSupportReason" name='无赡（抚、扶）养能力原因' style="width: 90%" >
						<option dataset='noSupportReasonDataset'></option>
					</select>
				</td>
			</tr>	
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>
<script type="text/javascript">
var	monthIncome='';
var	monthAverageIncome='';
var	yearIncome='';
var	yearAverageIncome='';
var assistanceMoney='';
//初始化
function init(){
	if(isMod == '1'){
		document.getElementById('supportedPay').disabled="disabled";
		document.getElementById('monthIncomeID').disabled="disabled";
	}
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
	//加载被赡（抚、扶）养人
	var supportedPeopleDataSet = L5.DatasetMgr.lookup("supportedPeopleDataSet");
    supportedPeopleDataSet.setParameter("filterSql", "FAMILY_ID='" + familyId + "'");
    supportedPeopleDataSet.load();
    window.onbeforeunload=function(){  
		var parent=window.dialogArguments;
		var supportListDataset=parent.supportListDataset;
		supportListDataset.setParameter("FAMILY_ID",familyId);
		supportListDataset.load();
	} 
}
//窗口确定
function confirmSupport(){
	var supportDataset=L5.DatasetMgr.lookup("supportDataset");
	var supportDatasetValidate = supportDataset.isValidate();
	if(supportDatasetValidate != true){
		L5.Msg.alert("提示",supportDatasetValidate);
		return false;
	}	
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilySupportCmd");
	command.setParameter("record",supportDataset.getCurrent());
	command.setParameter("assistanceType",assistanceType);
	command.setParameter("applyId",applyId);
	command.setParameter("assistanceModeValue", assistanceModeValue);
	command.execute("save");
	
	monthIncome=command.getReturn("monthIncome");
	monthAverageIncome=command.getReturn("monthAverageIncome");
	yearIncome=command.getReturn("yearIncome");
	yearAverageIncome=command.getReturn("yearAverageIncome");
	assistanceMoney=command.getReturn("assistanceMoney");
	
	var parent=window.dialogArguments;
	var familyDataSet=parent.familyDataSet;
	familyDataSet.set("monthIncome",monthIncome);
	familyDataSet.set("monthAverageIncome",monthAverageIncome);
	familyDataSet.set("yearIncome",yearIncome);
	familyDataSet.set("yearAverageIncome",yearAverageIncome);
	if(assistanceMoney != "null"){
		familyDataSet.set("assistanceMoney",assistanceMoney);
	}
	if(assistanceType == '01' || assistanceType == "02"){
		parent.countTotle();
	}
	if (!command.error) {
		//保存成功的提示信息
		saveSuccessAlert();		
	}else{
		L5.Msg.alert('提示',"出现系统异常！"+command.error);
	}
}
//保存成功的提示信息
function saveSuccessAlert(){
	//新增
	if(supportId==''||supportId=='null'){
		L5.MessageBox.confirm('提示','保存成功！是否继续添加赡（抚、扶）养义务人员信息？',function(state){
			if(state=="yes"){		
				//继续添加
				var supportDataset=L5.DatasetMgr.lookup("supportDataset");
				supportDataset.newRecord({'familyId':familyId});
			}else{
				//关闭窗口
				closeSupport();
			}
		});
	}else{//修改
		L5.Msg.alert("提示","保存成功！",function(){
			//关闭窗口
			closeSupport();
		});		
	}
}
//窗口关闭
function closeSupport(){
	window.close();
}
function checkIdCard(){
	if(_$('idCard')==''){
		L5.Msg.alert("提示","请输入身份证号");
		return;
	}
	//身份证号
	if(checkIDCard($("idCard")) != true){
		L5.Msg.alert("提示","校验未通过："+"身份证号不合法");
		return;
	}else{
		var supportDataset=L5.DatasetMgr.lookup("supportDataset");
		//回填性别
		supportDataset.set("sex",getSexByCode(_$('idCard')));
	}
}
</script>