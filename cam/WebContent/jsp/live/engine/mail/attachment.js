
/*用于动态设置附件上传与显示
**@param tableId jsp中的附件显示表格
**@param attachDs 包含附件信息的dataset
**@property attTable 标识表格
*/
function attachTableInit(tableId , attachDs){
	var attTable = document.getElementById(tableId);
	var attDs = L5.DatasetMgr.lookup(attachDs);
	if(attDs == null || attDs.getCount() == 0){
		return;
	}else{
		for(var i=0; i<attDs.getCount(); i++){
		//使用uuid标识该行
			//动态增加行，列
			var trNode = attTable.insertRow(i);
			//trNode.className = "attachmentRow";
			var uuid = attDs.getAt(i).get("fileID");
			trNode.id = uuid; 
			
			//增加空白列靠右一点
			var blankCol = trNode.insertCell(0);
			blankCol.className = "blankCol";
			//设置隐藏域记录uuid
			var hiddenInput = document.createElement("INPUT");
			hiddenInput.type = "hidden";
			hiddenInput.value =  attDs.getAt(i).get("fileID");
			blankCol.appendChild(hiddenInput);
			
			//增加附件图标列
			var attachIconCol = trNode.insertCell(1);
			attachIconCol.className = "attachIconCol";
			
			//增加文件信息列
			var fileCol = trNode.insertCell(2);
			
			//创建一个div
			var newDiv = document.createElement("DIV");
			var fileNameSpan = document.createElement("SPAN");
			var fileName = attDs.getAt(i).get("fileName");
			fileName.className = "fileNameCol";
			var size = attDs.getAt(i).get("fileSize");
			var text = document.createTextNode(fileName +"(" + size +") ");
			//先不显示类型
			fileNameSpan.appendChild(text);
			fileCol.appendChild(newDiv);
			newDiv.appendChild(fileNameSpan);
		
			
			//增加删除链接列
			var delLink = document.createElement("a");
			delLink.className = "delLink";
			var uuid = attDs.getAt(i).get("fileID");
			text = document.createTextNode("删除");
			delLink.appendChild(text);

			//加入风格
			var href = "delAtt(\"" +  uuid +"\")"; 
			delLink.href = "javascript:"+ href;

			newDiv.appendChild(delLink);	
		}
	}
}
//当上传附件时，显示进度条
function addAttach(tableId , attinfo){
	//新增一行，使用attname标识
	var attTable = document.getElementById(tableId);
	
	var trNode = attTable.insertRow(attTable.rows.length);
	//trNode.className = "attachmentRow";
	trNode.id = attinfo.attname; 
	
	//增加空白列靠右一点
	var blankCol = trNode.insertCell(0);
	blankCol.className = "blankCol";
	
	//增加附件图标列
	var attachIconCol = trNode.insertCell(1);
	attachIconCol.className = "attachIconCol";
			
	//增加文件信息列
	var fileCol = trNode.insertCell(2);
			
	//创建一个div 使用attname + "-Container"标识
	var newDiv = document.createElement("DIV");
	newDiv.id = attinfo.attname + "-container";	
	var fileNameSpan = document.createElement("SPAN");
	//var fileName = attDs.getAt(i).get("fileName");
	fileNameSpan.className = "fileNameCol";
	var text = document.createTextNode(attinfo.filename +"("+ attinfo.size +") ");
	//先不显示类型
	fileNameSpan.appendChild(text);
	fileCol.appendChild(newDiv);
	newDiv.appendChild(fileNameSpan);
	
	//增加进度条 进度条id为attname+"-pro"
	var fileProgress = new FileProgress(attinfo.attname+"-pro" , newDiv.id);		
			
	//增加取消链接
	var delLink = document.createElement("a");
	delLink.id = attinfo.attname + "-delLink";	
	delLink.className = "delLink";
	//var uuid = attDs.getAt(i).get("fileID");
	text = document.createTextNode("取消");
	delLink.appendChild(text);

	//加入删除链接
	var href = "fdel(\"" + attinfo.fname +"\",\"" +attinfo.attname+"\")"; 
	delLink.href = "javascript:"+ href;

	newDiv.appendChild(delLink);				
}





/*用于实现进度条*/
/*FileProgress进度条对象
*@param progressId标识当前进度条
*@param targetId 标识进度条的容器
**progressContainer标识当前的进度条容器即TD
**progressBg标识当前进度条的背景容器 DIV
**progressId标识当前操作的进度条id  DIV
*/
function FileProgress(progressId , targetId){
	this.progressId = progressId;
	this.progressContainer = document.getElementById(targetId);
	this.progressBg = document.getElementById(this.progressId);
	//该进度条不存在
	if(!this.progressBg){
		//创建一个span用来做容器，提供背景
		this.progressBg = document.createElement("SPAN");
		this.progressBg.className = "progressBackground";
		this.progressBg.id = this.progressId;
		
		//创建进度条
		this.progressBar = document.createElement("DIV");
		this.progressBar.className = "progressBar";
		
		this.progressBg.appendChild(this.progressBar);
		this.progressContainer.appendChild(this.progressBg);
	}else {
		this.progressBar = this.progressBg.firstChild;
	}
	//这里可以设置初始化属性
}
//显示进度条

FileProgress.prototype.appear = function(){
	if(this.getTimer != null){
		clearTimeout(this.getTimer());
		this.setTimer(null);
	}
	this.progressBg.style.display = "inline"
}
//隐藏进度条

FileProgress.prototype.disappear = function(){
	this.progressBg.style.display = "none";	
}


/*初始化取消按钮
**@param show boolean类型标志显示还是隐藏
**@param funcname String类型函数名称
**@param args Array类型存储函数需要的参数
**@param length number类型标识args的长度（未使用）
*/
/*
FileProgress.prototype.toggleCancel = function(show , funcname , args , length){
	this.childNodes[1].style.visibility = show ? "visible" : "hidden";
	if(show && funcname != null)
	{
		var func = 'fdel("';
		//构造一个函数
		for(var i=0; i<args.length; i++)
		{
			func += args[i];
			if(i != length-1)
				func += '","';
			else
				func += '")';
		}
	}
	this.fileProgressElement.childNodes[0].href = new Function(func);
}
*/
/**设置进度条进度
**@param percent number类型小于<=100
*/
FileProgress.prototype.setProgress = function(percent){
	this.progressBar.style.width = percent + "%";	
} 
//设置定时用于进度完成时逐渐隐藏
FileProgress.prototype.setTimer = function(timer){
	this.progressBg["FP_TIMER"] = timer;
}
//获取定时
FileProgress.prototype.getTimer = function(){
	return this.progressBg["FP_TIMER"]|| null;
}

//设置完成后的处理方式
FileProgress.prototype.complete = function(interval , attInfo){
	var progress = this;
	//设置定时
	if(!interval)
		interval = 0;
	this.setTimer(setTimeout(function () {
		progress.disappear();
	}, interval));
	
	var trNode = document.getElementById(attInfo.attname);
	
	//修改删除链接的事件 找到删除的链接ctrl是进度条的下一个节点
	var delLink = document.getElementById(attInfo.attname + "-delLink");
	//兼容浏览器
	if(delLink.innerText == undefined){
		delLink.textContent = "删除"
	}else{
		delLink.innerText = "删除";
	}
	var href = "delAtt(\"" +  attInfo.uuid +"\")"; 
	delLink.href = "javascript:"+ href;
	//修改tr的id
	trNode.id = attInfo.uuid;
}

//为了方便处理加入attInfo对象
function AttInfo(fname , attname , filename , size , filetype , uuid){
	//拷贝并创建属性不判断空值
	this.fname = fname;
	this.attname = attname;
	this.filename = filename;
	this.size = size;
	this.filetype = filetype;
	this.uuid = uuid;
}
/*根据附件列表初始化
**@attDs 数据集的名称
**@tableId 显示附件列表的表格容器
*/
function initAttTable(attachDs , tableId){
	var rowIndex = 0;
	var attDs = L5.DatasetMgr.lookup(attachDs);
	if(attDs==null || attDs.getCount() == 0)
		return;
	var attTable = document.getElementById(tableId);
	if(attTable == null){
		return;
	}
	var newTr;
	var newCol;
	if(attDs.getCount() != 0 &&　attDs.getCount() != 1){
		newTr = attTable.insertRow(rowIndex);
		//增加空白列靠右一点
		newCol = newTr.insertCell(0);
		var downloadLink = document.createElement("A");
		downloadLink.href = "#";
		downloadLink.className = "downloadLink";
		text = document.createTextNode("全部下载");
		var href = new Function("getAllAtt()");
		downloadLink.onclick = href;
		downloadLink.appendChild(text);
		newCol.appendChild(downloadLink);	
		rowIndex++;		
	}
	
	//创建附件内容表格
	var newTable = document.createElement("TABLE");
	newTable.id = "attDetailTable";
	newTable.className = "attachmentTable";
	newTr = attTable.insertRow(rowIndex);
	newCol = newTr.insertCell(0);
	newCol.appendChild(newTable);
	attTable = newTable;
	
	for(var i=0; i<attDs.getCount(); i++){
		
		var newTr = attTable.insertRow(i);
		var blankCol = newTr.insertCell(0);
		blankCol.className = "blankCol";
		//设置隐藏域记录uuid
		var hiddenInput = document.createElement("INPUT");
		hiddenInput.type = "hidden";
		hiddenInput.value =  attDs.getAt(i).get("fileID");
		blankCol.appendChild(hiddenInput);
		
		//创建图标列
		var typeIconCol = newTr.insertCell(1);
		var fileType = attDs.getAt(i).get("fileType");
		typeIconCol.className = getTypeCss(fileType);
						
		//创建文件操作表格
		var fileCol = newTr.insertCell(2);
		var newTable = document.createElement("TABLE");
		fileCol.appendChild(newTable);
		
		//创建文件基本信息行
		var fileInfoTr = newTable.insertRow(0);
		fileInfoTr.className = "fileNameCol";
		var fileInfoTd = fileInfoTr.insertCell(0);
		//文件信息包含文件名与文件大小
		var fileInfo = attDs.getAt(i).get("fileName") +"(" + attDs.getAt(i).get("fileSize") + ")";
		var text = document.createTextNode(fileInfo);
		fileInfoTd.appendChild(text);
		
		//创建文件操作行
		var downloadTr = newTable.insertRow(1);
		var downloadTd = downloadTr.insertCell(0);
		//增加下载链接
		var downloadLink = document.createElement("A");
		downloadLink.className = "downloadLink";
		text = document.createTextNode("下载");
		//var href = "javascript:" + "downloadAtt(\"" + attDs.getAt(i).get("fileID") + "\")";
		var href = new Function("downloadAtt(\"" + attDs.getAt(i).get("fileID") + "\")");
		downloadLink.href =  "#";
		downloadLink.onclick = href;
		downloadLink.appendChild(text);	
		downloadTd.appendChild(downloadLink);
	}
}
//根据文件类型返回对应css
function getTypeCss(fileType){
	var fType = fileType.replace("." , "");
	var typeCss = "";
	switch(fType){
		//媒体文件
		case "mp3":
		case "wmv":
		case "rm":
		case "rmvb":
		case "mp4":
			typeCss = "att_type_media";
			break;
		//word
		case "doc":
		case "docx":
			typeCss = "att_type_doc";
			break;
		//excel
		case "xls":
		case "xlsx":
			typeCss = "att_type_xls";
			break;
		//ppt
		case "ppt":
		case "pptx":
			typeCss = "att_type_ppt";
			break;
		//pdf
		case "pdf":
			typeCss = "att_type_pdf";
			break;
		//压缩文件
		case "rar":
		case "zip":
		case "jar":
			typeCss = "att_type_rar";
			break;
		//文本文件
		case "txt":
			typeCss = "att_type_txt";
			break;
		//图片文件
		case "gif":
		case "bmp":
		case "png":
		case "jpg":
		case "jpeg":
			typeCss = "att_type_img";
			break;
		//网页文件
		case "html":
		case "htm":
			typeCss = "att_type_htm";
			break;
		default:
			typeCss = "att_type_unkown";
			break;		
	}
	return typeCss;
}
//获得所有附件的uuid
function getAllAtt(){
	var dTable = document.getElementById("attDetailTable");
	var uuids = "";
	for(var i=0; i<dTable.rows.length; i++){
		uuids += dTable.rows[i].cells[0].firstChild.value; 
		if(i+1 != dTable.rows.length)
			uuids += ",";
	}
	//这里已经获得了所有的uuid
	downloadByUuids(uuids);
}