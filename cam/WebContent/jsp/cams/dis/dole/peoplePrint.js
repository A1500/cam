var webObj;
var activeDocument;
var marksNames;
var totalMoney=0;
/**
本方法 以实例的方式，约定说明模板、标签和数据的格式
**/
function init(){
	//取得文件名 和标签    
	var nowFileName = "peoplePrint.doc";
	//marksNames = "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号 
	//打开文件
	webObj = document.getElementById("webOfficeNt");
	webObj.Titlebar = false;
	webObj.OpenFromURL(nowFileName);   
	activeDocument = webObj.activeDocument;
	activeDocument.Application.ActiveWindow.View.ShowBookmarks = true;
}

function writeDoc(mp){
	//遍历map的值
	for(var key in mp.map){
		//var getMapMark = mp.get(key);
		//分割标签
		var marks=marksNames.split("&");
		//遍历所有标签
		for(var i=0;i<marks.length;i++){
			//分离标签和标记
			var marksStr = marks[i].split("__");
			//标签和预含义标签相等的场合
			if(marksStr[0]==key){
				//获取标签值
	  			var bkmkObj = activeDocument.Bookmarks(marks[i]);
				//向模板中写数据
				if(bkmkObj){
					var inputValue = mp.get(key);						
					var saverange = bkmkObj.Range;
					saverange.Text = inputValue;
					//saverange.InsertBefore(""); //之前写内容
					//saverange.InsertAfter("");  //之后写内容
				}		  			
		    }
		}
	}
}
/**
获得 模板中的标签并组成串 "name1__1&code1__1";  标签定义格式 字段代码 + __ + 序号 
*/        
function getMarks(){

	marksNames = "";
	var count = activeDocument.Bookmarks.Count;
	for(var i=1;i<=count;i++){
		if(i<count){
			marksNames = marksNames + activeDocument.Bookmarks(i).Name + "&";
		}
		else{
			marksNames = marksNames + activeDocument.Bookmarks(i).Name;
		}
	}
	//alert(marksNames);
}

function  returnButton(){
	webObj = document.getElementById("webOfficeNt");
	webObj.close();
	//window.close();  //如果本界面为独立窗口显示，可放开这个注释
}
/**
打印（参数可以控制是前台打印还是后台打印）
*/
function printdoc(isBackground){
	var oldOption;	
	try{
		var objOptions =  activeDocument.Application.Options;
		oldOption = objOptions.PrintBackground;
		objOptions.PrintBackground = isBackground;
	}
	catch(err){};
	webObj.printout(true);
	try{
		var objOptions =  activeDocument.Application.Options;
		objOptions.PrintBackground = oldOption;
	}
	catch(err){};	
}