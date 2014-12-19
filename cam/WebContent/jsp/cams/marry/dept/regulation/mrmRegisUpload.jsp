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
var deptCode=<%=request.getParameter("deptCode")%>;
</script>
</head>
<body>
<model:datasets>
	<!-- 申请材料 -->
	<model:dataset id="ds" cmd="com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoQueryCommand" >
		<model:record fromBean="com.inspur.cams.marry.base.data.MrmRegisOrganInfo"></model:record>
	</model:dataset>
	<!-- 申请证明材料 -->
	<!--<model:dataset id="fileTypeDataset" enumName="SAM_FILE_NAME" autoLoad="true" global="true"></model:dataset>-->
</model:datasets>
<next:Panel id="winUploadFile" title="" width="600"  autoScroll="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="确定" handler="confirmUploadFile"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeUploadFile"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form id="form_content" method="post" onsubmit="return false" class="L5form" dataset='ds'>
		<table width="100%">
				<td class="FieldLabel" style="width:10%">附件上传：</td>
				<td class="FieldInput" ><input class="file" type="file" id="files" name="files" style="width:97%"/></td>
			<tr>
				<td class="FieldLabel" style="width: 10%;text-align:center;" colspan="2"><font color="red">注意：上传附件的格式限制为word！大小限制为5M！</font></td>
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
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("dept_Code",deptCode);
	ds.load();
}
//证明材料窗口确定
function confirmUploadFile(){
	var ds=L5.DatasetMgr.lookup("ds");
	var target=document.getElementById('files'); 
	var filePath = target.value;      
    var fileSystem = new ActiveXObject("Scripting.FileSystemObject");         
    var file = fileSystem.GetFile (filePath);
    var exname=fileSystem.GetExtensionName(filePath);
	/*
	var dsValidate = ds.isValidate();
	if(dsValidate != true){
		L5.Msg.alert("提示",dsValidate);
		return false;
	}
	*/	
	if(_$("files")=="" || _$("files")==null){
		L5.Msg.alert('提示',"上传文件不能为空!");
		return false;
	}
     if(String(exname)!="doc"&&String(exname)!="docx"){
    	L5.Msg.alert('提示',"请上传word格式文档");
        return false;
     }
	try{
		var isIE = /msie/i.test(navigator.userAgent) && !window.opera;   
		var fileSize = 0;         
	    if (isIE && !target.files) {      
	      fileSize = file.Size;   
	    } else {     
	     	fileSize = target.files[0].size;      
	    } 
	    var size = fileSize / 1024;     
	    if(size>5000){   
	    	 L5.Msg.alert("提示","附件不能大于5M！");
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
	var command = new L5.Command("com.inspur.cams.marry.base.cmd.MrmRegisOrganInfoCommand");
	command.setParameter("uploadRd",ds.getCurrent());
	command.setForm("form_content");
	command.execute("saveUpload");
	
	//包含有大字段的异常判断
	command.afterExecute=function(){
		if(!command.error){
			//上传成功的提示信息
		L5.MessageBox.alert('提示','上传附件成功！');
		closeUploadFile();
		}
		else{
	        L5.Msg.alert("提示",(''+command.error).replace("出现系统异常",""),{});
        }
	}
}
//证明材料窗口关闭
function closeUploadFile(){
	window.returnValue="w";
	window.close();
}
</script>