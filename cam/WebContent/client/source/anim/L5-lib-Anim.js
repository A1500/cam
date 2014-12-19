/**
 * @constructor
 */
L5.lib.Anim = function() {
	//
}

L5.lib.Anim.scroll = function(el, args, duration, easing, cb, scope) {
	return this.run(el, args, duration, easing, cb, scope, L5.lib.Scroll);
};

L5.lib.Anim.motion = function(el, args, duration, easing, cb, scope) {
	return this.run(el, args, duration, easing, cb, scope, L5.lib.Motion);
};

L5.lib.Anim.color = function(el, args, duration, easing, cb, scope) {
	return this.run(el, args, duration, easing, cb, scope, L5.lib.ColorAnim);
};

L5.lib.Anim.run = function(el, args, duration, easing, cb, scope, type) {
	type = type || L5.lib.AnimBase;
	if (typeof easing == "string") {
		easing = L5.lib.Easing[easing];
	}
	var anim = new type(el, args, duration, easing);
	anim.animateX(function() {
		L5.callback(cb, scope);
	});
	return anim;
};

/**
 * @constructor
 */
L5.lib.AnimBase = function(el, attributes, duration, method) {
	if (el) {
		this.init(el, attributes, duration, method);
	}
};

L5.lib.AnimBase.prototype = {

	toString : function() {
		var el = this.getEl();
		var id = el.id || el.tagName;
		return ("Anim " + id);
	},

	patterns : {
		noNegatives : /width|height|opacity|padding/i,
		offsetAttribute : /^((width|height)|(top|left))$/,
		defaultUnit : /width|height|top$|bottom$|left$|right$/i,
		offsetUnit : /\d+(em|%|en|ex|pt|in|cm|mm|pc)$/i
	},

	doMethod : function(attr, start, end) {
		return this.method(this.currentFrame, start, end - start,
				this.totalFrames);
	},

	setAttribute : function(attr, val, unit) {
		if (this.patterns.noNegatives.test(attr)) {
			val = (val > 0) ? val : 0;
		}

		L5.fly(this.getEl(), '_anim').setStyle(attr, val + unit);
	},

	getAttribute : function(attr) {
		var el = this.getEl();
		var val = L5.lib.Dom.fly(el).getStyle(attr);

		if (val !== 'auto' && !this.patterns.offsetUnit.test(val)) {
			return parseFloat(val);
		}

		var a = this.patterns.offsetAttribute.exec(attr) || [];
		var pos = !!(a[3]);
		var box = !!(a[2]);

		if (box || (L5.lib.Dom.fly(el).getStyle('position') == 'absolute' && pos)) {
			val = el['offset' + a[0].charAt(0).toUpperCase() + a[0].substr(1)];
		} else {
			val = 0;
		}

		return val;
	},

	getDefaultUnit : function(attr) {
		if (this.patterns.defaultUnit.test(attr)) {
			return 'px';
		}

		return '';
	},

	animateX : function(callback, scope) {
		var f = function() {
			this.onComplete.removeListener(f);
			if (typeof callback == "function") {
				callback.call(scope || this, this);
			}
		};
		this.onComplete.addListener(f, this);
		this.animate();
	},

	setRuntimeAttribute : function(attr) {
		var start;
		var end;
		var attributes = this.attributes;

		this.runtimeAttributes[attr] = {};

		var isset = function(prop) {
			return (typeof prop !== 'undefined');
		};

		if (!isset(attributes[attr]['to']) && !isset(attributes[attr]['by'])) {
			return false;
		}

		start = (isset(attributes[attr]['from'])) ? attributes[attr]['from']
				: this.getAttribute(attr);

		if (isset(attributes[attr]['to'])) {
			end = attributes[attr]['to'];
		} else if (isset(attributes[attr]['by'])) {
			if (start.constructor == Array) {
				end = [];
				for ( var i = 0, len = start.length; i < len; ++i) {
					end[i] = start[i] + attributes[attr]['by'][i];
				}
			} else {
				end = start + attributes[attr]['by'];
			}
		}

		this.runtimeAttributes[attr].start = start;
		this.runtimeAttributes[attr].end = end;

		this.runtimeAttributes[attr].unit = (isset(attributes[attr].unit)) ? attributes[attr]['unit']
				: this.getDefaultUnit(attr);
	},

	init : function(el, attributes, duration, method) {

		var isAnimated = false;

		var startTime = null;

		var actualFrames = 0;

		el = L5.getDom(el);

		this.attributes = attributes || {};

		this.duration = duration || 1;

		this.method = method || L5.lib.Easing.easeNone;

		this.useSeconds = true;

		this.currentFrame = 0;

		this.totalFrames = L5.lib.AnimMgr.fps;

		this.getEl = function() {
			return el;
		};

		this.isAnimated = function() {
			return isAnimated;
		};

		this.getStartTime = function() {
			return startTime;
		};

		this.runtimeAttributes = {};

		this.animate = function() {
			if (this.isAnimated()) {
				return false;
			}

			this.currentFrame = 0;

			this.totalFrames = (this.useSeconds) ? Math.ceil(L5.lib.AnimMgr.fps
					* this.duration) : this.duration;

			L5.lib.AnimMgr.registerElement(this);
		};

		this.stop = function(finish) {
			if (finish) {
				this.currentFrame = this.totalFrames;
				this._onTween.fire();
			}
			L5.lib.AnimMgr.stop(this);
		};

		var onStart = function() {
			this.onStart.fire();

			this.runtimeAttributes = {};
			for ( var attr in this.attributes) {
				this.setRuntimeAttribute(attr);
			}

			isAnimated = true;
			actualFrames = 0;
			startTime = new Date();
		};

		var onTween = function() {
			var data = {
				duration : new Date() - this.getStartTime(),
				currentFrame : this.currentFrame
			};

			data.toString = function() {
				return ('duration: ' + data.duration + ', currentFrame: ' + data.currentFrame);
			};

			this.onTween.fire(data);

			var runtimeAttributes = this.runtimeAttributes;

			for ( var attr in runtimeAttributes) {
				this.setAttribute(attr, this.doMethod(attr,
						runtimeAttributes[attr].start,
						runtimeAttributes[attr].end),
						runtimeAttributes[attr].unit);
			}

			actualFrames += 1;
		};

		var onComplete = function() {
			var actual_duration = (new Date() - startTime) / 1000;

			var data = {
				duration : actual_duration,
				frames : actualFrames,
				fps : actualFrames / actual_duration
			};

			data.toString = function() {
				return ('duration: ' + data.duration + ', frames: '
						+ data.frames + ', fps: ' + data.fps);
			};

			isAnimated = false;
			actualFrames = 0;
			this.onComplete.fire(data);
		};

		this._onStart = new L5.util.Event(this);
		this.onStart = new L5.util.Event(this);
		this.onTween = new L5.util.Event(this);
		this._onTween = new L5.util.Event(this);
		this.onComplete = new L5.util.Event(this);
		this._onComplete = new L5.util.Event(this);
		this._onStart.addListener(onStart);
		this._onTween.addListener(onTween);
		this._onComplete.addListener(onComplete);
	}
};

/**
 * @constructor
 */
L5.lib.AnimMgr = function() {

};

(function() {

	/**
	 * 
	 * @ignore
	 */
	var thread = null;
	/**
	 * 
	 * @ignore
	 */
	var queue = [];

	/**
	 * 
	 * @ignore
	 */
	var tweenCount = 0;
	/**
	 * 
	 * @ignore
	 */
	var getIndex = function(anim) {
		for ( var i = 0, len = queue.length; i < len; ++i) {
			if (queue[i] == anim) {
				return i;
			}
		}
		return -1;
	};
	/**
	 * 
	 * @ignore
	 */
	var correctFrame = function(tween) {
		var frames = tween.totalFrames;
		var frame = tween.currentFrame;
		var expected = (tween.currentFrame * tween.duration * 1000 / tween.totalFrames);
		var elapsed = (new Date() - tween.getStartTime());
		var tweak = 0;

		if (elapsed < tween.duration * 1000) {
			tweak = Math.round((elapsed / expected - 1) * tween.currentFrame);
		} else {
			tweak = frames - (frame + 1);
		}
		if (tweak > 0 && isFinite(tweak)) {
			if (tween.currentFrame + tweak >= frames) {
				tweak = frames - (frame + 1);
			}

			tween.currentFrame += tweak;
		}
	};

	
	L5.lib.AnimMgr.fps = 1000;

	L5.lib.AnimMgr.delay = 1;

	L5.lib.AnimMgr.registerElement = function(tween) {
		queue[queue.length] = tween;
		tweenCount += 1;
		tween._onStart.fire();
		this.start();
	};

	L5.lib.AnimMgr.unRegister = function(tween, index) {
		tween._onComplete.fire();
		index = index || getIndex(tween);
		if (index != -1) {
			queue.splice(index, 1);
		}

		tweenCount -= 1;
		if (tweenCount <= 0) {
			this.stop();
		}
	};

	L5.lib.AnimMgr.start = function() {
		if (thread === null) {
			thread = setInterval(this.run, this.delay);
		}
	};

	L5.lib.AnimMgr.stop = function(tween) {
		if (!tween) {
			clearInterval(thread);

			for ( var i = 0, len = queue.length; i < len; ++i) {
				if (queue[0].isAnimated()) {
					this.unRegister(queue[0], 0);
				}
			}

			queue = [];
			thread = null;
			tweenCount = 0;
		} else {
			this.unRegister(tween);
		}
	};

	L5.lib.AnimMgr.run = function() {
		for ( var i = 0, len = queue.length; i < len; ++i) {
			var tween = queue[i];
			if (!tween || !tween.isAnimated()) {
				continue;
			}

			if (tween.currentFrame < tween.totalFrames
					|| tween.totalFrames === null) {
				tween.currentFrame += 1;

				if (tween.useSeconds) {
					correctFrame(tween);
				}
				tween._onTween.fire();
			} else {
				L5.lib.AnimMgr.stop(tween, i);
			}
		}
	};
})();



/**
 * @constructor
 */
L5.lib.Bezier = function() {

};

L5.lib.Bezier.getPosition = function(points, t) {
	var n = points.length;
	var tmp = [];

	for ( var i = 0; i < n; ++i) {
		tmp[i] = [ points[i][0], points[i][1] ];
	}

	for ( var j = 1; j < n; ++j) {
		for (i = 0; i < n - j; ++i) {
			tmp[i][0] = (1 - t) * tmp[i][0] + t * tmp[parseInt(i + 1, 10)][0];
			tmp[i][1] = (1 - t) * tmp[i][1] + t * tmp[parseInt(i + 1, 10)][1];
		}
	}

	return [ tmp[0][0], tmp[0][1] ];
};
/**
 * @constructor
 */
L5.lib.Easing = function() {
	//
};

L5.lib.Easing.easeNone = function(t, b, c, d) {
	return c * t / d + b;
};

L5.lib.Easing.easeIn = function(t, b, c, d) {
	return c * (t /= d) * t + b;
};

L5.lib.Easing.easeOut = function(t, b, c, d) {
	return -c * (t /= d) * (t - 2) + b;
};

L5.lib.Easing.easeBoth = function(t, b, c, d) {
	if ((t /= d / 2) < 1) {
		return c / 2 * t * t + b;
	}

	return -c / 2 * ((--t) * (t - 2) - 1) + b;
};

L5.lib.Easing.easeInStrong = function(t, b, c, d) {
	return c * (t /= d) * t * t * t + b;
};

L5.lib.Easing.easeOutStrong = function(t, b, c, d) {
	return -c * ((t = t / d - 1) * t * t * t - 1) + b;
};

L5.lib.Easing.easeBothStrong = function(t, b, c, d) {
	if ((t /= d / 2) < 1) {
		return c / 2 * t * t * t * t + b;
	}

	return -c / 2 * ((t -= 2) * t * t * t - 2) + b;
};

L5.lib.Easing.elasticIn = function(t, b, c, d, a, p) {
	if (t == 0) {
		return b;
	}
	if ((t /= d) == 1) {
		return b + c;
	}
	if (!p) {
		p = d * .3;
	}

	if (!a || a < Math.abs(c)) {
		a = c;
		var s = p / 4;
	} else {
		var s = p / (2 * Math.PI) * Math.asin(c / a);
	}

	return -(a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s)
			* (2 * Math.PI) / p))
			+ b;
};

L5.lib.Easing.elasticOut = function(t, b, c, d, a, p) {
	if (t == 0) {
		return b;
	}
	if ((t /= d) == 1) {
		return b + c;
	}
	if (!p) {
		p = d * .3;
	}

	if (!a || a < Math.abs(c)) {
		a = c;
		var s = p / 4;
	} else {
		var s = p / (2 * Math.PI) * Math.asin(c / a);
	}

	return a * Math.pow(2, -10 * t) * Math.sin((t * d - s) * (2 * Math.PI) / p)
			+ c + b;
};

L5.lib.Easing.elasticBoth = function(t, b, c, d, a, p) {
	if (t == 0) {
		return b;
	}

	if ((t /= d / 2) == 2) {
		return b + c;
	}

	if (!p) {
		p = d * (.3 * 1.5);
	}

	if (!a || a < Math.abs(c)) {
		a = c;
		var s = p / 4;
	} else {
		var s = p / (2 * Math.PI) * Math.asin(c / a);
	}

	if (t < 1) {
		return -.5
				* (a * Math.pow(2, 10 * (t -= 1)) * Math.sin((t * d - s)
						* (2 * Math.PI) / p)) + b;
	}
	return a * Math.pow(2, -10 * (t -= 1))
			* Math.sin((t * d - s) * (2 * Math.PI) / p) * .5 + c + b;
};

L5.lib.Easing.backIn = function(t, b, c, d, s) {
	if (typeof s == 'undefined') {
		s = 1.70158;
	}
	return c * (t /= d) * t * ((s + 1) * t - s) + b;
};

L5.lib.Easing.backOut = function(t, b, c, d, s) {
	if (typeof s == 'undefined') {
		s = 1.70158;
	}
	return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b;
};

L5.lib.Easing.backBoth = function(t, b, c, d, s) {
	if (typeof s == 'undefined') {
		s = 1.70158;
	}

	if ((t /= d / 2) < 1) {
		return c / 2 * (t * t * (((s *= (1.525)) + 1) * t - s)) + b;
	}
	return c / 2 * ((t -= 2) * t * (((s *= (1.525)) + 1) * t + s) + 2) + b;
};

L5.lib.Easing.bounceIn = function(t, b, c, d) {
	return c - L5.lib.Easing.bounceOut(d - t, 0, c, d) + b;
};

L5.lib.Easing.bounceOut = function(t, b, c, d) {
	if ((t /= d) < (1 / 2.75)) {
		return c * (7.5625 * t * t) + b;
	} else if (t < (2 / 2.75)) {
		return c * (7.5625 * (t -= (1.5 / 2.75)) * t + .75) + b;
	} else if (t < (2.5 / 2.75)) {
		return c * (7.5625 * (t -= (2.25 / 2.75)) * t + .9375) + b;
	}
	return c * (7.5625 * (t -= (2.625 / 2.75)) * t + .984375) + b;
};

L5.lib.Easing.bounceBoth = function(t, b, c, d) {
	if (t < d / 2) {
		return L5.lib.Easing.bounceIn(t * 2, 0, c, d) * .5 + b;
	}
	return L5.lib.Easing.bounceOut(t * 2 - d, 0, c, d) * .5 + c * .5 + b;
};

/**
 * @constructor
 */
L5.lib.ColorAnim = function(el, attributes, duration, method) {
	L5.lib.ColorAnim.superclass.constructor.call(this, el, attributes,
			duration, method);
};

L5.extend(L5.lib.ColorAnim, L5.lib.AnimBase);

(function() {

	var superclass = L5.lib.ColorAnim.superclass;

	var proto = L5.lib.ColorAnim.prototype;
	/**
	 * 
	 */
	L5.lib.ColorAnim.prototype.toString = function() {
		var el = this.getEl();
		var id = el.id || el.tagName;
		return ("ColorAnim " + id);
	};

	proto.patterns.color = /color$/i;
	proto.patterns.rgb = /^rgb\(([0-9]+)\s*,\s*([0-9]+)\s*,\s*([0-9]+)\)$/i;
	proto.patterns.hex = /^#?([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})$/i;
	proto.patterns.hex3 = /^#?([0-9A-F]{1})([0-9A-F]{1})([0-9A-F]{1})$/i;
	proto.patterns.transparent = /^transparent|rgba\(0, 0, 0, 0\)$/;

	L5.lib.ColorAnim.prototype.parseColor = function(s) {
		if (s.length == 3) {
			return s;
		}

		var c = this.patterns.hex.exec(s);
		if (c && c.length == 4) {
			return [ parseInt(c[1], 16), parseInt(c[2], 16), parseInt(c[3], 16) ];
		}

		c = this.patterns.rgb.exec(s);
		if (c && c.length == 4) {
			return [ parseInt(c[1], 10), parseInt(c[2], 10), parseInt(c[3], 10) ];
		}

		c = this.patterns.hex3.exec(s);
		if (c && c.length == 4) {
			return [ parseInt(c[1] + c[1], 16), parseInt(c[2] + c[2], 16),
					parseInt(c[3] + c[3], 16) ];
		}

		return null;
	};

	L5.lib.ColorAnim.prototype.getAttribute = function(attr) {
		var el = this.getEl();
		if (this.patterns.color.test(attr)) {
			var val = L5.lib.Dom.fly(el).getStyle(attr);

			if (this.patterns.transparent.test(val)) {
				var parent = el.parentNode;
				val = L5.lib.Dom.fly(parent).getStyle(attr);

				while (parent && this.patterns.transparent.test(val)) {
					parent = parent.parentNode;
					val = L5.lib.Dom.fly(parent).getStyle(attr);
					if (parent.tagName.toUpperCase() == 'HTML') {
						val = '#fff';
					}
				}
			}
		} else {
			val = superclass.getAttribute.call(this, attr);
		}

		return val;
	};

	L5.lib.ColorAnim.prototype.doMethod = function(attr, start, end) {
		var val;

		if (this.patterns.color.test(attr)) {
			val = [];
			for ( var i = 0, len = start.length; i < len; ++i) {
				val[i] = superclass.doMethod.call(this, attr, start[i], end[i]);
			}

			val = 'rgb(' + Math.floor(val[0]) + ',' + Math.floor(val[1]) + ','
					+ Math.floor(val[2]) + ')';
		} else {
			val = superclass.doMethod.call(this, attr, start, end);
		}

		return val;
	};

	L5.lib.ColorAnim.prototype.setRuntimeAttribute = function(attr) {
		superclass.setRuntimeAttribute.call(this, attr);

		if (this.patterns.color.test(attr)) {
			var attributes = this.attributes;
			var start = this.parseColor(this.runtimeAttributes[attr].start);
			var end = this.parseColor(this.runtimeAttributes[attr].end);

			if (typeof attributes[attr]['to'] === 'undefined'
					&& typeof attributes[attr]['by'] !== 'undefined') {
				end = this.parseColor(attributes[attr].by);

				for ( var i = 0, len = start.length; i < len; ++i) {
					end[i] = start[i] + end[i];
				}
			}

			this.runtimeAttributes[attr].start = start;
			this.runtimeAttributes[attr].end = end;
		}
	};
})();
/**
 * @constructor
 */
L5.lib.Motion = function(el, attributes, duration, method) {
	if (el) {
		L5.lib.Motion.superclass.constructor.call(this, el, attributes,
				duration, method);
	}
};

L5.extend(L5.lib.Motion, L5.lib.ColorAnim);

(function() {
	var superclass = L5.lib.Motion.superclass;

	var translateValues = function(val, start) {
		var pageXY = L5.lib.Dom.getXY(this.getEl());
		val = [ val[0] - pageXY[0] + start[0], val[1] - pageXY[1] + start[1] ];
		return val;
	};

	var isset = function(prop) {
		return (typeof prop !== 'undefined');
	};

	L5.lib.Motion.prototype.toString = function() {
		var el = this.getEl();
		var id = el.id || el.tagName;
		return ("Motion " + id);
	};

	L5.lib.Motion.prototype.patterns.points = /^points$/i;

	L5.lib.Motion.prototype.setAttribute = function(attr, val, unit) {
		if (this.patterns.points.test(attr)) {
			unit = unit || 'px';
			superclass.setAttribute.call(this, 'left', val[0], unit);
			superclass.setAttribute.call(this, 'top', val[1], unit);
		} else {
			superclass.setAttribute.call(this, attr, val, unit);
		}
	};

	L5.lib.Motion.prototype.getAttribute = function(attr) {
		if (this.patterns.points.test(attr)) {
			var val = [ superclass.getAttribute.call(this, 'left'),
					superclass.getAttribute.call(this, 'top') ];
		} else {
			val = superclass.getAttribute.call(this, attr);
		}

		return val;
	};

	L5.lib.Motion.prototype.doMethod = function(attr, start, end) {
		var val = null;

		if (this.patterns.points.test(attr)) {
			var t = this.method(this.currentFrame, 0, 100, this.totalFrames) / 100;
			val = L5.lib.Bezier.getPosition(this.runtimeAttributes[attr], t);
		} else {
			val = superclass.doMethod.call(this, attr, start, end);
		}
		return val;
	};

	L5.lib.Motion.prototype.setRuntimeAttribute = function(attr) {
		if (this.patterns.points.test(attr)) {
			var el = this.getEl();
			var attributes = this.attributes;
			var start;
			var control = attributes['points']['control'] || [];
			var end;
			var i, len;

			if (control.length > 0 && !L5.isArray(control[0])) {
				control = [ control ];
			} else {
				var tmp = [];
				for (i = 0, len = control.length; i < len; ++i) {
					tmp[i] = control[i];
				}
				control = tmp;
			}

			L5.fly(el, '_anim').position();

			if (isset(attributes['points']['from'])) {
				L5.lib.Dom.setXY(el, attributes['points']['from']);
			} else {
				L5.lib.Dom.setXY(el, L5.lib.Dom.getXY(el));
			}

			start = this.getAttribute('points');

			if (isset(attributes['points']['to'])) {
				end = translateValues.call(this, attributes['points']['to'],
						start);

				var pageXY = L5.lib.Dom.getXY(this.getEl());
				for (i = 0, len = control.length; i < len; ++i) {
					control[i] = translateValues.call(this, control[i], start);
				}

			} else if (isset(attributes['points']['by'])) {
				end = [ start[0] + attributes['points']['by'][0],
						start[1] + attributes['points']['by'][1] ];

				for (i = 0, len = control.length; i < len; ++i) {
					control[i] = [ start[0] + control[i][0],
							start[1] + control[i][1] ];
				}
			}

			this.runtimeAttributes[attr] = [ start ];

			if (control.length > 0) {
				this.runtimeAttributes[attr] = this.runtimeAttributes[attr]
						.concat(control);
			}

			this.runtimeAttributes[attr][this.runtimeAttributes[attr].length] = end;
		} else {
			superclass.setRuntimeAttribute.call(this, attr);
		}
	};
})();

/**
 * @constructor
 */
L5.lib.Scroll = function(el, attributes, duration, method) {
	if (el) {
		L5.lib.Scroll.superclass.constructor.call(this, el, attributes,
				duration, method);
	}
};

L5.extend(L5.lib.Scroll, L5.lib.ColorAnim);

(function() {
	var superclass = L5.lib.Scroll.superclass;
	
	L5.lib.Scroll.prototype.toString = function() {
		var el = this.getEl();
		var id = el.id || el.tagName;
		return ("Scroll " + id);
	};

	L5.lib.Scroll.prototype.doMethod = function(attr, start, end) {
		var val = null;

		if (attr == 'scroll') {
			val = [
					this.method(this.currentFrame, start[0], end[0] - start[0],
							this.totalFrames),
					this.method(this.currentFrame, start[1], end[1] - start[1],
							this.totalFrames) ];

		} else {
			val = superclass.doMethod.call(this, attr, start, end);
		}
		return val;
	};

	L5.lib.Scroll.prototype.getAttribute = function(attr) {
		var val = null;
		var el = this.getEl();

		if (attr == 'scroll') {
			val = [ el.scrollLeft, el.scrollTop ];
		} else {
			val = superclass.getAttribute.call(this, attr);
		}

		return val;
	};

	L5.lib.Scroll.prototype.setAttribute = function(attr, val, unit) {
		var el = this.getEl();

		if (attr == 'scroll') {
			el.scrollLeft = val[0];
			el.scrollTop = val[1];
		} else {
			superclass.setAttribute.call(this, attr, val, unit);
		}
	};
})();
