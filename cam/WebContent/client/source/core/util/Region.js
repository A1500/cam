(function() {
	/**
	 * 区域、块
	 * 
	 * @param {Number}
	 *            t 顶部位置
	 * @param {Number}
	 *            r 右部位置
	 * @param {Number}
	 *            b 底部位置
	 * @param {Number}
	 *            l 左部位置
	 * @constructor
	 * @private
	 */
	L5.lib.Region = function(t, r, b, l) {
		this.top = t;
		this[1] = t;
		this.right = r;
		this.bottom = b;
		this.left = l;
		this[0] = l;
	};

	L5.lib.Region.prototype = {
		/**
		 * 当前区域是否完全包含指定区域
		 * 
		 * @param {L5.lib.Region}
		 *            region
		 * @returns {Boolean}
		 */
		contains : function(region) {
			return (region.left >= this.left && region.right <= this.right
					&& region.top >= this.top && region.bottom <= this.bottom);

		},

		/**
		 * 获取当前区域的大小
		 * 
		 * @returns {Number} 长度和宽度的乘积
		 */
		getArea : function() {
			return ((this.bottom - this.top) * (this.right - this.left));
		},
		/**
		 * 取和指定区域的交集
		 * 
		 * @param {L5.lib.Region}
		 *            region
		 * @returns {L5.lib.Region}
		 */
		intersect : function(region) {
			var t = Math.max(this.top, region.top);
			var r = Math.min(this.right, region.right);
			var b = Math.min(this.bottom, region.bottom);
			var l = Math.max(this.left, region.left);

			if (b >= t && r >= l) {
				return new L5.lib.Region(t, r, b, l);
			} else {
				return null;
			}
		},
		/**
		 * 取和指定区域的并集
		 * 
		 * @param {L5.lib.Region}
		 *            region
		 * @returns {L5.lib.Region}
		 */
		union : function(region) {
			var t = Math.min(this.top, region.top);
			var r = Math.max(this.right, region.right);
			var b = Math.max(this.bottom, region.bottom);
			var l = Math.min(this.left, region.left);

			return new L5.lib.Region(t, r, b, l);
		},

		/**
		 * 调整当前区域(调整上下左右的值)，使当前区域被指定区域包含
		 * 
		 * @param {L5.lib.Region}
		 *            r
		 */
		constrainTo : function(r) {
			this.top = this.top.constrain(r.top, r.bottom);
			this.bottom = this.bottom.constrain(r.top, r.bottom);
			this.left = this.left.constrain(r.left, r.right);
			this.right = this.right.constrain(r.left, r.right);
			return this;
		},
		/**
		 * 区域微调，使区域的上下左右都有所增加
		 * 
		 * @param {Number}
		 *            t
		 * @param {Number}
		 *            l
		 * @param {Number}
		 *            b
		 * @param {Number}
		 *            r
		 */
		adjust : function(t, l, b, r) {
			this.top += t;
			this.left += l;
			this.right += r;
			this.bottom += b;
			return this;
		}
	};

	/**
	 * 静态方法：获取某个元素所在区域
	 * 
	 * @param {L5.Element}
	 *            el
	 * @returns {L5.lib.Region}
	 */
	L5.lib.Region.getRegion = function(el) {
		var p = L5.lib.Dom.getXY(el);

		var t = p[1];
		var r = p[0] + el.offsetWidth;
		var b = p[1] + el.offsetHeight;
		var l = p[0];

		return new L5.lib.Region(t, r, b, l);
	};

	/**
	 * 点，一个区域缩成一个点
	 * 
	 * @param {Number}
	 *            x
	 * @param {Number}
	 *            y
	 * @constructor
	 * @private
	 */
	L5.lib.Point = function(x, y) {
		if (L5.isArray(x)) {
			y = x[1];
			x = x[0];
		}
		this.x = this.right = this.left = this[0] = x;
		this.y = this.top = this.bottom = this[1] = y;
	};

	L5.lib.Point.prototype = new L5.lib.Region();

})();