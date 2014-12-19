/**
 * @class L5.form.ComboBox
 * @extends L5.form.TriggerField
 * <p>A combobox control with support for autocomplete, remote-loading, paging and many other features.</p>
 * A ComboBox works in a similar manner to a traditional HTML &lt;select> field. The difference is that to submit the
 * {@link #valueField}, you must specify a {@link #hiddenName} to create a hidden input field to hold the
 * value of the valueField. The <i>{@link #displayField}</i> is shown in the text field which is named
 * according to the {@link #name}.
 * @constructor
 * Create a new ComboBox.
 * @param {Object} config Configuration options
 */
L5.form.ComboBox = L5.extend(L5.form.TriggerField, {
    /**
     * @cfg {Mixed} transform The id, DOM node or element of an existing HTML SELECT to convert to a ComboBox.
     * Note that if you specify this and the combo is going to be in a {@link L5.form.BasicForm} or
     * {@link L5.form.FormPanel}, you must also set {@link #lazyRender} = true.
     */
    /**
     * @cfg {Boolean} lazyRender True to prevent the ComboBox from rendering until requested (should always be used when
     * rendering into an L5.Editor, defaults to false).
     */
    /**
     * @cfg {Boolean/Object} autoCreate A DomHelper element spec, or true for a default element spec (defaults to:
     * {tag: "input", type: "text", size: "24", autocomplete: "off"})
     */
    /**
     * @cfg {L5.model.Dataset/Array} dataset The data source to which this combo is bound (defaults to undefined).  This can be
     * any {@link L5.model.Dataset} subclass, a 1-dimensional array (e.g., ['Foo','Bar']) or a 2-dimensional array (e.g.,
     * [['f','Foo'],['b','Bar']]).  Arrays will be converted to a {@link L5.model.SimpleDataset} internally.
     * 1-dimensional arrays will automatically be expanded (each array item will be the combo value and text) and
     * for multi-dimensional arrays, the value in index 0 of each item will be assumed to be the combo value, while
     * the value at index 1 is assumed to be the combo text.
     */
    /**
     * @cfg {String} title If supplied, a header element is created containing this text and added into the top of
     * the dropdown list (defaults to undefined, with no header element)
     */

    // private
    defaultAutoCreate : {tag: "input", type: "text", size: "24", autocomplete: "off"},
    /**
     * @cfg {Number} listWidth The width in pixels of the dropdown list (defaults to the width of the ComboBox field)
     */
    /**
     * @cfg {String} displayField The underlying data field name to bind to this ComboBox (defaults to undefined if
     * mode = 'remote' or 'text' if transforming a select)
     */
    /**
     * @cfg {String} valueField The underlying data value name to bind to this ComboBox (defaults to undefined if
     * mode = 'remote' or 'value' if transforming a select) Note: use of a valueField requires the user to make a selection
     * in order for a value to be mapped.
     */
    /**
     * @cfg {String} hiddenName If specified, a hidden form field with this name is dynamically generated to dataset the
     * field's data value (defaults to the underlying DOM element's name). Required for the combo's value to automatically
     * post during a form submission.  Note that the hidden field's id will also default to this name if {@link #hiddenId}
     * is not specified.  The combo's id and the hidden field's ids should be different, since no two DOM nodes should
     * share the same id, so if the combo and hidden names are the same, you should specify a unique hiddenId.
     */
    /**
     * @cfg {String} hiddenId If {@link #hiddenName} is specified, hiddenId can also be provided to give the hidden field
     * a unique id (defaults to the hiddenName).  The hiddenId and combo {@link #id} should be different, since no two DOM
     * nodes should share the same id.
     */
    /**
     * @cfg {String} listClass CSS class to apply to the dropdown list element (defaults to '')
     */
    listClass: '',
    /**
     * @cfg {String} selectedClass CSS class to apply to the selected item in the dropdown list (defaults to 'l-combo-selected')
     */
    selectedClass: 'l-combo-selected',
    /**
     * @cfg {String} triggerClass An additional CSS class used to style the trigger button.  The trigger will always get the
     * class 'l-form-trigger' and triggerClass will be <b>appended</b> if specified (defaults to 'l-form-arrow-trigger'
     * which displays a downward arrow icon).
     */
    triggerClass : 'l-form-arrow-trigger',
    /**
     * @cfg {Boolean/String} shadow True or "sides" for the default effect, "frame" for 4-way shadow, and "drop" for bottom-right
     */
    shadow:'sides',
    /**
     * @cfg {String} listAlign A valid anchor position value. See {@link L5.Element#alignTo} for details on supported
     * anchor positions (defaults to 'tl-bl')
     */
    listAlign: 'tl-bl?',
    /**
     * @cfg {Number} maxHeight The maximum height in pixels of the dropdown list before scrollbars are shown (defaults to 300)
     */
    maxHeight: 300,
    /**
     * @cfg {Number} minHeight The minimum height in pixels of the dropdown list when the list is constrained by its
     * distance to the viewport edges (defaults to 90)
     */
    minHeight: 90,
    /**
     * @cfg {String} triggerAction The action to execute when the trigger is clicked.  Use 'all' to run the
     * query specified by the allQuery config option (defaults to 'query')
     */
    triggerAction: 'all',
    /**
     * @cfg {Number} minChars The minimum number of characters the user must type before autocomplete and typeahead activate
     * (defaults to 4 if remote or 0 if local, does not apply if typeAble = false)
     */
    minChars : 4,
    /**
     * @cfg {Boolean} typeAhead True to populate and autoselect the remainder of the text being typed after a configurable
     * delay ({@link #typeAheadDelay}) if it matches a known value (defaults to false)
     */
    typeAhead: false,
    /**
     * @cfg {Number} queryDelay The length of time in milliseconds to delay between the start of typing and sending the
     * query to filter the dropdown list (defaults to 500 if mode = 'remote' or 10 if mode = 'local')
     */
    queryDelay: 500,
    /**
     * @cfg {Number} pageSize If greater than 0, a paging toolbar is displayed in the footer of the dropdown list and the
     * filter queries will execute with page start and limit parameters.  Only applies when mode = 'remote' (defaults to 0)
     */
    pageSize: 0,
    /**
     * @cfg {Boolean} selectOnFocus True to select any existing text in the field immediately on focus.  Only applies
     * when editable = true (defaults to false)
     */
    selectOnFocus:false,
    /**
     * @cfg {String} queryParam Name of the query as it will be passed on the querystring (defaults to 'query')
     */
    queryParam: 'query',
    /**
     * @cfg {String} loadingText The text to display in the dropdown list while data is loading.  Only applies
     * when mode = 'remote' (defaults to 'Loading...')
     */
    loadingText: 'Loading...',
    /**
     * @cfg {Boolean} resizable True to add a resize handle to the bottom of the dropdown list (defaults to false)
     */
    resizable: false,
    /**
     * @cfg {Number} handleHeight The height in pixels of the dropdown list resize handle if resizable = true (defaults to 8)
     */
    handleHeight : 8,
    /**
     * @cfg {Boolean} typeAble False to prevent the user from typing text directly into the field, just like a
     * traditional select (defaults to true)
     */
    typeAble: true,
    /**
     * @cfg {String} allQuery The text query to send to the server to return all records for the list with no filtering (defaults to '')
     */
    allQuery: '',
    /**
     * @cfg {String} mode Set to 'local' if the ComboBox loads local data (defaults to 'remote' which loads from the server)
     */
    mode: 'remote',
    /**
     * @cfg {Number} minListWidth The minimum width of the dropdown list in pixels (defaults to 70, will be ignored if
     * listWidth has a higher value)
     */
    minListWidth : 70,
    /**
     * @cfg {Boolean} forceSelection True to restrict the selected value to one of the values in the list, false to
     * allow the user to set arbitrary text into the field (defaults to false)
     */
    forceSelection:false,
    /**
     * @cfg {Number} typeAheadDelay The length of time in milliseconds to wait until the typeahead text is displayed
     * if typeAhead = true (defaults to 250)
     */
    typeAheadDelay : 250,
    /**
     * @cfg {String} valueNotFoundText When using a name/value combo, if the value passed to setValue is not found in
     * the dataset, valueNotFoundText will be displayed as the field text if defined (defaults to undefined). If this
     * defaut text is used, it means there is no value set and no validation will occur on this field.
     */

    /**
     * @cfg {Boolean} lazyInit True to not initialize the list for this combo until the field is focused (defaults to true)
     */
    lazyInit : false,
    /**
     * The value of the match string used to filter the dataset. Delete this property to force a requery.
     * @property lastQuery
     * @type String
     */

    // private
    initComponent : function(){
        L5.form.ComboBox.superclass.initComponent.call(this);
        this.addEvents(
            /**
             * @event expand
             * Fires when the dropdown list is expanded
             * @param {L5.form.ComboBox} combo This combo box
             */
            'expand',
            /**
             * @event collapse
             * Fires when the dropdown list is collapsed
             * @param {L5.form.ComboBox} combo This combo box
             */
            'collapse',
            /**
             * @event beforeselect
             * Fires before a list item is selected. Return false to cancel the selection.
             * @param {L5.form.ComboBox} combo This combo box
             * @param {L5.model.Record} record The data record returned from the underlying dataset
             * @param {Number} index The index of the selected item in the dropdown list
             */
            'beforeselect',
            /**
             * @event select
             * Fires when a list item is selected
             * @param {L5.form.ComboBox} combo This combo box
             * @param {L5.model.Record} record The data record returned from the underlying dataset
             * @param {Number} index The index of the selected item in the dropdown list
             */
            'select',
            /**
             * @event beforequery
             * Fires before all queries are processed. Return false to cancel the query or set the queryEvent's
             * cancel property to true.
             * @param {Object} queryEvent An object that has these properties:<ul>
             * <li><code>combo</code> : L5.form.ComboBox <div class="sub-desc">This combo box</div></li>
             * <li><code>query</code> : String <div class="sub-desc">The query</div></li>
             * <li><code>forceAll</code> : Boolean <div class="sub-desc">True to force "all" query</div></li>
             * <li><code>cancel</code> : Boolean <div class="sub-desc">Set to true to cancel the query</div></li>
             * </ul>
             */
            'beforequery'
        );
        if(this.transform){
            this.allowDomMove = false;
            var s = L5.getDom(this.transform);
            if(!this.hiddenName){
                this.hiddenName = s.name;
            }
            if(!this.dataset){
                this.mode = 'local';
                var d = [], opts = s.options;
                for(var i = 0, len = opts.length;i < len; i++){
                    var o = opts[i];
                    var value = (L5.isIE ? o.getAttributeNode('value').specified : o.hasAttribute('value')) ? o.value : o.text;
                    if(o.selected) {
                        this.value = value;
                    }
                    d.push([value, o.text]);
                }
                this.dataset = new L5.model.SimpleDataset({
                    'id': 0,
                    fields: ['value', 'text'],
                    data : d
                });
                this.valueField = 'value';
                this.displayField = 'text';
            }
            s.name = L5.id(); // wipe out the name in case somewhere else they have a reference
            if(!this.lazyRender){
                this.target = true;
                this.el = L5.DomHelper.insertBefore(s, this.autoCreate || this.defaultAutoCreate);
                L5.removeNode(s); // remove it
                this.render(this.el.parentNode);
            }else{
                L5.removeNode(s); // remove it
            }
        }
        //auto-configure dataset from local array data
        else if(L5.isArray(this.dataset)){
            if (L5.isArray(this.dataset[0])){
                this.dataset = new L5.model.SimpleDataset({
                    fields: ['value','text'],
                    data: this.dataset
                });
                this.valueField = 'value';
            }else{
                this.dataset = new L5.model.SimpleDataset({
                    fields: ['text'],
                    data: this.dataset,
                    expandData: true
                });
                this.valueField = 'text';
            }
            this.displayField = 'text';
            this.mode = 'local';
        }
        if(!this.displayField)
        	this.displayField = 'text';
        if(!this.valueField)
        	this.valueField='value';
        this.selectedIndex = -1;
        if(this.mode == 'local'){
            if(this.initialConfig.queryDelay === undefined){
                this.queryDelay = 10;
            }
            if(this.initialConfig.minChars === undefined){
                this.minChars = 0;
            }
        }
    },

    // private
    onRender : function(ct, position){
        L5.form.ComboBox.superclass.onRender.call(this, ct, position);
        if(this.hiddenName){
            this.hiddenField = this.el.insertSibling({tag:'input', type:'hidden', name: this.hiddenName,
                    id: (this.hiddenId||this.hiddenName)}, 'before', true);

            // prevent input submission
            this.el.dom.removeAttribute('name');
        }
        if(L5.isGecko){
            this.el.dom.setAttribute('autocomplete', 'off');
        }
        this.wrap.dom.style.display="inline";
        if(!this.lazyInit){
            this.initList();
        }else{
            this.on('focus', this.initList, this, {single: true});
        }
        if(typeof this.editable=='function'){
        	this.editable=this.editable.call();
        }
        if(typeof this.typeAble=='function'){
        	this.typeAble=this.typeAble.call();
        }
        if(!this.typeAble){
            this.typeAble = true;
            this.setEditable(false);
        }
        this.disabled = !this.editable;
    },

    // private
    initValue : function(){
        L5.form.ComboBox.superclass.initValue.call(this);
        if(this.hiddenField){
            this.hiddenField.value =
                this.hiddenValue !== undefined ? this.hiddenValue :
                this.value !== undefined ? this.value : '';
        }
    },

    // private
    initList : function(){
        if(!this.list){
            var cls = 'l-combo-list';

            this.list = new L5.Layer({
                shadow: this.shadow, cls: [cls, this.listClass].join(' '), constrain:false
            });

            var lw = this.listWidth || Math.max(this.wrap.getWidth(), this.minListWidth);
            this.list.setWidth(lw);
            this.list.swallowEvent('mousewheel');
            this.assetHeight = 0;

            if(this.title){
                this.header = this.list.createChild({cls:cls+'-hd', html: this.title});
                this.assetHeight += this.header.getHeight();
            }

            this.innerList = this.list.createChild({cls:cls+'-inner'});
            this.innerList.on('mouseover', this.onViewOver, this);
            this.innerList.on('mousemove', this.onViewMove, this);
            this.innerList.setWidth(lw - this.list.getFrameWidth('lr'));

            if(this.pageSize){
                this.footer = this.list.createChild({cls:cls+'-ft'});
                this.pageTb = new L5.PagingToolbar({
                    dataset:this.dataset,
                    pageSize: this.pageSize,
                    renderTo:this.footer
                });
                this.assetHeight += this.footer.getHeight();
            }

            if(!this.tpl){
                /**
                * @cfg {String/L5.XTemplate} tpl The template string, or {@link L5.XTemplate}
                * instance to use to display each item in the dropdown list. Use
                * this to create custom UI layouts for items in the list.
                * <p>
                * If you wish to preserve the default visual look of list items, add the CSS
                * class name <pre>l-combo-list-item</pre> to the template's container element.
                * <p>
                * <b>The template must contain one or more substitution parameters using field
                * names from the Combo's</b> {@link #dataset Dataset}. An example of a custom template
                * would be adding an <pre>ext:qtip</pre> attribute which might display other fields
                * from the Dataset.
                * <p>
                * The dropdown list is displayed in a DataView. See {@link L5.DataView} for details.
                */
                this.tpl = '<tpl for="."><div class="'+cls+'-item">{' + this.displayField + '}</div></tpl>';
                /**
                 * @cfg {String} itemSelector
                 * <b>This setting is required if a custom XTemplate has been specified in {@link #tpl}
                 * which assigns a class other than <pre>'l-combo-list-item'</pre> to dropdown list items</b>.
                 * A simple CSS selector (e.g. div.some-class or span:first-child) that will be
                 * used to determine what nodes the DataView which handles the dropdown display will
                 * be working with.
                 */
            }

            /**
            * The {@link L5.DataView DataView} used to display the ComboBox's options.
            * @type L5.DataView
            */
            this.view = new L5.DataView({
                applyTo: this.innerList,
                tpl: this.tpl,
                singleSelect: true,
                selectedClass: this.selectedClass,
                itemSelector: this.itemSelector || '.' + cls + '-item'
            });

            this.view.on('click', this.onViewClick, this);

            this.bindDataset(this.dataset, true);

            if(this.resizable){
                this.resizer = new L5.Resizable(this.list,  {
                   pinned:true, handles:'se'
                });
                this.resizer.on('resize', function(r, w, h){
                    this.maxHeight = h-this.handleHeight-this.list.getFrameWidth('tb')-this.assetHeight;
                    this.listWidth = w;
                    this.innerList.setWidth(w - this.list.getFrameWidth('lr'));
                    this.restrictHeight();
                }, this);
                this[this.pageSize?'footer':'innerList'].setStyle('margin-bottom', this.handleHeight+'px');
            }
        }
    },
    
    /**
     * Returns the dataset associated with this combo.
     * @return {L5.model.Dataset} The dataset
     */
    getDataset : function(){
        return this.dataset;
    },

    // private
    bindDataset : function(dataset, initial){
        if(this.dataset && !initial){
            this.dataset.un('beforeload', this.onBeforeLoad, this);
            this.dataset.un('load', this.onLoad, this);
            this.dataset.un('loadexception', this.collapse, this);
            if(!dataset){
                this.dataset = null;
                if(this.view){
                    this.view.setDataset(null);
                }
            }
        }
        if(dataset){
            this.dataset = L5.DatasetMgr.lookup(dataset);

            this.dataset.on('beforeload', this.onBeforeLoad, this);
            this.dataset.on('load', this.onLoad, this);
            this.dataset.on('loadexception', this.collapse, this);

            if(this.view){
                this.view.setDataset(dataset);
            }
        }
    },

    // private
    initEvents : function(){
        L5.form.ComboBox.superclass.initEvents.call(this);

        this.keyNav = new L5.KeyNav(this.el, {
            "up" : function(e){
                this.inKeyMode = true;
                this.selectPrev();
            },

            "down" : function(e){
                if(!this.isExpanded()){
                    this.onTriggerClick();
                }else{
                    this.inKeyMode = true;
                    this.selectNext();
                }
            },

            "enter" : function(e){
                this.onViewClick();
                this.delayedCheck = true;
                this.unsetDelayCheck.defer(10, this);
            },

            "esc" : function(e){
                this.collapse();
            },

            "tab" : function(e){
                this.onViewClick(false);
                return true;
            },

            scope : this,

            doRelay : function(foo, bar, hname){
                if(hname == 'down' || this.scope.isExpanded()){
                   return L5.KeyNav.prototype.doRelay.apply(this, arguments);
                }
                return true;
            },

            forceKeyDown : true
        });
        this.queryDelay = Math.max(this.queryDelay || 10,
                this.mode == 'local' ? 10 : 250);
        this.dqTask = new L5.util.DelayedTask(this.initQuery, this);
        if(this.typeAhead){
            this.taTask = new L5.util.DelayedTask(this.onTypeAhead, this);
        }
        if(this.typeAble !== false){
            this.el.on("keyup", this.onKeyUp, this);
        }
        if(this.forceSelection){
            this.on('blur', this.doForce, this);
        }
    },

    // private
    onDestroy : function(){
        if(this.view){
            L5.destroy(this.view);
        }
        if(this.list){
            if(this.innerList){
                this.innerList.un('mouseover', this.onViewOver, this);
                this.innerList.un('mousemove', this.onViewMove, this);
            }
            this.list.destroy();
        }
        if (this.dqTask){
            this.dqTask.cancel();
            this.dqTask = null;
        }
        this.bindDataset(null);
        L5.form.ComboBox.superclass.onDestroy.call(this);
    },

    // private
    unsetDelayCheck : function(){
        delete this.delayedCheck;
    },

    // private
    fireKey : function(e){
        if(e.isNavKeyPress() && !this.isExpanded() && !this.delayedCheck){
            this.fireEvent("specialkey", this, e);
        }
    },

    // private
    onResize: function(w, h){
        L5.form.ComboBox.superclass.onResize.apply(this, arguments);
        if(this.list && this.listWidth === undefined){
            var lw = Math.max(w, this.minListWidth);
            this.list.setWidth(lw);
            this.innerList.setWidth(lw - this.list.getFrameWidth('lr'));
        }
    },

    // private
    onEnable: function(){
        L5.form.ComboBox.superclass.onEnable.apply(this, arguments);
        if(this.hiddenField){
            this.hiddenField.disabled = false;
        }
    },

    // private
    onDisable: function(){
        L5.form.ComboBox.superclass.onDisable.apply(this, arguments);
        if(this.hiddenField){
            this.hiddenField.disabled = true;
        }
    },

    /**
     * Allow or prevent the user from directly editing the field text.  If false is passed,
     * the user will only be able to select from the items defined in the dropdown list.  This method
     * is the runtime equivalent of setting the 'editable' config option at config time.
     * @param {Boolean} value True to allow the user to directly edit the field text
     */
    setEditable : function(value){
        if(value == this.typeAble){
            return;
        }
        this.typeAble = value;
        if(!value){
            this.el.dom.setAttribute('readOnly', true);
            this.el.on('mousedown', this.onTriggerClick,  this);
            this.el.addClass('l-combo-noedit');
        }else{
            this.el.dom.removeAttribute('readOnly');
            this.el.un('mousedown', this.onTriggerClick,  this);
            this.el.removeClass('l-combo-noedit');
        }
    },

    // private
    onBeforeLoad : function(){
        if(!this.hasFocus){
            return;
        }
        this.innerList.update(this.loadingText ?
               '<div class="loading-indicator">'+this.loadingText+'</div>' : '');
        this.restrictHeight();
        this.selectedIndex = -1;
    },

    // private
    onLoad : function(){
        if(!this.hasFocus){
            return;
        }
        if(this.dataset.getCount() > 0){
            this.expand();
            this.restrictHeight();
            if(this.lastQuery == this.allQuery){
                if(this.typeAble){
                    this.el.dom.select();
                }
                if(!this.selectByValue(this.value, true)){
                    this.select(0, true);
                }
            }else{
                this.selectNext();
                if(this.typeAhead && this.lastKey != L5.EventObject.BACKSPACE && this.lastKey != L5.EventObject.DELETE){
                    this.taTask.delay(this.typeAheadDelay);
                }
            }
        }else{
            this.onEmptyResults();
        }
        //this.el.focus();
    },

    // private
    onTypeAhead : function(){
    	var typedValue = this.getRawValue();
    	var hasSelect = false;
    	for(var i=0;i<this.dataset.getCount();i++){
    		var reValue = this.dataset.getAt(i).data[this.displayField];
    		if((reValue.lastIndexOf(typedValue)>-1&&!hasSelect)||(typedValue == reValue)){
    			hasSelect= true;
    			this.setRawValue(typedValue);
    			this.selectText(0, reValue.length);
    			this.setValue(this.dataset.getAt(i).data[this.valueField]);
    		}
    	}
        /*if(this.dataset.getCount() > 0){
            var r = this.dataset.getAt(0);
            var newValue = r.data[this.displayField];
            var len = newValue.length;
            var selStart = this.getRawValue().length;
            if(selStart != len){
                this.setRawValue(newValue);
                this.selectText(selStart, newValue.length);
            }
        }*/
    },

    // private
    onSelect : function(record, index){
        if(this.fireEvent('beforeselect', this, record, index) !== false){
            this.setValue(record.data[this.valueField || this.displayField]);
            this.collapse();
            this.fireEvent('select', this, record, index);
        }
    },

    /**
     * Returns the currently selected field value or empty string if no value is set.
     * @return {String} value The selected value
     */
    getValue : function(){
        if(this.valueField){
            return typeof this.value != 'undefined' ? this.value : '';
        }else{
            return L5.form.ComboBox.superclass.getValue.call(this);
        }
    },

    /**
     * Clears any text/value currently set in the field
     */
    clearValue : function(){
        if(this.hiddenField){
            this.hiddenField.value = '';
        }
        this.setRawValue('');
        this.lastSelectionText = '';
        this.applyEmptyText();
        this.value = '';
    },

    /**
     * Sets the specified value into the field.  If the value finds a match, the corresponding record text
     * will be displayed in the field.  If the value does not match the data value of an existing item,
     * and the valueNotFoundText config option is defined, it will be displayed as the default field text.
     * Otherwise the field will be blank (although the value will still be set).
     * @param {String} value The value to match
     */
    setValue : function(v){
        var text = v;
        if(this.valueField){
            var r = this.findRecord(this.valueField, v);
            if(r){
                text = r.data[this.displayField];
            }else if(this.valueNotFoundText !== undefined){
                text = this.valueNotFoundText;
            }
        }
        this.lastSelectionText = text;
        if(this.hiddenField){
            this.hiddenField.value = v;
        }
        L5.form.ComboBox.superclass.setValue.call(this, text);
        this.value = v;
    },

    // private
    findRecord : function(prop, value){
        var record;
        if(this.dataset.getCount() > 0){
            this.dataset.each(function(r){
                if(r.data[prop] == value){
                    record = r;
                    return false;
                }
            });
        }
        return record;
    },

    // private
    onViewMove : function(e, t){
        this.inKeyMode = false;
    },

    // private
    onViewOver : function(e, t){
        if(this.inKeyMode){ // prevent key nav and mouse over conflicts
            return;
        }
        var item = this.view.findItemFromChild(t);
        if(item){
            var index = this.view.indexOf(item);
            this.select(index, false);
        }
    },

    // private
    onViewClick : function(doFocus){
        var index = this.view.getSelectedIndexes()[0];
        var r = this.dataset.getAt(index);
        if(r){
            this.onSelect(r, index);
        }
        if(doFocus !== false){
            this.el.focus();
        }
    },

    // private
    restrictHeight : function(){
        this.innerList.dom.style.height = '';
        var inner = this.innerList.dom;
        var pad = this.list.getFrameWidth('tb')+(this.resizable?this.handleHeight:0)+this.assetHeight;
        var h = Math.max(inner.clientHeight, inner.offsetHeight, inner.scrollHeight);
        var ha = this.getPosition()[1]-L5.getBody().getScroll().top;
        var hb = L5.lib.Dom.getViewHeight()-ha-this.getSize().height;
        var space = Math.max(ha, hb, this.minHeight || 0)-this.list.shadowOffset-pad-5;
        h = Math.min(h, space, this.maxHeight);

        this.innerList.setHeight(h);
        this.list.beginUpdate();
        this.list.setHeight(h+pad);
        this.list.alignTo(this.wrap, this.listAlign);
        this.list.endUpdate();
    },

    // private
    onEmptyResults : function(){
        this.collapse();
    },

    /**
     * Returns true if the dropdown list is expanded, else false.
     */
    isExpanded : function(){
        return this.list && this.list.isVisible();
    },

    /**
     * Select an item in the dropdown list by its data value. This function does NOT cause the select event to fire.
     * The dataset must be loaded and the list expanded for this function to work, otherwise use setValue.
     * @param {String} value The data value of the item to select
     * @param {Boolean} scrollIntoView False to prevent the dropdown list from autoscrolling to display the
     * selected item if it is not currently in view (defaults to true)
     * @return {Boolean} True if the value matched an item in the list, else false
     */
    selectByValue : function(v, scrollIntoView){
        if(v !== undefined && v !== null){
            var r = this.findRecord(this.valueField || this.displayField, v);
            if(r){
                this.select(this.dataset.indexOf(r), scrollIntoView);
                return true;
            }
        }
        return false;
    },

    /**
     * Select an item in the dropdown list by its numeric index in the list. This function does NOT cause the select event to fire.
     * The dataset must be loaded and the list expanded for this function to work, otherwise use setValue.
     * @param {Number} index The zero-based index of the list item to select
     * @param {Boolean} scrollIntoView False to prevent the dropdown list from autoscrolling to display the
     * selected item if it is not currently in view (defaults to true)
     */
    select : function(index, scrollIntoView){
        this.selectedIndex = index;
        this.view.select(index);
        if(scrollIntoView !== false){
            var el = this.view.getNode(index);
            if(el){
                this.innerList.scrollChildIntoView(el, false);
            }
        }
    },

    // private
    selectNext : function(){
        var ct = this.dataset.getCount();
        if(ct > 0){
            if(this.selectedIndex == -1){
                this.select(0);
            }else if(this.selectedIndex < ct-1){
                this.select(this.selectedIndex+1);
            }
        }
    },

    // private
    selectPrev : function(){
        var ct = this.dataset.getCount();
        if(ct > 0){
            if(this.selectedIndex == -1){
                this.select(0);
            }else if(this.selectedIndex != 0){
                this.select(this.selectedIndex-1);
            }
        }
    },

    // private
    onKeyUp : function(e){
        if(this.typeAble !== false && !e.isSpecialKey()){
            this.lastKey = e.getKey();
            this.dqTask.delay(this.queryDelay);
        }
    },

    // private
    validateBlur : function(){
        return !this.list || !this.list.isVisible();
    },

    // private
    initQuery : function(){
        this.doQuery(this.getRawValue());
    },

    // private
    doForce : function(){
        if(this.el.dom.value.length > 0){
            this.el.dom.value =
                this.lastSelectionText === undefined ? '' : this.lastSelectionText;
            this.applyEmptyText();
        }
    },

    /**
     * Execute a query to filter the dropdown list.  Fires the {@link #beforequery} event prior to performing the
     * query allowing the query action to be canceled if needed.
     * @param {String} query The SQL query to execute
     * @param {Boolean} forceAll True to force the query to execute even if there are currently fewer characters
     * in the field than the minimum specified by the minChars config option.  It also clears any filter previously
     * saved in the current dataset (defaults to false)
     */
    doQuery : function(q, forceAll){
        if(q === undefined || q === null){
            q = '';
        }
        var qe = {
            query: q,
            forceAll: forceAll,
            combo: this,
            cancel:false
        };
        if(this.fireEvent('beforequery', qe)===false || qe.cancel){
            return false;
        }
        q = qe.query;
        forceAll = qe.forceAll;
        if(forceAll === true || (q.length >= this.minChars)){
            if(this.lastQuery !== q){
                this.lastQuery = q;
                if(this.mode == 'local'){
                    this.selectedIndex = -1;
                    if(forceAll){
                        this.dataset.clearFilter();
                    }else{
                        this.dataset.filter(this.displayField, q);
                    }
                    this.onLoad();
                }else{
                    this.dataset.baseParams[this.queryParam] = q;
                    this.dataset.load({
                        params: this.getParams(q)
                    });
                    this.expand();
                }
            }else{
                this.selectedIndex = -1;
                this.onLoad();
            }
        }
    },

    // private
    getParams : function(q){
        var p = {};
        //p[this.queryParam] = q;
        if(this.pageSize){
            p.start = 0;
            p.limit = this.pageSize;
        }
        return p;
    },

    /**
     * Hides the dropdown list if it is currently expanded. Fires the {@link #collapse} event on completion.
     */
    collapse : function(){
        if(!this.isExpanded()){
            return;
        }
        this.list.hide();
        L5.getDoc().un('mousewheel', this.collapseIf, this);
        L5.getDoc().un('mousedown', this.collapseIf, this);
        this.fireEvent('collapse', this);
    },

    // private
    collapseIf : function(e){
        if(!e.within(this.wrap) && !e.within(this.list)){
            this.collapse();
        }
    },

    /**
     * Expands the dropdown list if it is currently hidden. Fires the {@link #expand} event on completion.
     */
    expand : function(){
        if(this.isExpanded() || !this.hasFocus){
            return;
        }
        this.list.alignTo(this.wrap, this.listAlign);
        this.list.show();
        this.innerList.setOverflow('auto'); // necessary for FF 2.0/Mac
        L5.getDoc().on('mousewheel', this.collapseIf, this);
        L5.getDoc().on('mousedown', this.collapseIf, this);
        this.fireEvent('expand', this);
    },

    /**
     * @method onTriggerClick
     * @hide
     */
    // private
    // Implements the default empty TriggerField.onTriggerClick function
    onTriggerClick : function(){
        if(this.disabled){
            return;
        }
        if(this.isExpanded()){
            this.collapse();
            this.el.focus();
        }else {
            this.onFocus({});
            if(this.triggerAction == 'all') {
                this.doQuery(this.allQuery, true);
            } else {
                this.doQuery(this.getRawValue());
            }
            this.el.focus();
        }
    }

    /**
     * @hide
     * @method autoSize
     */
    /**
     * @cfg {Boolean} grow @hide
     */
    /**
     * @cfg {Number} growMin @hide
     */
    /**
     * @cfg {Number} growMax @hide
     */

});
L5.reg('combo', L5.form.ComboBox);