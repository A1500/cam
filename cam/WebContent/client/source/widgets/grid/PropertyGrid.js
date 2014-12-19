/**
 * @class L5.grid.PropertyRecord
 * A specific {@link L5.model.Record} type that represents a name/value pair and is made to work with the
 * {@link L5.grid.PropertyGrid}.  Typically, PropertyRecords do not need to be created directly as they can be
 * created implicitly by simply using the appropriate data configs either via the {@link L5.grid.PropertyGrid#source}
 * config property or by calling {@link L5.grid.PropertyGrid#setSource}.  However, if the need arises, these records
 * can also be created explicitly as shwon below.  Example usage:
 * <pre><code>
var rec = new L5.grid.PropertyRecord({
    name: 'Birthday',
    value: new Date(Date.parse('05/26/1972'))
});
// Add record to an already populated grid
grid.dataset.addSorted(rec);
</code></pre>
 * @constructor
 * @param {Object} config A data object in the format: {name: [name], value: [value]}.  The specified value's type
 * will be read automatically by the grid to determine the type of editor to use when displaying it.
 */
L5.grid.PropertyRecord = L5.model.Record.create([
    {name:'name',type:'string'}, 'value'
]);

/**
 * @class L5.grid.PropertyDataset
 * @extends L5.util.Observable
 * A custom wrapper for the {@link L5.grid.PropertyGrid}'s {@link L5.model.Dataset}. This class handles the mapping
 * between the custom data source objects supported by the grid and the {@link L5.grid.PropertyRecord} format
 * required for compatibility with the underlying dataset. Generally this class should not need to be used directly --
 * the grid's data should be accessed from the underlying dataset via the {@link #dataset} property.
 * @constructor
 * @param {L5.grid.Grid} grid The grid this dataset will be bound to
 * @param {Object} source The source data config object
 */
L5.grid.PropertyDataset = function(grid, source){
    this.grid = grid;
    this.dataset = new L5.model.Dataset({
        recordType : L5.grid.PropertyRecord
    });
    this.dataset.on('update', this.onUpdate,  this);
    if(source){
        this.setSource(source);
    }
    L5.grid.PropertyDataset.superclass.constructor.call(this);
};
L5.extend(L5.grid.PropertyDataset, L5.util.Observable, {
    // protected - should only be called by the grid.  Use grid.setSource instead.
    setSource : function(o){
        this.source = o;
        this.dataset.removeAll();
        var data = [];
        for(var k in o){
            if(this.isEditableValue(o[k])){
                data.push(new L5.grid.PropertyRecord({name: k, value: o[k]}, k));
            }
        }
        this.dataset.loadRecords({records: data}, {}, true);
    },

    // private
    onUpdate : function(ds, record, type){
        if(type == L5.model.Record.EDIT){
            var v = record.data['value'];
            var oldValue = record.modified['value'];
            if(this.grid.fireEvent('beforepropertychange', this.source, record.id, v, oldValue) !== false){
                this.source[record.id] = v;
                record.commit();
                this.grid.fireEvent('propertychange', this.source, record.id, v, oldValue);
            }else{
                record.reject();
            }
        }
    },

    // private
    getProperty : function(row){
       return this.dataset.getAt(row);
    },

    // private
    isEditableValue: function(val){
        if(L5.isDate(val)){
            return true;
        }else if(typeof val == 'object' || typeof val == 'function'){
            return false;
        }
        return true;
    },

    // private
    setValue : function(prop, value){
        this.source[prop] = value;
        this.dataset.getById(prop).set('value', value);
    },

    // protected - should only be called by the grid.  Use grid.getSource instead.
    getSource : function(){
        return this.source;
    }
});

/**
 * @class L5.grid.PropertyColumnModel
 * @extends L5.grid.ColumnModel
 * A custom column model for the {@link L5.grid.PropertyGrid}.  Generally it should not need to be used directly.
 * @constructor
 * @param {L5.grid.Grid} grid The grid this dataset will be bound to
 * @param {Object} source The source data config object
 */
L5.grid.PropertyColumnModel = function(grid, dataset){
    this.grid = grid;
    var g = L5.grid;
    g.PropertyColumnModel.superclass.constructor.call(this, [
        {header: this.nameText, width:50, sortable: true, field:'name', id: 'name', menuDisabled:true},
        {header: this.valueText, width:50, resizable:false, field: 'value', id: 'value', menuDisabled:true}
    ]);
    this.dataset = dataset;
    this.bselect = L5.DomHelper.append(document.body, {
        tag: 'select', cls: 'l-grid-editor l-hide-display', children: [
            {tag: 'option', value: 'true', html: 'true'},
            {tag: 'option', value: 'false', html: 'false'}
        ]
    });
    var f = L5.form;

    var bfield = new f.Field({
        el:this.bselect,
        bselect : this.bselect,
        autoShow: true,
        getValue : function(){
            return this.bselect.value == 'true';
        }
    });
    this.editors = {
        'date' : new g.GridEditor(new f.DateField({selectOnFocus:true})),
        'string' : new g.GridEditor(new f.TextField({selectOnFocus:true})),
        'number' : new g.GridEditor(new f.NumberField({selectOnFocus:true, style:'text-align:left;'})),
        'boolean' : new g.GridEditor(bfield)
    };
    this.renderCellDelegate = this.renderCell.createDelegate(this);
    this.renderPropDelegate = this.renderProp.createDelegate(this);
};

L5.extend(L5.grid.PropertyColumnModel, L5.grid.ColumnModel, {
    // private - strings used for locale support
    nameText : 'Name',
    valueText : 'Value',
    dateFormat : 'm/j/Y',

    // private
    renderDate : function(dateVal){
        return dateVal.dateFormat(this.dateFormat);
    },

    // private
    renderBool : function(bVal){
        return bVal ? 'true' : 'false';
    },

    // private
    isCellEditable : function(colIndex, rowIndex){
        return colIndex == 1;
    },

    // private
    getRenderer : function(col){
        return col == 1 ?
            this.renderCellDelegate : this.renderPropDelegate;
    },

    // private
    renderProp : function(v){
        return this.getPropertyName(v);
    },

    // private
    renderCell : function(val){
        var rv = val;
        if(L5.isDate(val)){
            rv = this.renderDate(val);
        }else if(typeof val == 'boolean'){
            rv = this.renderBool(val);
        }
        return L5.util.Format.htmlEncode(rv);
    },

    // private
    getPropertyName : function(name){
        var pn = this.grid.propertyNames;
        return pn && pn[name] ? pn[name] : name;
    },

    // private
    getCellEditor : function(colIndex, rowIndex){
        var p = this.dataset.getProperty(rowIndex);
        var n = p.data['name'], val = p.data['value'];
        if(this.grid.customEditors[n]){
            return this.grid.customEditors[n];
        }
        if(L5.isDate(val)){
            return this.editors['date'];
        }else if(typeof val == 'number'){
            return this.editors['number'];
        }else if(typeof val == 'boolean'){
            return this.editors['boolean'];
        }else{
            return this.editors['string'];
        }
    }
});

/**
 * @class L5.grid.PropertyGrid
 * @extends L5.grid.EditorGridPanel
 * A specialized grid implementation intended to mimic the traditional property grid as typically seen in
 * development IDEs.  Each row in the grid represents a property of some object, and the data is stored
 * as a set of name/value pairs in {@link L5.grid.PropertyRecord}s.  Example usage:
 * <pre><code>
var grid = new L5.grid.PropertyGrid({
    title: 'Properties Grid',
    autoHeight: true,
    width: 300,
    renderTo: 'grid-ct',
    source: {
        "(name)": "My Object",
        "Created": new Date(Date.parse('10/15/2006')),
        "Available": false,
        "Version": .01,
        "Description": "A test object"
    }
});
</pre></code>
 * @constructor
 * @param {Object} config The grid config object
 */
L5.grid.PropertyGrid = L5.extend(L5.grid.EditorGridPanel, {
    /**
    * @cfg {Object} propertyNames An object containing property name/display name pairs.
    * If specified, the display name will be shown in the name column instead of the property name.
    */
    /**
    * @cfg {Object} source A data object to use as the data source of the grid (see {@link #setSource} for details).
    */
    /**
    * @cfg {Object} customEditors An object containing name/value pairs of custom editor type definitions that allow
    * the grid to support additional types of editable fields.  By default, the grid supports strongly-typed editing
    * of strings, dates, numbers and booleans using built-in form editors, but any custom type can be supported and
    * associated with a custom input control by specifying a custom editor.  The name of the editor
    * type should correspond with the name of the property that will use the editor.  Example usage:
    * <pre><code>
var grid = new L5.grid.PropertyGrid({
    ...
    customEditors: {
        'Start Time': new L5.grid.GridEditor(new L5.form.TimeField({selectOnFocus:true}))
    },
    source: {
        'Start Time': '10:00 AM'
    }
});
</code></pre>
    */

    // private config overrides
    enableColumnMove:false,
    stripeRows:false,
    trackMouseOver: false,
    clicksToEdit:1,
    enableHdMenu : false,
    viewConfig : {
        forceFit:true
    },

    // private
    initComponent : function(){
        this.customEditors = this.customEditors || {};
        this.lastEditRow = null;
        var dataset = new L5.grid.PropertyDataset(this);
        this.propDataset = dataset;
        var cm = new L5.grid.PropertyColumnModel(this, dataset);
        dataset.dataset.sort('name', 'ASC');
        this.addEvents(
            /**
             * @event beforepropertychange
             * Fires before a property value changes.  Handlers can return false to cancel the property change
             * (this will internally call {@link L5.model.Record#reject} on the property's record).
             * @param {Object} source The source data object for the grid (corresponds to the same object passed in
             * as the {@link #source} config property).
             * @param {String} recordId The record's id in the data dataset
             * @param {Mixed} value The current edited property value
             * @param {Mixed} oldValue The original property value prior to editing
             */
            'beforepropertychange',
            /**
             * @event propertychange
             * Fires after a property value has changed.
             * @param {Object} source The source data object for the grid (corresponds to the same object passed in
             * as the {@link #source} config property).
             * @param {String} recordId The record's id in the data dataset
             * @param {Mixed} value The current edited property value
             * @param {Mixed} oldValue The original property value prior to editing
             */
            'propertychange'
        );
        this.cm = cm;
        this.ds = dataset.dataset;
        L5.grid.PropertyGrid.superclass.initComponent.call(this);

        this.selModel.on('beforecellselect', function(sm, rowIndex, colIndex){
            if(colIndex === 0){
                this.startEditing.defer(200, this, [rowIndex, 1]);
                return false;
            }
        }, this);
    },

    // private
    onRender : function(){
        L5.grid.PropertyGrid.superclass.onRender.apply(this, arguments);

        this.getGridEl().addClass('l-props-grid');
    },

    // private
    afterRender: function(){
        L5.grid.PropertyGrid.superclass.afterRender.apply(this, arguments);
        if(this.source){
            this.setSource(this.source);
        }
    },

    /**
     * Sets the source data object containing the property data.  The data object can contain one or more name/value
     * pairs representing all of the properties of an object to display in the grid, and this data will automatically
     * be loaded into the grid's {@link #dataset}.  The values should be supplied in the proper data type if needed,
     * otherwise string type will be assumed.  If the grid already contains data, this method will replace any
     * existing data.  See also the {@link #source} config value.  Example usage:
     * <pre><code>
grid.setSource({
    "(name)": "My Object",
    "Created": new Date(Date.parse('10/15/2006')),  // date type
    "Available": false,  // boolean type
    "Version": .01,      // decimal type
    "Description": "A test object"
});
</code></pre>
     * @param {Object} source The data object
     */
    setSource : function(source){
        this.propDataset.setSource(source);
    },

    /**
     * Gets the source data object containing the property data.  See {@link #setSource} for details regarding the
     * format of the data object.
     * @return {Object} The data object
     */
    getSource : function(){
        return this.propDataset.getSource();
    }
});
L5.reg("propertygrid", L5.grid.PropertyGrid);
