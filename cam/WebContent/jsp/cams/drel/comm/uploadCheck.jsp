<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<%
String fileType=request.getParameter("fileType");
String title="";
if("DC".equals(fileType)){
	title="入户调查文件";
}else if("PY".equals(fileType)){
	title="民主评议文件";
}else if("GS".equals(fileType)){
	title="公示结果文件";
}
%>
<title><%=title %></title>
<next:ScriptManager/>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript">
var applyFileId = '<%=request.getParameter("applyFileId")%>' ;
var applyId = '<%=request.getParameter("applyId")%>' ;
var fileType = '<%=request.getParameter("fileType")%>' ;
var rootPath='<%=SkinUtils.getRootUrl(request)%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="checkFileDataset" cmd="com.inspur.cams.drel.sam.cmd.SamApplyFilesQueryCmd" >
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamApplyFiles">
			<model:field name="remarks" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel id="winUploadFile" width="600"  autoScroll="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="确定" handler="confirmUploadFile"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeUploadFile"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form" dataset='checkFileDataset'>
		<table width="100%" height="100%">
			<tr>
				<td class="FieldLabel" style="width:10%">上传文件</td>
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
	var checkFileDataset=L5.DatasetMgr.lookup("checkFileDataset");
	checkFileDataset.setParameter("APPLY_FILE_ID",applyFileId);
	checkFileDataset.load();
	checkFileDataset.on('load',function(ds){
		if(ds.getCount()==0){
			checkFileDataset.newRecord({'applyId':applyId,'fileType':fileType});
		}	
	});
	
	//窗口关闭的时候
	window.onbeforeunload=function(){  
		var parent=window.dialogArguments;
		if(fileType=="DC"){	
			var surveyFileDataset=parent.surveyFileDataset;
			surveyFileDataset.setParameter("APPLY_ID",applyId);
			surveyFileDataset.setParameter("FILE_TYPE","DC");
		 	surveyFileDataset.load();
	    }else if(fileType=="PY"){	
	    	var discussionFileDataset=parent.discussionFileDataset;
			discussionFileDataset.setParameter("APPLY_ID",applyId);
			discussionFileDataset.setParameter("FILE_TYPE","PY");
		 	discussionFileDataset.load();
	    }else if(fileType=="GS"){
	   	 var noticeFileDataset=parent.noticeFileDataset;
	    	noticeFileDataset.setParameter("APPLY_ID",applyId);
			noticeFileDataset.setParameter("FILE_TYPE","GS");
		 	noticeFileDataset.load();
	    }
	} 
}
//证明材料窗口确定
function confirmUploadFile(){
	var checkFileDataset=L5.DatasetMgr.lookup("checkFileDataset");
	var valid = checkFileDataset.isValidate();
	if(valid != true){
		L5.Msg.alert("提示",valid);
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
	command.setParameter("uploadRd",checkFileDataset.getCurrent());
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
	L5.MessageBox.confirm('提示','上传文件成功！是否继续上传文件？',function(state){
		if(state=="yes"){		
			//继续添加
			var checkFileDataset=L5.DatasetMgr.lookup("checkFileDataset");
			checkFileDataset.newRecord({'applyId':applyId,'fileType':fileType});
			document.getElementById('files').outerHTML=document.getElementById('files').outerHTML;
			
		}else{
			//关闭窗口
			closeUploadFile();
		}
	});
}
//窗口关闭
function closeUploadFile(){
	window.close();
}
function loadCheckFileDataset(ds){
    ds.un("load",loadCheckFileDataset);
	loadCheckFile(ds,fileType);
}
//insert页面加载刷新
function loadCheckFile(ds,fileType){
    var count=ds.getCount();
   	var fileName="";
   	var applyFileId="";
   	var fileNameHTML="";
   	var delHTML="";
    for(var i=0;i<count;i++){
    	var record=ds.getAt(i);
    	if(i>0){
    		fileName+="; ";
    		applyFileId+="; ";
    	}
    	fileName+=record.get("fileName"); 
    	applyFileId+=record.get("applyFileId");      	
    }
	var parent=window.dialogArguments;
    if(fileName && count>1){
    	fileNameHTML='<a href=# onclick="clickCheckFileList(\'' + applyId+'\',\''+fileType+'\'' + ')">' + fileName + '</a>';
    	delHTML='<a href=# onclick="clickCheckFileList(\'' + applyId+'\',\''+fileType+'\'' + ')">' + '删除' + '</a>';
    }else if(fileName && count==1){
	    var url0=rootPath+"download?table=sam_apply_files&column=file_content&pk=apply_file_id&filename=file_name&apply_file_id='"+applyFileId+"'";
    	fileNameHTML='<a id="download"  href='+url0+'>'+fileName+'</a>';
    	delHTML='<a href=# onclick="clickDelCheckFile(\'' + applyFileId + '\',\''+fileType+'\'' + ')">' + '删除' + '</a>';
    }else{
    	fileNameHTML="";
    	delHTML="";
    }
    if(fileType=="DC"){	
    	parent.$("fileName_survey").innerHTML=fileNameHTML;
    	parent.$("del_survey").innerHTML=delHTML;
    }else if(fileType=="PY"){	
    	parent.$("fileName_discussion").innerHTML=fileNameHTML;
    	parent.$("del_discussion").innerHTML=delHTML;
    }else if(fileType=="GS"){	
    	parent.$("fileName_notice").innerHTML=fileNameHTML;
    	parent.$("del_notice").innerHTML=delHTML;
    }
	window.close();
}
</script>