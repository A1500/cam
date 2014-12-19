
/**
 * @constructor
 * @private
 */
L5.EventObjectImpl = function(e) {
	if (e) {
		this.setEvent(e.browserEvent || e);
	}
};

(function() {
	var E = L5.lib.Event;

	// safari keypress events for special keys return bad keycodes
	var safariKeys = {
		3 : 13, // enter
		63234 : 37, // left
		63235 : 39, // right
		63232 : 38, // up
		63233 : 40, // down
		63276 : 33, // page up
		63277 : 34, // page down
		63272 : 46, // delete
		63273 : 36, // home
		63275 : 35
	// end
	};

	// normalize button clicks
	var btnMap = L5.isIE ? {
		1 : 0,
		4 : 1,
		2 : 2
	} : (L5.isSafari ? {
		1 : 0,
		2 : 1,
		3 : 2
	} : {
		0 : 0,
		1 : 1,
		2 : 2
	});

	L5.EventObjectImpl.prototype = {
		/** The normal browser event */
		browserEvent : null,
		/** The button pressed in a mouse event */
		button : -1,
		/** True if the shift key was down during the event */
		shiftKey : false,
		/** True if the control key was down during the event */
		ctrlKey : false,
		/** True if the alt key was down during the event */
		altKey : false,

		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		BACKSPACE : 8,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		TAB : 9,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_CENTER : 12,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		ENTER : 13,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		RETURN : 13,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		SHIFT : 16,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		CTRL : 17,
		CONTROL : 17, // legacy
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		ALT : 18,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		PAUSE : 19,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		CAPS_LOCK : 20,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		ESC : 27,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		SPACE : 32,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		PAGE_UP : 33,
		PAGEUP : 33, // legacy
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		PAGE_DOWN : 34,
		PAGEDOWN : 34, // legacy
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		END : 35,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		HOME : 36,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		LEFT : 37,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		UP : 38,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		RIGHT : 39,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		DOWN : 40,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		PRINT_SCREEN : 44,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		INSERT : 45,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		DELETE : 46,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		ZERO : 48,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		ONE : 49,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		TWO : 50,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		THREE : 51,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		FOUR : 52,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		FIVE : 53,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		SIX : 54,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		SEVEN : 55,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		EIGHT : 56,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NINE : 57,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		A : 65,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		B : 66,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		C : 67,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		D : 68,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		E : 69,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F : 70,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		G : 71,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		H : 72,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		I : 73,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		J : 74,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		K : 75,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		L : 76,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		M : 77,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		N : 78,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		O : 79,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		P : 80,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		Q : 81,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		R : 82,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		S : 83,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		T : 84,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		U : 85,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		V : 86,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		W : 87,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		X : 88,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		Y : 89,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		Z : 90,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		CONTEXT_MENU : 93,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_ZERO : 96,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_ONE : 97,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_TWO : 98,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_THREE : 99,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_FOUR : 100,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_FIVE : 101,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_SIX : 102,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_SEVEN : 103,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_EIGHT : 104,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_NINE : 105,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_MULTIPLY : 106,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_PLUS : 107,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_MINUS : 109,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_PERIOD : 110,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		NUM_DIVISION : 111,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F1 : 112,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F2 : 113,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F3 : 114,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F4 : 115,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F5 : 116,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F6 : 117,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F7 : 118,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F8 : 119,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F9 : 120,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F10 : 121,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F11 : 122,
		/**
		 * Key constant
		 * 
		 * @type Number
		 */
		F12 : 123,

		/** @private */
		setEvent : function(e) {
			if (e == this || (e && e.browserEvent)) { // already wrapped
				return e;
			}
			this.browserEvent = e;
			if (e) {
				// normalize buttons
				this.button = e.button ? btnMap[e.button]
						: (e.which ? e.which - 1 : -1);
				if (e.type == 'click' && this.button == -1) {
					this.button = 0;
				}
				this.type = e.type;
				this.shiftKey = e.shiftKey;
				// mac metaKey behaves like ctrlKey
				this.ctrlKey = e.ctrlKey || e.metaKey;
				this.altKey = e.altKey;
				// in getKey these will be normalized for the mac
				this.keyCode = e.keyCode;
				this.charCode = e.charCode;
				// cache the target for the delayed and or buffered events
				this.target = E.getTarget(e);
				// same for XY
				this.xy = E.getXY(e);
			} else {
				this.button = -1;
				this.shiftKey = false;
				this.ctrlKey = false;
				this.altKey = false;
				this.keyCode = 0;
				this.charCode = 0;
				this.target = null;
				this.xy = [ 0, 0 ];
			}
			return this;
		},

		/**
		 * 停止事件，包括停止传播，阻止事件触发调用方法(preventDefault and stopPropagation)
		 */
		stopEvent : function() {
			if (this.browserEvent) {
				if (this.browserEvent.type == 'mousedown') {
					L5.EventManager.stoppedMouseDownEvent.fire(this);
				}
				E.stopEvent(this.browserEvent);
			}
		},

		/**
		 * 阻止某个事件触发默认动作.
		 */
		preventDefault : function() {
			if (this.browserEvent) {
				E.preventDefault(this.browserEvent);
			}
		},

		/** @private */
		isNavKeyPress : function() {
			var k = this.keyCode;
			k = L5.isSafari ? (safariKeys[k] || k) : k;
			return (k >= 33 && k <= 40) || k == this.RETURN || k == this.TAB
					|| k == this.ESC;
		},

		/**
		 * 是不是特殊键：回车键、CTRL、等等
		 */
		isSpecialKey : function() {
			var k = this.keyCode;
			return (this.type == 'keypress' && this.ctrlKey) || k == 9
					|| k == 13 || k == 40 || k == 27 || (k == 16) || (k == 17)
					|| (k >= 18 && k <= 20) || (k >= 33 && k <= 35)
					|| (k >= 36 && k <= 39) || (k >= 44 && k <= 45);
		},

		/**
		 * 终止事件在传播过程的捕获、目标处理或起泡阶段进一步传播。
		 * <p>
		 * 调用该方法后，该节点上处理该事件的处理程序将被调用，事件不再被分派到其他节点
		 */
		stopPropagation : function() {
			if (this.browserEvent) {
				if (this.browserEvent.type == 'mousedown') {
					L5.EventManager.stoppedMouseDownEvent.fire(this);
				}
				E.stopPropagation(this.browserEvent);
			}
		},

		/**
		 * 返回事件的charcode.
		 * 
		 * @return {Number}
		 */
		getCharCode : function() {
			return this.charCode || this.keyCode;
		},

		/**
		 * 返回事件的keycode
		 * 
		 * @return {Number} The key code
		 */
		getKey : function() {
			var k = this.keyCode || this.charCode;
			return L5.isSafari ? (safariKeys[k] || k) : k;
		},

		/**
		 * 返回时间的x坐标
		 * 
		 * @return {Number}
		 */
		getPageX : function() {
			return this.xy[0];
		},

		/**
		 * 返回事件的y坐标
		 * 
		 * @return {Number}
		 */
		getPageY : function() {
			return this.xy[1];
		},

		/**
		 * 返回事件的发生时间
		 * 
		 * @return {Number}
		 */
		getTime : function() {
			if (this.browserEvent) {
				return E.getTime(this.browserEvent);
			}
			return null;
		},

		/**
		 * 返回事件的X、Y坐标值
		 * 
		 * @return {Array} [x, y]
		 */
		getXY : function() {
			return this.xy;
		},

		/**
		 * 获取事件的目标节点
		 * 
		 * @param {String}
		 *            selector (optional) 节点过滤器
		 * @param {Number/Mixed}
		 *            maxDepth (optional) 查找最大深度 (defaults to 10 ||
		 *            document.body)
		 * @param {Boolean}
		 *            returnEl (optional) 返回L5.Element还是原生的DOM对象
		 * @return {HTMLelement}
		 */
		getTarget : function(selector, maxDepth, returnEl) {
			return selector ? L5.fly(this.target).findParent(selector,
					maxDepth, returnEl) : (returnEl ? L5.get(this.target)
					: this.target);
		},

		/**
		 * 返回与事件的目标节点相关的节点。
		 * 
		 * 对于 mouseover 事件来说，该属性是鼠标指针移到目标节点上时所离开的那个节点。
		 * 
		 * 对于 mouseout 事件来说，该属性是离开目标时，鼠标指针进入的节点。
		 * 
		 * 对于其他类型的事件来说，这个属性没有用。
		 * 
		 * @return {HTMLElement}
		 */
		getRelatedTarget : function() {
			if (this.browserEvent) {
				return E.getRelatedTarget(this.browserEvent);
			}
			return null;
		},

		/**
		 * 鼠标滚轮滚动量
		 * 
		 * @return {Number}
		 */
		getWheelDelta : function() {
			var e = this.browserEvent;
			var delta = 0;
			if (e.wheelDelta) { /* IE/Opera. */
				delta = e.wheelDelta / 120;
			} else if (e.detail) { /* Mozilla case. */
				delta = -e.detail / 3;
			}
			return delta;
		},

		/**
		 * 事件中是不是按下了CTRL, SHIFT or ALT 键.
		 * 
		 * @return {Boolean}
		 */
		hasModifier : function() {
			return ((this.ctrlKey || this.altKey) || this.shiftKey) ? true
					: false;
		},

		/**
		 * 判断事件的目标(target)是不是指定元素的一个子节点。
		 * 
		 * <p>
		 * 例如:
		 * 
		 * <pre><code>
		 * // Handle click on any child of an element
		 * L5.getBody().on('click', function(e) {
		 * 	if (e.within('some-el')) {
		 * 		alert('Clicked on a child of some-el!');
		 * 	}
		 * });
		 * 
		 * // Handle click directly on an element, ignoring clicks on child nodes
		 * L5.getBody().on('click', function(e, t) {
		 * 	if ((t.id == 'some-el') &amp;&amp; !e.within(t, true)) {
		 * 		alert('Clicked directly on some-el!');
		 * 	}
		 * });
		 * </code></pre>
		 * 
		 * @param {Mixed}
		 *            el 某个指定的父节点元素
		 * @param {Boolean}
		 *            related (optional) 是否使用事件目标节点的相关节点来代替目标节点做判断
		 * @param {Boolean}
		 *            allowEl {optional} 是否事件的目标节点和相关节点都可以做判断
		 * @return {Boolean}
		 */
		within : function(el, related, allowEl) {
			var t = this[related ? "getRelatedTarget" : "getTarget"]();
			return t
					&& ((allowEl ? (t === L5.getDom(el)) : false) || L5.fly(el)
							.contains(t));
		},

		/**
		 * 获得事件位置
		 * 
		 * @returns {L5.lib.Point}
		 */
		getPoint : function() {
			return new L5.lib.Point(this.xy[0], this.xy[1]);
		}
	};
})();
/**
 * 为了屏蔽浏览器的差异，对浏览器事件对象的一个封装。
 * <p>
 * 例如:
 * 
 * <pre><code>
 *  function handleClick(e){ // e is not a standard event object, it is a L5.EventObject
 *  e.preventDefault();
 *  var target = e.getTarget();
 *  ...
 *  }
 *  var myDiv = L5.get(&quot;myDiv&quot;);
 *  myDiv.on(&quot;click&quot;, handleClick);
 *  //or
 *  L5.EventManager.on(&quot;myDiv&quot;, 'click', handleClick);
 *  L5.EventManager.addListener(&quot;myDiv&quot;, 'click', handleClick);
 * </code></pre>
 * 
 * @class L5.EventObject
 * 
 * @singleton
 */
L5.EventObject = function() {
	return new L5.EventObjectImpl();
}();
