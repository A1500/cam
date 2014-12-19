/*
 * 函数名称：function  doMofFormKeyDown()
 * 函数功能：回车到下一个域
 * 参    数：
 * 说    明:
 * 作    者：
 * 时    间：
 */
function doMofFormKeyDown() {
	if (window.event.keyCode == 13) {
		if(window.event.srcElement.tagName == "TEXTAREA"){
			if(window.event.ctrlKey){
				window.event.srcElement.innerText+="\n";
				window.event.keyCode=40;
			}else{
				window.event.keyCode = 9;
			}
		}
		if(window.event.srcElement.tagName=="INPUT"||window.event.srcElement.tagName=="SELECT"||
			window.event.srcElement.tagName == "BUTTON"){
			if (window.event.srcElement.type=="file"){
				;
			}else{
				window.event.keyCode = 9;
			}
		}
	}
}
/*
 * 函数名称：function  doMofFormKeyDown()
 * 函数功能：判断输入域的长度（支持中英混合）
 * 参    数：
 * 说    明:
 * 作    者：
 * 时    间：
 */
   function strLen(s)
{
    var i,str1,str2,str3,nLen;
    str1 = s.value;
    nLen = 0;
    for(i=1;i<=str1.length;i++)
    {
          str2=str1.substring(i-1,i)
          str3=escape(str2);
          if(str3.length>3)
          {
               nLen = nLen + 2;
          }
          else
          {
               nLen = nLen + 1;
          }
     }
     return nLen;
} 
//根据id获取对象
function $(o){
	return document.getElementById(o);
}
//根据id获取值
function _$(o){
	return document.getElementById(o).value;
}
   