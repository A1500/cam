<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>家庭房产信息</title>
<next:ScriptManager/>
<script type="text/javascript">
var houseId = '<%=request.getParameter("houseId")%>' ;
var familyId = '<%=request.getParameter("familyId")%>' ;
</script>
</head>
<body>
<model:datasets>
	<!-- 家庭房产信息 -->
	<model:dataset id="houseDataset" cmd="com.inspur.cams.drel.sam.cmd.SamFamilyHouseQueryCmd" >
		<model:record fromBean="com.inspur.sdmz.jtxx.data.SamFamilyHouse">
		    <model:field name="propertyOwner" type="string" rule="require" />
			<model:field name="houseQuality" type="string" rule="require" />
			<model:field name="propertyCertificate" type="string" rule="length{50}" />
			<model:field name="houseAdd" type="string" rule="length{100}" />
			<model:field name="buildArea" type="string" rule="regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}" />
			<model:field name="useArea" type="string" rule="regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}" />
		</model:record>
	</model:dataset>
	<!-- 住房类型 -->
	 <model:dataset id="houseQualityDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_QUALITY'></model:param>
		</model:params>
	</model:dataset>
	<!-- 房屋所有人-->
    <model:dataset id="houseOwnerDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" >
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dic" value='BASEINFO_PEOPLE'></model:param>
            <model:param name="value" value='PEOPLE_ID'></model:param>
            <model:param name="text" value='NAME'></model:param>
        </model:params>
    </model:dataset>
</model:datasets>
<next:Panel title="" width="800"  autoScroll="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="确定" handler="confirmHouse"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeHouse"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form" dataset='houseDataset'>
		<table width="100%">
			<tr>
			    <td class="FieldLabel" style="width: 20%">所有权人</td>
                <td class="FieldInput" style="width: 30%">
                    <select field="propertyOwner"  name='所有权人' style="width: 90%" >
                        <option dataset='houseOwnerDataSet'></option>
                    </select><font color="red">*</font>
                </td>
				<td class="FieldLabel" style="width: 20%">住房性质</td>
				<td class="FieldInput" style="width: 30%">
					<select field="houseQuality" name='住房性质' style="width: 90%">
						<option dataset="houseQualityDataset"></option>
					</select><font color="red">*</font>
				</td>
			</tr>
			<tr>
                <td class="FieldLabel" style="width: 20%">房产（建房）证号</td>
                <td class="FieldInput" style="width: 30%"><input type='text' field="propertyCertificate" maxlength="50" name='房产（建房）证号' style="width: 90%" /></td>
				<td class="FieldLabel" style="width: 20%">住房地址</td>
				<td class="FieldInput" colspan='3'><input type='text' field="houseAdd" maxlength="100" name='住房地址' style="width: 90%" /></td>
			</tr>				
			<tr>
				<td class="FieldLabel" style="width: 20%">建筑面积（㎡）</td>
				<td class="FieldInput" style="width: 30%"><input type='text' field="buildArea" maxlength="14" name='建筑面积' style="width: 90%" /></td>
				<td class="FieldLabel" style="width: 20%">使用面积（㎡）</td>
				<td class="FieldInput" style="width: 30%"><input type='text' field="useArea" maxlength="14" name='使用面积' style="width: 90%" /></td>
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
	var houseDataset=L5.DatasetMgr.lookup("houseDataset");
	houseDataset.setParameter("HOUSE_ID",houseId);
	houseDataset.load();
	houseDataset.on('load',function(ds){
		if(ds.getCount()==0){
			houseDataset.newRecord({'familyId':familyId});
		}	
	});
	//过滤掉房屋类型的 自有和租赁
	houseQualityDataset.filterBy(function(record, id){
		if(record.get('value') != '100' && record.get('value') != '200'){
			return record;
		}
	});
	//加载产权所有人
    var houseOwnerDataSet = L5.DatasetMgr.lookup("houseOwnerDataSet");
    houseOwnerDataSet.setParameter("filterSql", "FAMILY_ID='" + familyId + "'");
    houseOwnerDataSet.load();
  
  
    window.onbeforeunload=function(){  
		var parent=window.dialogArguments;
		var houseListDataset=parent.houseListDataset;
		houseListDataset.setParameter("FAMILY_ID",familyId);
		houseListDataset.load();
	} 
}
//窗口确定
function confirmHouse(){
	var houseDataset=L5.DatasetMgr.lookup("houseDataset");
	var houseDatasetValidate = houseDataset.isValidate();
	if(houseDatasetValidate != true){
		L5.Msg.alert("提示",houseDatasetValidate);
		return false;
	}	
	var useArea=houseDataset.get('useArea');
	var buildArea=houseDataset.get('buildArea');
	if(useArea!='' && buildArea!='' && parseFloat(useArea)>=parseFloat(buildArea)){
		L5.Msg.alert("提示",'校验不通过："使用面积"不得大于"建筑面积"!');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamFamilyHouseCmd");
	command.setParameter("record",houseDataset.getCurrent());
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
	if(houseId==''||houseId=='null'){
		L5.MessageBox.confirm('提示','保存成功！是否继续添加家庭房产信息？',function(state){
			if(state=="yes"){		
				//继续添加
				var houseDataset=L5.DatasetMgr.lookup("houseDataset");
				houseDataset.newRecord({'familyId':familyId});
			}else{
				//关闭窗口
				closeHouse();
			}
		});
	}else{//修改
		L5.Msg.alert("提示","保存成功！",function(){
			//关闭窗口
			closeHouse();
		});		
	}
}
//窗口关闭
function closeHouse(){
	window.close();
}
</script>