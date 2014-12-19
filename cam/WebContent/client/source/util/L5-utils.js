(function() {
	/**
	 * 初始化变量sameDomain
	 */
	var sameDomain = true;

	try {
		top.location.host
	} catch (e) {
		sameDomain = false;
	}
	/**
	 * 页面导向，使用方法： var param = new L5.Map(); param.put("userId","S0001");</br>
	 * L5.forward("jsp/demo/cust.jsp","客户管理",param);
	 * 
	 * @method L5.forward
	 * @param {String}
	 *            url 转向的路径
	 * @param {String}
	 *            caption 转向页面的标题
	 * @param {L5.Map}
	 *            params 转向页面需要传递的参数
	 */
	L5.forward = function(url, caption, params) {
		// 传递参数
		var str = "?";
		if (params) {
			for ( var p in params.map) {
				str += p + "=" + params.get(p) + "&";
			}
		}
		str = str.substring(0, str.lastIndexOf("&"));
		/*
		 * var node = {}; node.href = url + str; var record = new L5.Map();
		 * record.put("text",caption); record.put("url",url + str); node.record =
		 * record;
		 * 
		 * if(sameDomain&&window.parent.load != null){
		 * window.parent.load(node,L5.webPath); } else {
		 */
		window.location.href = L5.webPath + "/" + url + str;
		/* } */
	};

	/**
	 * 导出数据到CSV格式的文件
	 * 
	 * @method L5.grid2excel
	 * @param {L5.model.Dataset}
	 *            dataset dataset对象
 	 * @param {Object} gridObj grid对象
 	 * @param {String} fileName 导出文件名称
	 */
	L5.grid2excel = function(dataset, gridObj, fileName, classNamePath) {
		// 创建作为target的iframe
		var frame = document.getElementById("L5_excel_frame");
		if (!frame) {
			frame = document.createElement('iframe');
			frame.id = "L5_excel_frame";
			frame.name = "L5_excel_frame";
			frame.className = 'l-hidden';
			if (L5.isIE) {
				frame.src = L5.SSL_SECURE_URL;
			}
			document.body.appendChild(frame);
			if (L5.isIE) {// 必需的哦
				document.frames["L5_excel_frame"].name = "L5_excel_frame";
			}
		}

		// 创建form作为提交载体
		var form = document.getElementById("L5_excel_form");
		if (!form) {
			form = document.createElement('form');
			form.id = "L5_excel_form";
			form.name = "L5_excel_form";
			form.display = "none";
			form.target = "L5_excel_frame";
			form.method = 'POST';
			if(classNamePath != null) {
				form.action = L5.webPath
				+ "/command/dispatcher/" + classNamePath;
			} else {
				form.action = L5.webPath
						+ "/command/dispatcher/org.loushang.next.web.cmd.ExcelCSVCommand";
			}
			document.body.appendChild(form);

			var hd1 = document.createElement('input');
			hd1.type = 'hidden';
			hd1.name = "params";
			hd1.id = "params";
			form.appendChild(hd1);

			var hd2 = document.createElement('input');
			hd2.type = 'hidden';
			hd2.name = "command_clazz";
			hd2.id = "command_clazz";
			form.appendChild(hd2);

			var hd3 = document.createElement('input');
			hd3.type = 'hidden';
			hd3.name = "command_method";
			hd3.id = "command_method";
			form.appendChild(hd3);
			
			var headerInfo = document.createElement('input');
			headerInfo.type = 'hidden';
			headerInfo.name = "headerInfo";
			headerInfo.id = "headerInfo";
			form.appendChild(headerInfo);
			
			if(fileName != null && fileName != undefined) {
				var fileNameInfo = document.createElement('input');
				fileNameInfo.type = 'hidden';
				fileNameInfo.name = 'fileName';
				fileNameInfo.id = 'fileName';
				form.appendChild(fileNameInfo);
				//进行编码处理，防止汉字乱码问题
		        form.fileName.value = encodeURI(fileName);
			}
		}

		var map = new L5.Map("ParameterSet");
		var params = L5.apply(dataset.lastOptions.params || {},
				dataset.baseParams);

		for (name in params) {
			if (name == "start" || name == "limit") {
				continue;
			}
			map.put(name, params[name]);
		}
		form.params.value = L5.encode(map);

		if (dataset.proxy.clazz) {
			form.command_clazz.value = dataset.proxy.clazz;
		} else {
			form.command_clazz.value = "no class";
		}

		if (dataset.proxy.method) {
			form.command_method.value = dataset.proxy.method;
		} else {
			form.command_method.value = "execute";
		}
		//取得列信息并设置表头名称集
        var colModel = gridObj.getColumnModel();
        var colCount = colModel.getColumnCount();
        var headerMap = new L5.Map();
        var headers = new Array();
        var field;
        for(var j = 0 ;j<colCount;j++){
        	var columnId = colModel.getColumnId(j);
        	if(columnId == "numberer" || columnId == "checker")
        		field = columnId;
        	else
        		field = colModel.getColumnById(columnId).field;
        	headerMap.put(field, colModel.getColumnHeader(j));
        	headers[j] = field;
        }
        headerMap.put("headers", headers);
        //进行编码处理，防止汉字乱码问题
        form.headerInfo.value = encodeURI(L5.encode(headerMap));
		form.submit();
	}
	/**
	 * 按照提供的模板导出数据到Excel，示例：
	 * L5.dataset2excel("custDataset","jsp/template/cust_layout.jsp");
	 * 
	 * @method L5.dataset2excel
	 * @param {L5.model.Dataset}
	 *            dataset 要导出的数据集合
	 * @param {String}
	 *            layout 模板的路径
	 */
	L5.dataset2excel = function(dataset, layout) {
		// 创建作为target的iframe
		var frame = document.getElementById("L5_excel_frame");
		if (!frame) {
			frame = document.createElement('iframe');
			frame.id = "L5_excel_frame";
			frame.name = "L5_excel_frame";
			frame.className = 'l-hidden';
			if (L5.isIE) {
				frame.src = L5.SSL_SECURE_URL;
			}
			document.body.appendChild(frame);
			if (L5.isIE) {// 必需的哦
				document.frames["L5_excel_frame"].name = "L5_excel_frame";
			}
		}

		// 创建form作为提交载体
		var form = document.getElementById("L5_excel_form");
		if (!form) {
			form = document.createElement('form');
			form.id = "L5_excel_form";
			form.name = "L5_excel_form";
			form.display = "none";
			form.target = "L5_excel_frame";
			form.method = 'POST';
			form.action = L5.webPath
					+ "/command/dispatcher/org.loushang.next.web.cmd.Dataset2ExcelCommand";
			document.body.appendChild(form);

			var hd1 = document.createElement('input');
			hd1.type = 'hidden';
			hd1.name = "params";
			hd1.id = "params";
			form.appendChild(hd1);

			var hd2 = document.createElement('input');
			hd2.type = 'hidden';
			hd2.name = "command_clazz";
			hd2.id = "command_clazz";
			form.appendChild(hd2);

			var hd3 = document.createElement('input');
			hd3.type = 'hidden';
			hd3.name = "command_method";
			hd3.id = "command_method";
			hd3.value = "execute";
			form.appendChild(hd3);

			var hd4 = document.createElement('input');
			hd4.type = 'hidden';
			hd4.name = "excel_layout_jsp";
			hd4.id = "excel_layout_jsp";
			form.appendChild(hd4);
		}

		var map = new L5.Map("ParameterSet");
		var params = L5.apply(dataset.lastOptions.params || {},
				dataset.baseParams);

		for (name in params) {
			if (name == "start" || name == "limit") {
				continue;
			}
			map.put(name, params[name]);
		}
		form.params.value = L5.encode(map);

		if (dataset.proxy.clazz) {
			form.command_clazz.value = dataset.proxy.clazz;
		} else {
			form.command_clazz.value = "no class";
		}

		if (dataset.proxy.method) {
			form.command_method.value = dataset.proxy.method;
		} else {
			form.command_method.value = "execute";
		}

		if (layout) {
			form.excel_layout_jsp.value = layout;
		}

		form.submit();
	}
	/**
	 * 前台session对象
	 * 
	 * @class L5.session
	 */
	L5.session = {};
	/**
	 * 获得用户信息，暂不可用
	 * 
	 * @method getUserInfo
	 * @private
	 * @return {Object} 用户信息
	 */
	L5.session.getUserInfo = function() {
		if (sameDomain && top.userInfo != null)
			return top.userInfo;
		var command = new L5.Command("org.loushang.session.SessionCmd");
		// 执行命令（将上面的parameter传入后台） true是同步执行，false是异步执行。
		command.execute("getUserInfo");
		// 判断返回值，如果返回的不是true，
		if (!command.error) {
			var info = command.getReturn("userInfo");
			if (sameDomain) {
				top.userInfo = info;
			}
			return info;
		} else {
			// 如果有问题，alert出异常。
			alert("用户没有登录！");
		}
	}
	/**
	 * 获取服务器信息
	 * 
	 * @class L5.server
	 */
	L5.server = {
		executeSysCmd : function(method) {
			var command = new L5.Command(
					"org.loushang.next.common.cmd.SystemInfoCmd");
			command.execute(method);
			if (!command.error) {
				return command;
			} else {
				// 如果有问题，alert出异常。
				alert("获取服务器端信息出错！");
				return null;
			}
		}
	};
	/**
	 * 获取服务器的时间
	 * 
	 * @method L5.server.getSysDate
	 * @return {Date} 日期
	 */
	L5.server.getSysDate = function() {
		var command = this.executeSysCmd("getSysDate");
		if (command != null)
			return command.getReturn("date");
		else
			return null;
	}
	/**
	 * 打印Grid数据
	 * 
	 * @method L5.gridPrint
	 * @private
	 * @param {String}
	 *            id grid标签的id
	 * @param {String}
	 *            title grid的标题
	 */
	L5.gridPrint = function(id, title) {
		if (!id) {
			return;
		}
		if (!title) {
			title = "";
		}
		var path = encodeURI(encodeURI(L5.webPath
				+ '/jsp/public/gridPrint.jsp?id=' + id + '&title=' + title));
		window
				.open(path, 'print',
						'toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	}
	/**
	 * 设置调试模式
	 * 
	 * @method L5.setDebugger
	 * @param {boolean}
	 *            symbol 是否开启调试 true开启调试模式 false关闭调试模式
	 *            
	 */
	L5.setDebug = function(symbol) {
		var command=new L5.Command("org.loushang.next.web.cmd.LoadjsCommand"); 
		if(symbol){
			command.execute("openDebug");
		}else{
			command.execute("closeDebug");
		}
	}
	/**
	 * 获取调试模式状态
	 */
	L5.getDebug = function() {
		var command=new L5.Command("org.loushang.next.web.cmd.LoadjsCommand");
		command.execute("getDebug");
		return command.getReturn("DEBUG_MODE");
	}
})();