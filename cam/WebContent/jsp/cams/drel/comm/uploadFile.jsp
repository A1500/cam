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
	<model:dataset id="filesDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" >
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
				<td class="FieldLabel" style="width: 10%">证明材料名称</td>
				<td class="FieldInput" style="width: 30%">
					<select id='fileType' field="fileType" name='证明材料名称' style="width: 97%">
						<option dataset="fileTypeDataset"></option>
					</select><label style='color:red'>*</label>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:10%">附件上传：</td>
				<td class="FieldInput" ><input class="file" type="file" id="files" name="files" style="width:97%"/></td>
    		</tr>
			<tr>
				<td class="FieldLabel" style="width: 10%">备注</td>
				<td class="FieldInput" style="width: 30%">
					<textarea id='remarks' field="remarks" name='备注' style="width: 97%" rows='3'></textarea>
				</td>
			</tr>	
			<tr>
				<td class="FieldLabel" style="width: 10%;text-align:center;" colspan="2"><font color="red">注意：上传附件的大小限制为1M！</font></td>
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
	
	try{
		var isIE = /msie/i.test(navigator.userAgent) && !window.opera;   
		var fileSize = 0;   
		var target=document.getElementById('files');       
	    if (isIE && !target.files) {      
	      var filePath = target.value;      
	      var fileSystem = new ActiveXObject("Scripting.FileSystemObject");         
	      var file = fileSystem.GetFile (filePath);      
	      fileSize = file.Size;   
	    } else {     
	     	fileSize = target.files[0].size;      
	    } 
	    var size = fileSize / 1024;     
	    if(size>1000){   
	    	 L5.Msg.alert("提示","附件不能大于1M！");
	    	 return;
	    } 
	}catch(e){
	 if(e.description=="Automation服务器不能创建对象"){
       alert("文件大小验证未生效！\r\n启用此验证，请如下修改浏览器设置：工具->Internet选项->安全->本地Intranet->自定义级别->ActiveX控件和插件->对没有标记为安全的ActiveX控件进行初始化和脚本运行->启用！");
     //  formname.submit();
      }else{
       //alert(e.description);
       //可能出现“拒绝访问”异常，刷新后又无此异常
       window.location.reload();
      }
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