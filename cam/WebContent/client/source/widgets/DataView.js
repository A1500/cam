/**
 * @class L5.DataView
 * @extends L5.BoxComponent
 * 提供一个可以按照自定义格式和模板显示数据的机制。DataView使用了{@link L5.XTemplate}，并且将视图与{@link L5.model.Dataset}
 * 绑定，使得数据的变动自动的反映到试图上。这个视图还提供了许多事件比如click，doubleclick等，以及一个内置的选择模型。为了使用
 * 这些特性，我们需要提供一个CSS选择器（{@link #itemSelector}）。
 *
 * <p>下面的例子是一个DataView绑定一个{@link L5.model.Dataset}并渲染到一个{@link L5.Panel}.</p>
 * <pre><code>
var dataset = new L5.model.JsonDataset({
    url: 'get-images.php',
    root: 'images',
    fields: [
        'name', 'url',
        {name:'size', type: 'float'},
        {name:'lastmod', type:'date', dateFormat:'timestamp'}
    ]
});
dataset.load();

var tpl = new L5.XTemplate(
    '&lt;tpl for="."&gt;',
        '&lt;div class="thumb-wrap" id="{name}"&gt;',
        '&lt;div class="thumb"&gt;&lt;img src="{url}" title="{name}"&gt;&lt;/div&gt;',
        '&lt;span class="l-editable"&gt;{shortName}&lt;/span&gt;&lt;/div&gt;',
    '&lt;/tpl&gt;',
    '&lt;div class="l-clear"&gt;&lt;/div&gt;'
);

var panel = new L5.Panel({
    id:'images-view',
    frame:true,
    width:535,
    autoHeight:true,
    collapsible:true,
    layout:'fit',
    title:'Simple DataView',

    items: new L5.DataView({
        dataset: dataset,
        tpl: tpl,
        autoHeight:true,
        multiSelect: true,
        overClass:'l-view-over',
        itemSelector:'div.thumb-wrap',
        emptyText: 'No images to display'
    })
});
panel.render(document.body);
</code></pre>
 * @constructor
 * @param {Object} config 配置对象
 */
L5.DataView = L5.extend(L5.BoxComponent, {
    /**
     * @cfg {String/Array/L5.XTemplate} tpl
     * 一个或者一组HTML代码片段,用来生成DataView的模板用的。或者直接是一个模板对象也可以
     */
    /**
     * @cfg {L5.model.Dataset} dataset
     * 和DataView绑定的{@link L5.model.Dataset}
     */
    /**
     * @cfg {String} itemSelector
     * 这个配置项是必须有的。一个简单的CSS选择符（例如 div.some-class 或者 span:first-child），这个选择符将用来确定哪些是
     * DataView的有效节点
     */
    /**
     * @cfg {Boolean} multiSelect
     * 如果是true将允许同时选择多个dataview的节点，false仅允许选择一个，同时也参考 {@link #singleSelect} 。(默认 false).
     */
    /**
     * @cfg {Boolean} singleSelect
     * 如果是true，只能选择一个节点，如果是false不允许选择（默认是false）。注意：当{@link #multiSelect} = true, 这个配置项将被忽略。
     */
    /**
     * @cfg {Boolean} simpleSelect
     * 如果是true，当多选的时候允许单击节点就选中节点，而不必按住Shift或Ctrl键。如果是false，则必须按住Shift或Ctrl键
     * 才能选中多个。（默认是false）
     */
    /**
     * @cfg {String} overClass
     * 当鼠标悬浮在节点的时候的CSS样式(默认是 undefined).
     */
    /**
     * @cfg {String} loadingText
     * 当数据加载的时候显示的文本信息（默认是undefined）
     */
    /**
     * @cfg {String} selectedClass
     * 当DataView节点选中的时候的CSS样式（默认是'l-view-selected'）。
     */
    selectedClass : "l-view-selected",
    /**
     * @cfg {String} emptyText
     * 当没有数据显示的时候，页面显示的文本信息。（默认是“”）
     */
    emptyText : "",

    /**
     * @cfg {Boolean} deferEmptyText 
     * true，推迟应用允许emptyText直到dataset第一次加载后。
     * True to defer emptyText being applied until the dataset's first load
     */
    deferEmptyText: true,
    /**
     * @cfg {Boolean} trackOver 
     * 如果是true，允许mouseenter 和 mouseleave事件
     */
    trackOver: false,

    /**
     * @private
     */
    last: false,


    /**
     * @private
     */
    initComponent : function(){
        L5.DataView.superclass.initComponent.call(this);
        if(typeof this.tpl == "string"){
            this.tpl = new L5.XTemplate(this.tpl);
        }

        this.addEvents(
            /**
             * @event beforeclick
             * 当节点单击事件触发前触发。如果返回false取消单击事件。
             * @param {L5.DataView} this
             * @param {Number} index 目标节点的索引
             * @param {HTMLElement} node 目标界节点
             * @param {L5.EventObject} e 事件对象
             */
            "beforeclick",
            /**
             * @event click
             * Fires when a template node is clicked.
             * @param {L5.DataView} this
             * @param {Number} index The index of the target node
             * @param {HTMLElement} node The target node
             * @param {L5.EventObject} e The raw event object
             */
            "click",
            /**
             * @event mouseenter
             * Fires when the mouse enters a template node. trackOver:true or an overCls must be set to enable this event.
             * @param {L5.DataView} this
             * @param {Number} index The index of the target node
             * @param {HTMLElement} node The target node
             * @param {L5.EventObject} e The raw event object
             */
            "mouseenter",
            /**
             * @event mouseleave
             * Fires when the mouse leaves a template node. trackOver:true or an overCls must be set to enable this event.
             * @param {L5.DataView} this
             * @param {Number} index The index of the target node
             * @param {HTMLElement} node The target node
             * @param {L5.EventObject} e The raw event object
             */
            "mouseleave",
            /**
             * @event containerclick
             * Fires when a click occurs and it is not on a template node.
             * @param {L5.DataView} this
             * @param {L5.EventObject} e The raw event object
             */
            "containerclick",
            /**
             * @event dblclick
             * Fires when a template node is double clicked.
             * @param {L5.DataView} this
             * @param {Number} index The index of the target node
             * @param {HTMLElement} node The target node
             * @param {L5.EventObject} e The raw event object
             */
            "dblclick",
            /**
             * @event contextmenu
             * Fires when a template node is right clicked.
             * @param {L5.DataView} this
             * @param {Number} index The index of the target node
             * @param {HTMLElement} node The target node
             * @param {L5.EventObject} e The raw event object
             */
            "contextmenu",
            /**
             * @event selectionchange
             * Fires when the selected nodes change.
             * @param {L5.DataView} this
             * @param {Array} selections Array of the selected nodes
             */
            "selectionchange",

            /**
             * @event beforeselect
             * Fires before a selection is made. If any handlers return false, the selection is cancelled.
             * @param {L5.DataView} this
             * @param {HTMLElement} node The node to be selected
             * @param {Array} selections Array of currently selected nodes
             */
            "beforeselect"
        );

        this.all = new L5.CompositeElementLite();
        this.selected = new L5.CompositeElementLite();
    },

    /**
     * @private
     */
    onRender : function(){
        if(!this.el){
            this.el = document.createElement('div');
            this.el.id = this.id;
        }
        L5.DataView.superclass.onRender.apply(this, arguments);
    },

    /**
     * @private
     */
    afterRender : function(){
        L5.DataView.superclass.afterRender.call(this);

        this.el.on({
            "click": this.onClick,
            "dblclick": this.onDblClick,
            "contextmenu": this.onContextMenu,
            scope:this
        });

        if(this.overClass || this.trackOver){
            this.el.on({
                "mouseover": this.onMouseOver,
                "mouseout": this.onMouseOut,
                scope:this
            });
        }

        if(this.dataset){
            this.setDataset(this.dataset, true);
        }
    },

    /**
     * 通过刷新数据来实现刷新视图的功能。
     * @private
     */
    refresh : function(){
        this.clearSelections(false, true);
        this.el.update("");
        var records = this.dataset.getRange();
        if(records.length < 1){
            if(!this.deferEmptyText || this.hasSkippedEmptyText){
                this.el.update(this.emptyText);
            }
            this.hasSkippedEmptyText = true;
            this.all.clear();
            return;
        }
        this.tpl.overwrite(this.el, this.collectData(records, 0));
        this.all.fill(L5.query(this.itemSelector, this.el.dom));
        this.updateIndexes(0);
    },

    /**
     * 可以用来被重写的方法，提供自定义格式化数据的功能，被作用于DataView的 {@link #tpl template} 用来渲染每一个节点.
     * @param {Array/Object} data 原始数据.
     * @param {Number} recordIndex rencord的索引
     * @param {Record} record record对象
     * @return {Array/Object} 返回格式化以后的数据。将被应用到模板{@link #tpl template}的overwrite方法中。
     */
    prepareData : function(data){
    	var htmlValue = /\<|\>/;
		if(htmlValue.test(data.text)) {
			data.text = L5.util.Format.htmlEncode(data.text);
		}
        return data;
    },

    /**这个方法可以被重写，该方法返回的数据对象将被应用于DataView的 {@link #tpl template} 渲染数据，通常返回一个数组，每个数组
     * 元素都作用于 {@link L5.XTemplate XTemplate} 。
     * @param records {Array} 一个 {@link L5.model.Record}的数组
     * @return {Array} An 返回一个数组，数据已经被处理过。
     */
    collectData : function(records, startIndex){
        var r = [];
        for(var i = 0, len = records.length; i < len; i++){
            r[r.length] = this.prepareData(records[i].data, startIndex+i, records[i]);
        }
        return r;
    },

    /**
     * @private
     */
    bufferRender : function(records){
        var div = document.createElement('div');
        this.tpl.overwrite(div, this.collectData(records));
        return L5.query(this.itemSelector, div);
    },

    /**
     * @private
     */
    onUpdate : function(ds, record){
        var index = this.dataset.indexOf(record);
        var sel = this.isSelected(index);
        var original = this.all.elements[index];
        var node = this.bufferRender([record], index)[0];

        this.all.replaceElement(index, node, true);
        if(sel){
            this.selected.replaceElement(original, node);
            this.all.item(index).addClass(this.selectedClass);
        }
        this.updateIndexes(index, index);
    },

    /**
     * @private
     */
    onAdd : function(ds, records, index){
        if(this.all.getCount() == 0){
            this.refresh();
            return;
        }
        var nodes = this.bufferRender(records, index), n, a = this.all.elements;
        if(index < this.all.getCount()){
            n = this.all.item(index).insertSibling(nodes, 'before', true);
            a.splice.apply(a, [index, 0].concat(nodes));
        }else{
            n = this.all.last().insertSibling(nodes, 'after', true);
            a.push.apply(a, nodes);
        }
        this.updateIndexes(index);
    },

    /**
     * @private
     */
    onRemove : function(ds, record, index){
        this.deselect(index);
        this.all.removeElement(index, true);
        this.updateIndexes(index);
    },

    /**
     * 刷新节点数据
     * @param {Number} index 节点索引
     */
    refreshNode : function(index){
        this.onUpdate(this.dataset, this.dataset.getAt(index));
    },

    /**
     * @private
     */
    updateIndexes : function(startIndex, endIndex){
        var ns = this.all.elements;
        startIndex = startIndex || 0;
        endIndex = endIndex || ((endIndex === 0) ? 0 : (ns.length - 1));
        for(var i = startIndex; i <= endIndex; i++){
            ns[i].viewIndex = i;
        }
    },
    
    /**
     * 返回和DataView绑定的数据模型
     * @return {L5.model.Dataset} The dataset
     */
    getDataset : function(){
        return this.dataset;
    },

    /**
     * 设置DataView绑定的数据结构，并刷新
     * @param {Dataset} dataset 绑定到View的数据模型
     */
    setDataset : function(ds, initial){
        if(!initial && this.dataset){
            this.dataset.un("beforeload", this.onBeforeLoad, this);
            this.dataset.un("datachanged", this.refresh, this);
            this.dataset.un("add", this.onAdd, this);
            this.dataset.un("remove", this.onRemove, this);
            this.dataset.un("update", this.onUpdate, this);
            this.dataset.un("clear", this.refresh, this);
        }
        if(ds){
            _ds = L5.DatasetMgr.lookup(ds);
            _ds.on("beforeload", this.onBeforeLoad, this);
            _ds.on("datachanged", this.refresh, this);
            _ds.on("add", this.onAdd, this);
            _ds.on("remove", this.onRemove, this);
            _ds.on("update", this.onUpdate, this);
            _ds.on("clear", this.refresh, this);
        }
        this.dataset = _ds;
        if(ds){
            this.refresh();
        }
    },

    /**
     * 通过子元素信息获取所属的节点信息，如果不属于任何节点返回null
     * @param {HTMLElement} 节点
     * @return {HTMLElement} 返回节点模板信息
     */
    findItemFromChild : function(node){
        return L5.fly(node).findParent(this.itemSelector, this.el);
    },

    /**
     * @private
     */
    onClick : function(e){
        var item = e.getTarget(this.itemSelector, this.el);
        if(item){
            var index = this.indexOf(item);
            if(this.onItemClick(item, index, e) !== false){
                this.fireEvent("click", this, index, item, e);
            }
        }else{
            if(this.fireEvent("containerclick", this, e) !== false){
                this.clearSelections();
            }
        }
    },

    /**
     * @private
     */
    onContextMenu : function(e){
        var item = e.getTarget(this.itemSelector, this.el);
        if(item){
            this.fireEvent("contextmenu", this, this.indexOf(item), item, e);
        }
    },

    /**
     * @private
     */
    onDblClick : function(e){
        var item = e.getTarget(this.itemSelector, this.el);
        if(item){
            this.fireEvent("dblclick", this, this.indexOf(item), item, e);
        }
    },

    /**
     * @private
     */
    onMouseOver : function(e){
        var item = e.getTarget(this.itemSelector, this.el);
        if(item && item !== this.lastItem){
            this.lastItem = item;
            L5.fly(item).addClass(this.overClass);
            this.fireEvent("mouseenter", this, this.indexOf(item), item, e);
        }
    },

    /**
     * @private
     */
    onMouseOut : function(e){
        if(this.lastItem){
            if(!e.within(this.lastItem, true, true)){
                L5.fly(this.lastItem).removeClass(this.overClass);
                this.fireEvent("mouseleave", this, this.indexOf(this.lastItem), this.lastItem, e);
                delete this.lastItem;
            }
        }
    },

    /**
     * @private
     */
    onItemClick : function(item, index, e){
        if(this.fireEvent("beforeclick", this, index, item, e) === false){
            return false;
        }
        if(this.multiSelect){
            this.doMultiSelection(item, index, e);
            e.preventDefault();
        }else if(this.singleSelect){
            this.doSingleSelection(item, index, e);
            e.preventDefault();
        }
        return true;
    },

    /**
     * @private
     */
    doSingleSelection : function(item, index, e){
        if(e.ctrlKey && this.isSelected(index)){
            this.deselect(index);
        }else{
            this.select(index, false);
        }
    },

    /**
     * @private
     */
    doMultiSelection : function(item, index, e){
        if(e.shiftKey && this.last !== false){
            var last = this.last;
            this.selectRange(last, index, e.ctrlKey);
            this.last = last; // reset the last
        }else{
            if((e.ctrlKey||this.simpleSelect) && this.isSelected(index)){
                this.deselect(index);
            }else{
                this.select(index, e.ctrlKey || e.shiftKey || this.simpleSelect);
            }
        }
    },

    /**
     * 获取选中节点的数目
     * @return {Number} 返回选中的节点的数目
     */
    getSelectionCount : function(){
        return this.selected.getCount()
    },

    /**
     * 获取选中的节点
     * @return {Array} 数组，选中节点的DOM
     */
    getSelectedNodes : function(){
        return this.selected.elements;
    },

    /**
     * 返回选中节点的索引信息
     * @return {Array} 选中的节点的索引（数组）
     */
    getSelectedIndexes : function(){
        var indexes = [], s = this.selected.elements;
        for(var i = 0, len = s.length; i < len; i++){
            indexes.push(s[i].viewIndex);
        }
        return indexes;
    },

    /**
     * 获取选中节点的{@link L5.model.Record}
     * @return {Array} 返回{@link L5.model.Record} 数组
     */
    getSelectedRecords : function(){
        var r = [], s = this.selected.elements;
        for(var i = 0, len = s.length; i < len; i++){
            r[r.length] = this.dataset.getAt(s[i].viewIndex);
        }
        return r;
    },

    /**
     * 从一组节点中获取对应的{@link L5.model.Record}信息
     * @param {Array} nodes 节点数组
     * @return {Array} records  {@link L5.model.Record} 数组
     */
    getRecords : function(nodes){
        var r = [], s = nodes;
        for(var i = 0, len = s.length; i < len; i++){
            r[r.length] = this.dataset.getAt(s[i].viewIndex);
        }
        return r;
    },

    /**
     * 从节点获取{@link L5.model.Record}信息
     * @param {HTMLElement} 节点DOM信息
     * @return {Record} record 返回 {@link L5.model.Record} 
     */
    getRecord : function(node){
        return this.dataset.getAt(node.viewIndex);
    },

    /**
     * 清空所有的选择结果
     * @param {Boolean} suppressEvent (可选) 如果是true不发出事件
     */
    clearSelections : function(suppressEvent, skipUpdate){
        if((this.multiSelect || this.singleSelect) && this.selected.getCount() > 0){
            if(!skipUpdate){
                this.selected.removeClass(this.selectedClass);
            }
            this.selected.clear();
            this.last = false;
            if(!suppressEvent){
                this.fireEvent("selectionchange", this, this.selected.elements);
            }
        }
    },

    /**
     * 判断一个节点是否选中
     * @param {HTMLElement/Number} node 节点或者节点的索引
     * @return {Boolean} 假如被选中返回true
     */
    isSelected : function(node){
        return this.selected.contains(this.getNode(node));
    },

    /**
     * 反选一个节点
     * @param {HTMLElement/Number} node 反选的节点
     */
    deselect : function(node){
        if(this.isSelected(node)){
            node = this.getNode(node);
            this.selected.removeElement(node);
            if(this.last == node.viewIndex){
                this.last = false;
            }
            L5.fly(node).removeClass(this.selectedClass);
            this.fireEvent("selectionchange", this, this.selected.elements);
        }
    },

    /**
     * 选择一个节点
     * @param {Array/HTMLElement/String/Number} nodeInfo 一个节点的HTML元素信息或者节点索引或者节点的id
     * @param {Boolean} keepExisting (可选) 如果是true保持已经选中的
     * @param {Boolean} suppressEvent (可选) 如果是true不发出事件
     */
    select : function(nodeInfo, keepExisting, suppressEvent){
        if(L5.isArray(nodeInfo)){
            if(!keepExisting){
                this.clearSelections(true);
            }
            for(var i = 0, len = nodeInfo.length; i < len; i++){
                this.select(nodeInfo[i], true, true);
            }
	        if(!suppressEvent){
	            this.fireEvent("selectionchange", this, this.selected.elements);
	        }
        } else{
            var node = this.getNode(nodeInfo);
            if(!keepExisting){
                this.clearSelections(true);
            }
            if(node && !this.isSelected(node)){
                if(this.fireEvent("beforeselect", this, node, this.selected.elements) !== false){
                    L5.fly(node).addClass(this.selectedClass);
                    this.selected.add(node);
                    this.last = node.viewIndex;
                    if(!suppressEvent){
                        this.fireEvent("selectionchange", this, this.selected.elements);
                    }
                }
            }
        }
    },

    /**
     * 选择一个区间的所有节点。
     * @param {Number} start 区间的开始索引
     * @param {Number} end 区间的结束索引
     * @param {Boolean} keepExisting (可选) 如果是true保持已经选中的
     */
    selectRange : function(start, end, keepExisting){
        if(!keepExisting){
            this.clearSelections(true);
        }
        this.select(this.getNodes(start, end), true);
    },

    /**
     * 获取节点
     * @param {HTMLElement/String/Number} nodeInfo  一个节点的HTML元素信息或者节点索引或者节点的id
     * @return {HTMLElement} 返回获取的节点，如果没找到返回null
     */
    getNode : function(nodeInfo){
        if(typeof nodeInfo == "string"){
            return document.getElementById(nodeInfo);
        }else if(typeof nodeInfo == "number"){
            return this.all.elements[nodeInfo];
        }
        return nodeInfo;
    },

    /**
     * 获取区间的节点信息
     * @param {Number} start (可选) 区间的开始索引
     * @param {Number} end (可选) 区间的结束索引
     * @return {Array} 节点的数组
     */
    getNodes : function(start, end){
        var ns = this.all.elements;
        start = start || 0;
        end = typeof end == "undefined" ? Math.max(ns.length - 1, 0) : end;
        var nodes = [], i;
        if(start <= end){
            for(i = start; i <= end && ns[i]; i++){
                nodes.push(ns[i]);
            }
        } else{
            for(i = start; i >= end && ns[i]; i--){
                nodes.push(ns[i]);
            }
        }
        return nodes;
    },

    /**
     * 获取节点的索引
     * @param {HTMLElement/String/Number} nodeInfo 一个节点的HTML元素信息或者节点索引或者节点的id
     * @return {Number} 返回节点的索引如果没找到返回-1
     */
    indexOf : function(node){
        node = this.getNode(node);
        if(typeof node.viewIndex == "number"){
            return node.viewIndex;
        }
        return this.all.indexOf(node);
    },

    /**
     * @private
     */
    onBeforeLoad : function(){
        if(this.loadingText){
            this.clearSelections(false, true);
            this.el.update('<div class="loading-indicator">'+this.loadingText+'</div>');
            this.all.clear();
        }
    },
    /**
     * @private
     */
    onDestroy : function(){
        L5.DataView.superclass.onDestroy.call(this);
        this.setDataset(null);
    }
});

L5.reg('dataview', L5.DataView);