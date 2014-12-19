/**
 * 处理消息框的静态类。 注意：消息框是异步的，不像JavaScript的<code>alert</code>一样可以是浏览器停止，使用消息框不能让代码停止运行。因此如果
 *              想让某些代码在消息框反馈信息后运行，需要将该部分代码写到一个回调函数里面。
 * 示例： L5.Msg.alert('Status','Changes saved successfully.');
 * L5.Msg.prompt('Name', 'Please enter your name:', function(btn, text){ 
 * 		if (btn =='ok'){
 *  		// process text value and close... 
 *  	}
 *	});
 * @class L5.MessageBox
 * @singleton
 * @constructor 
 */
L5.MessageBox = function() {
	var dlg, opt, mask, waitTimer;
	var bodyEl, msgEl, textboxEl, textareaEl, progressBar, pp, iconEl, spacerEl;
	var buttons, activeTextEl, bwidth, iconCls = '';

	/**
	 * @private
	 */
	var handleButton = function(button) {
		if (dlg.isVisible()) {
			dlg.hide();
			L5.callback(opt.fn, opt.scope || window, [ button,
					activeTextEl.dom.value, opt ], 1);
		}
	};

	/**
	 * @private
	 */
	var handleHide = function() {
		if (opt && opt.cls) {
			dlg.el.removeClass(opt.cls);
		}
		progressBar.reset();
	};

	/**
	 * @private
	 */
	var handleEsc = function(d, k, e) {
		if (opt && opt.closable !== false) {
			dlg.hide();
		}
		if (e) {
			e.stopEvent();
		}
	};

	/**
	 * @private
	 */
	var updateButtons = function(b) {
		var width = 0;
		if (!b) {
			buttons["ok"].hide();
			buttons["cancel"].hide();
			buttons["yes"].hide();
			buttons["no"].hide();
			return width;
		}
		dlg.footer.dom.style.display = '';
		for ( var k in buttons) {
			if (typeof buttons[k] != "function") {
				if (b[k]) {
					buttons[k].show();
					buttons[k].setText(typeof b[k] == "string" ? b[k]
							: L5.MessageBox.buttonText[k]);
					width += buttons[k].el.getWidth() + 15;
				} else {
					buttons[k].hide();
				}
			}
		}
		return width;
	};

	return {
		/**
		 * 获取一个{@link L5.Window} 对象
		 * @ignore
		 * @return {L5.Window} 返回一个{@link L5.Window}窗口
		 */
		getDialog : function(titleText) {
			if (!dlg) {
				dlg = new L5.Window( {
					autoCreate : true,
					title : titleText,
					resizable : false,
					constrain : true,
					constrainHeader : true,
					minimizable : false,
					maximizable : false,
					stateful : false,
					modal : true,
					shim : true,
					buttonAlign : "center",
					width : 400,
					height : 100,
					minHeight : 80,
					plain : true,
					footer : true,
					closable : true,
					close : function() {
						if (opt && opt.buttons && opt.buttons.no
								&& !opt.buttons.cancel) {
							handleButton("no");
						} else {
							handleButton("cancel");
						}
					}
				});
				buttons = {};
				var bt = this.buttonText;
				//TODO: refactor this block into a buttons config to pass into the Window constructor
				buttons["ok"] = dlg.addButton(bt["ok"], handleButton
						.createCallback("ok"));
				buttons["yes"] = dlg.addButton(bt["yes"], handleButton
						.createCallback("yes"));
				buttons["no"] = dlg.addButton(bt["no"], handleButton
						.createCallback("no"));
				buttons["cancel"] = dlg.addButton(bt["cancel"], handleButton
						.createCallback("cancel"));
				buttons["ok"].hideMode = buttons["yes"].hideMode = buttons["no"].hideMode = buttons["cancel"].hideMode = 'offsets';
				dlg.render(document.body);
				dlg.getEl().addClass('l-window-dlg');
				mask = dlg.mask;
				bodyEl = dlg.body
						.createChild( {
							html : '<div class="L5-mb-icon"></div><div class="L5-mb-content"><span class="L5-mb-text"></span><br /><div class="L5-mb-fix-cursor"><input type="text" class="L5-mb-input" /><textarea class="L5-mb-textarea"></textarea></div></div>'
						});
				iconEl = L5.get(bodyEl.dom.firstChild);
				var contentEl = bodyEl.dom.childNodes[1];
				msgEl = L5.get(contentEl.firstChild);
				textboxEl = L5.get(contentEl.childNodes[2].firstChild);
				textboxEl.enableDisplayMode();
				textboxEl.addKeyListener( [ 10, 13 ], function() {
					if (dlg.isVisible() && opt && opt.buttons) {
						if (opt.buttons.ok) {
							handleButton("ok");
						} else if (opt.buttons.yes) {
							handleButton("yes");
						}
					}
				});
				textareaEl = L5.get(contentEl.childNodes[2].childNodes[1]);
				textareaEl.enableDisplayMode();
				progressBar = new L5.ProgressBar( {
					renderTo : bodyEl
				});
				bodyEl.createChild( {
					cls : 'l-clear'
				});
			}
			return dlg;
		},

		/**
		 * 更新消息框的文本
		 * @private
		 * @param {String} text (可选) 更新消息框的文本信息
		 * @return {L5.MessageBox} this
		 */
		updateText : function(text) {
			if (text && text.replace) {
				text = text.replace(/\n/g, "<br>");
				if ((text.lastIndexOf("<br>") + 4) == text.length) {
					text = text.substring(0, text.lastIndexOf("<br>"));
				}
			}
			if (!dlg.isVisible() && !opt.width) {
				dlg.setSize(this.maxWidth, 100); // resize first so content is never clipped from previous shows
			}
			msgEl.update(text || '&#160;');

			var iw = iconCls != '' ? (iconEl.getWidth() + iconEl
					.getMargins('lr')) : 0;
			var mw = msgEl.getWidth() + msgEl.getMargins('lr');
			var fw = dlg.getFrameWidth('lr');
			var bw = dlg.body.getFrameWidth('lr');
			if (L5.isIE && iw > 0) {
				//3 pixels get subtracted in the icon CSS for an IE margin issue,
				//so we have to add it back here for the overall width to be consistent
				iw += 3;
			}
			var w = Math.max(Math.min(opt.width || iw + mw + fw + bw,
					this.maxWidth), Math.max(opt.minWidth || this.minWidth,
					bwidth || 0));

			if (opt.prompt === true) {
				activeTextEl.setWidth(w - iw - fw - bw);
			}
			if (opt.progress === true || opt.wait === true) {
				progressBar.setSize(w - iw - fw - bw);
			}
			if (L5.isIE && w == bwidth) {
				w += 4; //Add offset when the content width is smaller than the buttons.    
			}
			dlg.setSize(w, 'auto').center();
			return this;
		},

		/**
		 * 更新进度条弹出框的显示文本和进度条。仅当弹出框是{@link L5.MessageBox#progress} ， {@link L5.MessageBox#wait},
		 * 或者{@link L5.MessageBox#show} 的配置项 progress: true有效。
		 * @param {Number} value 0到1之间的任意数字（默认是0）
		 * @param {String} progressText (可选)在进度条上显示的文本 (默认是 '')
		 * @param {String} msg (可选)在弹出框显示的文本 (默认是 '')
		 * @return {L5.MessageBox} this
		 */
		updateProgress : function(value, progressText, msg) {
			if(value||value==0){
				progressBar.updateProgress(value);
			}
			if(progressText)
				progressBar.updateText(progressText);
			if (msg) {
				this.updateText(msg);
			}
			return this;
		},

		/**
		 * 消息框是否可见
		 * @return {Boolean} True 假如消息框是可见状态返回true
		 */
		isVisible : function() {
			return dlg && dlg.isVisible();
		},

		/**
		 * 隐藏消息框
		 * @return {L5.MessageBox} this
		 */
		hide : function() {
			var proxy = dlg.activeGhost;
			if (this.isVisible() || proxy) {
				dlg.hide();
				handleHide();
				if (proxy) {
					proxy.hide();
				}
			}
			return this;
		},

		/**
		 * 显示一个消息框，如果还不存在消息框就根据配置项新建一个。所有类型的弹出框都是调用这个方法显示的，也是用的同一个对象。
		 * @param {Object} config 配置对象，支持如下参数: <ul>
		 * <li><b>animEl</b> : String/Element<div class="sub-desc">一个元素或者元素的id，当消息框展现或者隐藏的时候会向该元素展示动画效果（默认没有动画效果)</div></li>
		 * <li><b>buttons</b> : Object/Boolean<div class="sub-desc">一个按钮配置对象 (e.g., L5.Msg.OKCANCEL or {ok:'Foo',
		 * cancel:'Bar'}), 如果是false不显示任何的按钮（默认是false）</div></li>
		 * <li><b>closable</b> : Boolean<div class="sub-desc">是否可关闭 (defaults to true). .</div></li>
		 * <li><b>cls</b> : String<div class="sub-desc">为消息框自定义CSS</div></li>
		 * <li><b>defaultTextHeight</b> : Number<div class="sub-desc">默认的弹出框高度(默认是 75)</div></li>
		 * <li><b>fn</b> : Function<div class="sub-desc">当弹出框反馈后调用的方法
		 * 按钮配置:<ul>
		 * <li><b>buttonId</b> : String<div class="sub-desc">按钮的id, 可以是如下值:<div class="sub-desc"><ul>
		 * <li><tt>ok</tt></li>
		 * <li><tt>yes</tt></li>
		 * <li><tt>no</tt></li>
		 * <li><tt>cancel</tt></li>
		 * </ul></div></div></li>
		 * <li><b>text</b> : String<div class="sub-desc">确认对话框里面默认显示的文本信息 <tt><a href="#show-option-prompt" L5:member="show-option-prompt" L5:cls="L5.Msg">prompt</a></tt>
		 * or <tt><a href="#show-option-multiline" L5:member="show-option-multiline" L5:cls="L5.Msg">multiline</a></tt> is true</div></li>
		 * <li><b>opt</b> : Object<div class="sub-desc">要显示的配置对象信息.</div></li>
		 * </ul></p></div></li>
		 * <li><b>scope</b> : Object<div class="sub-desc">回调的作用域</div></li>
		 * <li><b>icon</b> : String<div class="sub-desc">对话框的背景图片(默认是 '')</div></li>
		 * <li><b>iconCls</b> : String<div class="sub-desc">标准的 {@link L5.Window#iconCls} 按钮图片 (默认是'')</div></li>
		 * <li><b>maxWidth</b> : Number<div class="sub-desc">消息框的最大宽度 (默认是 600)</div></li>
		 * <li><b>minWidth</b> : Number<div class="sub-desc">消息框的最小宽度 (默认是 100)</div></li>
		 * <li><b>modal</b> : Boolean<div class="sub-desc">如果是false，当消息框弹出的时候允许用户与页面交互 (默认是 true)</div></li>
		 * <li><b>msg</b> : String<div class="sub-desc">文本信息，将会显示在消息框主体部分，消息将会覆盖原先的内容</div></li>
		 * <li><a id="show-option-multiline"></a><b>multiline</b> : Boolean<div class="sub-desc">
		 * 如果是true可以允许用户输入多行信息 (默认是false false)</div></li>
		 * <li><b>progress</b> : Boolean<div class="sub-desc">如果是true，将会显示进度条 (默认是 false)</div></li>
		 * <li><b>progressText</b> : String<div class="sub-desc">当 progress = true的时候进度条上显示的文字 (默认是 '')</div></li>
		 * <li><a id="show-option-prompt"></a><b>prompt</b> : Boolean<div class="sub-desc">如果是true，页面将会显示输入框(默认是false false)</div></li>
		 * <li><b>proxyDrag</b> : Boolean<div class="sub-desc">如果是true，拖动的时候将会显示拖动痕迹 (默认是 false)</div></li>
		 * <li><b>title</b> : String<div class="sub-desc">消息框的标题信息</div></li>
		 * <li><b>value</b> : String<div class="sub-desc">如果显示文本框，将会把value值填进文本框内</div></li>
		 * <li><b>wait</b> : Boolean<div class="sub-desc">如果是true，就会显示进度条 (默认false false)</div></li>
		 * <li><b>waitConfig</b> : Object<div class="sub-desc">一个 {@link L5.ProgressBar#waitConfig} 配置对象 (仅当wait = true时起作用)</div></li>
		 * <li><b>width</b> : Number<div class="sub-desc">弹出框的宽度，像素值</div></li>
		 * </ul>
		 * 示例:
		 * <pre><code>
		L5.Msg.show({
		title: 'Address',
		msg: 'Please enter your address:',
		width: 300,
		buttons: L5.Msg.OKCANCEL,
		multiline: true,
		fn: saveAddress,
		animEl: 'addAddressBtn',
		icon: L5.Msg.INFO
		});
		</code></pre>
		 * @return {L5.MessageBox} this
		 */
		show : function(options) {
			if (this.isVisible()) {
				this.hide();
			}
			opt = options;
			var d = this.getDialog(opt.title || "&#160;");

			d.setTitle(opt.title || "&#160;");
			var allowClose = (opt.closable !== false && opt.progress !== true && opt.wait !== true);
			d.tools.close.setDisplayed(allowClose);
			activeTextEl = textboxEl;
			opt.prompt = opt.prompt || (opt.multiline ? true : false);
			if (opt.prompt) {
				if (opt.multiline) {
					textboxEl.hide();
					textareaEl.show();
					textareaEl
							.setHeight(typeof opt.multiline == "number" ? opt.multiline
									: this.defaultTextHeight);
					activeTextEl = textareaEl;
				} else {
					textboxEl.show();
					textareaEl.hide();
				}
			} else {
				textboxEl.hide();
				textareaEl.hide();
			}
			activeTextEl.dom.value = opt.value || "";
			if (opt.prompt) {
				d.focusEl = activeTextEl;
			} else {
				var bs = opt.buttons;
				var db = null;
				if (bs && bs.ok) {
					db = buttons["ok"];
				} else if (bs && bs.yes) {
					db = buttons["yes"];
				}
				if (db) {
					d.focusEl = db;
				}
			}
			if (opt.iconCls) {
				d.setIconClass(opt.iconCls);
			}
			this.setIcon(opt.icon);
			bwidth = updateButtons(opt.buttons);
			progressBar.setVisible(opt.progress === true || opt.wait === true);
			this.updateProgress(0, opt.progressText);
			this.updateText(opt.msg);
			if (opt.cls) {
				d.el.addClass(opt.cls);
			}
			d.proxyDrag = opt.proxyDrag === true;
			d.modal = opt.modal !== false;
			d.mask = opt.modal !== false ? mask : false;
			if (!d.isVisible()) {
				// force it to the end of the z-index stack so it gets a cursor in FF
				document.body.appendChild(dlg.el.dom);
				d.setAnimateTarget(opt.animEl);
				d.show(opt.animEl);
			}

			//workaround for window internally enabling keymap in afterShow
			d.on('show', function() {
				if (allowClose === true) {
					d.keyMap.enable();
				} else {
					d.keyMap.disable();
				}
			}, this, {
				single : true
			});

			if (opt.wait === true) {
				progressBar.wait(opt.waitConfig);
			}
			return this;
		},

		/**
		 * @private
		 * 
		 * Adds the specified icon to the dialog.  By default, the class 'L5-mb-icon' is applied for default
		 * styling, and the class passed in is expected to supply the background image url. Pass in empty string ('')
		 * to clear any existing icon.  The following built-in icon classes are supported, but you can also pass
		 * in a custom class name:
		 * <pre>
		L5.MessageBox.INFO
		L5.MessageBox.WARNING
		L5.MessageBox.QUESTION
		L5.MessageBox.ERROR
		 *</pre>
		 * @param {String} icon A CSS classname specifying the icon's background image url, or empty string to clear the icon
		 * @return {L5.MessageBox} this
		 */
		setIcon : function(icon) {
			if (icon && icon != '') {
				iconEl.removeClass('l-hidden');
				iconEl.replaceClass(iconCls, icon);
				iconCls = icon;
			} else {
				iconEl.replaceClass(iconCls, 'l-hidden');
				iconCls = '';
			}
			return this;
		},

		/**
		 * 显示一个进度条。
		 * @param {String} title 标题
		 * @param {String} msg (可选)在弹出框显示的文本 (默认是 '')
		 * @param {String} progressText (可选)在进度条上显示的文本 (默认是 '')
		 * @return {L5.MessageBox} this
		 */
		progress : function(title, msg, progressText) {
			this.show( {
				title : title,
				msg : msg,
				buttons : false,
				progress : true,
				closable : false,
				minWidth : this.minProgressWidth,
				progressText : progressText
			});
			return this;
		},

		/**
		 * 显示一个自动更新的进度条弹出框，当用户执行长时间等待的操作并且未定义时间间隔（进度条不可控制）的时候可以使用这个弹出框。
		 * 当进度完成时需要控制关闭弹出框。
		 * @param {String} msg 弹出框主体部分显示的文字
		 * @param {String} title (可选) 弹出框的标题
		 * @param {Object} config (可选) A {@link L5.ProgressBar#waitConfig} object
		 * waitConfig可以包含如下属性：
		 * duration   Number        进度条应该持续的毫秒数 (默认是undefined, 这种情况下会无限循环)
		 *	interval   Number        进度条增长间隔时间(默认是 1000 ms)
		 *	animate    Boolean       是否有动画效果                                                 
		 *	increment  Number        整个进度条分隔的段数，假如是5，那么进度条增长五次就会到末尾，然后重新开始增长(默认是10). 
		 *	text       String        进度条上显示的文字(默认 '').
		 *	fn         Function      当进度条结束的时候调用的回调方法，没有参数，如果没有指定持续的毫秒数将会被忽略
		 *	scope      Object        回调的作用域
		 * @return {L5.MessageBox} this
		 */
		wait : function(msg, title, config) {
			this.show( {
				title : title,
				msg : msg,
				buttons : false,
				closable : false,
				wait : true,
				modal : true,
				minWidth : this.minProgressWidth,
				waitConfig : config
			});
			return this;
		},

		/**
		 * 弹出一个标准的提示框，只有一个确认按钮。(和标准的JavaScript alert效果相同).
		 * 如果回调函数也被传入,则会在确认按钮按下后才好执行回调函数。
		 * @param {String} title 提示框的标题
		 * @param {String} msg 提示框的内容
		 * @param {Function} fn (可选) 当点击确认按钮之后会执行
		 * @param {Object} scope (可选) 回调函数的作用域
		 * @return {L5.MessageBox} this
		 */
		alert : function(title, msg, fn, scope) {
			this.show( {
				title : title,
				msg : msg,
				buttons : this.OK,
				fn : fn,
				minWidth : 130,
				scope : scope
			});
			return this;
		},

		/**
		 * 展示一个确认提示框，有确认和取消两个按钮(和JavaScript'的confirm相同).
		 * 如果有回调函数，则在按钮下了确认或者取消按钮后都会执行
		 * @param {String} title 确认框的标题
		 * @param {String} msg 确认框的内容
		 * @param {Function} fn (可选) 当按下确认或者取消按钮后会执行此函数
		 * @param {Object} scope (可选) 函数的作用域
		 * @return {L5.MessageBox} this
		 */
		confirm : function(title, msg, fn, scope) {
			this.show( {
				title : title,
				msg : msg,
				buttons : this.YESNO,
				fn : fn,
				scope : scope,
				icon : this.QUESTION
			});
			return this;
		},
		
		/**
		 * 弹出一个标准的提示框。提示框可以自动消失。
		 * @param {String} title 提示框的标题
		 * @param {String} msg 提示框的内容
		 * @param {Number} seconds (可选) 显示的持续时间
		 * @return {L5.MessageBox} this
		 */
		showMsg : function(title, msg, seconds) {
			this.show( {
				title : title,
				msg : msg,
				modal : true,
//				animEl : L5.getBody(),
				minWidth : 130
			});
			seconds = seconds || 1500;
			(function(){
				L5.Msg.hide();
			}).defer(seconds,this);
			return this;
		},

		/**
		 * 弹出一个信息获取框，有确定和取消两个按钮，还有一个文本框可以供用户输入内容(和JavaScript的prompt方法一样).
		 * 输入域可以是单行的也可以是多行的文本域，如果有回调函数，则会在按钮按下之后执行.
		 * @param {String} title 信息获取框的标题
		 * @param {String} msg 信息获取框的内容
		 * @param {Function} fn (可选) 回调函数
		 * @param {Object} scope (可选) 回调函数执行的作用域
		 * @param {Boolean/Number} multiline (可选) true使用多行文本域(默认是false /单行文本框)
		 * @param {String} value (可选) 文本框内的初始值(默认是'')
		 * @return {L5.MessageBox} this
		 */
		prompt : function(title, msg, fn, scope, multiline, value) {
			this.show( {
				title : title,
				msg : msg,
				buttons : this.OKCANCEL,
				fn : fn,
				minWidth : 250,
				scope : scope,
				prompt : true,
				multiline : multiline,
				value : value
			});
			return this;
		},

		/**
		 * Button config that displays a single OK button
		 * @private
		 * @type Object
		 */
		OK : {
			ok : true
		},
		/**
		 * @private
		 * Button config that displays a single Cancel button
		 * @type Object
		 */
		CANCEL : {
			cancel : true
		},
		/**
		 * @private
		 * Button config that displays OK and Cancel buttons
		 * @type Object
		 */
		OKCANCEL : {
			ok : true,
			cancel : true
		},
		/**
		 * @private
		 * Button config that displays Yes and No buttons
		 * @type Object
		 */
		YESNO : {
			yes : true,
			no : true
		},
		/**
		 * @private
		 * Button config that displays Yes, No and Cancel buttons
		 * @type Object
		 */
		YESNOCANCEL : {
			yes : true,
			no : true,
			cancel : true
		},
		/**
		 * @private
		 * The CSS class that provides the INFO icon image
		 * @type String
		 */
		INFO : 'L5-mb-info',
		/**
		 * @private
		 * The CSS class that provides the WARNING icon image
		 * @type String
		 */
		WARNING : 'L5-mb-warning',
		/**
		 * @private
		 * The CSS class that provides the QUESTION icon image
		 * @type String
		 */
		QUESTION : 'L5-mb-question',
		/**
		 * @private
		 * The CSS class that provides the ERROR icon image
		 * @type String
		 */
		ERROR : 'L5-mb-error',

		/**
		 * @private
		 * The default height in pixels of the message box's multiline textarea if displayed (defaults to 75)
		 * @type Number
		 */
		defaultTextHeight : 75,
		/**
		 * @private
		 * The maximum width in pixels of the message box (defaults to 600)
		 * @type Number
		 */
		maxWidth : 600,
		/**
		 * @private
		 * The minimum width in pixels of the message box (defaults to 100)
		 * @type Number
		 */
		minWidth : 100,
		/**
		 * @private
		 * The minimum width in pixels of the message box if it is a progress-style dialog.  This is useful
		 * for setting a different minimum width than text-only dialogs may need (defaults to 250)
		 * @type Number
		 */
		minProgressWidth : 250,
		/**
		 * @private
		 * An object containing the default button text strings that can be overriden for localized language support.
		 * Supported properties are: ok, cancel, yes and no.  Generally you should include a locale-specific
		 * resource file for handling language support across the framework.
		 * Customize the default text like so: L5.MessageBox.buttonText.yes = "oui"; //french
		 * @type Object
		 */
		buttonText : {
			ok : "OK",
			cancel : "Cancel",
			yes : "Yes",
			no : "No"
		}
	};
}();

/**
 * 缩写 {@link L5.MessageBox}
 */
L5.Msg = L5.MessageBox;