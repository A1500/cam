<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>申请证明材料</title>
<next:ScriptManager/>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript">
var applyFileId = '<%=request.getParameter("applyFileId")%>' ;
var applyId = '<%=request.getParameter("applyId")%>' ;
</script>
</head>
<body>
<model:datasets>
	<!-- 申请材料 -->
	<model:dataset id="filesDataset" cmd="com.inspur.cams.prs.prsproblemdeal.cmd.PrsProblemDealQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
			<model:field name="fileType" type="string" rule="require" />
			<model:field name="remarks" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 申请证明材料 -->
	<model:dataset id="fileTypeDataset" enumName="SAM_FILE_NAME" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel id="winUploadFile" title="" width="600"  autoScroll="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="确定" handler="confirmUploadFile"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeUploadFile"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form" dataset='filesDataset'>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 10%">上传文件名称</td>
				<td class="FieldInput" style="width: 30%">
					<select id='fileType' field="fileType" name='证明材料名称' style="width: 97%">
						<option dataset="fileTypeDataset"></option>
					</select><label style='color:red'>*</label>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:10%">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="files" name="files" style="width:97%"/></td>
    		</tr>
			<tr>
				<td class="FieldLabel" style="width: 10%">备注</td>
				<td class="FieldInput" style="width: 30%">
					<textarea id='remarks' field="remarks" name='备注' style="width: 97%" rows='3'></textarea>
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
	var filesDataset=L5.DatasetMgr.lookup("filesDataset");
	filesDataset.setParameter("APPLY_FILE_ID",applyFileId);
	filesDataset.load();
	filesDataset.on('load',function(ds){
		if(ds.getCount()==0){
			filesDataset.newRecord({'applyId':applyId});
		}	
	});
	 window.onbeforeunload=function(){  
		var parent=window.dialogArguments;
		var filesListDataset=parent.filesListDataset;
		filesListDataset.setParameter("APPLY_ID",applyId);
	    filesListDataset.setParameter("FILE_TYPE@IN","101,102,201,202,203,204,205,206,207,208,209,210,301,001,000");
		filesListDataset.load();
	} 
}
//证明材料窗口确定
function confirmUploadFile(){
	var filesDataset=L5.DatasetMgr.lookup("filesDataset");
	var filesDatasetValidate = filesDataset.isValidate();
	if(filesDatasetValidate != true){
		L5.Msg.alert("提示",filesDatasetValidate);
		return false;
	}	
	if(_$("files")=="" || _$("files")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.drel.sam.cmd.SamApplyFilesCmd");
	command.setParameter("uploadRd",filesDataset.getCurrent());
	command.setForm("form_content");
	command.execute("saveUpload");
	
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			//上传成功的提示信息
		saveSuccessAlert();	
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
//上传成功的提示信息
function saveSuccessAlert(){
	L5.MessageBox.confirm('提示','上传附件成功！是否继续上传申请证明材料？',function(state){
		if(state=="yes"){		
			//继续添加
			var filesDataset=L5.DatasetMgr.lookup("filesDataset");
			filesDataset.newRecord({'applyId':applyId});
			document.getElementById('files').outerHTML=document.getElementById('files').outerHTML;
			
		}else{
			//关闭窗口
			closeUploadFile();
		}
	});
}
//证明材料窗口关闭
function closeUploadFile(){
	window.close();
}
</script>