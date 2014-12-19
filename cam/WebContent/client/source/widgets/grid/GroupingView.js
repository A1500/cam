/**
 * @class L5.grid.GroupingView
 * @extends L5.grid.GridView
 * 为grid增加了单级分组的功能
 *<pre><code>var grid = new L5.grid.GridPanel({
    // A groupingDataset is required for a GroupingView
    dataset: new L5.model.GroupingDataset({
        reader: reader,
        data: xg.dummyData,
        sortInfo:{field: 'company', direction: "ASC"},
        groupField:'industry'
    }),

    columns: [
        {id:'company',header: "Company", width: 60, sortable: true, field: 'company'},
        {header: "Price", width: 20, sortable: true, renderer: L5.util.Format.usMoney, field: 'price'},
        {header: "Change", width: 20, sortable: true, field: 'change', renderer: L5.util.Format.usMoney},
        {header: "Industry", width: 20, sortable: true, field: 'industry'},
        {header: "Last Updated", width: 20, sortable: true, renderer: L5.util.Format.dateRenderer('m/d/Y'), field: 'lastChange'}
    ],

    view: new L5.grid.GroupingView({
        forceFit:true,
        // custom grouping text template to display the number of items per group
        groupTextTpl: '{text} ({[values.rs.length]} {[values.rs.length > 1 ? "Items" : "Item"]})'
    }),

    frame:true,
    width: 700,
    height: 450,
    collapsible: true,
    animCollapse: false,
    title: 'Grouping Example',
    iconCls: 'icon-grid',
    renderTo: document.body
});</code></pre>
 * @constructor
 * @param {Object} config
 */
L5.grid.GroupingView = L5.extend(L5.grid.GridView, {
    /**
     * @cfg {Boolean} hideGroupedColumn 
     * 如果是true，隐藏当前分组的列，默认是false
     */
    hideGroupedColumn:false,
    /**
     * @cfg {Boolean} showGroupName 
     * 如果是true，为每个分组集合显示分组字段名称(默认是true）
     */
    showGroupName:true,
    /**
     * @cfg {Boolean} startCollapsed
     * 如果是true，分组后各组都会收缩不展开。（默认是false）
     */
    startCollapsed:false,
    /**
     * @cfg {Boolean} enableGrouping 
     * 如果是false，禁用分组功能（默认是true）
     */
    enableGrouping:true,
    /**
     * @cfg {Boolean} enableGroupingMenu 
     * 如果是true，在列的菜单启用分组控制菜单
     */
    enableGroupingMenu:true,
    /**
     * @cfg {Boolean} enableNoGroups 
     * 如果是true允许用户关闭分组
     * True to allow the user to turn off grouping
     */
    enableNoGroups:true,
    /**
     * @cfg {String} emptyGroupText 
     * 当分组计算值是空的时候显示的内容
     */
    emptyGroupText : '(None)',
    /**
     * @cfg {Boolean} ignoreAdd 
     * 如果是true，当增加行的时候不刷新视图。（默认是false）
     */
    ignoreAdd: false,
    /**
     * @cfg {String} groupTextTpl 
     * 这个配置属性用来当作分组表头的渲染的模板，用来格式化一个对象，该对象可以包含下面这些属性：
     * <div class="mdetail-params"><ul>
     * <li><b>group</b> : String<p class="sub-desc">分组字段的对应的列的显示的值。通常情况下这个值不会改变，就是数据模型中该字段的值
     * 假如有groupRenderer自定义的方法，那么这个值就是groupRenderer返回的值
     * <li><b>gvalue</b> : Object<p class="sub-desc">该字段对应的最原始的值（假如有groupRenderer那就是在处理之前的值）</p></li>
     * <li><b>text</b> : String<p class="sub-desc">假如showGroupName是true的时候，分组集合显示的分组名称（默认显示列配置项的header属性的值）.</p></li>
     * <li><b>groupId</b> : String<p class="sub-desc">一个唯一的自动生成的ID，将会应用到分组视图的元素
     * <li><b>startRow</b> : Number<p class="sub-desc">引起分组改变的record的索引.</p></li>
     * <li><b>rs</b> : Array<p class="sub-desc">record的数组，这个数组包含了该符合分组条件的一组数据.</p></li>
     * <li><b>cls</b> : String<p class="sub-desc">应用到分组显示信息出的CSS类名.</p></li>
     * <li><b>style</b> : String<p class="sub-desc">内联样式规则，适用于该组头元素.</p></li>
     * </ul></div></p>
     * See {@link L5.XTemplate} 如何用模板格式化数据
     */
    groupTextTpl : '{text}',
    /**
     * @cfg {Function} groupRenderer 
     * 该方法，用于格式化分组字段，需要返回一个字符串，格式化后的值作为分组的依据，比如：
     * 	record[0]中的name格式化后是jack，
     * record[1]中的name格式化后是tom，
     * record[2]中的name格式化后是jack，
     * 那么分组的时候将record[0]和record[2]分到一组。
     * 支持如下参数：
     * <div class="mdetail-params"><ul>
     * <li><b>v</b> : Object<p class="sub-desc">处理前分组字段对应的值.</p></li>
     * <li><b>unused</b> : undefined<p class="sub-desc">暂时未用到该参数.</p></li>
     * <li><b>r</b> : L5.model.Record<p class="sub-desc">当前行对应的record</p></li>
     * <li><b>rowIndex</b> : Number<p class="sub-desc">当前行的索引</p></li>
     * <li><b>colIndex</b> : Number<p class="sub-desc">当前字段所在列的索引</p></li>
     * <li><b>ds</b> : L5.model.Dataset<p class="sub-desc">这个grid绑定的数据模型DataSet</p></li>
     * </ul></div></p>
     */
    /**
     * @cfg {String} groupName 
     * 在分组标题栏，为每组显示的分组名称，如果没有定义groupName，那么分组名称取该列的header
     */
    /**
     * @cfg {String} header 
     * 用于分组标题行的字段值
     */

    /**
     * @private
     */
    gidSeed : 1000,

    /**
     * 初始化模板，首先调用父类（gridView）的初始化模板的方法，然后增加了一个分组标题行模板
     */
    initTemplates : function(){
        L5.grid.GroupingView.superclass.initTemplates.call(this);
        this.state = {};

        var sm = this.grid.getSelectionModel();
        sm.on(sm.selectRow ? 'beforerowselect' : 'beforecellselect',
                this.onBeforeRowSelect, this);

        if(!this.startGroup){
            this.startGroup = new L5.XTemplate(
                '<div id="{groupId}" class="l-grid-group {cls}">',
                    '<div id="{groupId}-hd" class="l-grid-group-hd" style="{style}"><div>', this.groupTextTpl ,'</div></div>',
                    '<div id="{groupId}-bd" class="l-grid-group-body">'
            );
        }
        this.startGroup.compile();
        this.endGroup = '</div></div>';
    },

    /**
     * @private
     */
    findGroup : function(el){
        return L5.fly(el).up('.l-grid-group', this.mainBody.dom);
    },

    /**
     * @private
     */
    getGroups : function(){
        return this.hasRows() ? this.mainBody.dom.childNodes : [];
    },

    /**
     * @private
     */
    onAdd : function(){
        if(this.enableGrouping && !this.ignoreAdd){
            var ss = this.getScrollState();
            this.refresh();
            this.restoreScroll(ss);
        }else if(!this.enableGrouping){
            L5.grid.GroupingView.superclass.onAdd.apply(this, arguments);
        }
    },

    /**
     * @private
     */
    onRemove : function(ds, record, index, isUpdate){
        L5.grid.GroupingView.superclass.onRemove.apply(this, arguments);
        var g = document.getElementById(record._groupId);
        if(g && g.childNodes[1].childNodes.length < 1){
            L5.removeNode(g);
        }
        this.applyEmptyText();
    },

    /**
     * @private
     * 刷新某一行的数据
     * @param {L5.model.Record} record 该行对应的record
     */
    refreshRow : function(record){
        if(this.ds.getCount()==1){
            this.refresh();
        }else{
            this.isUpdating = true;
            L5.grid.GroupingView.superclass.refreshRow.apply(this, arguments);
            this.isUpdating = false;
        }
    },

    /**
     * @private
     * 当列菜单显示之前，根据配置项，初始化菜单
     */
    beforeMenuShow : function(){
        var field = this.getGroupField();
        var g = this.hmenu.items.get('groupBy');
        if(g){
            g.setDisabled(this.cm.config[this.hdCtxIndex].groupable === false);
        }
        var s = this.hmenu.items.get('showGroups');
        if(s){
           s.setDisabled(!field && this.cm.config[this.hdCtxIndex].groupable === false);
			s.setChecked(!!field, true);
        }
    },

    /**
     * @private
     * 为列菜单初始化菜单项
     */
    renderUI : function(){
        L5.grid.GroupingView.superclass.renderUI.call(this);
        this.mainBody.on('mousedown', this.interceptMouse, this);

        if(this.enableGroupingMenu && this.hmenu){
            this.hmenu.add('-',{
                id:'groupBy',
                text: this.groupByText,
                handler: this.onGroupByClick,
                scope: this,
                iconCls:'l-group-by-icon'
            });
            if(this.enableNoGroups){
                this.hmenu.add({
                    id:'showGroups',
                    text: this.showGroupsText,
                    checked: true,
                    checkHandler: this.onShowGroupsClick,
                    scope: this
                });
            }
            this.hmenu.on('beforeshow', this.beforeMenuShow, this);
        }
    },

    /**
     * @private
     */
    onGroupByClick : function(){
        this.grid.dataset.groupBy(this.cm.getDataIndex(this.hdCtxIndex));
        this.beforeMenuShow(); // Make sure the checkboxes get properly set when changing groups
    },

    /**
     * @private
     */
    onShowGroupsClick : function(mi, checked){
        if(checked){
            this.onGroupByClick();
        }else{
            this.grid.dataset.clearGrouping();
        }
    },

    /**
     * 切换指定的组，如果expanded是undefined就展开分组，否则根据expanded设置组展开状态
     * @param {String} groupId 分组的ID
     * @param {Boolean} expanded (optional)
     */
    toggleGroup : function(group, expanded){
        this.grid.stopEditing(true);
        group = L5.getDom(group);
        var gel = L5.fly(group);
        expanded = expanded !== undefined ?
                expanded : gel.hasClass('l-grid-group-collapsed');

        this.state[gel.dom.id] = expanded;
        gel[expanded ? 'removeClass' : 'addClass']('l-grid-group-collapsed');
    },

    /**
     * 如果没有参数就切换各组的展开状态，否则设置就按照传递过来的参数设置展开状态，如果是true，就展开否则闭合
     * @param {Boolean} expanded (optional)
     */
    toggleAllGroups : function(expanded){
        var groups = this.getGroups();
        for(var i = 0, len = groups.length; i < len; i++){
            this.toggleGroup(groups[i], expanded);
        }
    },

    /**
     * 展开所有的分组
     */
    expandAllGroups : function(){
        this.toggleAllGroups(true);
    },

    /**
     * 闭合所有的分组
     */
    collapseAllGroups : function(){
        this.toggleAllGroups(false);
    },

    /**
     * @private
     */
    interceptMouse : function(e){
        var hd = e.getTarget('.l-grid-group-hd', this.mainBody);
        if(hd){
            e.stopEvent();
            this.toggleGroup(hd.parentNode);
        }
    },

    /**
     * 处理分组字段对应的数据
     * @param {String/Number} v 格式化之前字段对应的值
     * @param {L5.model.Record} r 当前行对应的record
     * @param {Function} groupRenderer 自定义的格式化方法
     * @param {Number} rowIndex 行索引
     * @param {Number} colIndex 列索引
     * @param {L5.model.DataSet} ds grid对一个的数据模型
     */
    getGroup : function(v, r, groupRenderer, rowIndex, colIndex, ds){
        var g = groupRenderer ? groupRenderer(v, {}, r, rowIndex, colIndex, ds) : String(v);
        if(g === ''){
            g = this.cm.config[colIndex].emptyGroupText || this.emptyGroupText;
        }
        return g;
    },

    /**
     * @private
     */
    getGroupField : function(){
        return this.grid.dataset.getGroupState();
    },

    /**
     * @private
     * 渲染指定区间的行，渲染功能调用的是父类的方法，子类主要是根据子类的配置项，对列进行操作
     * @param {Number} startRow 开始的行索引
     * @param {Number} endRow 结束的行索引
     */
    renderRows : function(){
        var groupField = this.getGroupField();
        var eg = !!groupField;
        // if they turned off grouping and the last grouped field is hidden
        if(this.hideGroupedColumn) {
            var colIndex = this.cm.findColumnIndex(groupField);
            if(!eg && this.lastGroupField !== undefined) {
                this.mainBody.update('');
                this.cm.setHidden(this.cm.findColumnIndex(this.lastGroupField), false);
                delete this.lastGroupField;
            }else if (eg && this.lastGroupField === undefined) {
                this.lastGroupField = groupField;
                this.cm.setHidden(colIndex, true);
            }else if (eg && this.lastGroupField !== undefined && groupField !== this.lastGroupField) {
                this.mainBody.update('');
                var oldIndex = this.cm.findColumnIndex(this.lastGroupField);
                this.cm.setHidden(oldIndex, false);
                this.lastGroupField = groupField;
                this.cm.setHidden(colIndex, true);
            }
        }
        return L5.grid.GroupingView.superclass.renderRows.apply(
                    this, arguments);
    },

    /**
     * @private
     * 将指定的行数组的数据渲染到grid表体的指定位置，主要调用的父类的doRender方法，
     * 子类额外增加的功能是将dataset分组
     * @param {Array} cs 通过getColumnData获取的表头的配置信息数组
     * @param {Array} rs 指定行集合对应的Record数组
     * @param {L5.model.DataSet} ds grid对应的数据模型
     * @param {Number} startRow 要渲染到的指定位置的索引
     * @param {Number} colCount 总的列数
     * @param {Boolean} stripe 
     * @return {String} 返回HTML代码段
     */
    doRender : function(cs, rs, ds, startRow, colCount, stripe){
        if(rs.length < 1){
            return '';
        }
        var groupField = this.getGroupField();
        var colIndex = this.cm.findColumnIndex(groupField);

        this.enableGrouping = !!groupField;

        if(!this.enableGrouping || this.isUpdating){
            return L5.grid.GroupingView.superclass.doRender.apply(
                    this, arguments);
        }
        var gstyle = 'width:'+this.getTotalWidth()+';';

        var gidPrefix = this.grid.getGridEl().id;
        var cfg = this.cm.config[colIndex];
        var groupRenderer = cfg.groupRenderer || cfg.renderer;
        var prefix = this.showGroupName ?
                     (cfg.groupName || cfg.header)+': ' : '';

        var groups = [], curGroup, i, len, gid;
        for(i = 0, len = rs.length; i < len; i++){//在执行这步的时候已经用DroupingDataset里面的groupBy方法进行了分组。
            var rowIndex = startRow + i;
            var r = rs[i],
                gvalue = r.data[groupField],
                g = this.getGroup(gvalue, r, groupRenderer, rowIndex, colIndex, ds);
            if(!curGroup || curGroup.group != g){
            	/**
            	 * @ignore
            	 * @private
            	 * 将分组好的数据再处理，最后的分组结构是：每组相同的数据都放到一个curGroup对象中，对象中有个属性rs（是数组），
            	 * 该数组每个对象都是一个record。然后若干curGroup组成一个groups数组。
            	 */
                gid = gidPrefix + '-gp-' + groupField + '-' + L5.util.Format.htmlEncode(g);
               	// if state is defined use it, however state is in terms of expanded
				// so negate it, otherwise use the default.
				var isCollapsed  = typeof this.state[gid] !== 'undefined' ? !this.state[gid] : this.startCollapsed;
				var gcls = isCollapsed ? 'l-grid-group-collapsed' : '';	
                curGroup = {
                    group: g,
                    gvalue: gvalue,
                    text: prefix + g,
                    groupId: gid,
                    startRow: rowIndex,
                    rs: [r],
                    cls: gcls,
                    style: gstyle
                };
                groups.push(curGroup);
            }else{
                curGroup.rs.push(r);
            }
            r._groupId = gid;
        }

        var buf = [];
        for(i = 0, len = groups.length; i < len; i++){
            var g = groups[i];
            this.doGroupStart(buf, g, cs, ds, colCount);
            buf[buf.length] = L5.grid.GroupingView.superclass.doRender.call(
                    this, cs, g.rs, ds, g.startRow, colCount, stripe);

            this.doGroupEnd(buf, g, cs, ds, colCount);
        }
        return buf.join('');
    },

    /**
     *	通过一个分组的value尝试动态的获取一个groupId
     * @param {String} value 一个分组的value
     * @return {String} 返回这个分组的id
     */
    getGroupId : function(value){
        var gidPrefix = this.grid.getGridEl().id;
        var groupField = this.getGroupField();
        var colIndex = this.cm.findColumnIndex(groupField);
        var cfg = this.cm.config[colIndex];
        var groupRenderer = cfg.groupRenderer || cfg.renderer;
        var gtext = this.getGroup(value, {data:{}}, groupRenderer, 0, colIndex, this.ds);
        return gidPrefix + '-gp-' + groupField + '-' + L5.util.Format.htmlEncode(value);
    },

    /**
     * @private
     * 增加分组标题栏信息
     * @param {Array} buf 已经构建的HTML代码片段的数组
     * @param {Object} g 里面存放了上面cruGroup的对象
     * @param {Array} cs 通过getColumnData获取的表头的配置信息数组
     * @param {L5.model.DataSet} ds grid对应的数据模型
     * @param {Number} colCount 总的列数
     */
    doGroupStart : function(buf, g, cs, ds, colCount){
        buf[buf.length] = this.startGroup.apply(g);
    },

    /**
     * @private
     * 增加分组结束的HTML代码段
     * @param {Array} buf 已经构建的HTML代码片段的数组
     * @param {Object} g 里面存放了上面cruGroup的对象
     * @param {Array} cs 通过getColumnData获取的表头的配置信息数组
     * @param {L5.model.DataSet} ds grid对应的数据模型
     * @param {Number} colCount 总的列数
     */
    doGroupEnd : function(buf, g, cs, ds, colCount){
        buf[buf.length] = this.endGroup;
    },

    /**
     * @private
     * 获取grid的所有行
     * @returns {Array} 返回所有行的一个数组
     */
    getRows : function(){
        if(!this.enableGrouping){
            return L5.grid.GroupingView.superclass.getRows.call(this);
        }
        var r = [];
        var g, gs = this.getGroups();
        for(var i = 0, len = gs.length; i < len; i++){
            g = gs[i].childNodes[1].childNodes;
            for(var j = 0, jlen = g.length; j < jlen; j++){
                r[r.length] = g[j];
            }
        }
        return r;
    },

    /**
     * @private
     * 更新分组grid的列宽
     */
    updateGroupWidths : function(){
        if(!this.enableGrouping || !this.hasRows()){
            return;
        }
        var tw = Math.max(this.cm.getTotalWidth(), this.el.dom.offsetWidth-this.scrollOffset) +'px';
        var gs = this.getGroups();
        for(var i = 0, len = gs.length; i < len; i++){
            gs[i].firstChild.style.width = tw;
        }
    },

    /**
     * @private
     * 更新列宽
     */
    onColumnWidthUpdated : function(col, w, tw){
        L5.grid.GroupingView.superclass.onColumnWidthUpdated.call(this, col, w, tw);
        this.updateGroupWidths();
    },

    /**
     * @private
     */
    onAllColumnWidthsUpdated : function(ws, tw){
        L5.grid.GroupingView.superclass.onAllColumnWidthsUpdated.call(this, ws, tw);
        this.updateGroupWidths();
    },

    /**
     * @private
     */
    onColumnHiddenUpdated : function(col, hidden, tw){
        L5.grid.GroupingView.superclass.onColumnHiddenUpdated.call(this, col, hidden, tw);
        this.updateGroupWidths();
    },

    /**
     * @private
     */
    onLayout : function(){
        this.updateGroupWidths();
    },

    /**
     * @private
     */
    onBeforeRowSelect : function(sm, rowIndex){
        if(!this.enableGrouping){
            return;
        }
        var row = this.getRow(rowIndex);
        if(row && !row.offsetParent){
            var g = this.findGroup(row);
            this.toggleGroup(g, true);
        }
    },

    /**
     * @cfg {String} groupByText 
     * 以某列字段分组而在列表头菜单显示的文字
     */
    groupByText: '按照当前字段分组',
    /**
     * @cfg {String} showGroupsText 
     * 在列菜单上启用/禁用分组功能复选框后面的显示文字
     */
    showGroupsText: '分组显示'
});
// private
L5.grid.GroupingView.GROUP_ID = 1000;