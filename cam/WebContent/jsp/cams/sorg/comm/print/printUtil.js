function Chinese(Num) { 
	/*
	if(!/^\d*(\.\d*)?$/.test(num)) 
	{ 
		alert("你输入的不是数字，请重新输入!"); 
		return false; 
	} 
	if(num==0){
		return "零";
	}
	*/
	/*var AA = new Array("零","壹","贰","叁","肆","伍","陆","柒","捌","玖"); 
	var BB = new Array("","拾","佰","仟","万","亿","点",""); 
	var a = (""+ num).replace(/(^0*)/g, "").split("."), k = 0, re = ""; 
	for(var i=a[0].length-1; i>=0; i--) { 
		switch(k) { 
			case 0 : 
				re = BB[7] + re; 
				break; 
			case 4 : 
				if(!new RegExp("0{4}\\d{"+ (a[0].length-i-1) +"}$").test(a[0])) 
				re = BB[4] + re; 
				break; 
			case 8 : 
				re = BB[5] + re; 
				BB[7] = BB[5]; 
				k = 0; 
				break; 
		} 
		if(k%4 == 2 && a[0].charAt(i)=="0" && a[0].charAt(i+2) != "0") re = AA[0] + re; 
		if(a[0].charAt(i) != 0) re = AA[a[0].charAt(i)] + BB[k%4] + re; 
		k++; 
	} 
	if(a.length>1) { 
		re += BB[6]; 
		for(var i=0; i<a[1].length; i++) re += AA[a[1].charAt(i)]; 
	} 
	return re;*/ 
	
	for(i=Num.length-1;i>=0;i--){
		 Num = Num.replace(",","")//替换tomoney()中的“,”
		 Num = Num.replace(" ","")//替换tomoney()中的空格
	}
 	//Num = Num.replace("￥","")//替换掉可能出现的￥字符
	if(isNaN(Num)) { //验证输入的字符是否为数字
		 alert("请检查小写金额是否正确");
		 return;
	}
 	//---字符处理完毕，开始转换，转换采用前后两部分分别转换---//
	part = String(Num).split(".");
	newchar = ""; 
	//小数点前进行转化
	for(i=part[0].length-1;i>=0;i--){
		if(part[0].length > 10){ 
			alert("位数过大，无法计算");return "";
		}//若数量超过拾亿单位，提示
		tmpnewchar = ""
		perchar = part[0].charAt(i);
		switch(perchar){
			case "0": tmpnewchar="零" + tmpnewchar ;break;
			case "1": tmpnewchar="壹" + tmpnewchar ;break;
			case "2": tmpnewchar="贰" + tmpnewchar ;break;
			case "3": tmpnewchar="叁" + tmpnewchar ;break;
			case "4": tmpnewchar="肆" + tmpnewchar ;break;
			case "5": tmpnewchar="伍" + tmpnewchar ;break;
			case "6": tmpnewchar="陆" + tmpnewchar ;break;
			case "7": tmpnewchar="柒" + tmpnewchar ;break;
			case "8": tmpnewchar="捌" + tmpnewchar ;break;
			case "9": tmpnewchar="玖" + tmpnewchar ;break;
		}
		switch(part[0].length-i-1){
		    case 0: tmpnewchar = tmpnewchar +"元" ;break;
		    case 1: if(perchar!=0)tmpnewchar= tmpnewchar +"拾" ;break;
		    case 2: if(perchar!=0)tmpnewchar= tmpnewchar +"佰" ;break;
		    case 3: if(perchar!=0)tmpnewchar= tmpnewchar +"仟" ;break;
		    case 4: tmpnewchar= tmpnewchar +"万" ;break;
		    case 5: if(perchar!=0)tmpnewchar= tmpnewchar +"拾" ;break;
		    case 6: if(perchar!=0)tmpnewchar= tmpnewchar +"佰" ;break;
		    case 7: if(perchar!=0)tmpnewchar= tmpnewchar +"仟" ;break;
		    case 8: tmpnewchar= tmpnewchar +"亿" ;break;
		    case 9: tmpnewchar= tmpnewchar +"拾" ;break;
  		}
  		newchar = tmpnewchar + newchar;
	}
	//小数点之后进行转化
	// if(Num.indexOf(".")!=-1){
	if(part.length==2){
		if(part[1].length > 2) {
			//alert("小数点之后只能保留两位,系统将自动截段");
			part[1] = part[1].substr(0,2)
		}
		for(i=0;i<part[1].length;i++){
			tmpnewchar = ""
			perchar = part[1].charAt(i)
			switch(perchar){
				case "0": tmpnewchar="零" + tmpnewchar ;break;
				case "1": tmpnewchar="壹" + tmpnewchar ;break;
				case "2": tmpnewchar="贰" + tmpnewchar ;break;
				case "3": tmpnewchar="叁" + tmpnewchar ;break;
				case "4": tmpnewchar="肆" + tmpnewchar ;break;
				case "5": tmpnewchar="伍" + tmpnewchar ;break;
				case "6": tmpnewchar="陆" + tmpnewchar ;break;
				case "7": tmpnewchar="柒" + tmpnewchar ;break;
				case "8": tmpnewchar="捌" + tmpnewchar ;break;
				case "9": tmpnewchar="玖" + tmpnewchar ;break;
			}
			if(i==0)tmpnewchar =tmpnewchar + "角";
			if(i==1)tmpnewchar = tmpnewchar + "分";
	  		newchar = newchar + tmpnewchar;
		}
	}
 	//替换所有无用汉字
	while(newchar.search("零零") != -1)
		newchar = newchar.replace("零零", "零");
		newchar = newchar.replace("零亿", "亿");
		newchar = newchar.replace("亿万", "亿");
		newchar = newchar.replace("零万", "万");
		newchar = newchar.replace("零元", "元");
		newchar = newchar.replace("零角", "");
		newchar = newchar.replace("零分", "");
	
	//if (newchar.charAt(newchar.length-1) == "元" || newchar.charAt(newchar.length-1) == "角"){
	//	newchar = newchar+"整";
	//}
	return newchar;
} 