/**
 * 实现javascript里的继承关系：将一个类变为另一个类的子类，或者定义一个新的类：某个指定类的子类。
 * <p>
 * 例如，让L5.model.JsonReader类继承L5.model.DataReader类：
 * 
 * <pre><code>
 * L5.extend(L5.model.JsonReader, L5.model.DataReader, {
 * 		//可以在这里增加一些新的方法或属性
 * });
 * </code></pre>
 * 
 * <p>
 * 例如，定义一个新的L5 GridPanel的子类:
 * 
 * <pre><code>
 * MyGridPanel = L5.extend(L5.grid.GridPanel, {
 * 		constructor : function(config) {
 * 		// Your preprocessing here
 * 		MyGridPanel.superclass.constructor.apply(this, arguments);
 * 		// Your postprocessing here
 * 		},
 * 
 * 		yourMethod : function() {
 * 			// etc.
 * 		}
 * });
 * </code></pre>
 * 
 * </p>
 * 
 * @private
 * @param {Function}
 *            sub 子类
 * @param {Function}
 *            sup 父类
 * @param {Object}
 *            overrides (optional) 给子类增加的方法或属性,会覆盖原先的同名属性或方法
 * @return {Function} 子类构造函数.
 * @method extend
 */
L5.extend = function() {
	// 内联函数，就是将这个方法编译后放入内存中
	var io = function(o) {
		for ( var m in o) {
			this[m] = o[m];
		}
	};
	var oc = Object.prototype.constructor;

	return function(sb, sp, overrides) {
		if (typeof sp == 'object') {//只有两个参数的调用方式--直接创建一个新的子类	
			overrides = sp;//第2个参数是overrides
			sp = sb;//第一个参数是父类
			//overrides里定义了构造函数就用overrides里定义的(如注释里的第2个例子就定义了constructor)，否则在生成一个缺省的
			//缺省的构造函数只是简单调用父类的构造函数
			sb = overrides.constructor != oc ? overrides.constructor : function() {	sp.apply(this, arguments);};
		}
		var spp = sp.prototype;
		//创建一个匿名类，和父类具有相同原型、但构造函数没有参数
		var F = function() {
		};
		F.prototype = spp;
		var sbp = sb.prototype = new F();// 设置子类的原型是匿名类的一个实例
		sbp.constructor = sb;// 重置、修正子类的constructor属性
		sb.superclass = spp;// 增加superclass属性，目的就是构造虚拟指针只想父类，让子类可以调用到父类的方法，包括构造方法
		
		// 只有当时两个参数的时候并且第一个参数是object；或者三个参数第二个参数是object的时候才会用到，其余没用到
		if (spp.constructor == oc) {
			spp.constructor = sp;
		}
		
		// 将overrides里的属性和方法拷贝给子类原型
		L5.override(sb, overrides);
		
		//子类增加静态方法override,方便替换子类原型的方法
		sb.override = function(o) {
			L5.override(sb, o);
		};
		
		//子类增加实例方法override，方便替换子类实例的方法
		sbp.override = io;		
		
		
		return sb;
	};
}();

/**
 * 给指定类增加属性或方法，覆盖原先的同名属性或方法 例如:
 * 
 * <pre><code>
 * L5.override(MyClass, {
 * 	newMethod1 : function() {
 * 		// etc.
 * },
 * newMethod2 : function(foo) {
 * 	// etc.
 * }
 * });
 * </code></pre>
 * 
 * @private
 * @param {Object}
 *            origclass 指定类
 * @param {Object}
 *            overrides 属性/方法集合
 * @method override
 */
L5.override = function(origclass, overrides) {
	if (overrides) {
		var p = origclass.prototype;
		for ( var method in overrides) {
			p[method] = overrides[method];
		}
		if (L5.isIE && overrides.toString != origclass.toString) {
			p.toString = overrides.toString;
		}
	}
};