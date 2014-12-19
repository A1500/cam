/********************************
 * 民政综合业务系统校验
 * 作者：shgtch
 * 日期：2011-5-13
 ********************************/
//根据id获取对象
function $(o){
	return document.getElementById(o);
}
//根据id获取值
function _$(o){
	return document.getElementById(o).value;
}

//社会组织变更流程中，判断是否包含某种变更，包含返回true
function checkChangeItem(itemNum){
	var somChangeList=L5.DatasetMgr.lookup("somChangeList");
	var records=somChangeList.getAllRecords();
	for(var i=0;i<records.length;i++){
		var changeItem=records[i].get('changeItem');
		if(changeItem==itemNum){
			return true;
		}
	}
	return false;
}                                                                                                                                                                   

//捕捉keyDown事件，执行传入方法，func方法名，keyCode回车事件代码（13回车）
function EnterKeyDown(func,keyCode)
 	{ 
	  if(event.keyCode==keyCode)   
	  {
	  eval(func);
	  }   
 	}  
 	
//处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外
function forbidBackSpace(e) {
    var ev = e || window.event; //获取event对象
    var obj = ev.target || ev.srcElement; //获取事件源
    var t = obj.type || obj.getAttribute('type' ); //获取事件源类型
    //获取作为判断条件的事件类型
    var vReadOnly = obj.readOnly;
    var vDisabled = obj.disabled;
    //处理undefined值情况
    vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
    vDisabled = (vDisabled == undefined) ? true : vDisabled;
    //当敲Backspace键时，事件源类型为密码或单行、多行文本的，
    //并且readOnly属性为true或disabled属性为true的，则退格键失效
    var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea" ) && (vReadOnly == true || vDisabled == true);
    //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效
    var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea" ;
    //判断
    if (flag2 || flag1) return false;
}
//禁止后退键 作用于Firefox、Opera
document.onkeypress = forbidBackSpace;
//禁止后退键  作用于IE、Chrome
document.onkeydown = forbidBackSpace;
