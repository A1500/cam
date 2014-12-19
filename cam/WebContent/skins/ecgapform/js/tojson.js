/**  
* json数组读写有两种方式  
* 1: a.bs[0].id  
* 2: a["bs"][0]["id"]  
* 把表单转换成json数据格式  
*/
function formToJsonObject(form) {
	var jsonObject = new L5.Map();
	for (i = 0, max = form.elements.length; i < max; i++) {
		e = form.elements[i];
		em = new Array();
		if (e.type == 'select-multiple') {
			for (j = 0; j < e.options.length; j++) {
				op = e.options[j];
				if (op.selected) {
					em[em.length] = op.value;
				}
			}
		}
		switch (e.type) {
			case 'radio' :
				if (!e.checked) {
					break;
				}
			case 'hidden' :
			case 'password' :
			case 'select-one' :
			case 'select-multiple' :
			case 'textarea' :
			case 'text' :
			case 'checkbox' :
				eName = e.name;
				if (e.type == 'select-multiple') {
					eValue = em.join(",");
				} else if(e.type == 'checkbox'&&!e.checked){
					eValue="";
				} else{
					eValue = e.value.replace(new RegExp('(["\\\\])', 'g'),'\\$1');
				}
				//处理动态行;动态行容器中不会出现多值,所以分割符不会混乱,如果增加了增加了动态行容器中支持多值的情形,需要修改本方法
				valueStr=jsonObject.get(eName);
				if(typeof valueStr=='undefined'){
					valueStr=eValue;
				}else{
					valueStr+=",";
					valueStr+=eValue;
				}
				jsonObject.put(eName,valueStr)
				break;
			case 'button' :
			case 'file' :
			case 'image' :
			case 'reset' :
			case 'submit' :
			default :
		}
	}
	return jsonObject;
}
