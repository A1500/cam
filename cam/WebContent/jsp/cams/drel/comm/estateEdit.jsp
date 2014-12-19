<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>家庭财产信息</title>
<next:ScriptManager/>
<script type="text/javascript">
var estateId = '<%=request.getParameter("estateId")%>' ;
var familyId = '<%=request.getParameter("familyId")%>' ;
</script>
</head>
<body>
<model:datasets>
	<!-- 家庭财产信息 -->
	<model:dataset id="estateDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyEstateQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamFamilyEstate">
			<model:field name="estateType" type="string" rule="require" />
			<model:field name="remarks" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 财产类型 -->
	<model:dataset id="estateTypeDataset" enumName="SAM_ESTATE_TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="" width="600"  autoScroll="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="确定" handler="confirmEstate"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeEstate"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form" dataset='estateDataset'>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%">财产类型</td>
				<td class="FieldInput" style="width: 40%">
					<select id='fileType' field="estateType" name='财产类型' style="width: 90%">
						<option dataset="estateTypeDataset"></option>
					</select><font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 10%">备注</td>
				<td class="FieldInput" style="width: 40%">
					<textarea id='remarks' field="remarks" name='备注' style="width: 90%" rows='5'></textarea>
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
	var estateDataset=L5.DatasetMgr.lookup("estateDataset");
	estateDataset.setParameter("ESTATE_ID",estateId);
	estateDataset.load();
	estateDataset.on('load',function(ds){
		if(ds.getCount()==0){
			estateDataset.newRecord({'familyId':familyId});
		}	
	});
	
    window.onbeforeunload=function(){  
		var parent=window.dialogArguments;
		var estateListDataset=parent.estateListDataset;
		estateListDataset.setParameter("FAMILY_ID",familyId);
		estateListDataset.load();
	} 
}
//窗口确定
function confirmEstate(){
	var estateDataset=L5.DatasetMgr.lookup("estateDataset");
	var estateDatasetValidate = estateDataset.isValidate();
	if(estateDatasetValidate != true){
		L5.Msg.alert("提示",estateDatasetValidate);
		return false;
	}	
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyEstateCmd");
	command.setParameter("record",estateDataset.getCurrent());
	command.execute("save");
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
	if(estateId==''||estateId=='null'){
		L5.MessageBox.confirm('提示','保存成功！是否继续添加家庭财产信息？',function(state){
			if(state=="yes"){		
				//继续添加
				var estateDataset=L5.DatasetMgr.lookup("estateDataset");
				estateDataset.newRecord({'familyId':familyId});
			}else{
				//关闭窗口
				closeEstate();
			}
		});
	}else{//修改
		L5.Msg.alert("提示","保存成功！",function(){
			//关闭窗口
			closeEstate();
		});		
	}
}
//窗口关闭
function closeEstate(){
	window.close();
}
</script>