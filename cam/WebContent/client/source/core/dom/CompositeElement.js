/**
 * 增加注释
 * CompositeElement和CompositeElementLite的区别：
 * 	1）this.elements不同，虽然都是数组，但是CompositeElement里面的元素是L5.Element而CompositeElementLite里面的是dom元素
 * 2）CompositeElement里面每个元素都是独立的，但是CompositeElementLite里面的元素共享一个L5.Element.Flyweight，当用到得时候为当前的this.elements里面的dom创建L5.element对象
 * 3）addListener的作用域不同，一个是L5Element一个是dom这个是由第二条引起的
 * @date 2011-05-20
 */
/**
 * @class L5.CompositeElement
 * 标准的复合元素类（一个该类的实例，实际上就是L5.Element的一个集合），给实例中的每个元素创建一个L5.Element对象。
 * <br><br>
 * <b>注意：当前类支持所有L5.Element类中的set/update方法，L5.Element类的所有动作也会在集合中的每个元素上执行。</b>
 * <br><br>
 * 所有的方法返回<i>this</i>。
 <pre><code>
 var els = L5.select("#some-el div.some-class", true);// 或者直接从已存在的元素中选择
 var el = L5.get('some-el');
 el.select('div.some-class', true);
 els.setWidth(100); //所有元素的宽度设置为100（相当于对每个元素都调用L5.Element中的els.setWidth方法）
 els.hide(true); // 所有元素设置为隐藏
 // 或者
 els.setWidth(100).hide(true);
 </code></pre>
 */
L5.CompositeElement = function(els){
    this.elements = [];
    this.addElements(els);
};
L5.CompositeElement.prototype = {
    isComposite: true,
    /**
     * 为L5.CompositeElement增加Elements
     * @param {Array/String} 要增加的Elements
     * @returns {L5.CompositeElement} 复合类对象本身
     */
    addElements : function(els){
        if(!els) return this;
        if(typeof els == "string"){
            els = L5.Element.selectorFunction(els);
        }
        var yels = this.elements;
        var index = yels.length-1;
        for(var i = 0, len = els.length; i < len; i++) {
        	yels[++index] = L5.get(els[i]);
        }
        return this;
    },

    /**
    * 清空集合并添加新的元素
    * @param {String/Array} els 一个CSS选择器，元素集合数组或者某个元素
    * @return {CompositeElement} this 当前对象
    */
    fill : function(els){
        this.elements = [];
        this.add(els);
        return this;
    },

    /**
    * 根据传入的选择器过滤当前对象
    * @param {String} selector 一个字符串类型的CSS选择器
    * @return {CompositeElement} this
    */
    filter : function(selector){
        var els = [];
        this.each(function(el){
            if(el.is(selector)){
                els[els.length] = el.dom;
            }
        });
        this.fill(els);
        return this;
    },

    invoke : function(fn, args){
        var els = this.elements;
        for(var i = 0, len = els.length; i < len; i++) {
        	L5.Element.prototype[fn].apply(els[i], args);
        }
        return this;
    },
    /**
    * 添加元素到当前容器对象
    * @param {String/Array} els 一个CSS选择器，元素集合数组或者某个元素
    * @return {CompositeElement} this
    */
    add : function(els){
        if(typeof els == "string"){
            this.addElements(L5.Element.selectorFunction(els));
        }else if(els.length !== undefined){
            this.addElements(els);
        }else{
            this.addElements([els]);
        }
        return this;
    },
    /**
    * 通过el、this、index参数为每个元素调用fn
    * @param {Function} fn 要调用的函数
    * @param {Object} scope (可选) <i>this</i>对象 (默认是元素对象)
    * @return {CompositeElement} this
    */
    each : function(fn, scope){
        var els = this.elements;
        for(var i = 0, len = els.length; i < len; i++){
            if(fn.call(scope || els[i], els[i], this, i) === false) {
                break;
            }
        }
        return this;
    },

    /**
     * 返回指定位置的元素对象
     * @param {Number} index 索引
     * @return {L5.Element}
     */
    item : function(index){
        return this.elements[index] || null;
    },

    /**
     * 返回第一个元素对象
     * @return {L5.Element}
     */
    first : function(){
        return this.item(0);
    },

    /**
     * 返回最后一个元素对象
     * @return {L5.Element}
     */
    last : function(){
        return this.item(this.elements.length-1);
    },

    /**
     * 返回容器的元素数目
     * @return {int} Number 数目
     */
    getCount : function(){
        return this.elements.length;
    },

    /**
     * 当前容器是否包含当前元素，是返回true
     * @param el {Mixed} 元素的id，或者L5.Element对象，或者是HtmlElement
     * @return Boolean
     */
    contains : function(el){
        return this.indexOf(el) !== -1;
    },

    /**
     * 查找对象在容器集合中的索引位置
     * @param el {Mixed} 元素的id，或者L5.Element对象，或者是HtmlElement
     * @return Number 索引，如果没有找到返回-1
     */
    indexOf : function(el){
        return this.elements.indexOf(L5.get(el));
    },


    /**
    * 移除指定的元素对象
    * @param {Mixed} el 元素对象的id，元素对象本身，元素对象在容器中的位置或者数组集合
    * @param {Boolean} removeDom (可选) 是否从DOM对象中删除
    * @return {CompositeElement} this
    */
    removeElement : function(el, removeDom){
        if(L5.isArray(el)){
            for(var i = 0, len = el.length; i < len; i++){
                this.removeElement(el[i]);
            }
            return this;
        }
        var index = typeof el == 'number' ? el : this.indexOf(el);
        if(index !== -1 && this.elements[index]){
            if(removeDom){
                var d = this.elements[index];
                if(d.dom){
                    d.remove();
                }else{
                    L5.removeNode(d);
                }
            }
            this.elements.splice(index, 1);
        }
        return this;
    },

    /**
    * 替换指定对象为传入的对象
    * @param {Mixed} el 元素对象的id，元素对象本身，要替换元素对象在容器中的位置
    * @param {Mixed} replacement 元素对象的id或者对象本身
    * @param {Boolean} domReplace (可选) 是否从DOM对象中移除和替换元素对象
    * @return {CompositeElement} this
    */
    replaceElement : function(el, replacement, domReplace){
        var index = typeof el == 'number' ? el : this.indexOf(el);
        if(index !== -1){
            if(domReplace){
                this.elements[index].replaceWith(replacement);
            }else{
                this.elements.splice(index, 1, L5.get(replacement))
            }
        }
        return this;
    },

    /**
     * 清除所有元素
     * 
     */
    clear : function(){
        this.elements = [];
    }
};
/**
 * 实现了将L5.Element里面所有的方法都拷贝一份给L5.CompositeElement，同时调用的时候会为L5.CompositeElement里面的每个元素都调用
 * 一次L5.Element里面的方法
 * 假设els是L5.CompositeElement的一个实例：
 * els.setWidth(100); //所有元素的宽度设置为100（相当于对每个元素都调用L5.Element中的els.setWidth方法）
 * els.hide(true); // 所有元素设置为隐藏
 */
(function() {
	L5.CompositeElement.createCall = function(proto, fnName) {
		if (!proto[fnName]) {
			proto[fnName] = function() {
				return this.invoke(fnName, arguments);
			};
		}
	};
	for (var fnName in L5.Element.prototype) {
		if (typeof L5.Element.prototype[fnName] == "function") {
			L5.CompositeElement.createCall(L5.CompositeElement.prototype,
					fnName);
		}
	};
})();

/**
 * @class L5.CompositeElementLite
 * @extends L5.CompositeElement 轻量级的容器类，使用L5.Element对象中的操作
 * 
 * <pre><code>
 * var els = L5.select(&quot;#some-el div.some-class&quot;);
 * // 或者直接从已存在的元素中选择
 * var el = L5.get('some-el');
 * el.select('div.some-class');
 * els.setWidth(100); // 所有元素的宽度设置为100
 * els.hide(true); // 所有元素设置为隐藏
 * // 或者
 * els.setWidth(100).hide(true);
 * </code></pre>
 * 
 * <br>
 */
L5.CompositeElementLite = function(els){
    L5.CompositeElementLite.superclass.constructor.call(this, els);
    this.el = new L5.Element.Flyweight();
};
L5.extend(L5.CompositeElementLite, L5.CompositeElement, {
    addElements : function(els){
        if(els){
            if(L5.isArray(els)){
                this.elements = this.elements.concat(els);
            }else{
                var yels = this.elements;
                var index = yels.length-1;
                for(var i = 0, len = els.length; i < len; i++) {
                    yels[++index] = els[i];
                }
            }
        }
        return this;
    },
    /**
     * @private 实现了通过方法名，调用L5.Element里面方法的功能
     */
    invoke : function(fn, args){
        var els = this.elements;
        var el = this.el;
        for(var i = 0, len = els.length; i < len; i++) {
            el.dom = els[i];
        	L5.Element.prototype[fn].apply(el, args);
        }
        return this;
    },
    /**
     * 返回指定位置的元素对象
     * @param {Number} index 索引
     * @return {L5.Element}
     */
    item : function(index){
        if(!this.elements[index]){
            return null;
        }
        this.el.dom = this.elements[index];
        return this.el;
    },
    /**
     * 为CompositeElementLite里面每个Element都是用addListener，注册事件监听
     */
    // fixes scope with flyweight
    addListener : function(eventName, handler, scope, opt){
        var els = this.elements;
        for(var i = 0, len = els.length; i < len; i++) {
            L5.EventManager.on(els[i], eventName, handler, scope || els[i], opt);
        }
        return this;
    },

    /**
    * 通过el、this、index参数为每个元素调用fn
    * @param {Function} fn 要调用的函数
    * @param {Object} scope (可选) <i>this</i>对象 (默认是元素对象)
    * @return {CompositeElement} this
    */
    each : function(fn, scope){
        var els = this.elements;
        var el = this.el;
        for(var i = 0, len = els.length; i < len; i++){
            el.dom = els[i];
        	if(fn.call(scope || el, el, this, i) === false){
                break;
            }
        }
        return this;
    },
    /**
     * @return {int} Element在CompositeElement中的索引
     */
    indexOf : function(el){
    	//this.elements是一个数组，框架扩展了数组的indexOf
        return this.elements.indexOf(L5.getDom(el));
    },
    /**
     * 用心的新的Element（replacement）替换旧的Element（el），如果domReplace为true将会用新的Element的dom替换旧的dom
     * @param {L5.ELement} el 被替换的旧的Element
     * @param {L5.ELement} replacement 新的Element
     * @param {Boolean} domReplace 是否替换dom
     * @return {L5.CompositeElementLite} 返回复合对象本身
     */
    replaceElement : function(el, replacement, domReplace){
        var index = typeof el == 'number' ? el : this.indexOf(el);
        if(index !== -1){
            replacement = L5.getDom(replacement);
            if(domReplace){
                var d = this.elements[index];
                d.parentNode.insertBefore(replacement, d);
                L5.removeNode(d);
            }
            this.elements.splice(index, 1, replacement);
        }
        return this;
    }
});
L5.CompositeElementLite.prototype.on = L5.CompositeElementLite.prototype.addListener;
if(L5.DomQuery){
    L5.Element.selectorFunction = L5.DomQuery.select;
}
/**
 * 通过css选择器，创建一个CompositeElement/CompositeElementLite复合对象
 * CompositeElement和CompositeElementLite的区别：
 * 	1）this.elements不同，虽然都是数组，但是CompositeElement里面的元素是L5.Element而CompositeElementLite里面的是dom元素
 * 2）CompositeElement里面每个元素都是独立的，但是CompositeElementLite里面的元素共享一个L5.Element.Flyweight，当用到得时候为当前的this.elements里面的dom创建L5.element对象
 * 3）addListener的作用域不同，一个是L5Element一个是dom这个是由第二条引起的
 * Creates a {@link L5.CompositeElement} for child nodes based on the passed CSS selector (the selector should not contain an id).
 * @param {String} selector The CSS selector
 * @param {Boolean} unique (optional) True to create a unique L5.Element for each child (defaults to false, which creates a single shared flyweight object)
 * @return {CompositeElement/CompositeElementLite} The composite element
 */
L5.Element.select = function(selector, unique, root){
    var els;
    if(typeof selector == "string"){
        els = L5.Element.selectorFunction(selector, root);
    }else if(selector.length !== undefined){
        els = selector;
    }else{
        throw "Invalid selector";
    }
    if(unique === true){
        return new L5.CompositeElement(els);
    }else{
        return new L5.CompositeElementLite(els);
    }
};
/**
 * 通过css选择器，创建一个CompositeElement/CompositeElementLite复合对象
 * @param {String/Array} selector CSS选择器或者元素对象集合
 * @param {Boolean} unique (可选) 为每一个元素单独创建L5.Element对象 (默认共享一个轻量级对象)
 * @param {HTMLElement/String} root (可选) 查询的根元素或者根元素的id
 * @return {CompositeElementLite/CompositeElement}
 * @member L5
 * @method select
 */
L5.select = L5.Element.select;